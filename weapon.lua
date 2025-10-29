weapon = {
    card = nil,
    defeated = {}
}

function set_weapon(card)
    weapon.card = card
    weapon.defeated = {}
end

function weapon_value()
    if #weapon.defeated > 0 then
        return weapon.defeated[#weapon.defeated].value
    else
        return weapon.card.value
    end
end