# dotfiles

My dotfiles for various things.

```
sudo apt-get -y install libghc-xmonad-contrib-dev xmonad
```

```
git clone https://github.com/dobrite/dotfiles.git
cd dotfiles
./load.sh
```

## Update vim submodules

```
git submodule init
git submodule update
```

## Dropbox

[do this](http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment)
then this...

```
cp -r dropbox /etc/init.d/dropbox
sudo chmod +x /etc/init.d/dropbox
sudo update-rc.d dropbox defaults
```

## XMonad and XFCE

Do the ["ensure xmonad get started"](www.haskell.org/haskellwiki/Xmonad/Using_xmonad_in_XFCE#Configuring_XMonad_to_work_with_Xfce).

## XFCE4 Keyboard Shortcuts

* Get rid of `windows` button opening whisker menu and win+p display properties.
* Remap win+p to open collapsed appfinder.
* Remove Super_L line and add xfce4-appfinder --collapsed to Super p entry.

```
sudo vim
/etc/xdg/xdg-default/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```
