# Fra opprinnelig .zshrc
ZSH_THEME="robbyrussell"

# Henger igjen fra bootcamp
ZSH=$HOME/.oh-my-zsh
export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe

# Aliaser, skrevet selv 

## Mappesnarveier
alias zk="/mnt/c/Users/ml/zettelkasten"	   # Snarvei til Zettelkasten
alias BIU="/mnt/c/Users/ml/Desktop/BIU"    # Snarvei til BIU-kodemappa
alias ml="/mnt/c/Users/ml"
alias kode="/mnt/c/Users/ml/Desktop/Kodebaser"
alias desktop="/mnt/c/Users/ml/Desktop"

## Kommandoer
alias lagre="zsh lagre.zsh"                # ZK-autocommit/push 
alias gitpull="git pull origin master"
alias tiny="source /home/martinlillebo/pythonscript/tiny.zsh"	# Hjemmesnekra tinyURL-API-til-markdownlenke

# OMZ boilerplate

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/martinlillebo/.oh-my-zsh"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Aktiverer fargelegging av gyldige/ugyldige kommandoer
source /mnt/c/Users/ml/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Legger inn pythonscript-mappa mi til PYTHONPATH:
export PYTHONPATH="${PYTHONPATH}:/home/martinlillebo/pythonscript"


# Setter opp virtualenvwrapper
# Dette er for WSL, for Linux er filbanen annerledes, se virtualenvwrapper-zettelen
export PATH=/home/martinlillebo/.local/bin:$PATH
export VIRTUALENVWRAPPER_PYTHON=$(which python3) # Forklaring: 202201252051
source /home/martinlillebo/.local/bin/virtualenvwrapper.sh # Denne virker ikke

# Krav fra en openssl-installeringsside ifb. kjøring av sublimeless. 
# https://help.dreamhost.com/hc/en-us/articles/360001435926-Installing-OpenSSL-locally-under-your-username
# Kan hende dette er unødvendig, vet ikke hva det gjør
export PATH=$HOME/openssl/bin:$PATH
export LD_LIBRARY_PATH=$HOME/openssl/lib
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/home/martinlillebo/openssl/lib -Wl,-rpath,/home/martinlillebo/openssl/lib"
