function new-nvim --wraps='begin; set -lx NVIM_APPNAME new-nvim; nvim; end;' --description 'alias new-nvim begin; set -lx NVIM_APPNAME new-nvim; nvim; end;'
    begin
        set -lx NVIM_APPNAME new-nvim
        nvim $argv
    end
end
