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
rm -f /root/.p10k.zsh
file /root/.zshrc
ln -s /home/${User}/.zshrc /root/.zshrc
ln -s /home/${User}/.p10k.zsh /root/.p10k.zsh
ls -l /root/.zshrc
cp ${PathSt}/Bspwm/.xinitrc /root
file /root/.xinitrc
cd $PathSt
clear
echo "Presiona enter para continuar: "
read key
usermod --shell /usr/bin/zsh $User
usermod --shell /usr/bin/zsh root
figlet -c FZF ROOT
echo "Instalacion Usuario Root"
echo "Clonando repositorio FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
echo "Presiona enter para continuar: "
read key
echo "Instalando FZF"
/root/.fzf/install
clear
figlet -c NVIM
if [ -d /root/.config/nvim ]; then
  rm -Rf /root/.config/nvim
fi
ln -s /home/${User}/.config/nvim /root/.config/nvim
figlet -c JAVA
echo "Instalando Java 8 para burpsuit"
apt-get install openjdk-8-jdk openjdk-8-jdk-headless -y
echo "Configurando la opcion principal para java (seleccionar la version 11)"
update-alternatives --config java
sleep 20
java -version
sleep 5
figlet -c Instalacion Root Finalizada
echo "Presiona enter para continuar: "
read key 
