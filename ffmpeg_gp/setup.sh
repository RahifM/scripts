sudo apt update
sudo apt install screen ffmpeg -y

time bash $HOME/scripts/misc.sh || { git clone https://github.com/RahifM/scripts $HOME/scripts && bash $HOME/scripts/misc.sh ; }

screen -S 1 && screen -x 1
