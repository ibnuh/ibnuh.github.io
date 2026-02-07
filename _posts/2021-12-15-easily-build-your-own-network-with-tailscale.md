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

Keep in mind you still have to pay for it every month, a good and well-spec VPS from notable provider like Linode, Digitalocean and Vultr costs about $3 - $5 a month, we're going to look into how to eliminate this monthly expenses altogether with Tailscale.

### Inconvenience of adding new devices

Even through there are great solutions out there to manage OpenVPN users and credentials like Pritunl or OpenVPN's Web UI, managing whole set of network requires bits of knowledge to setup, creating new vpn user, downloading the vpn configuration file, transfer and import it to the new device, and only then you be able to connect.

### Sometimes unreliable

Whenever there is an issue with connectivity, prepare yourself to dig into the logs and spend extra time figuring out the issue, whether it is configuration issue, system issue, or worse there is someone in your network.

## Introducing Tailscale

On the headline of their website, its described as "A secure network that just works. Zero config VPN. Installs on any device in minutes, manages firewall rules for you, and works from anywhere.", thats pretty much sums it up.

There is a reason why software is served as a service nowadays (SaaS), the hassle of managing your own self hosted service is real and sometimes not fun when you encounter problems and had no one to help. With Tailscale, everything is managed by them.

The setup is dead simple - install the Tailscale client on a device, log in with your Google or GitHub account, and that's it. No extra credentials, no config files. The device just shows up on the network and can talk to everything else. You can also set up access control lists (ACLs) if you want to restrict what can connect to what.

OpenVPN is a VPN with a concentrator that directs traffic between devices, whereas Tailscale is a peer-to-peer mesh VPN that allows for direct connections between devices.

Tailscale is built on WireGuard and by default employs robust encryption. Because WireGuard is opinionated, it does not allow users to customize encryption and settings, instead opting for industry-best defaults.

### Getting started

Sign up at [tailscale.com](https://tailscale.com){:target="\_blank"} using your Google, Microsoft, or whatever SSO account you have. Then [download and install](https://tailscale.com/download){:target="\_blank"} the client on whatever devices you want to connect - they have packages for pretty much everything (Linux, Windows, macOS, iOS, Android).

Do the same thing on your other devices and you're done. Each device gets a stable 100.x.y.z IP address that works no matter where the device is - at home, at a coffee shop, behind a firewall, doesn't matter. Way less hassle than running your own OpenVPN server.
