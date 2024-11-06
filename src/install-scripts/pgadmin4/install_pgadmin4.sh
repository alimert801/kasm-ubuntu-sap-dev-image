#!/usr/bin/env bash
set -ex

# Install pgAdmin4
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg 
sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update' 
apt install apparmor apparmor-utils -y
apt install pgadmin4-desktop -y

# Desktop icon
chmod +x /usr/share/applications/pgadmin4.desktop
cp /usr/share/applications/pgadmin4.desktop $HOME/Desktop/pgadmin4.desktop
chmod +x $HOME/Desktop/pgadmin4.desktop

# Cleanup for app layer
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi