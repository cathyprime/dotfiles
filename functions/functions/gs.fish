function gs --wraps=git\ status\n --wraps='git status' --description 'alias gs git status'
  git status $argv
        
end
