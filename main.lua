states = {
    scoundrel = "scoundrel",
    game_over = "game_over"
}

current_state = states.scoundrel

function _init()
    init_scoundrel()
end

function _update()
    if current_state == states.scoundrel then
        update_scoundrel()
    elseif current_state == states.game_over then
        update_game_over()
    end
end

function _draw()
    if current_state == states.scoundrel then
        draw_scoundrel()
    elseif current_state == states.game_over then
        draw_game_over()
    end
end