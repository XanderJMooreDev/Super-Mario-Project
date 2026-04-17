
show_debug_message(warping);

if warping == 1 {
    if place_meeting(x, y + 8, obj_warp_pipe) {
        if y < instance_place(x, y + 8, obj_warp_pipe).y + 8 {
            y += 2;
        }
        else {
            pipemate = instance_place(x, y + 8, obj_warp_pipe).find_mate();
            
            if pipemate != noone {
                warping = 2;
                
                x = pipemate.x;
                y = pipemate.y + 8;
                camera_set_view_pos(obj_camera_manager.camera, x, y);
                return;
            }
        }
    }
}
else if place_meeting(x, y, obj_warp_pipe) && warping == 2 {
    y -= 2;
    return;
}
else if warping == 2 {
    obj_game_manager.playable = true;
    warping = 0;
    return;
}

animate();

if !alive {
    if deathHop == 300 {
        deathHop = 0;
        alarm[0] = 30;
    }
    else if deathHop != 0 {
        deathHop -= 2;
    }
    
    y -= deathHop;
    
    return;
}

transition_power(lastPower, powerUp);

if !obj_game_manager.playable {
	return;
}

check_controls();

if climbing {
    apply_climb();
}
else {
    apply_gravity();
    apply_walk();
}

pick_up_power_up();
use_power();