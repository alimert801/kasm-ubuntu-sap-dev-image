ARG BASE_TAG="develop"
ARG BASE_IMAGE="core-ubuntu-noble"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG

USER root

### Envrionment config 
ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV SRC_DIR=$STARTUPDIR/src-build 
ENV INST_DIR=$SRC_DIR/install-scripts
WORKDIR $HOME

######### Customize Container Here ###########

# Copy installation files
COPY ./src/ $SRC_DIR

# Install Node.js, npm, and global npm packages for SAP development
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @sap/cds-dk @sap/generator-fiori mbt typescript
    
# Install whiskermenu
RUN apt-get update && apt-get install xfce4-whiskermenu-plugin -y

# Run installations
RUN bash ${INST_DIR}/tools/install_tools_deluxe.sh || exit 1;
RUN bash ${INST_DIR}/misc/install_tools.sh || exit 1;
RUN bash ${INST_DIR}/chrome/install_chrome.sh || exit 1;
RUN bash ${INST_DIR}/vs_code/install_vs_code.sh || exit 1;
RUN bash ${INST_DIR}/eclipse/install_eclipse.sh || exit 1;
RUN bash ${INST_DIR}/postman/install_postman.sh || exit 1;
RUN bash ${INST_DIR}/nextcloud/install_nextcloud.sh || exit 1;
RUN bash ${INST_DIR}/only_office/install_only_office.sh || exit 1;
#RUN bash ${INST_DIR}/pgadmin4/install_pgadmin4.sh || exit 1;
RUN bash ${INST_DIR}/dbeaver/install_dbeaver.sh || exit 1;
RUN bash ${INST_DIR}/cloudfoundry_cli/install_cloudfoundry_cli.sh || exit 1;
RUN bash ${INST_DIR}/cleanup/cleanup.sh || exit 1;

# Install vscode extensions
RUN sudo code --extensions-dir /usr/share/code/resources/app/extensions --install-extension SAPSE.sap-ux-fiori-tools-extension-pack --no-sandbox --user-data-dir $HOME/.vscode
RUN sudo code --extensions-dir /usr/share/code/resources/app/extensions --install-extension SAPSE.vscode-cds --no-sandbox --user-data-dir $HOME/.vscode
RUN sudo code --extensions-dir /usr/share/code/resources/app/extensions --install-extension donjayamanne.python-extension-pack --no-sandbox --user-data-dir $HOME/.vscode
RUN sudo code --extensions-dir /usr/share/code/resources/app/extensions --install-extension DotJoshJohnson.xml --no-sandbox --user-data-dir $HOME/.vscode

# Change background 
RUN mv -f $SRC_DIR/wallpapers/wallpaper.png /usr/share/backgrounds/bg_default.png

# Configure xfce 
RUN rm -rf $HOME/.config/xfce4
RUN mv $SRC_DIR/configs/xfce4 $HOME/.config/

# Delete installation files
RUN rm -rf $SRC_DIR
######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000