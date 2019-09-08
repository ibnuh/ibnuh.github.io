---
layout: post
title: 'Remote SSH into Android Termux'
date: 2019-09-08 09:52:00 +0700
---

Termux is a powerful terminal emulation for Android, with broad community and robust package manager. Making it easier to run linux computing right in your pocket these days.

This article will explain to you how to setup an SSH Server in Termux and allow you to connect to it from any client in your network.

> Following forward, I refer `$` as termux and `#` as remote machine.

## Installing required packages

Ensure everything is up to date

```
$ pkg upgrade
```

Install the `openssh` package

```
$ pkg install openssh
```

## Starting and stopping SSH Server

To start the SSH server, run this command

```
$ sshd
```

If you need to kill the server, just kill it's process

```
$ pkill sshd
```

## Setting up authentication

We will setup password and key authentication, to start we will setup password authentication and move to key authentication to simplify the process of copying public key to your android device.

You can skip the key authentication process if you don't care, keep in mind that password authentication is less secure than key authentication.

### Password authentication

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

At this point we're ready to start the SSH Server and connect to our android device. If you don't care about setting up key authentication, just skip to **Connecting**

```
# ssh anything@
```
