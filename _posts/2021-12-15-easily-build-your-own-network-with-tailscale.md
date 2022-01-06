---
layout: post
title: 'Easily build your own network with Tailscale'
date: 2021-12-15 19:52:00 +0700
topics: tailscale networking vpn linux
---

![Tailscale device management page](/images/tailscale.png)

As a tech geek and software engineer, I maintain a small personal network where I keep all of my devices connected together, ranging from my development machines, local linux box, [HTPC server](https://en.wikipedia.org/wiki/Home_theater_PC){:target="\_blank"}, remote vps, to a [type 1 hypervisor running with proxmox](https://twitter.com/ibnuhx/status/1439492725129183234){:target="\_blank"}.

Please note that this comparison only applies for personal and fairly light use of the network setup, for real organization use, you might better off with common solutions that has better customization options. Before introducing you to Tailscale, let me explain why its so much better than the common solution.

## OpenVPN era

In the _old days_ of personal network, OpenVPN ought to be the primary choice because of familiarity, I can spin up a small vps to be a VPN server, setup and connect everything on a weekend and be happy about it.

Even though looks to be a robust and solid solution, setting up a personal VPN using OpenVPN still have some overheads and maintentance to do.

### Spinning up a whole linux box

Life is filled with important things to do than maintaining another linux box, let alone ones that you plan to put on the internet. From prepping up the security part to make sure no black hands ever touch your stuff, to doing a routine software update checks to keep up to date.

Keep in mind you still have to pay for it every month, a good and well-spec VPS from notable provider like Linode, Digitalocean and Vultr costs about $3 - $5 a month, we're going to look into how to eliminate this monthly expenses altoghether with Tailscale.

### Inconvenience of adding new devices

Even through there are great solutions out there to manage OpenVPN users and credentials like Pritunl or OpenVPN's Web UI, managing whole set of network requires bits of knowledge to setup, creating new vpn user, downloading the vpn configuration file, transfer and import it to the new device, and only then you be able to connect.

### Sometimes unreliable

Whenever there is an issue with connectivity, prepare yourself to dig into the logs and spend extra time figuring out the issue, whether it is configuration issue, system issue, or worse there is someone in your network.

## Introducing Tailscale

On the headline of their website, its described as "A secure network that just works. Zero config VPN. Installs on any device in minutes, manages firewall rules for you, and works from anywhere.", thats pretty much sums it up.

There is a reason why software is served as a service nowadays (SaaS), the hassle of managing your own self hosted service is real and sometimes not fun when you encounter problems and had no one to help. With Tailscale, everything is managed by them.

Tailscale is a company that focuses on usability. You can begin using Tailscale by installing the client on new devices and then logging in using a single sign-on (SSO) account, such as a Google account or GitHub account. A different set of credentials isn't required. The new devices will then become part of the network and will be able to connect to anything else on the network, and can also be controlled by access control lists (ACLs).

OpenVPN is a VPN with a concentrator that directs traffic between devices, whereas Tailscale is a peer-to-peer mesh VPN that allows for direct connections between devices.

Tailscale is built on WireGuard and by default employs robust encryption. Because WireGuard is opinionated, it does not allow users to customize encryption and settings, instead opting for industry-best defaults.

### Getting started with Tailscale

#### Sign up for an account

To get started, go to [tailscale.com](https://tailscale.com){:target="\_blank"} and create an account. Tailscale requires a Single Sign-On (SSO) provider, so you'll need an account with Google, Microsoft, Okta, OneLogin, Ping, or another compatible SSO identity provider.

#### Add a machine to your network

We'll need to add a machine to your network in order for Tailscale to be useful. Client-side software must be installed on each system. Linux, Windows, macOS, iOS, and Android are just a few of the platforms we support. Follow this [link](https://tailscale.com/download){:target="\_blank"} to download and install Tailscale on a system.

### Closing up

Congratulations! You've just built your very own Tailscale network! Simply repeat the preceding steps to add other devices, and you should be good to go.

When you've formed a network of numerous machines, the real fun and excitement begins. Tailscale assigns a unique 100.x.y.z IP address to each machine on the network, allowing you to establish stable connections between machines regardless of where they are in the world, whether they switch between different internet-accessible networks (e.g. home Ethernet, coffee shop Wi-Fi, or a cellular hotspot), or whether they are protected by a firewall.

Tailscale gives you the ability to connect to any computer in your network from anywhere in the globe using any standard network protocol.

I hope this page is useful, and I will continue to improve it in the future.
