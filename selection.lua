selections = {
    selected_index = 1,
    options = { "card1", "card2", "card3", "card4", "run" }
}

function current_selection()
    return selections.options[selections.selected_index]
end

function change_selection(direction)
    selections.selected_index = selections.selected_index + direction
    if selections.selected_index > #selections.options then
        selections.selected_index = 1
    elseif selections.selected_index < 1 then
        selections.selected_index = #selections.options
    end
end