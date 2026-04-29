maxSpeed = 16;
startDir = 0;
velocityX = 0;

throw_start = function() {
	velocityX = maxSpeed * startDir;
}

boomerang_thrown = function() {
	for (i = 0; i < array_length(global.player.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, global.player.collideable_terrain[i]) {
			instance_destroy();
		}
	}
	
	for (i = 0; i < array_length(global.player.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, global.player.breakable_terrain[i]) {
			instance_destroy(instance_place(x + velocityX, y, global.player.breakable_terrain[i]));
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) {
		instance_destroy();
	}
	
	x += velocityX;
	velocityX -= startDir / 2.5;
	
	image_angle += 90;
}

kill = function() {
	if place_meeting(x, y, obj_simple_enemy) {
		instance_place(x, y, obj_simple_enemy).kill_fall();
	}
    
	if place_meeting(x, y, obj_shell) {
		instance_destroy(instance_place(x, y, obj_shell));
		
		instance_destroy();
	}
}