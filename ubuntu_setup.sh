#!/bin/zsh

CODENAME=$(lsb_release -cs);
echo "CODENAME = $CODENAME"

PG_VER=9.5

# Make directories
mkdir -p ~/Documents/projects

sudo apt install -y zsh git mc libssl-dev xsel libreadline-dev
sudo apt install -y libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev
sudo apt install -y libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev
sudo apt install -y xz-utils tk-dev cmake libboost-all-dev python3-dev silversearcher-ag

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change default shell to zsh
chsh -s $(which zsh)

# Install pyenv 
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | zsh
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.3

# Compile vim
LDFLAGS="-Wl,-rpath=${HOME}/.pyenv/versions/3.7.3/lib" ./configure --with-features=huge --enable-fail-if-missing \
--enable-multibyte \
--enable-python3interp=dynamic \
--enable-terminal \
--disable-gui --with-x --enable-largefile --disable-netbeans
