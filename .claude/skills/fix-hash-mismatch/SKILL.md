---
name: fix-hash-mismatch
description: >
  Find open PRs with failing CI caused by Nix hash mismatches (vendorHash, cargoHash),
  then automatically fix them by extracting the correct hash from CI logs or rebuilding locally.
  Use this skill when the user mentions fixing hashes, hash mismatches, failing Renovate PRs,
  vendorHash, cargoHash, or wants to batch-fix CI failures on open PRs.
---

# Fix Hash Mismatches in Failing PRs

Automate fixing `vendorHash` (Go) and `cargoHash` (Rust) mismatches in open PRs with failing CI.
Each PR is processed in an isolated git worktree so the main working tree stays clean.

## Prerequisites

- `gh` CLI authenticated with push access to this repository
- `nix` available with flakes enabled
- Current directory is the repository root

## Workflow

### Step 1: Find open PRs with failing CI

```bash
gh pr list --state open --json number,title,headRefName --limit 50
```

For each PR, check CI status:

```bash
gh pr checks <PR_NUMBER> --json name,state,bucket
```

Collect PRs where any check has `bucket` equal to `"fail"` (or `state` equal to `"FAILURE"`). If none found, report and stop.

### Step 2: Filter to hash-mismatch candidates

For each failing PR, inspect the diff:

```bash
gh pr diff <PR_NUMBER> --name-only
```

A PR is a candidate when both conditions hold:

1. It modifies files in `_sources/` (indicating a version bump by Renovate/nvfetcher).
2. It does NOT already modify a `vendorHash` or `cargoHash` line in `pkgs/*/default.nix`.

To confirm condition 2, check the full diff for changes to hash lines:

```bash
gh pr diff <PR_NUMBER> | grep -E '^\+.*?(vendorHash|cargoHash)\s*='
```

If that grep matches, the PR already updates the hash — skip it.

### Step 3: Identify the package

Determine which package needs a hash fix:

1. The PR title from Renovate follows `chore(deps): update dependency <owner>/<repo> to <version>`. The repo name maps to a package directory under `pkgs/`.
2. Cross-reference with root `default.nix` to find the exact package attribute name used by `nix build .#<name>`.
3. Read `pkgs/<package>/default.nix` and identify the hash field:
    - `vendorHash` — Go package (`buildGoModule` / `buildGo126Module`)
    - `cargoHash` — Rust package (`buildRustPackage`)
    - If `vendorHash = null;`, skip this PR (vendored deps, no hash update needed).

Also handle the `overrideAttrs` pattern (e.g., `pkgs/ghq/default.nix`) where `vendorHash` appears inside the override block. In this pattern `lib` is typically not in scope.

### Step 4: Create a worktree

Create an isolated worktree for the PR branch. This avoids touching the main working tree.

```bash
git fetch origin <headRefName>
mkdir -p .wt
git worktree add .wt/<package> -b fix-hash-<package> origin/<headRefName>
cd .wt/<package>
```

The `.wt/` directory is in the repository root. The `-b` flag creates a local branch tracking the remote, avoiding detached HEAD. All subsequent steps run inside this worktree directory.

### Step 5: Extract the correct hash

Try CI logs first, then fall back to a local build.

#### 5a: Try CI logs

```bash
gh run list --branch <headRefName> --status failure --json databaseId --limit 1
gh run view <runId> --log 2>&1 | grep -o 'got:\s*sha256-[A-Za-z0-9+/]*='
```

Extract the `sha256-...=` portion from the matched line.

If a `sha256-...` value is found, use it as the correct hash. Proceed to Step 6.

#### 5b: Fallback — local build with fake hash

If CI logs do not contain the hash (e.g., logs expired or truncated):

1. In `pkgs/<package>/default.nix`, replace the current hash value with a fake hash:
    - If `lib` is in the file's function arguments: use `lib.fakeHash` (unquoted, it is a Nix expression)
    - If `lib` is NOT available (e.g., `overrideAttrs` pattern): use the string literal `"sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="`
2. Build and capture the error:

   ```bash
   nix build .#<packageName> 2>&1
   ```

3. Parse the correct hash from the output: look for `got:    sha256-XXXX=`.
4. If the build error does NOT contain a hash mismatch, this is not a hash-only problem. Restore the file, skip this PR, and report it as needing manual attention:

   ```bash
   git checkout -- pkgs/<package>/default.nix
   ```

### Step 6: Update the hash

Replace the fake hash (or old hash if using CI log result) with the correct hash value as a quoted string in `pkgs/<package>/default.nix`.

For example:

```text
vendorHash = "sha256-CORRECT_HASH_HERE=";
```

### Step 7: Verify the build

```bash
nix build .#<packageName>
```

If it succeeds, proceed to commit. If it fails with another hash mismatch (different derivation), repeat Steps 5b-6 for the new hash. If it fails for a non-hash reason, restore the file, skip this PR, and report it.

### Step 8: Commit and push

Extract the version from the PR title (`chore(deps): update dependency <name> to <version>`).

Check `git status` first. A linter hook may have already committed the change automatically. If the working tree is clean and the latest commit contains the hash update, skip to push.

Otherwise, commit manually:

```bash
git add pkgs/<package>/default.nix
git commit -m "chore(<package>): update <vendorHash|cargoHash> for <version>"
```

Then push:

```bash
git push origin HEAD:<headRefName>
```

If `git push` is blocked by a hook, ask the user to run it manually and provide the exact command.

Rules:

- NEVER use `git add .` or `git add -A`
- NEVER use `git commit --amend`
- Stage only the specific file that was changed

### Step 9: Clean up worktree

```bash
cd <repository-root>
git worktree remove .wt/<package>
```

Always clean up even if the PR was skipped.

### Step 10: Repeat

Go back to Step 4 for the next candidate PR.

### Step 11: Report results

Summarize what was done:

- **Fixed**: List each PR number, package name, hash type, old hash, new hash.
- **Skipped**: List each skipped PR with the reason (not a hash mismatch, `vendorHash = null`, build failure for other reasons, etc.).