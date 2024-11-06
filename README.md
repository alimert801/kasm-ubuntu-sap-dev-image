# Kasm Ubuntu Noble Custom Image 
Kasm Ubuntu Noble custom image for SAP Software development. 

![screenshot-1](https://github.com/alimert801/kasm-ubuntu-sap-dev-image/blob/main/src/screenshots/screenshot-1.png?raw=true)

## Application List

* NodeJS & NPM
* NPM packages: @sap/cds-dk, @sap/generator-fiori, mbt, typescript
* xfce4-whiskermenu-plugin
* Google Chrome
* VSCode
* Eclipse (**ADT needs to be installed separately**)
* Postman
* Nextcloud
* Only Office
* DBeaver-CE
* pgAdmin4 - deprecated

## VSCode Extensions

* SAP Fiori Tools - Extension Pack - SAPSE.sap-ux-fiori-tools-extension-pack
* SAP CDS Language Support - SAPSE.vscode-cds
* XML Tools - DotJoshJohnson.xml
* Python Extension Pack - donjayamanne.python-extension-pack 

## Build docker image

```zsh
sudo docker build -t kasm-custom-image:ubuntu-noble-xfce-sap .
```

Delete all docker build caches
```zsh
sudo docker builder prune -a
```

## Give sudo permission to the users

Docker Exec Config (JSON)
```json
{
  "first_launch": {
    "user": "root",
    "cmd": "bash -c '/usr/bin/desktop_ready && apt-get update && apt-get install -y sudo && echo \"kasm-user  ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers'"
  }
}
```

## Persistent profile path
```plain
/path/to/kasm/ubuntu-noble-xfce-sap/{user_id}
```
