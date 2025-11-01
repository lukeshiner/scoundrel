room = nil

function reset_room()
    room = {
        cards = {},
        potion_taken = false,
        can_run = true,
        card_size = { x = 24, y = 32 },
        positions = {
            8, 40, 60, 90
        },
        room_number = 0
    }
    next_room()
end

function refill_room()
    while #room.cards < 4 do
        if #deck > 0 then
            add(room.cards, deli(deck, 1))
        else
            break
        end
    end
    room.room_number += 1
    room.potion_taken = false
end

function next_room()
    room.can_run = true
    refill_room()
end

function run()
    room.cards = shuffle(room.cards)
    for card in all(room.cards) do
        add(deck, card)
    end
    room.cards = {}
    room.can_run = false
    refill_room()
end

function rooms_remaining()
    return ceil(#deck / 3)
end

function draw_room()
    for card_number = 1, 4 do
        draw_card_slot(card_number)
    end
    draw_weapon_slot()
    draw_run()
    draw_health()
    draw_stats()
end

function draw_card_slot(card_number)
    local margin = 6
    local x = margin * card_number + room.card_size.x * (card_number - 1)
    local y = 10
    local x2 = x + room.card_size.x
    local y2 = y + room.card_size.y
    local selected
    if current_selection() == "card" .. card_number then
        selected = true
        print("◆", x + room.card_size.x / 2 - 4, y - 6, 6)
    else
        selected = false
    end
    rect(x, y, x2, y2, 5)
    if #room.cards >= card_number then
        local card = room.cards[card_number]
        if selected == true then
            draw_instructions(x, y, card)
        end
        draw_card(x, y, card)
    end
end

function draw_weapon_slot()
    local x = 8
    local y = 64
    local x2 = x + room.card_size.x
    local y2 = y + room.card_size.y
    rect(x, y, x2, y2, 5)
    if weapon.card != nil then
        draw_card(x, y, weapon.card)
        for enemy_card in all(weapon.defeated) do
            y += 8
            draw_card(x, y, enemy_card)
        end
    end
end

function draw_card(x, y, card)
    local x2 = x + room.card_size.x
    local y2 = y + room.card_size.y
    rectfill(x + 1, y + 1, x2 - 1, y2 - 1, 7)
    rect(x + 1, y + 1, x2 - 1, y2 - 1, 6)
    spr(card.suit, x + 2, y + 2)
    print(card.text_value, x + 10, y + 3, 0)
    spr(card.suit, x2 - 10, y2 - 9)
    print(card.text_value, x2 - 18, y2 - 8)
    spr(type_sprites[card.type], x + 4, y + 7, 2, 2)
end

function draw_run()
    local x = 50
    local y = 64
    local x2 = x + 40
    local y2 = y + 12
    local colour = 8
    if room.can_run == false then
        colour = 5
    end
    rectfill(x, y, x2, y2, colour)
    rect(x, y, x2, y2, 5)
    print("run", x + 14, y + 4, 7)
    if current_selection() == "run" then
        print("◆", x + 16, y - 6, 6)
    end
end

function draw_instructions(x, y, card)
    local x = x + 2
    local y = y + room.card_size.y + 2
    if card.type == health then
        instruction = "🅾️heal"
    elseif card.type == sword then
        instruction = "🅾️equip"
        x = x - 4
    elseif card.type == enemy then
        instruction = "🅾️unarmed"
        if can_use_weapon(card) then
            instruction = "🅾️sword\n❎unarmed"
        end
        x = x - 6
    end
    print(instruction, x, y, 7)
end

function draw_health()
    local x = 110
    local y = 100
    rect(x, y, x - 5, y - 41, 7)
    rectfill(x - 1, y - 1, x - 4, y - (current_health * 2), 8)
    print("♥", x - 10, y + 2, 8)
    print(current_health, x - 2, y + 2, 7)
end

function draw_stats()
    print("room " .. room.room_number, 50, 78, 7)
    print("remaining " .. rooms_remaining())
end