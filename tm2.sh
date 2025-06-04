tm (){
	sudo apt install transmission-cli transmission-daemon -y 2>&1 | tee tm.txt && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd)
}

tm

if [ "$(grep success tm.txt)" == "" ] ; then
	tm
fi

