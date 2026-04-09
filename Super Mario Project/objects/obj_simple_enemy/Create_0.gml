enemyType = "Goomba";
turnOnEdge = false;

walkSpeed = 2;
velocityX = 0;
velocityY = 0;
terminalFallSpeed = 7;

dying = false;

enemy_types = [ "Goomba" ];
enemy_walk_sprites = [ spr_goomba ];

assign_properties = function() {
	switch enemyType {
		case "Goomba":
			turnOnEdge = false;
		default:
			break;
	}
}

walk = function() {
	if turnOnEdge = false {
		wobble();
	}
}

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
	if velocityX = 0 {
		velocityX = walkSpeed;
	}
	
	sit_still();
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.collideable_terrain[i]) {
			velocityX *= -1;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.breakable_terrain[i]) {
			velocityX *= -1;
			return;
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) {
		velocityX *= -1;
		return;
	}
	
	x += velocityX;
}

kill_stomp = function() {
	dying = true;
	image_yscale = .5;
	y += 8;
	alarm[0] = 30;
}

kill_fall = function() {
	dying = true;
	image_yscale = -1;
	
	if y > obj_mario.y + 300 {
		instance_destroy();
	}
}