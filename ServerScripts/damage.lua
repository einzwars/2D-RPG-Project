Server.damageCallback = function(a, b, damage, skillDataID, critical, visible)
    if a.luk > rand(1,101) then
        b.showAnimation(14)
        critical = true
        damage = math.ceil(damage * 2 + (damage * a.agi * 0.01))   -- 민첩 1당 원래 데미지의 0.01% 추가 상승
        return damage-b.def
    end
    return damage-b.def
end