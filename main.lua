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
        play_card(1)
    end
end

function _draw()
    cls(3)
    for n, card in pairs(room.cards) do
        print(n .. "  " .. card.name)
    end
    print("run")
    print(current_health .. "    " .. #deck, 0, 100)
    draw_room()
end

function play_card(index)
    card = deli(room.cards, index)
    log("play card " .. index .. ": " .. card.name)
    if card.type == enemy then
        current_health = current_health - card.value
    elseif card.type == health then
        current_health = current_health + card.value
    end
    if #room.cards == 1 then
        next_room()
    end
end