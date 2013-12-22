dotfiles
========

My dotfiles for various things.

sudo apt-get -y install libghc-xmonad-contrib-dev xmonad

git clone https://github.com/dobrite/dotfiles.git
cd dotfiles
./load.sh

Update vim submodules
=====================
git submodule init
git submodule update

Dropbox
=======
http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
cp -r dropbox /etc/init.d/dropbox
sudo chmod +x /etc/init.d/dropbox
sudo update-rc.d dropbox defaults

XMonad and XFCE
===============
Do the "ensure xmonad get started"
www.haskell.org/haskellwiki/Xmonad/Using_xmonad_in_XFCE#Configuring_XMonad_to_work_with_Xfce
