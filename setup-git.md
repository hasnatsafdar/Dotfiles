sudo apt update
sudo apt install git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --list
ssh-keygen -t ed25519 -C "your.email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
- Add the public key to 'https://github.com/settings/keys'
git clone git@github.com:your-username/your-repo.git
cd your-repo
echo "Some change" >> README.md
git add .
git commit -m "Your commit message"
git push origin main
git branch

