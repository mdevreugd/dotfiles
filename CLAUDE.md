# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **chezmoi-managed dotfiles repository** for macOS. It automates the setup of development machines using templated configuration files, encrypted secrets via age, and 1Password integration for credential management.

## Key Commands

```bash
# Apply dotfiles to home directory
chezmoi apply

# Preview changes before applying
chezmoi diff

# Re-initialize (re-prompts for personal/vault/device settings)
chezmoi init

# Edit a managed file (opens source, applies on save)
chezmoi edit ~/.zshrc

# Add a new file to be managed
chezmoi add ~/.some-config

# Encrypt a file for the repository
chezmoi encrypt path/to/file > path/to/file.age
```

## Architecture

### File Naming Conventions

Chezmoi uses special prefixes to control behavior:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Translates to `.` in home directory (e.g., `dot_zshrc` → `~/.zshrc`) |
| `.tmpl` | Template file processed with Go text/template |
| `.age` | Age-encrypted file (decrypted during apply) |
| `run_once_` | Script runs once per machine |
| `run_onchange_` | Script re-runs when source file changes |
| `_before_` | Script runs before chezmoi applies files |
| `_after_` | Script runs after chezmoi applies files |

### Template Variables

Defined in `.chezmoi.toml.tmpl` and available in all `.tmpl` files:

- `.personal` (bool) - True for personal machines, false for work
- `.vault` (string) - 1Password vault name ("Private" for personal, custom for work)
- `.deviceType` (string) - "Laptop" or "Desktop" (determines SSH key selection)

### 1Password Integration

Secrets are pulled from 1Password using the `onepasswordRead` template function:
```
{{ onepasswordRead "op://Private/Git Config/name" }}
```

The repository expects these 1Password items:
- `Git Config` (per vault) - name, email fields
- `SSH Key - Laptop` or `SSH Key - Desktop` - SSH signing key
- `chezmoi age key` (Private vault) - age secret key for decryption
- `rclone-dropbox` (Private vault, personal only) - Dropbox OAuth token

### Script Execution Order

Scripts run in alphanumeric order within their phase:
1. `run_once_before_00-age-key.sh.tmpl` - Extract encryption key from 1Password
2. `run_once_before_01-install-homebrew.sh` - Install Homebrew
3. (chezmoi applies dotfiles)
4. `run_onchange_after_02-brew-bundle.sh.tmpl` - Install/update Homebrew packages
5. `run_once_03-*` through `run_once_99-*` - Post-apply setup scripts

### Conditional Content

Use `.personal` to include content only on personal machines:
```
{{- if .personal }}
# Personal-only configuration
{{- end }}
```

The `.chezmoiignore` file excludes `dot_config/rclone` on non-personal machines.

## Adding New Configuration

1. **Regular config file**: `chezmoi add ~/.config/app/config`
2. **Templated config**: Add file with `.tmpl` suffix, use template syntax
3. **Encrypted file**: `chezmoi add --encrypt ~/.config/app/secret.conf`
4. **Setup script**: Create `run_once_NN-description.sh` with appropriate prefix

## Testing Changes

```bash
# See what would change without applying
chezmoi diff

# Apply to a specific file only
chezmoi apply ~/.zshrc

# Verify chezmoi state matches source
chezmoi verify
```
