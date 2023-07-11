function fish_greeting
    echo
    echo "  $(date)"
    paste (nitch | psub) (calcurse -ad 10 -t | psub) | column -s \t -t
    echo "$(date +%Y) the year of linux desktop!"
    # cat $HOME/News/archlinux/news | archnews -iu
end
