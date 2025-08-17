#!/usr/bin/env bats

setup() {
  REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
  export REPO_ROOT
  export PATH="/opt/homebrew/bin:$REPO_ROOT/tests/bin:$PATH"
  # Ensure the script uses the mock gh explicitly
  export GH_CMD="$REPO_ROOT/tests/bin/gh"
  export GH_API_LOG="$BATS_TEST_TMPDIR/gh.log"
}

@test "lock with --lock-branch includes lock_branch=true and approvals=6" {
  run bash "$REPO_ROOT/src/branch-lock" -y --config "$REPO_ROOT/tests/fixtures/branch-lock.lock.yaml" --lock-branch lock
  [ "$status" -eq 0 ]
  # JSON is valid and fields match
  run jq -e . "$GH_API_LOG"
  [ "$status" -eq 0 ]
  jq -r '.required_pull_request_reviews.required_approving_review_count' "$GH_API_LOG" | grep -q '^6$'
  jq -r '.lock_branch' "$GH_API_LOG" | grep -q '^true$'
}

@test "unlock without lock_branch in YAML omits the field" {
  run bash "$REPO_ROOT/src/branch-lock" -y --config "$REPO_ROOT/tests/fixtures/branch-lock.no-lb.yaml" unlock
  [ "$status" -eq 0 ]
  run jq -e '.lock_branch' "$GH_API_LOG"
  [ "$status" -ne 0 ]  # campo ausente
}
