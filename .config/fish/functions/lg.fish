function lg --wraps='lazygit -p' --description 'alias lg lazygit -p'
    if count $argv >/dev/null && test -e $argv[1]
        lazygit -p $argv
    else if count $argv >/dev/null
        lazygit $argv
    else
        lazygit
    end
end
