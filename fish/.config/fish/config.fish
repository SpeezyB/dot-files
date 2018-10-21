if test -f /opt/dev/dev.fish
  source /opt/dev/dev.fish
end

bind \ce forward-char
bind \cl clear
bind \ef forward-word
bind \eb backward-word
bind \ec kill-whole-line
abbr -a -- - 'cd -'
set -x MICRO_TRUECOLOR 1
set -x EDITOR vim
set -x RANGER_LOAD_DEFAULT_RC FALSE
set -x BACKUPIFY_DATABASE_PASSWORD Bkarm@1670
set -x GOPATH /home/pi/code/golang /home/pi/gh/golang
#set -x PATH /Users/benspiessens/.gem/ruby/2.5.0/bin $PATH
#set -x PATH /Users/benspiessens/.rubies/ruby-2.5.0/lib/ruby/gems/2.5.0/bin $PATH
set -x PATH /usr/local/opt/sqlite/bin /usr/local/sbin /usr/local/opt/openssl/bin /usr/local/opt/libxml2/bin $PATH
set -x TERM screen-256color
