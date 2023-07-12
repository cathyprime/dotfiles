function lt --wraps='exa --tree --level=2 --long --icons --git' --wraps='exa --tree --level=2 --long --icons --git --group-directories-first' --description 'alias lt exa --tree --level=2 --long --icons --git --group-directories-first'
  exa --tree --level=2 --long --icons --git --group-directories-first $argv
        
end
