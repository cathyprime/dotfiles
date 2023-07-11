function ls --wraps=exa --wraps='exa --git' --wraps='exa --git --group-directories-first' --description 'alias ls exa --git --group-directories-first'
  exa --git --group-directories-first $argv
        
end
