cd ~/.dotfiles
git submodule init
git submodule update --remote

cd ~
for F in $(ls -A .dotfiles); do
  rm -rf $F
  ln -s .dotfiles/$F
done
rm .git .gitmodules .gitignore
