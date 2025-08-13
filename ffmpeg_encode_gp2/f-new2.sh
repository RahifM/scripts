fmpgscrpt (){
export botmsg="curl -s -X POST "https://api.telegram.org/bot${BOTAPI}/sendMessage" -d chat_id="${CHATID}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text"

TG=$HOME/telegram.sh/telegram

if [ -d "$HOME/telegram.sh" ]; then
echo "Tgsh already exists"
else
time git clone https://github.com/fabianonline/telegram.sh $HOME/telegram.sh
if [ -d "$HOME/.telegram.sh" ]; then
echo ".Tgsh already exists"
else
cat <<'EOF' >> $HOME/.telegram.sh
TELEGRAM_TOKEN="demo1"
TELEGRAM_CHAT="demo2"
EOF
sed -i s/demo1/${BOTAPI}/g $HOME/.telegram.sh
sed -i s/demo2/${CHATID}/g $HOME/.telegram.sh
fi
fi

tm (){
        ( sudo apt install transmission-cli transmission-daemon -y && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd) ) 2>&1 | tee tm.txt
}
        tm

        if [ "$(grep success tm.txt)" == "" ] ; then
                tm
		rm tm.txt
        fi
	
	transmission-remote --start-paused -a "https://github.com/zmzu/dump/releases/download/1.0/Bleach.Box.1-6.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.torrent" &&
	transmission-remote -t 1 -G all &&
	transmission-remote -t 1 -g13 &&
	transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s

export i=Bleach.E014.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.mkv
export o=Bleach.E014.mkv

fmpg() {

	cd Bl* && cd Bl* && pwd && du -hs *

	#time sudo apt install ffmpeg -y

echo -e "\nPlease set input and input! (only 720p encodes supported as of now)\n"
echo ${i}
echo ${o}
#read -e -p "Input: " i
#read -e -p "Output: " o


if [ -z "$i" -o -z "$o" ]; then
       echo -e "\nNo input or output found\n"
       exit 1
fi

$botmsg="${o} encode started"

echo -e "\n"

low() {
        rm ${o}*.txt
        time ffmpeg -i  "${i}" -s 1280x720 -c copy -map 0 -c:v libx265 -x265-params crf=28 -pix_fmt yuv420p -preset slow  "${o}" 2>&1 | tee ${o}-$(date +'%Y%m%d-%H%M').txt
}

up() {
[ -f "github-release-2.0.0.2-ubuntu-bkup" ] && echo "gh rel already exists" || ( echo "gh rel not found" && time wget https://github.com/RahifM/releases/releases/download/1.0/github-release-2.0.0.2-ubuntu-bkup && chmod +x github-release-2.0.0.2-ubuntu-bkup )

./gi* upload --token $GHSECRET --owner 'zmzu' --repo 'be_dump' --tag '1.0' --file ${o} --name ${o}
}

low

[ -f ${o} ] && up && echo "${o} encode / upload success" && $botmsg="${o} encode / upload success" || ( echo "${o} encode / upload failed" && $botmsg="${o} encode / upload failed" )
}

while true ; do
	if [ "$(transmission-remote -t 1 -i | grep State)" = "  State: Idle" ] ; then
		echo "Idling, starting encode"
		transmission-remote -t 1 -S
		ls && pwd
		fmpg
		pwd && du -hs *
		cd ../.. && rm -rf Bl*
		#gp stop
		break
	fi
	echo $(transmission-remote -t 1 -i | grep State)
	echo $(transmission-remote -t 1 -i | grep Percent)
	echo "check back after 15s"
  sleep 15
done
}

fmpgscrpt 2>&1 | tee log-$(date +'%Y%m%d-%H%M').txt
$TG -f log*.txt
rm log*.txt
gp stop
