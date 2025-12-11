# Dotfiles

## Prerequisites in 1Password

Before setting up a new device, ensure the following items exist in 1Password:

### Git Config (per vault)
Create a "Git Config" item (Secure Note or Login) in each vault you'll use:
- **Private** vault (personal devices)
- **Work** vault (work devices)

Fields required:
- `name` - Git user name
- `email` - Git email address

### SSH Key (per device)
Create an SSH Key item named `SSH Key - <hostname>` in the appropriate vault.

To find your hostname:
```bash
hostname -s
```

Example: If your hostname is `My-MacBook`, create `SSH Key - My-MacBook` in the Private vault.

## Fresh machine setup

1. Sign into Apple ID (System Settings → Apple Account)

2. Install and sign into [1Password](https://1password.com/downloads)

3. Enable 1Password integrations:
   - 1Password → Settings → Developer → Enable **SSH Agent**
   - 1Password → Settings → Developer → Enable **Integrate with 1Password CLI**

4. Install chezmoi:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
export PATH="$HOME/.local/bin:$PATH"
```

5. Apply dotfiles:
```bash
chezmoi init --apply mdevreugd/dotfiles
```

During init, you'll be asked:
- "Is this a personal machine (yes/no)?"
  - Yes → uses `Private` vault
  - No → prompts for work vault name

6. Initialize Rust toolchain (if not already done):
```bash
rustup default stable
```

## Manual steps

After setup, complete these manual configurations:

### Spotlight
- System Settings → Keyboard → Keyboard Shortcuts → Spotlight
- Disable "Show Spotlight search"

### Alfred
- Open Alfred → Preferences → General
- Set hotkey to Cmd+Space
- Grant accessibility permissions when prompted
- Set preferences sync folder

### Rectangle Pro
- Grant accessibility permissions when prompted
- Configure preferred window management shortcuts

### iTerm2
- Font is already set to MesloLGS Nerd Font
- Preferences are synced from `~/.config/iterm2`

## What's included

### Tools
- bat, gh, git, go, neovim, pyenv, rustup, terraform, tree

### Apps
- 1Password, Alfred, Claude Code, Firefox, Chrome, iTerm2, Rectangle Pro, VS Code

### Personal-only apps
- Brave, Microsoft Edge, Opera

### Configurations
- Git with 1Password SSH signing
- SSH agent via 1Password
- Zsh with oh-my-zsh, syntax highlighting, autosuggestions
- VS Code settings (symlinked)
- iTerm2 preferences
- macOS defaults (dock autohide, key repeat, etc.)
