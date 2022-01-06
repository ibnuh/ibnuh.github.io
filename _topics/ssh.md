---
layout: topics
topics: ssh
---

SSH is a cryptographic network protocol for securely executing network services over an unsecured network. Remote command-line, login, and command execution are common applications, although SSH can be used to protect any network service.

SSH uses a client–server architecture to create a secure route over an insecure network by connecting an SSH client program to an SSH server. SSH-1 and SSH-2 are the two primary versions of the protocol specified in the specification. SSH uses port 22 as its default TCP port. SSH is most commonly used to connect to Unix-like operating systems, but it can also be used on Windows. The default SSH client and server in Windows 10 is OpenSSH.

SSH was created to replace Telnet and other unsecured remote shell protocols like Berkeley rsh and its related rlogin and rexec protocols. Those protocols send sensitive data in unencrypted, including passwords, making them vulnerable to interception and disclosure via packet analysis. SSH's encryption is designed to offer data secrecy and integrity over an insecure network like the Internet.
