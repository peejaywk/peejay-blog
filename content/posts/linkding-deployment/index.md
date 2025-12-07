---
title: Linkding Deployment on Rancher Desktop Cluster
date: 2025-12-07
draft: false
tags:
  - homelab
  - selfhosted
  - Linux
  - Kubernetes
categories:
  - Linux
  - Kubernetes
resources:
- name: "featured-image"
  src: "featured-image.jpg"
---
## Linkding deployment on Rancher Desktop cluster

[Linkding](https://linkding.link/) is a self-hosted bookmark manager that normally runs via Docker, but since I'm currently learning Kubernetes I decided to document the process of running Linkding on a local development cluster. The cluster is running on my laptop using Rancher Desktop, so this deployment is purely for learning. Once I have some proper hardware for a dedicated Kubernetes cluster, I’ll move Linkding over to that.
### Prerequisites

- Rancher Desktop    
- kubectl (I use the `k` alias throughout)
- k9s
    
All the files referenced in this post can be found on GitHub [here](https://github.com/peejaywk/lab/tree/main/kubernetes/deployments/linkding).

- Create a new deployment and namespace file:
	`k create deployment linkding --image=linkding -o yaml --dry-run=client > deployment.yaml`
	`k create ns linkding --dry-run=client -o yaml > namespace.yaml`
- Apply / create the namespace
	`k apply -f namespace.yaml`
- Before moving on, here is the recommended docker-compose file for reference:
```yaml
services:
  linkding:
    container_name: "${LD_CONTAINER_NAME:-linkding}"
    image: sissbruecker/linkding:latest
    ports:
      - "${LD_HOST_PORT:-9090}:9090"
    volumes:
      - "${LD_HOST_DATA_DIR:-./data}:/etc/linkding/data"
    env_file:
      - .env
    restart: unless-stopped
```
- You can use this as a guide when populating the `deployment.yaml` file
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: linkding
  name: linkding
  namespace: linkding
spec:
  replicas: 1
  selector:
    matchLabels:
      app: linkding
  template:
    metadata:
      labels:
        app: linkding
    spec:
      containers:
      - image: sissbruecker/linkding:latest
        name: linkding
        ports:
          - containerPort: 9090
```
- Deploy the container
	`k deploy -f deployment.yaml`
- At this point Linkding is running inside the cluster with an internal cluster IP. Because there’s no service yet, you’ll need to forward the port to your local machine either via the CLI or directly within **k9s**.
- To set up the initial user, exec into the container and run:
	`python manage.py createsuperuser --username=joe --email=joe@example.com`
	- Set the user password when prompted
- Once that’s done, you can log in at `localhost:9090`
## Setting up a Load Balancer
- To avoid manually forwarding ports each time, you can expose the deployment using a LoadBalancer service.
- Create the `service.yaml` file
	`k create service loadbalancer linkding --tcp=9090 --dry-run=client -o yaml > service.yaml`
- Restart the linkding deployment and start the service deployment
	```yaml
	k delete deployments.apps linkding
	k apply -f deployment.yaml
	k apply -f service.yaml
	```
- You should now be able to access Linkding directly without port forwarding. However, you’ll also notice that the user you created earlier is gone. That’s because there’s currently no persistent storage attached to the pod.

## Setting up Persistent Storage
- Create a new `storage.yaml` and paste in the following. This will create a persistent volume claim for Linkding
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: linkding-data
  namespace: linkding
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
```
- Update the `deployment.yaml` file to attach to the persistent volume
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: linkding-data
  namespace: linkding
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
[peejaywk@marge linkding]$ cat deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: linkding
  name: linkding
  namespace: linkding
spec:
  replicas: 1
  selector:
    matchLabels:
      app: linkding
  template:
    metadata:
      labels:
        app: linkding
    spec:
      containers:
        - image: sissbruecker/linkding:latest
          name: linkding
          ports:
            - containerPort: 9090
          volumeMounts:
            - mountPath: /etc/linkding/data
              name: linkding-data
      volumes:
        - name: linkding-data
          persistentVolumeClaim:
            claimName: linkding-data
```
- This will include the persistent volume in the deployment and mount the volume to the `/etc/linkding/data` path inside the container.
- Apply the changes to the deployment and the new persistent storage
```bash
k apply -f storage.yaml
k apply -f deployment.yaml
```
- You will have to re-create the user again following the instructions above but this time if you stop and restart the pod the user settings will be remembered as they are now stored on the persistent volume.

### Final Thoughts
This is a simple deployment, but it covers the key parts: deployments, services, and persistent storage. It’s been a useful exercise on my way to a proper Kubernetes setup, and I’ll be revisiting it once I have real hardware to run it on.
