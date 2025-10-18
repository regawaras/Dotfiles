#neofetch

# ALIAS USAGE
alias p='neofetch'
alias v='vim'
alias wf="watch -n 5 nmcli dev wifi list"
alias b="watch -n 1 hcitool scan"
alias ipd="nmap -v -A -n scanme.nmap.org"
alias ipmac="sudo nmap -sn 192.168.18.106/24"
alias ncg="nix-store --gc"
alias nrs="nixos-rebuild switch"

PS1='\[\033[38;2;255;255;0m\]\u@\h\[\033[00m\]:\w\$ '

. "$HOME/als/Kritaai/server/uv/env"
