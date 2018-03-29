function devup1 -d "executes commands in order to update local dev environments"
  dev update; 
    and begin; 
      command ruby /Users/benspiessens/.config/fish/functions/_dev_wrapper.rb -skip_dev_update pre_done $argv;
    end
end
