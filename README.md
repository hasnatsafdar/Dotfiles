# Dotfiles for Debian-i3wm

![Screenshot](Screenshots/screenshot.png)

# ⚙️ Post-Install Configuration

```bash
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```
### Things to consider working with:

**Minimal hacker password workflow:**

1. Use **`gopass`** (modern `pass`) — GPG-encrypted passwords versioned with **Git**.
2. Keep multiple vaults (e.g., `personal`, `work`), each synced to a **private Git repo**.
3. Trigger a keybinding → `fzf` lists entries → pick one → `gopass show` + `xdotool` **types password** into current window.
4. Push/pull repos to sync across devices; your **GPG key** is the only secret.
    
    ➡️ 100% local, encrypted, scriptable, and as fast as Bitwarden autofill.
    

**System-wide adblocking =** self-hosting ad-guard or pi-hole

Private git repo obsidian notes and all passwords with pass or go pass etc.

Shxkd for managing keybinds that remain more or less the same across all WMs.
