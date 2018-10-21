# Import from https://blogs.umass.edu/Techbytes/2014/12/01/getting-started-with-zsh/

source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle chrissicool/zsh-256color
#antigen theme robbyrussell
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# For more plugins: -> https://github.com/unixorn/awesome-zsh-plugins

# If you come from bash you might have to change your $PATH.
 #export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/benspiessens/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
 export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Import from my .bash_profile
if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#source ~/.iterm2_shell_integration.zsh
export MICRO_TRUECOLOR=1
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=FALSE
export GOPATH=$HOME/go
export PATH=$GOPATH:$HOME/bin:/usr/local/bin:$PATH
#export TEXTTEST_HOME="/Users/benspiessens/gh/GildedRose-Refactoring-Kata/texttests"

alias cls='clear'
alias ll='gls -hlap --color=auto --group-directories-first'
# alias l='gls -FaGp --group-directories-first --color=auto'
alias l='gls -halFC --color=auto --group-directories-first'
alias cd..='cd ..'
alias c='cd ..'
#alias op='cd $OLDPWD'
alias df='gdf -h'
alias rdev='cd /Users/benspiessens/src/github.com/Shopify/shopify'
alias sdev='cd /Users/benspiessens/src/github.com/Shopify/sauron'
alias cdev='cd /Users/benspiessens/src/github.com/Shopify/cloud-docs'
alias m='micro'
alias up='brew update && \
  rm -rf /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask/homebrew-cask/ && \
  brew cleanup -s && \
  brew upgrade'
#alias cnc='cd /Users/benspiessens/Documents/code/tom/cnc'		# Coffee'n'Code working dir
alias r='ranger'
#alias showcov='open /Users/benspiessens/src/github.com/Shopify/sauron/coverage/index.html'
alias gitr='git pull origin master'
alias gits='git status'
alias gita='git commit --amend --no-edit'
alias gitb='git branch'
alias gitc='git checkout'
alias gitl='git log --graph --decorate'
alias gitm='git checkout master'
alias gunr='railgun status -aHo="name"'
alias j='jobs'
alias bi='bundle install'
alias v="vim"
alias railg='/Applications/Railgun.app/Contents/MacOS/Railgun &'
alias devup2='ruby /Users/benspiessens/.config/fish/functions/__dev_wrapper.rb'
alias lpssh='ssh pi@192.168.1.100'
alias lpssh1='ssh pi@192.168.1.101'
alias pssh='ssh pi@werf.info -p 22063'
alias pssh1='ssh pi@werf.info -p 22064'

# use brew vim if present
/usr/local/bin/vim --version > /dev/null 2>&1
BREW_VIM_INSTALLED=$?
if [ $BREW_VIM_INSTALLED -eq 0 ]; then
	alias vim='/usr/local/bin/vim'
fi

upvplugs() {
# "updates all vim-plugins that is in the ~/.vim/bundle dir"
  local ogDir=$(pwd);
  local vimDir="/Users/$USER/.vim/bundle";

  cd $vimDir;
  local vimPluginsDirs=($(/usr/local/bin/gls -ad1 */));

  for vplug in $vimPluginsDirs; do
    cd $vimDir/$vplug;
    echo "Updating Vim Plugin: $vplug";
    git pull origin master;
    echo "Done.";
    echo "";
    cd $vimDir;
  done

  cd $ogDir;
}

##
# Vcs info
##
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[cyan]%}%b%{$reset_color%}] "
#zstyle ':vcs_info:*' formats "%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[cyan]%}%b%{$reset_color%}] %{$fg[yellow]%}%s%{$reset_color%}:%r"
precmd() {  # run before each prompt
    vcs_info
}

##
# Prompt
##
setopt PROMPT_SUBST     # allow funky stuff in prompt
local return_code="‹%(?.%{$fg[green]%}%?%{$reset_color%}.%{$fg[red]%}%?%{$reset_color%})›"
#local return_code="‹%(?.%{$fg[green]%}%?%{$reset_color%}.%{$fg[red]%}%?%{$reset_color%})›"
color="green"
if [ "$USER" = "root" ]; then
    color="red"         # root is red, user is blue
fi;
#exitcode_color="green"
#if [[ "$?" -gt 0 ]]; then
#    exitcode_color="red"
#fi;
PROMPT="%t %{$fg[$color]%}%n%{$reset_color%}:%B%~%b %{$return_code%} > "
#prompt="%t %{$fg[$color]%}%n%{$reset_color%}@%U%{$fg[yellow]%}%m%{$reset_color%}%u %B%~%b {%{$fg[$exitcode_color]%}%?%{$reset_color%}} ${vim_mode} ${vcs_info_msg_0_}> "
RPROMPT='${vim_mode} ${vcs_info_msg_0_} '

# Import from K8s
#=================
kubectl-short-aliases() {
  alias k='kubectl'
  alias kgp='k get pods'
  alias kgn='k get namespaces'
  alias kgpn='k get pods -o name | grep -oP "(?<=/).+$"'
  alias kg='k get'
  alias kl='k logs $(kpgn)'
  alias klz='kgpn | fzf --preview "kubectl logs {}" --height=100%'
  alias kex='k exec -it $(kgpn | fzf)'
  alias kexb='kubectl exec -it $(kgpn | fzf --prompt "/bin/bash > ") -- /bin/bash'
  alias kdesc='k describe $(k get pods -o name | fzf)'

  alias t1e4='k --context "tier1-us-east-4"'
  alias t1e5='k --context "tier1-us-east-5"'
  alias t1c4='k --context "tier1-us-central-4"'
  alias t1c5='k --context "tier1-us-central-5"'
  alias t1ne13='k --context "tier1-na-ne1-3"'
  alias rdst1c1='k --context "redis-tier1-us-central1-1" --namespace shopify-core'
  alias rdst1e1='k --context "redis-tier1-us-east1-1" --namespace shopify-core'
}

exec-pod() {
  local type=$1; shift
  local container=$1; shift

  if ! [ "$type" ]; then
    echo "Please specify pod type";
    exit 1;
  fi

  POD=$(kubectl get pods -o=custom-columns=NAME:.metadata.name | grep -i --max-count=1 "^${type}");

  if ! [ "$POD" ]; then
    echo "No pods of type ${type} found";
    exit 1;
  fi

  if [ "$container" ]; then
    echo "Entering $container container of pod $POD"
    kubectl exec -ti "$POD" -c=$container -- sh
  else
    echo "Entering pod $POD"
    kubectl exec -ti "$POD" -- sh
  fi
}
alias kx=exec-pod

kubectl-current-ctx() {
  kubectl config current-context
}

kubectl-current-ns() {
  local ns=$(kubectl config view --minify --output "jsonpath={..namespace}" 2>/dev/null)
  local ns=${ns:-default}
  echo $ns
}

kubernetes-current-context-info() {
  echo "$(kubectl-current-ctx)/$(kubectl-current-ns)"
}

# if there's 1 match, switch, otherwise show fzf
grep-then-fzf() {
  local match=$1; shift
  local input=$1; shift
  local prompt=$1; shift
  local output="";

  if [[ -n $match ]]; then
    local matched=$(echo ${input} | tr " " "\n" | grep $match)
    if [[ $(echo "$matched" | wc -w) == 1 ]]; then
      echo $matched
    else
      echo "$matched" | tr " " "\n" | fzf --prompt "${prompt} (matches) >"
    fi
  else
    echo "$input" | tr " " "\n" | fzf --prompt "${prompt} >"
  fi
}

chns() {
  local ns=$1; shift
  local all_ns=$(kubectl get namespaces -o=custom-columns=NAME:.metadata.name --no-headers)
  local new_ns=$(grep-then-fzf "${ns}" "${all_ns}" "k8s namespace")
  test -z $new_ns && return 1 # allow ctrl-c
  kubectl config set-context $(kubectl-current-ctx) --namespace=${new_ns} >/dev/null
  echo "Switched to namespace \"${new_ns}\"."
}
alias kns=chns

chctx() {
  local ctx=$1; shift
  local all_ctx=$(kubectl config get-contexts -o name --no-headers)
  local new_ctx=$(grep-then-fzf "${ctx}" "${all_ctx}" "k8s context")
  test -z $new_ctx && return 1 # allow ctrl-c
  kubectl config use-context "${new_ctx}"
  kns
}
alias kctx=chctx
