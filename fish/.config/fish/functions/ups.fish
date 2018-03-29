function ups -d "Alais for update/upgrade and upgrade vim and all plugins"
	set ogdir (pwd)
  set -l startTimeStamp (date)
  sudo apt-get update; and sudo apt-get upgrade -y; and 0vup
  cd $ogdir

  # Copy all the ~/.config/fish/functions/*.fish to ~/gh/dot-file/.config/fish/functions/ and keep everything up to date
  cp -uf /home/$USER/.config/fish/functions/* /home/$USER/gh/dot-files/fish/.config/fish/functions/

  set -l endTimeStamp (date)

  echo -e '\n\n'
  echo Start Time: $startTimeStamp
  echo End Time:   $endTimeStamp
  echo -e '\n\n'
end
