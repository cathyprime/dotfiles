function tree --wraps='erd -HId physical -s name -y inverted' --description 'alias tree erd -HId physical -s name -y inverted'
  erd -HId physical -s name -y inverted $argv
        
end
