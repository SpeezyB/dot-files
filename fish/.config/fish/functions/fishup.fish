function fishup -d "alias for updating fish shell from git repo"
  set -l ogDir (pwd)
  set -l fishGitDir "/home/$USER/gh/fish-shell"

  cd $fishGitDir
  git pull origin master
  autoreconf --no-recursive #if building from Git
  ./configure
  make
  sudo make install 
  fish_update_completions

  cd $ogDir
end
