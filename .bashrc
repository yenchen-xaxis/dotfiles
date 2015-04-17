export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# Editor
export EDITOR=vim
export VISUAL=$EDITOR

# Term colors
export TERM=xterm-256color

# Ignore from history repeat commands, and some other unimportant ones
export HISTIGNORE="&:[bf]g:c:exit"
export HISTCONTROL="ignoreboth"

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
#                                    Aliases                                   #
#                                                                              #
################################################################################

# General
alias=ti='tmuxify'
alias ts='tmux ls'
alias ta='tmux attach -t '
alias grope='grep -Rni --color'

# Git
alias gs='git status'


################################################################################
#                                                                              #
#                                   Functions                                  #
#                                                                              #
################################################################################

__gst_ps1 () {
  ([ -n "$GEM_HOME" ] && echo "(gemset)") || echo ""
}

__gvp_ps1 () {
  ([ -n "$GOPATH" ] && echo "(gopath)") || echo ""
}


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
