# Dotfiles

## Fresh machine setup

1. Sign into Apple ID (System Settings → Apple Account)
2. Install and sign into [1Password](https://1password.com/downloads)
3. Install chezmoi:
```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   export PATH="$HOME/.local/bin:$PATH"
```
4. Apply dotfiles:
```bash
   chezmoi init --apply mdevreugd/dotfiles
```
