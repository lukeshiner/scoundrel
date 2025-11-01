function update_game_over()
    if btnp(🅾️) then
        init_scoundrel()
        current_state = states.scoundrel
    end
end

function draw_game_over()
    cls(1)
    print(title(), 48, 48, 7)
    print("score: " .. score(), 44, 56, 7)
    print("🅾️ play again", 38, 64, 7)
end

function score()
    local score = 0
    for card in all(deck) do
        if card.type == enemy then
            score -= card.value
        end
    end
    if score == 0 then
        score = current_health
        if last_played_card.type == health then
            score += last_played_card.value
        end
    end
    return score
end

function title()
    if #deck == 0 and #room.cards == 0 and current_health > 0 then
        return "you won"
    else
        return "you lost"
    end
end