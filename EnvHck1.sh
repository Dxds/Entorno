figlet -c BSPWM S4VITAR
echo "Script creado para automatizar la configuracion basada en el entorno de trabajo publicado por S4VITAR. Las referencias estan publicadas y se pueden revisar en esta urls:"
echo "      *.- https://s4vitar.github.io/bspwm-configuration-files/#"
echo "      *.- https://www.youtube.com/watch?v=66IAhBI0bCM"
echo "      *.- https://drive.google.com/drive/folders/1JIvgTECQlmH9vg8RVx-JYeIiVOmsG-ca"
echo "\n"
echo "Para realizar esta configuracion se considero la informacion documentada por aljavier, la cual se puede revisar en el siguiente link:"
echo "      *.- https://gist.github.com/aljavier/9c06356f4647b56ab3238d66219be6fa "
echo "\n"
echo "Se tomo como referencia el script generado por LevisWings, el cual se puede revisar en el siguiente link"
echo "Me ayudo a ver alguno problemas con el script que se armo"
echo "      *.- https://github.com/LevisWings/Auto-PWE "
read -s -p "Ingresar Password Usuario: " PassWD
clear
figlet -c Update OS
echo "Este script se puede ejecutar en sistemas operativos basados en Debian."
echo -e "\t Si utilizas otra distrubucion que no este basada en Debian, deberas realizar las modificaciones correspondientes para la instalacion de dependencias"
echo "\t\t\t\t Indicar S.O"
echo "\n\n"
echo "\t\t\t 1.- Kali"
echo "\t\t\t 2.- Parrot"
echo "\t\t\t 3.- Saltar"
echo -n "\t\t\t Si las actualizaciones estan instaladas digita 3 para saltar: "
read opts1

case $opts1 in
  1)
    echo $PassWD |sudo -S apt-get update -y 
    echo $PassWD |sudo -S apt-get upgrade -y 
    ;;
  2)
    echo $PassWD |sudo -S apt-get update -y 
    echo $PassWD |sudo -S parrot-upgrade -y 
    ;;
  3)
    echo "Se inicia la configuracion de variables ..."
    ;;
esac

figlet -c Variables

PathSt=$(pwd)
Eth=$(ip add|grep "2:"|awk '{print $2}'|head -1|sed 's/://g')
User=$(whoami|awk '{print $1}')
echo "Usuario: $User"
echo "red: $Eth"
echo "Espacio de trabajo: $PathST"
echo -n "Ingresar Alias(Nombre para dejar en la barra): "
read Alias
echo $PassWD |sudo -S id
echo -n "Ingresar path imagen de fondo: "
read Wallp
echo -n "Ingresar path imagen de fondo para pantalla de bloqueo: "
read WlpBl
echo -n "Ingresar Path imagen icono para la pantalla de bloqueo (Debe ser en formato png y de tamaño 50x50): "
read WlpIco
clear
figlet -c Sesion
echo "Definiendo icono y fondo de pantalla, inicio de sesion"
echo $PassWD |sudo -S cp /usr/share/backgrounds/login.jpg /usr/share/backgrounds/login_1.jpg
if [ -f /usr/share/backgrounds/login_1.jpg ]; then
     echo $PassWD |sudo -S rm -f  /usr/share/backgrounds/login_1.jpg
fi
echo $PassWD |sudo -S cp /usr/share/icons/parrot-logo.png /usr/share/icons/parrot-logo_1.png
if [ -f /usr/share/icons/parrot-logo_1.png ]; then
     echo $PassWD |sudo -S rm -f  /usr/share/icons/parrot-logo_1.png
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
figlet -c Bspwm
echo "Instalacion gestor de ventanas y multiples monitores"
echo "Instalando dependencias para Bspwm"
echo $PassWD|sudo -S apt-get install libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev -y
cd ~
if [ -d ~/sxhkd]; then
    rm -Rf ~/sxhkd
fi
if [ -d ~/bspwm]; then
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
else
     mkdir -p ~/.config/bspwm
fi
if [ -d ~/.config/sxhkd ]; then
     echo "Directorios bspwm sxhkd: Existe"
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
cp ${PathSt}/Bspwm/.xinitrc ~
cd $PathSt
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
     echo "Configuraciòn por defecto"
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
