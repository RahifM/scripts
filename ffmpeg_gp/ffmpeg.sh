export TZ='Asia/Kolkata'

export botmsg="curl -s -X POST "https://api.telegram.org/bot${BOTAPI}/sendMessage" -d chat_id="${CHATID}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text"

export TG=$HOME/telegram.sh/telegram

fmpgscrpt() {
if [ -d "$HOME/telegram.sh" ]; then
echo "Tgsh already exists"
else
time git clone https://github.com/fabianonline/telegram.sh $HOME/telegram.sh
fi

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

tms() {
        ( sudo apt install transmission-cli transmission-daemon -y && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd) ) 2>&1 | tee tm.txt
}
        tms

        if [ "$(grep success tm.txt)" == "" ] ; then
                tms
		rm tm.txt
        fi

tma() {
	rm -rf Bl*
	transmission-remote --start-paused -a "https://github.com/zmzu/dump/releases/download/1.0/Bleach.Box.1-6.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.torrent" &&
	transmission-remote -t 1 -G all &&
	transmission-remote -t 1 -g31 &&
	transmission-remote -t 1 -f | grep Yes && transmission-remote -t 1 -s
}

export i=Bleach.E032.1080p.BluRay.HEVC.AAC2.0.x265-RB26DETT.mkv
export o=Bleach.E032.mkv

fmpg() {
echo -e "\nPlease set input and input! (only 720p encodes supported as of now)\n"
echo ${i}
echo ${o}

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

tmc() {
while true ; do
	if [ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 100%" ] ; then
		echo $(transmission-remote -t 1 -i | grep State)
		echo $(transmission-remote -t 1 -i | grep Percent)
		echo "Downloaded, starting encode"
		transmission-remote -t 1 -S
		break
	fi
	[ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 0.0%" ] && echo $(transmission-remote -t 1 -i | grep State) && echo $(transmission-remote -t 1 -i | grep Percent)
	[ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 25.0%" ] && echo $(transmission-remote -t 1 -i | grep State) && echo $(transmission-remote -t 1 -i | grep Percent)
	[ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 50.0%" ] && echo $(transmission-remote -t 1 -i | grep State) && echo $(transmission-remote -t 1 -i | grep Percent)
	[ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 75.0%" ] && echo $(transmission-remote -t 1 -i | grep State) && echo $(transmission-remote -t 1 -i | grep Percent)
	[ "$(transmission-remote -t 1 -i | grep Percent)" = "  Percent Done: 100.0%" ] && echo $(transmission-remote -t 1 -i | grep State) && echo $(transmission-remote -t 1 -i | grep Percent)
  sleep 1
done
}

time tma
time tmc

pwd && du -hs *
cd Bl* && cd Bl*028* && pwd && du -hs *
fmpg
pwd && du -hs *
}

time fmpgscrpt 2>&1 | tee log-$(date +'%Y%m%d-%H%M').txt
[ -f Bl*/Bl*028*/Bl*txt ] && mv log*txt log-$(ls Bl*/Bl*028*/Bl*txt | cut -d / -f 3)
$TG -f log*.txt
rm *.txt
gp stop
