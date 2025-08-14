# Bash Scripts Collection

A repository of all my personal bash scripts that I enjoy making.

## Table of Contents
- [About](#about)
- [Scripts](#scripts)
- [Usage](#usage)
- [Contribution](#contribution)
- [License](#license)

## About

This repository is a collection of various bash scripts that I have created for different purposes. These scripts are designed to simplify and automate various tasks.

## Scripts

### egg
A Egg Live app launcher and port forwarding tool.

### awt
A Egg Live script that simplifies starting a development task and links GitHub with Jira.

### branch-lock
Multi-repo GitHub branch protection manager focused on required PR approvals.

- Requires: GitHub CLI (`gh`) authenticated, and `yq` for YAML parsing.
- Config file: `src/branch-lock.yaml` with global defaults and per-repo overrides.
- Actions: `lock` (set required approvals) and `unlock` (set different approvals, minimal protection retained).

Example configuration (`src/branch-lock.yaml`):

```yaml
lock:
  required_approvals: 6
unlock:
  required_approvals: 0

repositories:
  - org: galiprandi
    repo: bash
    branch: main
    # Optional per-repo overrides
    # lock:
    #   required_approvals: 4
    # unlock:
    #   required_approvals: 1
```

Usage:

```bash
# Lock: enforce N approvals (from config)
./src/branch-lock lock

# Unlock: set approvals to the unlock value (from config)
./src/branch-lock unlock

# Flags
./src/branch-lock -y lock      # skip confirmation
./src/branch-lock -q unlock    # quiet header/action lines
./src/branch-lock -y -q lock   # combine
```

Notes:

- Approvals are capped 0..6 per GitHub API.
- The tool only sets the PR approvals rule and sends a minimal protection payload.

## Usage

To use any of the scripts, simply clone the repository and run the desired script from your terminal.

```bash
git clone https://github.com/yourusername/bash.git
cd bash
./script_name.sh
```

Replace `script_name.sh` with the name of the script you want to run.

## Contribution

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
