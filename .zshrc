## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

stty stop undef

# ctrl + w で / を単語の区切りに加える
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## Default shell configuration
#
# set prompt
#
autoload -Uz vcs_info
autoload colors
colors
PROMPT="%B%{${fg[cyan]}%}$ %{${reset_color}%}%b"
RPROMPT="%B%{${fg[blue]}%}%n@%m %~% %(!.#.$) %{${reset_color}%}%b"

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
alias s="git status"
alias one="git one"
alias v="vim"
alias vz="vim ~/.zshrc"
alias vv="vim ~/.vimrc"
alias vs="vim ~/.screenrc"
alias vg="vim ~/.gitconfig"
alias vgem="vim ~/.gemrc"
alias virb="vim ~/.irbrc"
alias g="git"
alias gd="git diff"
alias one="git one"
alias r="rails"
alias sc="screen"
alias t="term -t"
alias develop_jobnote="ssh -v baba@kebab.dev.grooves.co.jp -R 3200:127.0.0.1:3000 sleep 99999"
alias jps="ssh baba@163.43.176.139 -p 10022"
alias jp="ssh baba@173.255.220.248 -p 10022"

alias binstall="bundle install"
alias vgl="vim ~/.vim/GetLatest/GetLatestVimScripts.dat"
alias tendon="ssh baba@tendon"

alias zshrc="source ~/.zshrc"

alias job_posting="cd work/projects/job_posting/"

case "${OSTYPE}" in
	freebsd*|darwin*)
	alias ls="ls -G -w"
	;;
	linux*)
	alias ls="ls --color"
	;;
esac

alias l="ls"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lal="ls -al"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias -g G=" | grep "

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports() 
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-256color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

export PATH=~/bin:~/.gem/ruby/1.8/bin:$PATH
export PATH=/Users/tatsuro/glassfishv3/bin:$PATH
# export PATH=$PATH:/Users/tatsuro/src/jruby-1.5.1/bin
if [[ -s /Users/tatsuro/.rvm/scripts/rvm ]] ; then source /Users/tatsuro/.rvm/scripts/rvm ; fi

export ARCHFLAGS='-arch x86_64'

export GEM_HOME=~/.gem/ruby/1.8/
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

if [ "$TERM" = "screen" ]; then
	preexec () {
		echo -ne "\ek${1%% *}\e\\"
	}
	PROMPT_COMMAND=~/bin/screen_minidir
	stty start ''
fi

if [ -x /usr/bin/tscreen -o ]; then
   alias screen='tscreen'
fi
