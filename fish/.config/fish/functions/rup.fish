function rup
  set -l ogDir (pwd)

  cd /home/$USER/gh/ranger

  git pull origin master;
  and sudo make install

  cd $ogDir
end

