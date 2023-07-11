function la --wraps='exa -la' --wraps='exa -la --git' --wraps='exa -la --git --group-directories-first' --description 'alias la exa -la --git --group-directories-first'
  exa -la --git --group-directories-first $argv
        
end
