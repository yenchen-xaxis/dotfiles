# vim: sts=2 sw=2 et
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# We're using 64 bits, right?
export ARCHFLAGS="-arch x86_64"

# Editor
export EDITOR=vim
export VISUAL=$EDITOR

# Term colors
export TERM=xterm-256color

# Ignore from history repeat commands, and some other unimportant ones
export HISTIGNORE="&:[bf]g:c:exit"

# Ruby development made easier
export RUBYOPT="rubygems Ilib Itest Ispec"

# Rubinius on 1.9.3
export RBXOPT="-X19 rbx -v"

# Go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOBIN=$GOROOT/bin
export GOPATH=~/go

# Use vim to browse man pages. One can use Ctrl-[ and Ctrl-t
# to browse and return from referenced man pages. ZZ or q to quit.
# NOTE: initially within vim, one can goto the man page for the
#       word under the cursor by using [section_number]K.
export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" \
-c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

if ((${BASH_VERSINFO[0]} >= 4)) && ! shopt globstar >/dev/null; then
  shopt -s globstar # recursive globs fuck yes!
fi

################################################################################
#                                                                              #
#                               External Scripts                               #
#                                                                              #
################################################################################

# Bash completion
_brew_prefix=$(brew --prefix)
if [[ -f "$_brew_prefix"/etc/bash_completion ]]; then
  . "$_brew_prefix"/etc/bash_completion
fi

if [[ -f "$_brew_prefix"/Library/Contributions/brew_bash_completion.sh ]]; then
  . "$_brew_prefix"/Library/Contributions/brew_bash_completion.sh
fi

################################################################################
#                                                                              #
#                                    Aliases                                   #
#                                                                              #
################################################################################

# General
alias ll='ls -la'
alias ls='ls -G'
alias c='clear'
alias ..='cd ..'
alias screen='screen -U'
alias retag='ctags --extra=+f -R .'
alias flushdns='dscacheutil -flushcache'
alias tmuxA='tmux attach-session -t Work'
alias grope='grep -Rni --color'
alias foca='t whois'
alias jdeps="bash <(curl -s https://raw.github.com/VividCortex/johnny-deps/v0.1.3/bin/johnny_deps)"

# Git
alias gs='git status'
alias gl='git log'

# Ruby
alias shotgun='shotgun -s puma || shotgun'

# Rails 3
alias rg='script/rails generate'
alias rs='script/rails server --debugger'
alias rc='script/rails console'
alias rd='script/rails dbconsole'
alias rroutes='be rake routes | grep'

# Bundler
alias be='bundle exec'

# Coffeescript
alias coffee='/usr/local/share/npm/bin/coffee'

################################################################################
#                                                                              #
#                                   Functions                                  #
#                                                                              #
################################################################################

# cd into matching gem directory
cdgem() {
  local gempath=$(gem env gemdir)/gems
  if [[ $1 == "" ]]; then
    cd $gempath
    return
  fi

  local gem=$(ls $gempath | g $1 | sort | tail -1)
  if [[ $gem != "" ]]; then
    cd $gempath/$gem
  fi
}
_cdgem() {
  COMPREPLY=($(compgen -W '$(ls `gem env gemdir`/gems)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0;
}
complete -o default -o nospace -F _cdgem cdgem;

# Encode the string into "%xx"
urlencode() {
  ruby -e 'puts ARGV[0].split(/%/).map{|c|"%c"%c.to_i(16)} * ""' "$1"
}

# Decode a urlencoded string ("%xx")
urldecode() {
  ruby -r cgi -e 'puts CGI.unescape ARGV[0]' "$1"
}

# open mvim for ack search results
ackvim(){
  local pattern=$1; shift
  ack -l --print0 "$pattern" "$@" | xargs -0o mvim -o +/"$pattern"
}

# reverse find
rfind() {
  local target="$1" cwd="$PWD"

  [[ "$target" ]] || { echo "ERROR: missing target" >&2; return 1; }

  while [[ "$cwd" ]]; do
    if [[ -e "$cwd"/"$target" ]]; then
      echo "$cwd"/"$target"
      return 0
    fi
    cwd="${cwd%/*}"
  done
  return 1
}; export -f rfind

# find cucumber features and step definitions
features () {
  local pattern=$1; shift
  egrep -Ir "$pattern" features/ --include '*.feature' "$@"
}; export -f features

steps () {
  local pattern=$1; shift
  egrep -Ir "$pattern" features/step_definitions/ "$@"
}; export -f steps

run_features() {
  local pattern=$1; shift

  local features=()
  while IFS= read -r -d '' feature; do
    features+=("$feature")
  done < <(features "$pattern" -lZ)

  if ((${#features[@]})); then
    cucumber "$@" -- "${features[@]}"
  else
    echo 'no matches' >&2; return 1
  fi
}


## rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

################################################################################
#                                                                              #
#                                     Prompt                                   #
#                                                                              #
################################################################################

# Prompt in two lines:
#   <hostname> <full path to pwd> (git: <git branch>)
#   ▸
export PS1='\[\033[01;32m\]\h \[\033[01;33m\]\w$(__git_ps1 " \[\033[01;36m\]\
  (git: %s)")\[\033[01;37m\]\n▸\[\033[00m\] '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
