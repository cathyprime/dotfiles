function fish_greeting
    echo
    echo "  $(date)"
    echo "$(nitch) $(date +%Y) the year of linux desktop!"
    cat $HOME/News/archlinux/news | archnews -iu
end
