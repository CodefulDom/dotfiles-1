git config --global fetch.prune true
git config --global pull.rebase preserve
git config --global push.default simple

git config --global alias.ci "commit"
git config --global alias.ds "diff --staged"
git config --global alias.lag "log --all --graph --pretty=format:'%C(auto)%h%d %Cgreen%an %Cred(%cr) %Creset%s'"
git config --global alias.lg "log --graph --pretty=format:'%C(auto)%h%d %Cgreen%an %Cred(%cr) %Creset%s'"
git config --global alias.lp "log -p"
git config --global alias.st "status"

echo "git config --global credential.helper"
echo "    wincred"
echo "    /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring"
