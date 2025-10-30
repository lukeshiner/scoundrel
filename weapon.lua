weapon = {
    card = nil,
    defeated = {}
}

function set_weapon(card)
    weapon.card = card
    weapon.defeated = {}
end

function weapon_value()
    if weapon.card == nil then
        return 0
    else
        return weapon.card.value
    end
end

function can_use_weapon(card)
    if card.type == enemy and weapon.card != nil then
        if #weapon.defeated == 0 then
            return true
        elseif card.value < weapon.defeated[#weapon.defeated].value then
            return true
        end
    end
    return false
end

function use_weapon(card)
    local damage = max(card.value - weapon_value(), 0)
    add(weapon.defeated, card)
    current_health -= damage
end