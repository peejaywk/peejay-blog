# PeeJay Labs Website

This is a static website built using [Hugo](https://gohugo.io/) and the [LoveIt](https://hugoloveit.com/) theme.

To keep the developement environment clean I have used a VSCode Dev Container to load in the Hugo and the Go packages. The LoveIt theme doesn't work with the latest version of Hugo so am using version 0.145.0 to build this site. See Issue [998](https://github.com/dillonzq/LoveIt/issues/998) for details.

This is very much work in progress but I will learn as I go along on how to use Hugo and its many features.

## Deployment
The website is deployed using Cloudflare workers following instructions from this [video](https://youtu.be/FZMgUSlNp-0?si=YEaLMNqAv5k3d_Va) by Christian Lempa.