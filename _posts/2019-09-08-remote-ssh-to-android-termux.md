---
layout: post
title: 'Remote SSH into Android Termux'
date: 2019-09-08 09:52:00 +0700
---

Termux is a powerful terminal emulation for Android, with broad community and robust package manager. Making it easier to run Linux computing right in your pocket these days.

This article will explain to you how to set up an SSH Server in Termux and allow you to connect to it from any client in your network.

> I refer `$` as termux and `#` as remote machine.

## Installing required packages

Ensure everything is up to date

```
$ pkg upgrade
```

Install the `OpenSSH` package

```
$ pkg install openssh
```

## Starting and stopping SSH Server

To start the SSH server, run this command

```
$ sshd
```

If you need to kill the server, just kill its process

```
$ pkill sshd
```

## Setting up password authentication

Ideally, we should set up key authentication, but for the sake of simplicity, I'm gonna skip that part, keep in mind that password authentication is less secure than key authentication.

Password authentication is enabled by default on termux, but you can still review the configuration by running

```
$ cat $PREFIX/etc/ssh/sshd_config
```

It should look pretty much like this

```
PrintMotd yes
PasswordAuthentication yes
PubkeyAcceptedKeyTypes +ssh-dss
Subsystem sftp /data/data/com.termux/files/usr/libexec/sftp-server
```

Set new password

```
$ passwd

New password:
Retype new password:
New password was successfully set.
```

At this point, we're ready to start the SSH Server and connect to the android device.

## Connecting from remote machine

First of all, we need to know the android device IP address on the device, get this by running

```
$ ifconfig
```

From this output, we know that the device IP address on the network is `192.168.100.92`

```
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.100.92  netmask 255.255.255.0  broadcast 192.168.100.255
        inet6 fe80::d4d0:8cac:6318:8ac9  prefixlen 64  scopeid 0x20<link>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 1118178  bytes 1321397645 (1.2 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 577939  bytes 80497172 (76.7 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

We're ready to connect to the android device from remote

```
# ssh anything@192.168.100.92 -p 8022
```

> You can connect using any username because termux doesn't care. In this example, I use `anything`.

Put in the password you've setup before, after that, you're in.

![SSH to Termux from remote machine](/images/termux-ssh-in.png)
