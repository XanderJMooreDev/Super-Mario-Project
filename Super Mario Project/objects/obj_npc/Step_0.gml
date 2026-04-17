if obj_game_manager.playable {
    if (place_meeting(x - 32, y, obj_mario) || place_meeting(x + 32, y, obj_mario)) && obj_control_manager.textControl {
        if talked_to {
            obj_dialogue_manager.display_dialogue(npc_repeat_interaction_dialogues[array_get_index(npc_array, npc_name)]);
        }
        else {
            talked_to = true;
            obj_dialogue_manager.display_dialogue(npc_first_interaction_dialogues[array_get_index(npc_array, npc_name)]);
        }
    }
    
    if obj_mario.x > x {
        image_xscale = 1;
    }
    else {
        image_xscale = -1;
    }
}