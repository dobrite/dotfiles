dotfiles
========

My dotfiles for various things.

WARNING: THIS WILL HOSE YOUR SYSTEM

sudo apt-get -y install python-virtualenv
sudo pip -U pip virtualenv virtualenvwrapper

sudp apt-get -y install xmonad xmobar suckless-tools

sudo apt-get -y install keepass2 autocutsel 

git clone https://github.com/dobrite/dotfiles.git
cd dotfiles
chmod +x load.sh
./load.sh

echo "manual" | sudo tee -a /etc/init/lightdm.override
remove "splash" from /etc/default/grub
sudo update-grub

git submodule init
git submodule update

sudo ln -s ~/dotfiles/switch-sound-output.sh /usr/local/bin
