function 0vup -d "Alias that Updates and installs the latest version of vim"
	set -l
	set og_dir (pwd)
	cd ~/gh/vim; 
  and	git pull origin master; 
  and	cd src; 
  and	./configure; 
  and	command make -j 4; 
  and	command sudo make install

  switch $status
    case 0
      echo -e \n;echo -e \n;echo Updating all Vim Plugins ...
      upvplugs
      if [ $status -gt 0 ]
        echo Updating Vim Plugins has failed!!!
      end

      fishup
      if [ $status -gt 0 ]
        echo Updating FishShell has failed!!!
      end
    case '*'
      echo -e \n;ehco -e \n;echo An Error has occured in Updating Vim exitting ...
      exit $status
  end
	cd $og_dir
end
