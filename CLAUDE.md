# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal NUR (Nix User Repository) containing custom Nix packages. The repository follows the standard NUR structure with packages organized in `pkgs/` directories and defined in `default.nix`.

## Key Commands

### Building and Testing

- `nix build .#<package-name>` - Build a specific package (e.g., `nix build .#claude-code`)
- `nix flake check` - Check flake validity and build all packages
- `nix develop` - Enter development shell with nvfetcher available

### Formatting and Linting

- `nix fmt` - Format all files using treefmt configuration
- `nix run .#check-action` - Run actionlint and ghalint for GitHub Actions validation
- `nix run .#check-renovate-config` - Validate renovate.json5 configuration

### Package Management

- `nvfetcher` - Update package sources (run from dev shell)
- `nix eval .#packages.x86_64-linux --apply builtins.attrNames` - List all available packages

## Architecture

### Core Structure

- `default.nix` - Main package definitions, imports sources from `_sources/generated.nix`
- `overlay.nix` - Nixpkgs overlay for packages
- `flake.nix` - Flake configuration with packages, apps, and development environments
- `ci.nix` - CI-specific package filtering (buildable vs cacheable)

### Package Sources

- `nvfetcher.toml` - Package source definitions for nvfetcher
- `_sources/generated.nix` - Auto-generated source definitions (do not edit manually)
- `_sources/generated.json` - Auto-generated source metadata

### Package Organization

- `pkgs/` - Individual package definitions organized by name
- Each package has its own `default.nix` with source parameter
- Node.js packages use `nodeEnv.buildNodePackage` from `node2nix/node-env.nix`

### Development Workflow

1. Add new package source to `nvfetcher.toml`
1. Run `nvfetcher` to generate source definitions
1. Create package definition in `pkgs/<package-name>/default.nix`
1. Add package to `default.nix` (keep-sorted sections are automatically maintained)
1. Test with `nix build .#<package-name>`

## Formatting Configuration

The repository uses treefmt with multiple formatters:

- nixfmt for Nix files
- yamlfmt for YAML files
- mdformat for Markdown files
- keep-sorted for maintaining sorted sections
- Various GitHub Actions tools (ghatm, pinact, etc.)

## Important Notes

- Keep `# keep-sorted` sections in `default.nix` alphabetically ordered
- Use `nvfetcher` for managing package sources instead of manual updates
- All packages should have proper meta attributes (description, homepage, license)
- Node.js packages require `nodeEnv` parameter and use npm registry sources
