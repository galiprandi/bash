# awt (Automation Workflow Task)

Interactive helper to create development tasks and wire GitHub with Jira.

## Features

- Guided prompts to:
  - Choose change type (feat/fix/docs/style/refactor/perf/test/chore)
  - Enter Jira ticket (e.g., EGG-123)
  - Title and branch name suggestion
  - Create branch, empty commit with ticket and title
  - Update CHANGELOG.md and commit
  - Push branch and open draft PR (if `gh` is available)
- Advanced options to merge branches between environments.

## Prerequisites

- Git installed and a Git repository (`.git`) present.
- Optional: GitHub CLI (`gh`) authenticated to auto-create a draft PR.

## Usage

```bash
chmod +x src/awt
./src/awt
```

Follow the on-screen prompts. For advanced options, select "Advanced options" from the menu.
