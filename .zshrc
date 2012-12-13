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
RPROMPT="%B%{${fg[blue]}%}%n@ %~% %(!.#.$)%{${reset_color}%}%b"

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
alias s="git status -s -b"
alias d="git diff"
alias dc="git diff --cached"
alias one="git one"
alias gg="git grep"
alias l="git log -p --stat --decorate"
alias vim="/usr/local/Cellar/macvim/7.3-64/MacVim.app/Contents/MacOS/Vim"
alias v="vim"
alias vz="vim ~/.zshrc"
alias vv="vim ~/.vimrc"
alias vs="vim ~/.screenrc"
alias vg="vim ~/.gitconfig"
alias vgem="vim ~/.gemrc"
alias virb="vim ~/.irbrc"
alias g="git"
alias deploy_branch='g co -b "deploy-`date '+%Y%m%d%H%M%S'`"'
alias one="git log --graph --oneline --decorate"
alias r="rails"
alias sc="screen"
alias t="term -t"
alias tunnel="ssh -v baba@kebab -R 3700:127.0.0.1:3000 sleep 99999"
alias jps="ssh baba@163.43.176.139 -p 10022"
alias jp="ssh baba@173.255.220.248 -p 10022"
alias bx="bundle exec"
alias tblame="tig blame"

alias emoji="open http://www.emoji-cheat-sheet.com/"

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

export PATH=/usr/local/bin:~/bin:~/.gem/ruby/1.8/bin:$PATH
export PATH=/Users/tatsuro/glassfishv3/bin:$PATH
export BUNDLER_EDITOR=vi
# export PATH=$PATH:/Users/tatsuro/src/jruby-1.5.1/bin

export ARCHFLAGS='-arch x86_64'

export GEM_HOME=~/.gem/ruby/1.8/

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

if [ -f ~/.nvm/nvm.sh ]; then
	source ~/.nvm/nvm.sh

	if which nvm >/dev/null 2>&1 ; then
		_nodejs_use_version="v0.6.11"
		if nvm ls |grep -F -e "${_nodejs_use_version}" > /dev/null 2>&1 ; then
			nvm use "${_nodejs_use_version}" > /dev/null
		fi
		unset _nodejs_use_version
	fi
fi

# PATH for groonga
export GROONGA_CFLAGS="-I/usr/local/groonga/include/groonga"
export GROONGA_LIBS="-L/usr/local/groonga/lib -lgroonga"

# PATH for AWS
export AWS_CREDENTIAL_FILE="${HOME}/Src/aws_config/credential-file"

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.5.2.3/jars"

export EC2_CERT="${HOME}/Src/aws_config/cert-XES5NAU3EPWXMIVC5G6FZMVFZCA3557D.pem"
export EC2_PRIVATE_KEY="${HOME}/Src/aws_config/pk-XES5NAU3EPWXMIVC5G6FZMVFZCA3557D.pem"

export AWS_AUTO_SCALING_HOME="${HOME}/Src/AutoScaling-1.0.49.1"
export AWS_CLOUDWATCH_HOME="${HOME}/Src/CloudWatch-1.0.12.1"
export AWS_ELB_HOME="${HOME}/Src/ElasticLoadBalancing-1.0.15.1"

export PATH=$AWS_ELB_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$AWS_CLOUDWATCH_HOME/bin:$PATH

# PATH for Android SDK
export PATH=$PATH:/Applications/android-sdk/tools
export PATH=$PATH:/Applications/android-sdk/platforms
source /Users/tbaba/perl5/perlbrew/etc/bashrc

export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATJ=/usr/local/sbin:$PATH
