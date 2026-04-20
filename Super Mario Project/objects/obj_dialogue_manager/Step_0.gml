if obj_control_manager.textControl && dialogueOption != -1 {
    dialogueOption++;
    
    if dialogueOption >= array_length(dialogue) && dialogueOption != -1 {
        dialogueOption = -2;
        obj_game_manager.playable = true;
        
        if variable_instance_exists(talking_to, "save") {
            talking_to.save();
        }
    }
}