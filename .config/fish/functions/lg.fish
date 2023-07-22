function lg --wraps='lazygit -p' --description 'alias lg lazygit -p'
    if count $argv >/dev/null
        lazygit -p $argv
    else
        lazygit
    end
end
