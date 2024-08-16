# Tema. Har alltid bare brukt det originale
ZSH_THEME="robbyrussell"

if [ `uname` = "Linux" ]; then
else
	export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe
fi

# Aliaser, skrevet selv
alias ggg="git pull origin master"
alias lagre="zsh lagre.zsh"                # ZK-autocommit/push
alias dec-hex='printf "%x\n"' # %x sier "omgjør til hex", \n legger til newline
alias hex-dec='printf "%d\n"'
alias dict='dict.cc.py'
alias dconf-dump="dconf dump /org/gnome/"
alias autokey-stop="pkill autokey-gtk"
alias autokey-av="pkill autokey-gtk"
alias vm="virt-manager"

## Mappesnarveier og div
if grep -qi microsoft /proc/version; then # Windows (WSL)
	alias repos="/mnt/c/repos"
	alias zk="/mnt/c/Users/ml/repos/notater"
	alias notater="/mnt/c/Users/ml/repos/notater"
	alias dotfiler="/mnt/c/Users/ml/repos/dotfiler"
	alias desktop="/mnt/c/Users/ml/Desktop"

else # Linux
	alias repos="$HOME/repos/"
	alias zk="$HOME/repos/notater"
	alias notater="$HOME/repos/notater"
	alias dotfiler="$HOME/repos/dotfiler"
	alias desktop="$HOME/Desktop"
        alias zk.py="~/Documents/sublimeless_zk/venv/bin/python3 ~/Documents/sublimeless_zk/src/sublimeless_zk.py"
#	xmodmap ~/.xmodmap # For å få capslock til å virke som konfigurerbar tast i AutoKey
	alias activate="source venv/bin/activate"
fi

## Kommandoer

if grep -qi microsoft /proc/version; then
	alias tiny="source /home/martinlillebo/pythonscript/tiny.zsh"	# Hjemmesnekra tinyURL-API-til-markdownlenke
else
	alias tiny="source $HOME/pythonscript/tiny.zsh"
fi

# OMZ boilerplate

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Disse to er avgjørende for å få custom prompt til å virke
export ZSH="$HOME/.oh-my-zsh"
source "$ZSH"/oh-my-zsh.sh


# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Aktiverer fargelegging av gyldige/ugyldige kommandoer
if grep -qi microsoft /proc/version; then # Windows
	source /mnt/c/Users/ml/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else # Linux
	source "$HOME"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

