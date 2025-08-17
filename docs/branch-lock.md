# branch-lock

Multi-repo GitHub branch protection manager focused on required PR approvals.

- Requires: GitHub CLI (`gh`) authenticated, and `yq` for YAML parsing.
- Config file: `src/branch-lock.yaml` with global defaults and per-repo overrides.
- Actions: `lock` (set required approvals) and `unlock` (set different approvals, minimal protection retained).
- Optional: toggle GitHub's `lock_branch` (read-only branch) from YAML or with a CLI flag.

## Installation

```bash
chmod +x src/branch-lock
```

## Configuration

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
    # Optional per-repository overrides
    # lock:
    #   required_approvals: 4
    #   lock_branch: true
    # unlock:
    #   required_approvals: 1
    #   lock_branch: false
```

## Usage

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

### Flags

- `--yes`, `-y`: skip confirmation
- `--quiet`, `-q`: minimal output
- `--config <file>`: custom YAML path
- `--lock-branch`: toggles `lock_branch` (true on lock, false on unlock). If omitted, only YAML controls it.

### Notes

- Approvals are capped 0..6 per GitHub API.
- The tool sets PR approvals and minimal protection fields.
- `lock_branch` precedence:
  1) CLI `--lock-branch` (if provided)
  2) Per-repo YAML override (`repositories[].lock|unlock.lock_branch`)
  3) Global YAML (`lock.lock_branch` / `unlock.lock_branch`)
  4) If unspecified, the script does not modify `lock_branch`.

## Testing

We use bats-core with a mocked `gh` to test `src/branch-lock` without hitting GitHub.

Requirements (macOS):

```bash
brew install bats-core jq yq
```

Run tests:

```bash
# Ensure mock is executable (first time only)
chmod +x tests/bin/gh

# Run all tests
bats tests

# If bats is not on PATH (Homebrew installs as bats):
/opt/homebrew/bin/bats tests
```

Notes:

- The test suite prepends `tests/bin` to `PATH` so the mock `gh` is used.
- JSON payloads sent to the mock are validated with `jq` and saved to `$GH_API_LOG` for assertions.
