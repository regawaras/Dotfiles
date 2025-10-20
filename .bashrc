# .Bashrc Configuration by @regawaras on Github | https://github.com/regawaras

#fastfetch # Executing for each time use window
#neofetch
#cat regawaras.txt

# ALIAS USAGE
alias v='sudo vim'
alias b='vim ~/.bashrc'
alias sp='sudo pkill'
alias t='touch'


# ALIAS FOR EDITING FILE
alias nix='v /etc/nixos/configuration.nix'
alias hypr='v ~/.config/hypr/hyprland.conf'
alias kitty='v ~/.config/kitty/kitty.conf'
alias waybar='v /etc/xdg/waybar/config'
alias vaichat='v ~/.config/aichat/dark.tmTheme'
alias vff='v ~/.config/fastfetch/config.jsonc'
alias vk='v ~/vk'

# ALIAS FOR EXTREME SHORTCUT
alias ai='aichat'

alias c='cat'
alias cb='cat ~/.bashrc'

alias la='ls -la'
alias lsd='ls -laSh'
alias lzp='du -h --max-depth=1 | sort -rh'
alias lzm='du -h --max-depth=1 | sort -h'


alias ipdd='while true; do nmap -v -A -n scanme.nmap.org; done'

alias p='fastfetch; cat ~/regawaras.txt'
alias ff='fastfetch'
alias nf='neofetch'
alias cm='cmatrix'

alias wf="watch -n 5 nmcli dev wifi list"
alias blt="watch -n 1 hcitool scan"
alias ipd="nmap -v -A -n scanme.nmap.org"
alias ipmac="sudo nmap -sn 192.168.18.106/24"
alias ddd="nix-store --gc"
alias nnn="sudo nixos-rebuild switch"

PS1='\[\033[38;2;255;255;0m\]\u@\h\[\033[00m\]:\w\$'


