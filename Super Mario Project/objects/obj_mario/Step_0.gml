animate();
transition_power(lastPower, powerUp);

if !obj_game_manager.playable {
	return;
}

check_controls();
apply_gravity();
apply_walk();
pick_up_power_up();
use_power();