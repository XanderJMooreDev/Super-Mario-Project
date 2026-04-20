dialogueOption = -1;
dialogue = [ "No message set" ];
talking_to = noone;

display_dialogue = function(dialogue_array, sender) {
    dialogue = dialogue_array;
    dialogueOption++;
    talking_to = sender;
    
    if dialogueOption >= 0 {
        obj_game_manager.playable = false;
        show_debug_message(dialogue[dialogueOption]);
    }
}