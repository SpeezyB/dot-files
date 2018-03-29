function up -d "alias for update and then upgrades homebrew apps"
	sudo apt-get update; and sudo apt-get upgrade $argv
end
