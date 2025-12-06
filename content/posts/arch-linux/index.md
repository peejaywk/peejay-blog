---
title: Learning Linux Fundamentals with Arch
date: 2025-12-06
draft: false
tags:
  - homelab
  - selfhosted
  - Linux
  - hyprland
categories:
  - "Linux"
resources:
- name: "featured-image"
  src: "featured-image.jpg"
---
## Using Arch Linux to Deepen My Understanding of Linux Fundamentals

I've been using Linux for many years as my daily driver and have used distributions including Kubuntu and MATE. Most recently, I've been experimenting with NixOS and this is currently installed on my main desktop and one of my home servers. After joining the Kubecraft community, I realised that even after using Linux for all these years my understanding of the fundamentals was still lacking.

## Why I Chose Arch Linux

To rectify this, I decided to follow the recommended path on Kubecraft: building a system from scratch using Arch Linux. As this is a minimal installation (terminal only) out of the box, it forces you to set up and configure the system yourself. By building and configuring a system from scratch, I hoped to develop my understanding of Linux and highlight areas I need to work on to broaden my knowledge.

## Moving Toward a Keyboard-Centric Workflow

As part of this, I also wanted to move to a more keyboard-centric workflow. To achieve this, I chose Hyprland as the window manager and, where possible, used Vim and its key bindings when working in the terminal and other applications. I've never used Vim before, so learning a modal text editor became another challenge. I also set up Obsidian, VSCode, and my bash shell to use Vim key bindings.

## Hardware: The ThinkPad T480

Instead of installing Arch Linux on my main desktop computer, I picked up a second-hand laptop on eBay. I didn't want to spend too much money on this, and the general consensus was to pick up a Lenovo T480 ThinkPad. I ended up with the T480 Core i7 with 16GB of memory. The laptop is more than adequate for running Arch and serves as a great learning platform going forward.

# Arch Installation

The Arch Wiki has detailed instructions on how to install and set up Arch, so below I’ll just cover the overall setup of the laptop and what packages I installed.

## Disk Configuration

The laptop came with a 256GB NVMe drive, which I set up with a 1GB boot partition and one large LUKS-encrypted volume that would hold the swap, root, and home partitions. This is a configuration recommended on the Arch Linux Wiki.

```bash
NAME             MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                8:0    1     0B  0 disk
nvme0n1          259:0    0 476.9G  0 disk
├─nvme0n1p1      259:1    0     1G  0 part  /boot
└─nvme0n1p2      259:2    0 475.9G  0 part
  └─homer        253:0    0 475.9G  0 crypt
    ├─homer-swap 253:1    0     4G  0 lvm   [SWAP]
    ├─homer-root 253:2    0    32G  0 lvm   /
    └─homer-home 253:3    0 439.9G  0 lvm   /home

```
## Installed Packages

- **Hyprland**
- **Hyprlock**
- **Hypridle**
- **Text Editor:** Vim
- **Browser:** Firefox & Qutebrowser
- **Note Taking:** Obsidian
- **Terminal Emulator:** Alacritty
- **Terminal Multiplexer:** Tmux
- **Shell:** Bash
    
## Final Thoughts

I've been using Arch and Hyprland for over three weeks now and have found it to be a solid and reliable system. By undertaking this project, I now have a better understanding of how a Linux system boots and how to set up a disk with different partitions using LUKS encryption. I've also enjoyed using Hyprland and have even reduced my monitor count from three down to a single monitor, as I find I can quickly switch between workspaces and window panes just using the keys. I'm also much more comfortable using Vim and realise now that lots of command-line tools use Vim key bindings for interacting with them.

Overall, this project has pushed my Linux knowledge forward in a way I hadn't managed in years, and it’s made me want to keep exploring. There’s still plenty I want to refine, tidying up my dotfiles, automating parts of my setup and using Dev Containers more to reduce the number of packages I install on the base OS.

