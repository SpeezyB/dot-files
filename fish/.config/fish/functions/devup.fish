function devup -d "executes commands in order to update local dev environments"
  set -l ogDir (pwd)

  echo Updating brew packages / upgrading them
    command brew update; and brew upgrade; or begin; echo "Exit code: $status"; return; end

  echo Updating Dev tool
    dev update; or begin; echo "Exit code: $status"; return; end
  
  #Shopify Land
  echo Changing to Shopfiy Repo
    dev cd shopify; or begin; echo "Exit code: $status"; return; end

  echo Running - Git Pull Origin master on Shopify Repo
    git pull origin master; or begin; echo "Exit code: $status"; return; end

  echo Running - Get fetch on Shopify Repo
    git fetch; or begin; echo "Exit code: $status"; return; end

  echo Starting Dev
    dev up; or begin; echo "Exit code: $status"; return; end

  echo Shutting Dev down
    dev down; or begin; echo "Exit code: $status"; return; end

  #Sauron Land
  echo Changing to Sauron Repo
    dev cd sauron; or begin; echo "Exit code: $status"; return; end

  echo Running - Git Pull Origin master on Sauron Repo
    git pull origin master; or begin; echo "Exit code: $status"; return; end

  echo Running - Git fetch on Sauron Repo
    git fetch; or begin; echo "Exit code: $status"; return; end

  echo Starting Dev
    dev up; or begin; echo "Exit code: $status"; return; end

  echo Shutting Dev down
    dev down; or begin; echo "Exit code: $status"; return; end

  cd $ogDir
end
