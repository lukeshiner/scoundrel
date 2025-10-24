health = "health"
sword = "sword"
enemy = "enemy"

hearts = 1
diamonds = 2
spades = 3
clubs = 4

function make_heart(value)
    return {
        type = health,
        value = value,
        suit = hearts,
        name = value .. " hearts"
    }
end

function make_diamond(value)
    return {
        type = sword,
        value = value,
        suit = diamonds,
        name = value .. " diamonds"
    }
end

function make_club(value)
    return {
        type = enemy,
        value = value,
        suit = clubs,
        name = value .. " clubs"
    }
end

function make_spade(value)
    return {
        type = enemy,
        value = value,
        suit = spades,
        name = value .. " spades"
    }
end

function make_deck()
    deck = {}
    for i = 1, 13 do
        if i < 11 then
            add(deck, make_heart(i))
            add(deck, make_diamond(i))
        end
        add(deck, make_club(i))
        add(deck, make_spade(i))
    end
    return deck
end

function shuffle(cards)
    new_cards = {}
    while #cards > 0 do
        local index = flr(rnd(#cards) + 1)
        add(new_cards, deli(cards, index))
    end
    return new_cards
end