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
export HISTCONTROL="ignoreboth"

# chruby
#source /usr/local/share/chruby/chruby.sh
# Default version
#chruby ruby-2.2.2
#export GEM_HOME=''

# Haskell
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Docker
export DOCKER_CERT_PATH=/Users/pote/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2380

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

# Most important alias in the world.
alias wh='echo "¯\_(ツ)_/¯" | pbcopy'
alias shame='say -v Victoria shame'

# Tmux
alias ti='tmuxify'
alias ts='tmux ls'
alias ta='tmux attach -t '
alias tk='tmux kill-session -t'

# General
alias grope='grep -Rni --color'
alias rss='LANG=en_GB newsbeuter'
alias fix_video='sudo killall VDCAssistant'

# Git
alias gs='git status'

# Rails 3
alias rg='script/rails generate'
alias rs='script/rails server'
alias rc='script/rails console'
alias rd='script/rails dbconsole'
alias rroutes='be rake routes | grep'

# Bundler
alias be='bundle exec'


################################################################################
#                                                                              #
#                                   Functions                                  #
#                                                                              #
################################################################################

__gst_ps1 () {
  ([ -n "$GEM_HOME" ] && echo "💎 ") || echo ""
}

__gvp_ps1 () {
  ([ -n "$GOPATH" ] && echo "📦 ") || echo ""
}


# OPAM configuration
. /Users/pote/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

################################################################################
#                                                                              #
#                                     Prompt                                   #
#                                                                              #
################################################################################

# Prompt in two lines:
#   <hostname> <full path to pwd> (git: <git branch>)
#   ▸
export PS1='\[\033[01;32m\]\h \[\033[01;33m\]\w$(__git_ps1 " \[\033[01;36m\]\
  (git: %s)") $(__gst_ps1) $(__gvp_ps1) \[\033[01;37m\]\n▸\[\033[00m\] '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## Adds gst path
export PATH="/Users/pote/code/gst/bin:$PATH"


