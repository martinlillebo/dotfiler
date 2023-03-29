ln -rs .zshrc ../.zshrc
ln -rs .vimrc ../.vimrc
ln -rs AutoHotkey ../AutoHotkey
ln -rs .nanorc ../.nanorc

## Feilsøking
#- Om alle symlenkene får "`'$'\r`" i filnavnene sine er det fordi config-filen er blitt endret med et Windows-system som tukler inn sine usynlige linjeskiftsymboler
#    - Løses med `dos2unix dotfiler-config.zsh`
