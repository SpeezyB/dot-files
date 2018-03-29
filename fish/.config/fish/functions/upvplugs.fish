function upvplugs -d "updates all vim-plugins that is in the ~/.vim/bundle dir"
  set -l ogDir (pwd)
  set -l vimDir "/home/$USER/.vim/bundle"

  cd $vimDir
  set -l vimPluginsDirs (/bin/ls -ad */)

  for vplug in $vimPluginsDirs
    cd $vimDir/$vplug
    echo Updating Vim Plugin: $vplug
    git pull origin master
    echo Done.
    echo ""
    cd $vimDir
  end

  cd $ogDir
end
