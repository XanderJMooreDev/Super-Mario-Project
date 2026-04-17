dialogueOption = -1;
dialogue = [ "No message set" ];

display_dialogue = function(dialogue_array) {
    
    dialogue = dialogue_array;
    dialogueOption++;
    
    if dialogueOption >= 0 {
        obj_game_manager.playable = false;
        show_debug_message(dialogue[dialogueOption]);
    }
}