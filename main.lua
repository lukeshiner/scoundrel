max_health = 20
can_run = true

function reset()
    current_health = max_health
    deck = shuffle(make_deck())
    next_room()
end

function _init()
    reset()
end

function _update()
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

function _draw()
    cls(3)
    print(current_health .. "    " .. #deck, 0, 100)
    draw_room()
end

function handle_selection(selection_text, alternate)
    if selection_text == "run" then
        run()
    else
        card_index = tonum(sub(selection_text, 5))
        play_card(card_index, alternate)
    end
end

function play_card(index, use_weapon)
    local use_weapon = use_weapon or false
    card = deli(room.cards, index)
    log("play card " .. index .. ": " .. card.name)
    if card.type == enemy then
        if use_weapon == true then
            add(weapon.defeated, card)
        else
            current_health = current_health - card.value
        end
    elseif card.type == health then
        current_health = current_health + card.value
    elseif card.type == sword then
        set_weapon(card)
    end
    if #room.cards == 1 then
        next_room()
    end
end