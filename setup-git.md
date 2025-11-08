# Git Setup & Workflow

A concise guide to set up Git and manage repositories after reinstalling your OS.

---

## 1. Install Git
```bash
sudo apt update
sudo apt install git
````

---

## 2. Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --list   # verify settings
```

---

## 3. Setup SSH Key for GitHub

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub   # copy this key
```

* Add the copied public key to [GitHub SSH Keys](https://github.com/settings/keys)

---

## 4. Basic Git Workflow

```bash
git clone git@github.com:your-username/your-repo.git
cd your-repo

# Make changes
echo "Some change" >> README.md

# Stage, commit, and push
git add .
git commit -m "Your commit message"
git push origin main

# Check branches
git branch
```

---

## 5. Dotfiles Repository Setup

For managing your dotfiles folder (`dotfiles_debian-i3`):

```bash
cd /path/to/dotfiles_debian-i3
git init
git add .
git commit -m "Initial commit"
```

### Using GitHub CLI (optional but recommended)

```bash
# Install GitHub CLI if not installed
sudo apt install gh

# Authenticate GitHub CLI
gh auth login

# Create a new GitHub repo and add remote
gh repo create hasnatsafdar/dotfiles_debian-i3 --public --source=. --remote=origin

# Push local repo
git push -u origin main
```

**Notes:**

* Replace `main` with `master` if your default branch differs.
* Use `--private` in the `gh repo create` command if you want a private repository.

---

## 6. Reference Commands

* `git status` → see file changes
* `git log` → view commit history
* `git pull` → update local repo with remote changes

```
