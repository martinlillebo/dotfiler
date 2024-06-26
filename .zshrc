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

## Mappesnarveier og div
alias ggg="git pull origin master"

if grep -qi microsoft /proc/version; then # Windows
	alias zk="/mnt/c/Users/ml/notater"
	alias desktop="/mnt/c/Users/ml/Desktop"
	alias repos="/mnt/c/repos"

else # Linux
	alias zk="$HOME/notater"
        alias zk.py="~/Documents/sublimeless_zk/venv/bin/python3 ~/Documents/sublimeless_zk/src/sublimeless_zk.py"
	alias desktop="$HOME/Desktop"
	xmodmap ~/.Xmodmap # For å få capslock til å virke som konfigurerbar tast i AutoKey
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

# Legger til PYTHONPATH:
## Pythonscriptmappa:
export PYTHONPATH="${PYTHONPATH}:/home/martinlillebo/pythonscript"
## pakker som installeres i .local/bin fra WSL:
export PYTHONPATH="${PYTHONPATH}:/home/martinlillebo/.local/bin"

# Setter opp virtualenvwrapper. Dette er for WSL, for Linux er filbanen annerledes, se virtualenvwrapper-zettelen
if [ `uname` = "Linux" ]; then
	# Jeg bruker egentlig aldri virtualenvwrapper
else
	export PATH=/home/martinlillebo/.local/bin:$PATH
	export VIRTUALENVWRAPPER_PYTHON=$(which python3) # Forklaring: 202201252051
	source /home/martinlillebo/.local/bin/virtualenvwrapper.sh
fi

# Krav fra en openssl-installeringsside ifb. kjøring av sublimeless. 
# https://help.dreamhost.com/hc/en-us/articles/360001435926-Installing-OpenSSL-locally-under-your-username
# Kan hende dette er unødvendig, vet ikke hva det gjør
export PATH=$HOME/openssl/bin:$PATH
export LD_LIBRARY_PATH=$HOME/openssl/lib
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/home/martinlillebo/openssl/lib -Wl,-rpath,/home/martinlillebo/openssl/lib"
alias eco-poller="~/repos/eco-poller/venv/bin/python3 ~/repos/eco-poller/eco-poller.py"
