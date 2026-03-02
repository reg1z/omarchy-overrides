USER_HOME=$(eval echo "~${SUDO_USER:-$USER}")
USER_DOTS="$USER_HOME/repos/omarchy-overrides"
USER_BINS="$USER_DOTS/scripts/bin"
LOCAL_BIN="$USER_HOME/.local/bin"

mkdir -p $USER_HOME/repos
mkdir -p $LOCAL_BIN

cd $USER_HOME/repos
git clone https://github.com/reg1z/omarchy-overrides
cd omarchy-overrides/scripts
./link-bins.sh
sleep 1
dots-setup
