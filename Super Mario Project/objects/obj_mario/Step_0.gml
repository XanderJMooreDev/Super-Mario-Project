animate();
transition_power(lastPower, powerUp);

if !alive {
    if deathHop == 300 {
        deathHop = 0;
        alarm[0] = 30;
    }
    else if deathHop != 0 {
        deathHop -= 2;
    }
    
    y -= deathHop;
}

if !obj_game_manager.playable {
	return;
}

check_controls();
apply_gravity();
apply_walk();
pick_up_power_up();
use_power();