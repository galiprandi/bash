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
- Optional: toggle GitHub's `lock_branch` (read-only branch) from YAML or with a CLI flag.

Example configuration (`src/branch-lock.yaml`):

```yaml
lock:
  required_approvals: 6
  lock_branch: true        # optional, if true sets branch as read-only on lock
unlock:
  required_approvals: 0
  lock_branch: false       # optional, if false clears read-only on unlock

repositories:
  - org: galiprandi
    repo: bash
    branch: main
    # Optional per-repo overrides
    # lock:
    #   required_approvals: 4
    #   lock_branch: true
    # unlock:
    #   required_approvals: 1
    #   lock_branch: false
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

# Toggle lock_branch explicitly (overrides YAML):
./src/branch-lock --lock-branch lock     # sets lock_branch: true
./src/branch-lock --lock-branch unlock   # sets lock_branch: false

# If your current directory is the repo root and your config is at src/branch-lock.yaml:
./src/branch-lock --config src/branch-lock.yaml lock
./src/branch-lock --config src/branch-lock.yaml --lock-branch lock
```

Flags:

- `--yes`, `-y`: skip confirmation
- `--quiet`, `-q`: minimal output
- `--config <file>`: custom YAML path
- `--lock-branch`: toggles `lock_branch` (true on lock, false on unlock). If omitted, only YAML controls it.

Notes:

- Approvals are capped 0..6 per GitHub API.
- The tool sets PR approvals and minimal protection fields.
- `lock_branch` precedence:
  1) CLI `--lock-branch` (if provided)
  2) Per-repo YAML override (`repositories[].lock|unlock.lock_branch`)
  3) Global YAML (`lock.lock_branch` / `unlock.lock_branch`)
  4) If unspecified, the script does not modify `lock_branch`.

Tip: If you see "Configuration file 'branch-lock.yaml' not found", pass `--config src/branch-lock.yaml` or run the script from the `src/` directory.

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
