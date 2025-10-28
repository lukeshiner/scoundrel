room = {
    cards = {},
    card_size = { x = 24, y = 32 },
    positions = {
        8, 40, 60, 90
    }
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

function draw_room()
    for card_number = 1, 4 do
        draw_card(card_number)
    end
end

function draw_card(card_number)
    local margin = 6
    local x = margin * card_number + room.card_size.x * (card_number - 1)
    local y = 20
    local x2 = x + room.card_size.x
    local y2 = y + room.card_size.y
    rect(x, y, x2, y2, 5)
    if #room.cards >= card_number then
        rectfill(x + 1, y + 1, x2 - 1, y2 - 1, 7)
        card = room.cards[card_number]
        spr(card.suit, x + 2, y + 2)
        print(card.value, x + 10, y + 3, 0)
        spr(card.suit, x2 - 10, y2 - 9)
        print(card.value, x2 - 18, y2 - 8)
        spr(type_sprites[card.type], x + 4, y + 7, 2, 2)
    end
end