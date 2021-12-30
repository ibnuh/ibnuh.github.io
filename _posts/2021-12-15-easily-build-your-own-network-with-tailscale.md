---
layout: post
title: 'Easily build your own network with Tailscale'
date: 2021-12-15 19:52:00 +0700
---

![Tailscale device management page](/images/tailscale.png)

As a tech geek and software engineer, I maintain a small personal network where I keep all of my devices connected together, ranging from my development machines, local linux box, [HTPC server](https://en.wikipedia.org/wiki/Home_theater_PC), remote vps, to a [type 1 hypervisor running with proxmox](https://twitter.com/ibnuhx/status/1439492725129183234).

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

Tailscale focuses on usability. You can start using Tailscale by downloading the client on the new devices, and then signing in through an SSO account, like Google account or GitHub. There is no need for a separate set of credentials. Then, that new devices is directly be a part of the network and can connect to anything else already on the network, as restricted by access control lists (ACLs)[^1].

Tailscale is a peer-to-peer mesh VPN which allows for direct connections between devices, whereas OpenVPN is a VPN with a concentrator that funnels traffic between devices.

Tailscale is based on WireGuard, and uses strong encryption by default. WireGuard is opinionated so does not allow for user-controlled encryption and settings, and instead uses industry-best default settings.

### Getting started with Tailscale

#### Sign up for an account

Head down to their website [tailscale.com](https://tailscale.com) and register, Tailscale requires a Single Sign-On (SSO) provider, so you’ll need a Google, Microsoft, Okta, OneLogin, Ping, or other supported SSO identity provider account to begin.

#### Add a machine to your network

In order for Tailscale to be useful, we need to add a machine to your network. Each machine needs to run some client-side software. We support popular platforms like Linux, Windows, macOS, iOS, and Android. Download and setup Tailscale on a machine by following this [link](https://tailscale.com/download).

### Closing up

Congratulations! You just created your own personal Tailscale network! To add more devices, just repeat previous steps and you should be good to go.

Once you have a network of multiple machines established, that’s when all the fun and excitement begins. Tailscale provides each machine on the network with a unique 100.x.y.z IP address so that you can establish stable connections between machines regardless of where those machines are located in the world[^2], regardless of whether they switch between different internet-accessible networks (e.g. home Ethernet, coffee shop Wi-Fi, or a cellular hotspot), and regardless of whether they are behind a firewall[^3].

Tailscale allows you to connect to any machine in your network, from anywhere in the world, over any standard network protocol.

Hope this article helps and I will be adding more updates in the future.

---

[^1]: https://tailscale.com/kb/1170/tailscale-vs-openvpn
[^2]: https://tailscale.com/kb/1017/install
[^3]: https://tailscale.com/kb/1151/what-is-tailscale
