# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Homebrew tap for the GIA (General Intelligence Assistant) application. It follows Homebrew's tap conventions with formulas in the `Formula/` directory.

## Architecture

- **Formula/gia.rb**: Main Homebrew formula for GIA
  - Supports both Intel (x86_64) and Apple Silicon (aarch64) architectures
  - Downloads pre-built binaries from GitHub releases
  - Installs two binaries: `gia` (CLI) and `giagui` (GUI)
  - Handles macOS Gatekeeper quarantine removal in post_install

## Testing and Validation

Testing uses Homebrew's official `brew test-bot` workflow:

```bash
# Syntax validation
brew test-bot --only-tap-syntax

# Full formula testing (runs install, test block, audit)
brew test-bot --only-formulae

# Manual testing
brew install --build-from-source Formula/gia.rb
brew test gia
brew audit --strict gia
```

## Updating the Formula

### Automated Updates (Recommended)

The formula is **automatically updated** when new releases are published in the main [github.com/mschnecke/gia](https://github.com/mschnecke/gia) repository:

1. Create a new release in the main gia repository with tag format `vX.Y.Z` (e.g., `v0.1.197`)
2. Include release assets: `gia-macos-x86_64-vX.Y.Z.tar.gz` and `gia-macos-aarch64-vX.Y.Z.tar.gz`
3. The automation workflow will:
   - Download both architecture variants
   - Calculate SHA256 hashes
   - Update [Formula/gia.rb](Formula/gia.rb) with new version and hashes
   - Commit and push changes automatically

### Manual Updates

If needed, you can manually trigger the update workflow:

```bash
# Via GitHub Actions UI
# Go to Actions → Update Formula → Run workflow
# Enter version: 0.1.197, formula: gia

# Or update locally
1. Update `version` field in Formula/gia.rb
2. Download new release artifacts and calculate SHA256:
   shasum -a 256 gia-macos-x86_64-v0.1.197.tar.gz
   shasum -a 256 gia-macos-aarch64-v0.1.197.tar.gz
3. Update both `sha256` fields (Intel and ARM)
4. Test locally before pushing
```

## CI/CD

- **tests.yml**: Runs on pushes/PRs, validates syntax and tests formulas across Ubuntu and macOS (Intel + ARM)
- **publish.yml**: Handles bottle publishing when PR is labeled with `pr-pull`
- **update-formula.yml**: Automated formula updates triggered by releases in main gia repository
  - Uses [.github/scripts/update-formula.sh](.github/scripts/update-formula.sh) to download assets, calculate SHA256, and update formula
  - Requires `GH_PERSONAL_TOKEN` secret in main gia repository with `repo` and `workflow` scopes
