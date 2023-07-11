function ll --wraps=ls --wraps='exa -l' --wraps='exa -l --git' --wraps='exa -l --git --group-directories-first' --description 'alias ll exa -l --git --group-directories-first'
  exa -l --git --group-directories-first $argv
        
end
