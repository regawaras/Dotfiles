# .Bashrc Configuration by @regawaras on Github | https://github.com/regawaras

#tty-clock
#fastfetch # Executing for each time use window
#neofetch
#cat regawaras.txt

# ALIAS USAGE
alias v='sudo vim'
alias b='vim ~/.bashrc'
alias sp='sudo pkill'
alias t='touch'

# ALIAS FOR EDITING FILE
alias vnix='v /etc/nixos/configuration.nix'
alias rvim='v /root/.vimrc'
alias hypr='v ~/.config/hypr/hyprland.conf'
alias kitty='v ~/.config/kitty/kitty.conf'
alias waybar='v /etc/xdg/waybar/config'
alias waybars='v /etc/xdg/waybar/style.css'
alias vaichat='v ~/.config/aichat/dark.tmTheme'
alias vff='v ~/.config/fastfetch/config.jsonc'
alias vcava='v ~/.config/cava/config'
alias vk='v ~/vk'
alias cc='tty-clock -s'
alias h='history'



# ALIAS FOR EXTREME SHORTCUT
alias ai='aichat'

alias c='cat'
alias cb='cat ~/.bashrc'

alias bh='cat ~/.bash_history | grep'

alias la='ls -la'
alias lsd='ls -laSh'
alias lzp='du -h --max-depth=1 | sort -rh'
alias lzm='du -h --max-depth=1 | sort -h'

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
alias filerun='sudo find / -type f -print0 | while IFS= read -r -d $'\0' file; do echo "$file"; sleep 0.1; done'
alias filepathrun='sudo find /home/regawaras/als/md -type f -print0 | while IFS= read -r -d $'\0' file; do echo "$file"; sleep 0.1; done'
alias mdrun='sudo find -type f -name "*.md" -print0 | while IFS= read r -d $'\0' file; do echo "$file"; sleep 0.1; done'

alias kcava='kitten panel --edge=background cava'

PS1='\[\e[38;2;255;255;0m\]\u@\h\[\e[0m\]:\[\e[38;2;100;149;237m\]\w\[\e[0m\]\$ '

