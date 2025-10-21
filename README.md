# PeeJay Labs Website

This is a static website built using [Hugo](https://gohugo.io/) and the [LoveIt](https://hugoloveit.com/) theme.

To keep the developement environment clean I have used a VSCode Dev Container to load in the Hugo and the Go packages. The LoveIt theme doesn't work with the latest version of Hugo so am using version 0.145.0 to build this site. See Issue [998](https://github.com/dillonzq/LoveIt/issues/998) for details.

This is very much work in progress but I will learn as I go along on how to use Hugo and its many features.

## Deployment
The website is deployed using Cloudflare workers following instructions from this [video](https://youtu.be/FZMgUSlNp-0?si=YEaLMNqAv5k3d_Va) by Christian Lempa.

## Creating Dev Environment 

- Open VSCode and close any open projects / folders.
- Install the Dev Container extension if not already installed.
- Click 'Open Remote Window' in the bottom left and select 'Clone Repository in Container Volume' from the drop down box.
- Enter the name of the GitHub repo. If you have SSH setup then use the SSH link to the repo.
- Configure the Dev Container using the menus. For example to setup a Hugo dev environment select
	- Ubuntu (noble)
	- Hugo (latest, extended)
	- Go (latest)
- Once finished the Dev Container will be deploy, install and packages and pull down the contents of the git repo
- Initialise a git repo and create a new Hugo project
```
git init
hugo new site . --force
```
- Install the LoveIt theme
```
git submodule add https://github.com/dillonzq/LoveIt.git themes/LoveIt
```
- Run the Hugo server
```
hugo server
```
## Todo / Issues

