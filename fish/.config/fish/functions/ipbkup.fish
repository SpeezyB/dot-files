function ipbkup -d "open a secure copy session to backup ip updater script to mbox"
	scp ~/.ipupdate/* ben@192.168.0.11:/home/ben/Dropbox/code/upip/
end
