velocityX = 0;
velocityY = 0;
walkSpeed = 6;

image_xscale = 1.5;
image_yscale = 1.5;

terminalFallSpeed = 4;

sit_still = function() {
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.collideable_terrain[i]) {
			velocityY = 0;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.breakable_terrain[i]) {
			velocityY = 0;
			return;
		}
	}
	
	if place_meeting(x + velocityX, y + velocityY, obj_question_block) {
		velocityY = 0;
		return;
	}
	
	y += velocityY;
    
    if velocityY < terminalFallSpeed {
        velocityY++;
    }
}

wobble = function() {
    sit_still();
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.collideable_terrain[i]) {
			velocityX *= -1;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.breakable_terrain[i]) {
			velocityX *= -1;
            instance_destroy(instance_place(x + velocityX, y, obj_mario.breakable_terrain[i]));
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) {
		velocityX *= -1;
        instance_place(x + velocityX, y, obj_question_block).get_hit_below();
	}
	
	x += velocityX;
}

throw_item = function() {
    y -= 32;
    velocityX = obj_mario.facingDir * 8;
}

gentle_set = function() {
    x += 32 * obj_mario.facingDir;
}