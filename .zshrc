# Temp til CPP EMS installering
#export LD_LIBRARY_PATH=/home/ml/repos/ems-cpp/3rd-party/lib/x86:
#export LD_LIBRARY_PATH=/home/ml/repos/ems-cpp/3rd-party/x86/lib:/home/ml/repos/ems-cpp/build/x86/lib:


# PATH
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH=$PATH:/usr/sbin 

# Tema. Har alltid bare brukt det originale
ZSH_THEME="robbyrussell" # set by `omz`

# Aliaser, skrevet selv
alias emacs-config="vim .config/doom/config.el"
alias e="emacs &"
alias tf="terraform"
alias ggg="git pull origin master"
alias lagre="zsh lagre.zsh"                # ZK-autocommit/push
alias dec-hex='printf "%x\n"' # %x sier "omgjør til hex", \n legger til newline
alias hex-dec='printf "%d\n"'
alias dict='dict.cc.py'
alias dconf-dump="dconf dump /org/gnome/"
alias autokey-stop="pkill autokey-gtk"
alias autokey-av="pkill autokey-gtk"
alias vm="virt-manager"
alias docker="sudo docker"
alias c="clear"
alias skruav="systemctl poweroff"
alias xclip="xclip -selection c" # for å kunne pipe til clipboard med (...) | xclip
alias tiny='source /home/ml/repos/tiny/tiny.zsh'
alias i='ip -c a'
alias pymodbus.console='~/venv-pymodbus/bin/python3 ~/venv-pymodbus/bin/pymodbus.console'
alias eco-poller='/home/ml/repos/EcoPlatform/eco-poller/venv/bin/python3 /home/ml/repos/EcoPlatform/eco-poller/eco-poller.py'

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
	alias repos="~/repos"
	alias zk="~/repos/notater"
	alias notater="~/repos/notater"
	alias dotfiler="~/repos/dotfiler"
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
	source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else # Linux
	source "$HOME"/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


export PYTHONPATH="${PYTHONPATH}:/home/ml/repos/EcoPlatform"
export PYTHONPATH="${PYTHONPATH}:/home/ml/repos/tiny"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export PATH="$HOME/.local/bin:$PATH"
