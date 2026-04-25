if obj_game_manager.playable && !hidden_until_saved {
    if (place_meeting(x - 32, y, obj_mario) || place_meeting(x + 32, y, obj_mario)) && obj_control_manager.textControl {
        if talked_to {
            obj_dialogue_manager.display_dialogue(npc_repeat_interaction_dialogues[array_get_index(npc_array, npc_name)], self);
        }
        else {
            talked_to = true;
            obj_dialogue_manager.display_dialogue(npc_first_interaction_dialogues[array_get_index(npc_array, npc_name)], self);
        }
    }
    
    if facing_direction == 0 {
        if obj_mario.x > x {
            image_xscale = 1;
        }
        else {
            image_xscale = -1;
        }
    }
    else {
        image_xscale = facing_direction;
    }
}
    
image_alpha = !hidden_until_saved;