sudo apt update
sudo apt install screen ffmpeg -y

[ -d $HOME/scripts ] && rm -rf $HOME/scripts

git clone https://github.com/RahifM/scripts -b newffmpeg $HOME/scripts

bash $HOME/scripts/misc.sh

cp $HOME/scripts/ffmpeg_gp/ffmpeg.sh $(pwd)/

screen -S 1 && screen -x 1
