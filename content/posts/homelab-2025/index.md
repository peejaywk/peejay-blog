---

title: My Homelab Setup October 2025
date: 2025-10-18
draft: false
tags:
    - docker
    - proxmox
    - homelab
    - selfhosted
categories:
    - "Home Lab"
resources:
- name: "featured-image"
  src: "featured-image.jpg"
---
I have been running a homelab in some form for over 5 years now. As my knowledge has increased over the last 5 years my homelab has also evolved from running applications on the bare metal to running them in containers. This is the first time I've documented the state of my homelab and I will continue to update this blog to document any major changes. The homelab is also part of my plan to learn new skills that will allow me change careers.

## Applications / Self Hosted Services
- [NextCloud](https://nextcloud.com/) Secure cloud storage and file sharing
- [Paperless](https://docs.paperless-ngx.com/) Open source document management system
- [Arr Suite](https://github.com/Ravencentric/awesome-arr) Manage DVD Rips etc.
- [Karakeep](https://karakeep.app/) Self hosted bookmark manager
- [Jellyfin](https://jellyfin.org/) Media server / player
- [Portainer](https://docs.portainer.io/start/install-ce/server/docker/linux) Manage deployment of Docker containers
- [Homarr Dashboard](https://homarr.dev/) Dashboard for homelab services
- [Atuin](https://atuin.sh/) Sync, search and backup shell hitory
## Hardware
### Storage
- Terramaster NAS running [TrueNAS Community Edition](https://www.truenas.com/truenas-community-edition/)
	- 4 x 8TB HDDs configured as a RAID-Z1. ~23TB available storage.
	- NFS Shares for containers on the network
- Synology NAS - Local Backup of critical files
### Servers / Hypervisors
- Dell Wyze
	- 8GB RAM
	- 128GB NVMe
	- OS: NixOS
		- Docker Containers
			- NextCloud
			- Paperless
			- Arr Suite
			- Karakeep
			- Jellyfin
			- Portainer
			- Homarr
- Dell Wyze
	- 16GB RAM
	- 1TB NVMe
	- OS: [Proxmox](https://www.proxmox.com/en/)
		- PiHole LXC Container

## Backups
- Important data is backup locally to my Synology NAS and to the cloud using [StorJ](https://www.storj.io/). I don't need to backup lots of data off-site so the pricing of StorJ is reasonable for my requirments. 
- When time/money permits I plan to host a backup NAS at a family members house so ZFS datasets can be replicated off-site.
## Networking / VPNs
- I am currently using the following Unifi network equipment:
	- Unifi Express Cloud Gateway
	- Unifi U7 Pro Access Point
	- Unifi Lite 16 Port PoE Network Switch
- [Tailscale](https://tailscale.com/) - I use Tailscale to connect to self hosted services on my homelab when I'm not connected to my home network. No need to open up any ports on the firewall so more secure.
- I use VLANs to control what devices have access to what services. For example IOT devices have a separate VLAN as these are untrusted devices.
## Cloud Servers
- I am currently using [Hetzner](https://www.hetzner.com/) to run my [Atuin](https://atuin.sh/) service. I could have run this locally on my homelab but I wanted to try out one of the cloud providers that wasn't based in the US. I have this Hetzner VM on my Tailnet so connecting to it from my homelab is seamless. I've had no issues with the Hetzner VM and they are also reasonably priced.

## Hosted Services
- I am currently migrating my email away from Gmail into [Fastmail](https://www.fastmail.com/). Even though Fastmail is a paid for service I like the web interface and the ability to generate masked email addresses has been very useful when signing up to different websites. If I start getting span from a masked email I can easily block or remove it. I plan to complete my migration away from Gmail by the end of the year, or at least forward all my messages into Fastmail.
## Future Plans
- Move containers from the first Dell Wyze box to the ProxMox hypervisor. This will free up the Dell Wyze to become a second ProxMox host.
	- Create a Ubuntu VM to run the containers.
- Put the docker-compose configurations into version control using GitHub.
	- How to manage secrets etc?
- Learn how to use Terraform and Ansible to provision VMs and deploy services.
- Setup a Kubernetes cluster as a learning platform. 
- Continue my migration from Google services by deploying [Immich](https://immich.app/) to manage my photo collection.
- Deploy tools to monitor services running on my network. I currently have no monitoring in place so only find out when a service is down when I come to use it.
- Install a UPS. I currently have no UPS so if the power goes out for any reason all my servers will power off. This has happened a couple of times and I've been lucky so far with no damaged hardware or data corruption. I am looking at purchasing a small UPS that will give me enough time to do a clean shutdown of my NAS and servers when power outage occurs.