function basher -d "alias for bash -rcfile ~/.bash_profile -i"
  command bash -rcfile ~/.bashrc -i $argv
end
