#!/bin/bash

ECLIPSE_VER_DATE="2024-09"

cd /tmp
wget -q -O eclipse.tar.gz "https://mirrors.xmission.com/eclipse/technology/epp/downloads/release/${ECLIPSE_VER_DATE}/R/eclipse-java-${ECLIPSE_VER_DATE}-R-linux-gtk-$(arch).tar.gz"
tar -xzf eclipse.tar.gz -C /opt

ECLIPSE_ICON="/opt/eclipse/plugins/$(ls /opt/eclipse/plugins/ | grep -m 1 org.eclipse.platform_)/eclipse128.png"
sed -i "s#eclipse128.png#${ECLIPSE_ICON}#" $INST_DIR/eclipse/eclipse.desktop
cp $INST_DIR/eclipse/eclipse.desktop $HOME/Desktop/
cp $INST_DIR/eclipse/eclipse.desktop /usr/share/applications/