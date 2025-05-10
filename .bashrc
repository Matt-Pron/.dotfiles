#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias hl='Hyprland'
alias y='yazi'
alias minecraft='nohup java -jar ~/Downloads/TLauncher.jar &'
alias v='nvim .'
alias vr='cd ~/notas/rol && nvim main.md'
