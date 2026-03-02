USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
USER_BINS="$USER_DOTS/scripts/bin"
LOCAL_BIN="$USER_HOME/.local/bin"

mkdir -p $USER_HOME/repos
mkdir -p $LOCAL_BIN
echo "Setup script requires gum..."
sudo pacman -Syy
sudo pacman -S --needed --noconfirm gum

cd $USER_HOME/repos
echo "Cloning GitHub Repository..."
git clone https://github.com/reg1z/omarchy-overrides
cd omarchy-overrides/scripts
./link-bins.sh
sleep 1
dots-setup
