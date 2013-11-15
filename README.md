dotfiles
========

My dotfiles for various things.

WARNING: THIS CAN HOSE YOUR SYSTEM

sudo apt-get -y install python-virtualenv
sudo pip -U pip virtualenv virtualenvwrapper

sudp apt-get -y install xmonad xmobar suckless-tools

sudo apt-get -y install keepass2 autocutsel

git clone https://github.com/dobrite/dotfiles.git
cd dotfiles
./load.sh

Prevent lightdm from running
============================

echo "manual" | sudo tee -a /etc/init/lightdm.override
remove "splash" from /etc/default/grub
sudo update-grub

Update vim submodules
=====================
git submodule init
git submodule update

Dropbox
=======
Install Dropbox in Unity
copy dropbox script to /etc/init.d/dropbox
sudo chmod +x /etc/init.d/dropbox
sudo update-rc.d dropbox defaults
