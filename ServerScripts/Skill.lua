function BasicAttack(a, b, critical)
    local a_atk = a.atk
    local b_def = b.def

    if a_atk <= b_def then
        return 0
    end

    if critical then
        a_atk = a_atk*2
    end

    return a.atk
end