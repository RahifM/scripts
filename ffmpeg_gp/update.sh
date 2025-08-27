[ -d $HOME/scripts ] && rm -rf $HOME/scripts

git clone https://github.com/RahifM/scripts -b newffmpeg $HOME/scripts

cp $HOME/scripts/ffmpeg_gp/ffmpeg.sh $(pwd)/
