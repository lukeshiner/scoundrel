room = {
    cards = {}
}

function refill_room()
    while #room.cards < 4 do
        if #deck > 0 then
            add(room.cards, deli(deck, 1))
        else
            break
        end
    end
end

function next_room()
    can_run = true
    refill_room()
end

function run()
    room.cards = shuffle(room.cards)
    for card in all(room.cards) do
        add(deck, card)
    end
    room.cards = {}
    can_run = false
    refill_room()
end