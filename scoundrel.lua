max_health = 20

function init_scoundrel()
    current_health = max_health
    last_played_card = nil
    deck = shuffle(make_deck())
    reset_weapon()
    reset_room()
end

function update_scoundrel()
    if btnp(🅾️) then
        handle_selection(current_selection(), false)
    elseif btnp(❎) then
        handle_selection(current_selection(), true)
    end
    if btnp(➡️) then
        change_selection(1)
    elseif btnp(⬅️) then
        change_selection(-1)
    end
end

function draw_scoundrel()
    cls(1)
    draw_room()
end

function handle_selection(selection_text, use_alternate)
    if selection_text == "run" then
        if room.can_run == true then
            run()
        end
    else
        card_index = tonum(sub(selection_text, 5))
        card = room.cards[card_index]
        if card != nil then
            play_card(card, use_alternate)
        end
    end
end

function play_card(card, use_alternate)
    local use_alternate = use_alternate or false
    log("play card " .. card_index .. ": " .. card.name .. " alternate: " .. tostr(use_alternate))
    if use_alternate == true then
        if card.type == enemy and can_use_weapon(card) then
            fight_barehand(card)
            last_played_card = del(room.cards, card)
        end
    else
        if card.type == enemy then
            if can_use_weapon(card) then
                fight_with_weapon(card)
            else
                fight_barehand(card)
            end
            last_played_card = del(room.cards, card)
        elseif card.type == health then
            take_potion(card)
            last_played_card = del(room.cards, card)
        elseif card.type == sword then
            equip_weapon(card)
            last_played_card = del(room.cards, card)
        end
    end
    if (#deck == 0 and #room.cards == 0) or current_health < 1 then
        current_state = states.game_over
    elseif #room.cards == 1 then
        next_room()
    end
end

function take_potion(card)
    if room.potion_taken == false then
        room.potion_taken = true
        current_health = min(current_health + card.value, max_health)
    end
end

function equip_weapon(card)
    set_weapon(card)
end

function fight_barehand(card)
    current_health -= card.value
end

function fight_with_weapon(card)
    use_weapon(card)
end