# Temp til CPP EMS installering
#export LD_LIBRARY_PATH=/home/ml/repos/ems-cpp/3rd-party/lib/x86:
#export LD_LIBRARY_PATH=/home/ml/repos/ems-cpp/3rd-party/x86/lib:/home/ml/repos/ems-cpp/build/x86/lib:



# Tema. Har alltid bare brukt det originale
ZSH_THEME="robbyrussell"

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
#alias code="com.visualstudio.code"
alias docker="sudo docker"
alias c="clear"
alias skruav="systemctl poweroff"
alias xclip="xclip -selection c" # for å kunne pipe til clipboard med (...) | xclip
alias tiny='source /home/ml/repos/tiny/tiny.zsh'

## Aliaser-Git
alias gst="git status"
alias gp="git push"
alias gpull="git pull"
alias ga="git add"
alias gc="git commit"

## Aliaser til mapper
alias ecop="~/repos/EcoPlatform"

## WSL
if grep -qi microsoft /proc/version; then # Windows (WSL)
	alias repos="/mnt/c/repos"
	alias zk="/mnt/c/Users/ml/repos/notater"
	alias notater="/mnt/c/Users/ml/repos/notater"
	alias dotfiler="/mnt/c/Users/ml/repos/dotfiler"
	alias desktop="/mnt/c/Users/ml/Desktop"
	export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe

else # Linux
	alias repos="$HOME/repos/"
	alias zk="$HOME/repos/notater"
	alias notater="$HOME/repos/notater"
	alias dotfiler="$HOME/repos/dotfiler"
	alias desktop="$HOME/Desktop"
	#alias zk.py="~/Documents/sublimeless_zk/venv/bin/python3 ~/Documents/sublimeless_zk/src/sublimeless_zk.py"
	alias activate="source venv/bin/activate"
fi

# PATH-tillegg
export PATH="$PATH:/var/lib/flatpak/exports/bin"

## For å få OMZ-prompt til å virke
export ZSH="$HOME/.oh-my-zsh"
source "$ZSH"/oh-my-zsh.sh
source $ZSH/oh-my-zsh.sh

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git)

# Fargelegging av gyldige/ugyldige kommandoer
if grep -qi microsoft /proc/version; then # Windows
	source /mnt/c/Users/ml/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else # Linux
	source "$HOME"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


export PYTHONPATH="${PYTHONPATH}:/home/ml/repos/EcoPlatform"
export PYTHONPATH="${PYTHONPATH}:/home/ml/repos/tiny"
