velocityX = 0;
velocityY = 0;
walkSpeed = 5;

terminalFallSpeed = 4;

sit_still = function() {
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.collideable_terrain[i]) {
			velocityY = -8;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.breakable_terrain[i]) {
			velocityY = -8;
			return;
		}
	}
	
	if place_meeting(x + velocityX, y + velocityY, obj_question_block) {
		velocityY = -8;
		return;
	}
	
	y += velocityY;
			
		if velocityY < terminalFallSpeed {
			velocityY++;
		}
}

wobble = function() {
	if velocityX = 0 {
		velocityX = walkSpeed * image_xscale;
	}
	
	sit_still();
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.collideable_terrain[i]) {
			instance_destroy();
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.breakable_terrain[i]) {
			instance_destroy();
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) {
		instance_destroy();
	}
	
	x += velocityX;
}

kill = function() {
	if place_meeting(x, y, obj_simple_enemy) {
		instance_place(x, y, obj_simple_enemy).kill_fall();
		
		instance_destroy();
	}
}