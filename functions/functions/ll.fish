function ll --wraps=ls --wraps='exa -l' --wraps='exa -l --git' --description 'alias ll exa -l --git'
  exa -l --git $argv
        
end
