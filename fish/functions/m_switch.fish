function m_switch
    if test $M_DISABLE = true
        set -U M_DISABLE false
    else
        set -U M_DISABLE true
    end
end
