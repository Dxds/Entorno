#!/bin/bash
clear
figlet -c BSPWM S4VITAR
echo "Script creado para automatizar la configuracion basada en el entorno de trabajo publicado por S4VITAR. Las referencias estan publicadas y se pueden revisar en esta urls:"
echo "      *.- https://s4vitar.github.io/bspwm-configuration-files/#"
echo "      *.- https://www.youtube.com/watch?v=66IAhBI0bCM"
echo "      *.- https://drive.google.com/drive/folders/1JIvgTECQlmH9vg8RVx-JYeIiVOmsG-ca"
echo -e  "\n"
echo "Para realizar esta configuracion se considero la informacion documentada por aljavier, la cual se puede revisar en el siguiente link:"
echo "      *.- https://gist.github.com/aljavier/9c06356f4647b56ab3238d66219be6fa "
echo -e  "\n"
echo "Se tomo como referencia el script generado por LevisWings, el cual se puede revisar en el siguiente link"
echo "Me ayudo a ver alguno problemas con el script que se armo"
echo "      *.- https://github.com/LevisWings/Auto-PWE "
echo -e  "\n"
echo -e  "\n"
echo -n "   Ingresar Password Usuario: " 
stty -echo
read PassWD
stty echo
clear
figlet -c OS
echo -e  "\n"
echo  -e "\n"
echo "Este script se puede ejecutar en sistemas operativos basados en Debian."
echo -e "\t Si utilizas otra distrubucion que no este basada en Debian, deberas realizar las modificaciones y updates correspondientes para la instalacion de dependencias"
echo -e "\t\t\t\t Indicar S.O"
echo -e "\n\n"
echo -e "\t\t\t 1.- Kali"
echo -e "\t\t\t 2.- Parrot"
echo -e "\t\t\t 3.- Other"
echo -ne "\t\t\t Si usas una distribucion diferente a las indicadas debera revisar el script de intalacion \n para adaptarlo al S.O: "
read optsos

if [ $optsos = 3 ]; then
  echo "Favor revisar script y adpatar al S.O"
  exit
fi
figlet -c Update OS
echo "Deseas Realizar la actualizacion de S.O [Y/N]"
read SO1
if [ $SO1 = 'Y' ]; then
  case $optsos in
    1)
      echo $PassWD |sudo -S apt-get update -y 
      echo $PassWD |sudo -S apt-get upgrade -y 
      ;;
    2)
     echo $PassWD |sudo -S apt-get update -y 
     echo $PassWD |sudo -S parrot-upgrade -y 
     ;;
   3)
     echo "Se saltara el update debes validar si tu distrubuci??n es compatible con los paquetes de instalaci??n ..."
     ;;
  esac
else
     echo "Se inicia la configuracion de variables ..."
fi
clear
figlet -c Variables

PathSt=$(pwd)
Eth=$(ip add|grep "2:"|awk '{print $2}'|head -1|sed 's/://g')
User=$(whoami|awk '{print $1}')
echo "Usuario: $User"
echo "red: $Eth"
echo "Espacio de trabajo: $PathST"
echo -n "Ingresar Alias(Nombre para dejar en la barra): "
read Alias
if [ $optsos == 2 ]; then
    echo $PassWD |sudo -S id
    echo -n "Ingresar path imagen de fondo: "
    read Wallp
    echo -n "Ingresar path imagen de fondo para pantalla de bloqueo: "
    read WlpBl
    echo -n "Ingresar Path imagen icono para la pantalla de bloqueo (Debe ser en formato png y de tama??o 50x50): "
    read WlpIco
fi
clear
if [ $optsos == 2 ]; then
    figlet -c Sesion
    echo "Definiendo icono y fondo de pantalla, inicio de sesion"
    #Respaldo Imagen
    if [ -f /usr/share/backgrounds/login_1.jpg ]; then
         echo $PassWD |sudo -S rm -f  /usr/share/backgrounds/login_1.jpg
    else
         echo $PassWD |sudo -S cp /usr/share/backgrounds/login.jpg /usr/share/backgrounds/login_1.jpg
    fi
    
    if [ -f /usr/share/icons/parrot-logo_1.png ]; then
         echo $PassWD |sudo -S rm -f  /usr/share/icons/parrot-logo_1.png
    else
         echo $PassWD |sudo -S cp /usr/share/icons/parrot-logo.png /usr/share/icons/parrot-logo_1.png
    fi
    
    #Wallpaper Pantalla Bloqueo
    if [ -z $WlpBl ]; then
        echo $PassWD |sudo -S cp ./Images/login.jpg /usr/share/backgrounds/login.jpg
    else
        echo $PassWD |sudo -S cp $WlpBl /usr/share/backgrounds/login.jpg
    fi
    #Logotipo Pantalla Bloqueo
    if [ -z $WlpIco ]; then
        echo $PassWD |sudo -S cp ./Images/login.png /usr/share/icons/parrot-logo.png
    else
        echo $PassWD |sudo -S cp $WlpIco /usr/share/icons/parrot-logo.png
    fi
    clear
fi
figlet -c Bspwm
echo "Instalacion gestor de ventanas y multiples monitores"
echo "Instalando dependencias para Bspwm"
echo $PassWD|sudo -S apt-get install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev xclip gnome-terminal -y
cd ~
if [ -d ~/sxhkd ]; then
    rm -Rf ~/sxhkd
fi
if [ -d ~/bspwm ]; then
    rm -Rf ~/bspwm
fi
if [ -d ~/.config ]; then 
     echo "directorio .config: Existe"
else
     mkdir ~/.config
     mkdir -p ~/.config/{bspwm,sxhkd}
fi
if [ -d ~/.config/bspwm ]; then
     echo "Directorios bspwm: Existe"
     echo "Eliminado Directorio actual"
     rm -Rf ~/.config/bspwm
else
     mkdir -p ~/.config/bspwm
fi
if [ -d ~/.config/sxhkd ]; then
     echo "Directorios bspwm sxhkd: Existe"
     echo "Eliminado Directorio actual"
     rm -Rf ~/.config/sxhkd
else
     mkdir -p ~/.config/sxhkd
fi
echo "Clonando Repositorio Bspwm"
git clone https://github.com/baskerville/bspwm.git
echo "Clonando Repositorio sxhkd"
git clone https://github.com/baskerville/sxhkd.git
echo "Instalando Bspwm"
echo $PassWD|sudo -S apt-get install bspwm -y
cd bspwm && make && echo $PassWD|sudo -S make install
echo "Instalando Sxhkd"
cd ../sxhkd && make && echo $PassWD|sudo -S make install
cp ${PathSt}/Bspwm/bspwmrc ~/.config/bspwm/
cp ${PathSt}/Bspwm/sxhkdrc ~/.config/sxhkd/
chmod u+x ~/.config/bspwm/bspwmrc
chmod u+x ~/.config/sxhkd/sxhkdrc
sed -i "s/username/${User}/g" ~/.config/bspwm/bspwmrc
sed -i "s/username/${User}/g" ~/.config/sxhkd/sxhkdrc
if [ -d ~/.config/bspwm/scripts ]; then
     if [ -f ~/.config/bspwm/scripts/bspwm_resize ]; then
           echo "Script existe. No es necesario realizar acciones"
     else
           cp ${PathSt}/Bspwm/bspwm_resize ~/.config/bspwm/scripts
           chmod +x ~/.config/bspwm/scripts/bspwm_resize
           ls -l ~/.config/bspwm/scripts/bspwm_resize
     fi
else
     mkdir  ~/.config/bspwm/scripts
     cp ${PathSt}/Bspwm/bspwm_resize ~/.config/bspwm/scripts
     chmod +x ~/.config/bspwm/scripts/bspwm_resize
     ls -l ~/.config/bspwm/scripts/bspwm_resize
fi
cp ${PathSt}/Bspwm/.xinitrc ~
cd $PathSt
echo -n "Presiona enter para continuar: "
read ent
clear
figlet -c Compton
echo "Personaliza las ventanas con transparencias y difuminado de las ventanas entre otras"
echo "Instalando Compton"
echo $PassWD|sudo -S apt-get install compton -y
if [ -d ~/.config/compton ]; then
     cp Bspwm/compton.conf ~/.config/compton
else
     mkdir ~/.config/compton
     cp Bspwm/compton.conf ~/.config/compton
fi
cd $PathSt
clear
figlet -c Rofi 
echo "Permite personalizar el menu flotante"
echo "Instalando Rofi"
echo $PassWD|sudo -S apt-get install rofi -y
echo -n "seleccionar tema rofi [Y/N]: "
read ops
if [ $ops = 'Y' ]; then
     rofi-theme-selector
else
     echo "Puedes configurar el tema mas tarde con el comando rofi-theme-selector"
fi
cd $PathSt
clear
figlet -c Feh
echo "Permite configurar el fondo de escritorio"
echo $PassWD|sudo -S apt-get install feh -y
echo "Creando directorio para imagenes"
mkdir ~/Fondos
if [ -z Wallp ]; then
     cp Images/Wallpaper.png ~/Fondos
else
     cp $Wallp ~/Fondos/Wallpaper.png
fi
clear
figlet -c Hack Nerd Font
echo "instalando Fuente"
cntFnt=$(ls -l /usr/local/share/fonts/*Hack* |wc -l)
if [ $cntFnt -eq 0 ]; then
    cd /usr/local/share/fonts
    echo $PassWD|sudo -S wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    echo $PassWD|sudo -S unzip Hack.zip
    echo $PassWD|sudo -S rm -f Hack.zip
    echo "Fuente Hack Nerd Instalada"
    echo "Revisar en el link como habilitar en la terminal"
    echo "Link:  https://www.youtube.com/watch?v=66IAhBI0bCM&t=3208s"
    echo -n "Presiona enter para continuar: "
    read ent
fi
clear
figlet -c Scripts
cd $PathSt
if [ -d ~/.config/bin ]; then
     echo "Directorio bin existe"
else
     echo "Creando directorio bin"
     mkdir ~/.config/bin
fi
echo "Configuracion y generacion de scripts polybar"
echo "Configuracion Script S4vitar"
echo "Si no se indico el Alias tomara la configuracion por defecto y quedara el nombre de usuario"
if [ -z $Alias ]; then
     echo "Configuraci??n por defecto"
     cp ${PathSt}/Bspwm/Name.sh ~/.config/bin/
     sed -i "s/S4vitar/${User}/g" ~/.config/bin/Name.sh
else
     echo "Se modifica configuracion"
     cp ${PathSt}/Bspwm/Name.sh ~/.config/bin/
     sed -i "s/S4vitar/${Alias}/g" ~/.config/bin/Name.sh
fi
if [ $Eth = "eth0" ]; then
     cp ${PathSt}/Bspwm/ethernet_status.sh ~/.config/bin/
else
     echo -n "Favor indicar nombre de la tarjeta de red"
     read eth1
     cp ${PathSt}/Bspwm/ethernet_status.sh ~/.config/bin/
     sed -i "s/eth0/${eth1}/g" ~/.config/bin/ethernet_status.sh
fi
cd $PathSt
cp ${PathSt}/Bspwm/hackthebox.sh ~/.config/bin/
cp ${PathSt}/Bspwm/battery.sh ~/.config/bin/
chmod +x -R ~/.config/bin
echo -n "Presiona enter para continuar: "
read ent
clear
figlet -c Polybar
echo "Personaliza la barra de tarea"
echo "Instalando Dependencias"
echo $PassWD|sudo -S apt install build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y
echo $PassWD|sudo -S apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
echo "Instalando Polybar"
echo $PassWD|sudo -S sudo apt install polybar -y
echo "Instalando polybar-themes"
echo "clonando repositorio"
echo $PassWD|sudo -S cp ${PathSt}/Bspwm/bspwm.desktop /usr/share/xsessions/ 
cd ~
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd polybar-themes
chmod +x setup.sh
#./setup.sh

if [ -d ~/.config/polybar ]; then
     rm -Rf ~/.config/polybar
fi
pwd
cp ${PathSt}/Bspwm/Comprimido.tar ~/.config/
file ~/.config/Comprimido.tar
sleep 5
cd ~/.config
pwd
if [ -f ~/.config/Comprimido.tar ]; then
     whoami
     tar -xvf ~/.config/Comprimido.tar
     file ~/.config/polybar/config.ini
     ls -l polybar
     sleep 5
fi
sleep 3
if [ -d ~/.config/bin ]; then
     echo "Directorio existe"
else
     mkdir ~/.config/bin
fi
cd $PathSt
cp Bspwm/launch.sh ~/.config/polybar
rm -f ~/.config/polybar/config.ini
cp Bspwm/config.ini ~/.config/polybar
if [ -f ~/.config/polybar/config.ini ]; then
     echo "file config.ini: existe"
else
     cp ${PathSt}/Bspwm/config.ini ~/.config/polybar
     file ~/.config/polybar/config.ini
fi     
clear
figlet -c Chrome
echo -n "Desean Instalar google chrome Y/N: "
read opsg
if [ $opsg = 'Y' ]; then
     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
     echo $PassWD|sudo -S dpkg -i google-chrome-stable_current_amd64.deb
     rm -f google-chrome-stable_current_amd64.deb
fi
figlet -c Powerlevel10k
echo "Permite personalizar la terminal ZSH"
echo "Clonando Repositorio"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "Configurando zsh"
echo "Secuencia de s4vitar: y y y y 3 1 n 1 2 2 1 2 2 2 n 1 y"
echo -n "??Deseas configurar la terminal zsh? (Y/N): "
read lvl10k
if [ $lvl10k = 'Y' ]; then
    echo "Para volver a la instalacion ejecuta exit en la terminal"
    sleep 5
    zsh
else
    echo -e "Puedes configurar en otro momento ejecutando zsh. \n Puedes ver la configuraci??n directamente en el link https://www.youtube.com/watch?v=66IAhBI0bCM&t=3296s"
fi
figlet -c ZSH
echo "Modificacion zsh"
rm -f  ~/.zshrc
cp  Bspwm/.zshrc ~/
echo "Configurando fuente zsh-theme archivo zhrc"
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
sed -i "s/user_name/${User}/g" ~/.zshrc
echo $PassWD|sudo -S cp ${PathSt}/Bspwm/bspwm.desktop /usr/share/xsessions/
echo "Instalacion Plugin"
echo $PassWD|sudo -S apt-get install zsh-syntax-highlighting zsh-autosuggestions -y
if [ -d /usr/share/zsh-sudo ]; then
    echo "Directorio Existe"
    if [ -f /usr/share/zsh-sudo/sudo.plugin.zsh ]; then
        echo "Plugin sudo zsh esta instalado"
    else
        echo "Instalando Plugin sudo"
        echo $PassWD|sudo -S cp ${PathSt}/Bspwm/sudo.plugin.zsh /usr/share/zsh-sudo/sudo.plugin.zsh
    fi
else
        echo "Instalando Plugin sudo"
        echo $PassWD|sudo -S mkdir /usr/share/zsh-sudo
        echo $PassWD|sudo -S cp ${PathSt}/Bspwm/sudo.plugin.zsh /usr/share/zsh-sudo/sudo.plugin.zsh
        echo $PassWD|sudo -S chmod +u /usr/share/zsh-sudo/sudo.plugin.zsh
fi
if [ -f ~/.p10k.zsh ]; then
     rm -f ~/.p10k.zsh
     cp ${PathSt}/Bspwm/.p10k.zsh ~/.p10k.zsh
else
     cp ${PathSt}/Bspwm/.p10k.zsh ~/.p10k.zsh
fi
echo -n "Presiona enter para continuar: "
read ent
clear
figlet -c LSD
echo "Mejora las capacidades del comando ls"
echo "descargando instalador"
wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb
echo "Instalando LSD"
echo $PassWD|sudo -S dpkg -i lsd_0.20.1_amd64.deb
clear
figlet -c BAT
echo "Mejora las capacidades del comando cat"
echo "Descargando instaldor utilida BAT"
wget https://github.com/sharkdp/bat/releases/download/v0.18.1/bat_0.18.1_amd64.deb
echo $PassWD|sudo -S dpkg -i bat_0.18.1_amd64.deb
clear
figlet -c Scrub
echo "Esta utilidad permite eliminar archivos completamente (no se pueden recuperar)"
echo "Instalando Scrub"
echo $PassWD|sudo -S apt-get install scrub -y
clear
figlet -c FZF
echo "Es una utilidad que mejora la experiencia con las busquedas de archivos"
echo "Instalacion usuario $User"
echo "Clonando repositorio FZF"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
echo "Instaland FZF"
~/.fzf/install
sleep 2
cd $PathSt
clear
figlet -c Dunst
echo "Mejora la estetica de las notificaciones"
echo "Instalando Dunst"
echo $PassWD|sudo -S apt-get install Dunst
cd $PathSt
clear
figlet -c Glichlock
echo "Permite personalizar la pantalla de bloqueo"
echo "Instalando i3lock-color scrot imagemagick"
echo $PassWD|sudo -S apt-get update -y
echo $PassWD|sudo -S apt-get install i3lock-color scrot imagemagick -y
cd /opt
echo $PassWD|sudo -S git clone https://github.com/xero/glitchlock
echo "#Bloque de pantalla" >> /home/${User}/.config/sxhkd/sxhkdrc
echo "super + ctrl + alt + x" >> /home/${User}/.config/sxhkd/sxhkdrc
echo "    GLITCHICON=/opt/glitchlock/stop.png /opt/glitchlock/glitchlock" >> /home/${User}/.config/sxhkd/sxhkdrc
clear
figlet -c Sublime
echo $PassWD|sudo -S wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo $PassWD|sudo -S apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
echo $PassWD|sudo -S ln -s /opt/sublime_text/sublime_text /usr/bin/sublime_text
figlet -c Instalacion ROOT
echo $PassWD|sudo -S su - root -c "${PathSt}/EnvHckRoot.sh $User $PathSt"
clear
echo "Presione enter para continuar: "
read ent
figlet -c Estamos Hack!
clear
echo "Solo falta cerrar sesion para cargar la configuracion"
echo "Deseas cerrar sesion [Y/N]: "
read opts2
if [ $opts2 = 'Y' ]; then
    figlet -c Se tenso
    figlet -c Que te cagas
    sleep 3
    kill -9 -1
else
    echo "Debes cerrar sesi??n y cambiar el entorna a bspwm, en la pantalla de inicio de sesi??n"
    sleep 5
    figlet -c Se tenso
    if [ -z $Alias ]; then
        figlet -c Adios $User
    else
        figlet -c Adios $Alias
    fi
fi
