# egg (Egg Launcher)

Launcher and port-forwarding helper for Egg projects.

## Highlights

- Start frontends/APIs with predefined commands.
- Open Kubernetes port-forwards across environments (development/demo/production).
- Show logs for services in a chosen namespace.
- Self-update flow with backup and permission handling.

## Prerequisites

- kubectl, gcloud (for GKE), aws-cli (for EKS) as applicable.
- Optional: pino-pretty for pretty logs.

## Usage

```bash
chmod +x src/egg
./src/egg
```

Choose from the menu or pass a shortcut, e.g.:

```bash
./src/egg pf   # open all port-forwards
./src/egg pc   # close all port-forwards
./src/egg log  # pick service and namespace logs
```

Configuration lives in `~/egg.env` and is auto-created on first run with sensible defaults.
