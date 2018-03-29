function ipup -d "The ip updater script"
	command ruby /home/pi/.ipupdate/updateip.rb $argv
end
