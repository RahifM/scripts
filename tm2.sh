tm (){
	( sudo apt install transmission-cli transmission-daemon -y && transmission-daemon && transmission-remote -l && transmission-remote -w $(pwd) ) 2>&1 | tee tm.txt
}
	tm

	if [ "$(grep success tm.txt)" == "" ] ; then
		tm
	fi
