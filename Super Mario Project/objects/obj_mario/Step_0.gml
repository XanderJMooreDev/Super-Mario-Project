animate();

if warping == 1 {
    if enter_pipe(pipeDirection) == 1 {
        return;
    }
}
else if place_meeting(x, y, obj_warp_pipe) && warping == 2 {
    switch instance_place(x, y, obj_warp_pipe).open_dir {
        case "Up":
            y -= 2;
            break;
        case "Down":
            y += 2;
            break;
        case "Right":
            x += 2;
            break;
        case "Left":
            x -= 2;
            break;
    }
    return;
}
else if warping == 2 {
    obj_game_manager.playable = true;
    warping = 0;
    return;
}

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

attempt_pickup();

if climbing {
    apply_climb();
}
else {
    apply_gravity();
    apply_walk();
}

pick_up_power_up();
use_power();