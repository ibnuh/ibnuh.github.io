---
layout: post
title: 'Better local development with .localhost subdomains'
date: 2025-06-28 10:21:00 +0700
---

If you're building web apps with multiple services running locally, like a frontend, an API, maybe an auth service, you're probably using `localhost` with different ports. It works, but there are some rough edges once cookies, CORS, or HTTPS get involved.

`.localhost` subdomains can help smooth things out.

## How .localhost works

**Any subdomain under `*.localhost` resolves to `127.0.0.1` (your local machine)**, on macOS, Linux, and Windows, without any configuration.

<pre class="mermaid">
graph TD
    A[web.localhost:3000] --> B[127.0.0.1:3000]
    C[anything.you.want.localhost:3001] --> D[127.0.0.1:3001]
    E[auth.localhost:5000] --> F[127.0.0.1:5000]
    G[payments.localhost:5002] --> H[127.0.0.1:5002]

    B --> I[Frontend App]
    D --> J[Backend API]
    F --> K[Auth Service]
    H --> L[Webhook Listener]

    classDef domainNode fill:#2d2d2d,stroke:#14b8a6,stroke-width:2px,color:#e4e4e4
    classDef ipNode fill:#343030,stroke:#f59e0b,stroke-width:2px,color:#e4e4e4
    classDef serviceNode fill:#1f1f1f,stroke:#f97316,stroke-width:2px,color:#e4e4e4

    class A,C,E,G domainNode
    class B,D,F,H ipNode
    class I,J,K,L serviceNode
</pre>

## Clean multi-service dev environments

Instead of remembering which port maps to which service, you can use subdomains:

* `web.localhost:3000` → your frontend
* `api.localhost:3001` → backend service
* `auth.localhost:5000` → auth or mock SSO
* `payments.localhost:5002` → webhook listener

All of these resolve to `127.0.0.1`. You can route them via your dev proxy (Vite, Webpack, Traefik) or just hardcode ports.

The URLs end up looking closer to production, which makes configuration a bit more straightforward.

## Cookie behavior on `localhost`

There are a few things worth knowing about how cookies work on `localhost`.

### Ports do not separate cookies

Browsers don't consider the port when scoping cookies. A cookie set on `localhost:3000` gets sent to `localhost:3001` too. In production, your services would be on separate domains or subdomains with their own cookie space. On localhost, they all share one.

This can lead to:

* Cookies being shared across unrelated services
* Difficulty testing `Domain`, `Path`, or `SameSite` behavior accurately

<pre class="mermaid">
graph TB
    A[localhost:3000] --> B[Cookie Jar]
    C[localhost:3001] --> B
    D[localhost:5000] --> B
    E[localhost:5002] --> B

    classDef portNode fill:#2d2d2d,stroke:#14b8a6,stroke-width:2px,color:#e4e4e4
    classDef cookieNode fill:#f59e0b,stroke:#f59e0b,stroke-width:2px,color:#1a1a1a

    class A,C,D,E portNode
    class B cookieNode
</pre>

### `127.0.0.1` and `localhost` are not treated the same

Although `127.0.0.1` and `localhost` both point to your local machine, browsers treat them as different origins. A cookie set on `localhost:3000` won't be sent with requests to `127.0.0.1:3001`.

### Using `.localhost` subdomains

With `.localhost` subdomains, each service gets its own domain, which means:

* Domain separation for cookies
* Cookie sharing when you want it, via `Domain=.localhost`
* `SameSite` and `Secure` flags work as expected
* CORS behaves like it would in production

Some additional benefits:

* `localStorage` and `sessionStorage` are isolated by subdomain, not by port
* `SameSite=None` requires HTTPS, which `.localhost` supports with mkcert
* URLs resemble your production setup

## Reserved by spec, supported everywhere

Per [RFC 6761](https://www.rfc-editor.org/rfc/rfc6761.html), `.localhost` is a reserved TLD. It resolves to `127.0.0.1` or `::1` without hitting external DNS servers.

This works on all major operating systems:
- **macOS**: Built-in DNS resolver
- **Linux**: Systemd-resolved and others
- **Windows**: Windows DNS resolver

Some things this gives you:

* **No DNS leaks.** `.localhost` stays local even if your VPN or DNS config is off.
* **No external traffic.** Requests stay on your machine.
* **No conflicts.** `.localhost` is unregistrable as a real domain.

## TLS support with mkcert

Some cookie features (like `SameSite=None`) require HTTPS. [`mkcert`](https://github.com/FiloSottile/mkcert) makes it easy to generate trusted certificates for `*.localhost` domains:

```bash
# Install mkcert
brew install mkcert  # macOS
# or
sudo apt install mkcert  # Ubuntu/Debian
# or
choco install mkcert  # Windows (Chocolatey)

# Install the local CA
mkcert -install

# Generate certificates for your domains
mkcert web.localhost api.localhost auth.localhost
```

This gets you `https://web.localhost`, `https://api.localhost`, etc. with valid TLS.

## Works with proxies, containers, and dev tools

`.localhost` fits into existing setups:

* Subdomain routing to map `web.localhost` to one container, `api.localhost` to another
* Proxies can route based on host headers
* Frontend tools like Vite, Next.js, and Create React App support localhost subdomains
* Test frameworks like Cypress treat `.localhost` as a trusted domain

### Example Vite configuration

```javascript
// vite.config.js
export default {
  server: {
    host: 'web.localhost',
    port: 3000,
    https: true
  }
}
```

### Example Docker Compose setup

```yaml
# docker-compose.yml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    extra_hosts:
      - "web.localhost:127.0.0.1"
      - "api.localhost:127.0.0.1"
```

### Environment variables

```javascript
// config.js
const isDev = process.env.NODE_ENV === 'development';

export const config = {
  apiUrl: isDev ? 'https://api.localhost' : 'https://api.production.com',
  authUrl: isDev ? 'https://auth.localhost' : 'https://auth.production.com',
  webUrl: isDev ? 'https://web.localhost' : 'https://app.production.com'
};
```

## Common gotchas

### Browser caching

Browsers sometimes cache DNS lookups. If subdomains aren't resolving:

```bash
# macOS
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

# Linux
sudo systemctl restart systemd-resolved

# Windows
ipconfig /flushdns
```

### Port conflicts

```bash
# Check what's running on port 3000
lsof -i :3000
```

### SSL certificate issues

```bash
# Reinstall mkcert CA
mkcert -install

# Regenerate certificates
mkcert -key-file key.pem -cert-file cert.pem web.localhost api.localhost
```

## Final thoughts

`.localhost` is part of the spec for a reason. It gives you:

* **Local-only domains** that are DNS-safe and work on macOS, Linux, and Windows
* **Clean subdomain structure** for microservices or frontends
* **Accurate cookie, storage, and CORS behavior**
* **Easy HTTPS** with tools like mkcert
* **Less config and fewer bugs** when you go live
