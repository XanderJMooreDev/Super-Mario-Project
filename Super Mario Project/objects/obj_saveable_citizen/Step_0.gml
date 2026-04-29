if obj_game_manager.playable {
    if (place_meeting(x - 32, y, global.player) || place_meeting(x + 32, y, global.player)) && obj_control_manager.textControl {
        obj_dialogue_manager.display_dialogue(saveable_interaction_dialogues[array_get_index(saveable_array, saveable_name)], self);
    }
    
    if global.player.x > x {
        image_xscale = 1;
    }
    else {
        image_xscale = -1;
    }
}