# switch to root because system packages can't be changed without root privileges
# This is not necessary for user based environment like virtualenv or pyenv

# Uninstall previous version of `uwsgi` if exists
. activate_venv.sh
pip uninstall uwsgi

# Install libraries for SSL support
sudo apt-get install libssl-dev

## Manually build uwsgi with SSL support
# set necessary lib paths
export CFLAGS="-I/usr/include/openssl"
# aarch64-linux-gnu folder used for ARM architecture and may be different for your env
# use [apt-file list libssl-dev] to check lib folders (apt-file should be additionally installed)
export LDFLAGS="-L/usr/lib/aarch64-linux-gnu"
# activate SSL support
export UWSGI_PROFILE_OVERRIDE=ssl=true
# build uwsgi using pip (--no-use-wheel deprecated so used --no-binary instead)
# this command will install 2.0.20 version. Version may be changed or removed. It is not mandatory
pip install -I --no-binary=:all: --no-cache-dir uwsgi==2.0.20

# Check SSL support
uwsgi --help | grep https
