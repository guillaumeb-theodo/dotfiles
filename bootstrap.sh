DOTFILESDIR=$(dirname $0)

cd $DORFILESDIR
git submodule init
git submodule update --remote

cd ~
for F in $(ls -A $DOTFILESDIR); do
  rm -rf $F
  ln -s $DOTFILESDIR/$F
done
rm .git .gitmodules bootstrap.sh
