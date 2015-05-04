DOTFILESDIR=$(dirname $0)
export LC_ALL="en_US.UTF-8"

cd $DOTFILESDIR
git submodule init
git submodule update --remote

cd ~
for F in $(ls -A $DOTFILESDIR); do
  rm -rf $F
  ln -s $DOTFILESDIR/$F
done
rm .git .gitmodules bootstrap.sh
