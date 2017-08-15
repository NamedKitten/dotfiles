CURRENT_DIR=$PWD

echo "Installing dotfiles."
rsync -avzP dotfiles/.[^.]* ~
cp -v ~/.Xresources ~/.Xdefaults

FONT_HOME=~/.local/share/fonts
echo "installing fonts at $PWD to $FONT_HOME"
mkdir -p "$FONT_HOME/adobe-fonts/source-code-pro"
git clone --branch release --depth 1 'https://github.com/adobe-fonts/source-code-pro.git' "$FONT_HOME/adobe-fonts/source-code-pro"
sudo fc-cache -f -v "$FONT_HOME/adobe-fonts/source-code-pro"


if [ "$(command -v apt-get)" ]; then sudo apt-get install rxvt-unicode rofi -y;
elif [ "$(command -v pacman)" ]; then sudo pacman -S --noconfirm rxvt-unicode rofi;
else echo "Can't install packages.";
fi

xrdb ~/.Xresources

if [ ! "$(command -v neofetch)" ];
then
  cd /tmp
  git clone https://github.com/dylanaraps/neofetch --depth 1
  cd neofetch
  sudo make install
  cd $CURRENT_DIR
fi
