#!/bin/bash

User=$1
PathSt=$2
figlet -c Powerlevel10k ROOT
cd /root
echo "Instalacion Usuario Root"
pwd
echo "Clonando Repositorio"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
echo "una vez finalizada la ejecucion del script ejecutar zsh con cuenta root"
rm -f /root/.zshrc
file /root/.zshrc
ln -s /home/${User}/.zshrc /root/.zshrc
ls -l /root/.zshrc
cp ${PathSt}/Bspwm/.xinitrc /root
file /root/.xinitrc
cd $PathSt
clear
echo "Presiona enter para continuar: "
read ent
usermod --shell /usr/bin/zsh $User
usermod --shell /usr/bin/zsh root
figlet -c FZF ROOT
echo "Instalacion Usuario Root"
echo "Clonando repositorio FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
echo "Instalando FZF"
/root/.fzf/install
figlet -c JAVA
echo "Instalando Java 8 para burpsuit"
apt-get install openjdk-8-jdk openjdk-8-jdk-headless -y
echo "Configurando la opcion principal para java (seleccionar la version 8)"
update-alternatives --config java
sleep 20
java -version
sleep 5
figlet -c Instalacion Root Finalizada
echo -n "Presiona enter para continuar: "
read ent
