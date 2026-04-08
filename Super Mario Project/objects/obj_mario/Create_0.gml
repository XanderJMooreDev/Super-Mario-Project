velocityX = 0;
velocityY = 0;
facingDir = 1;

jumpStrength = 18;
spinStrength = 15;
walkSpeed = 8;

spinFrame = 9;

lastPower = "Small";
powerUp = "Small";
powerCooldown = 0;
powerTransition = 31;

crouching = false;

diveOverpowerJoyX = 0;
wallOverpowerJoyX = 0;
joystickX = 0;
terminalFallSpeed = 12;

gpAirStall = 0;
gpStrength = 14;

hasAerialSpun = false;

collideable_terrain = [ obj_simple_terrain ];
breakable_terrain = [ obj_breakable_block ];
power_ups = [ "Small", "Super" ];
stand_sprites = [ spr_mario_stand_small, spr_mario_stand_super ];
walk_sprites = [ spr_mario_walk_small, spr_mario_walk_super ];
jump_sprites = [ spr_mario_jump_small, spr_mario_jump_super ];
gp_sprites = [ spr_mario_gp_small, spr_mario_gp_super ];
spin_sprites = [ spr_mario_spin_small, spr_mario_spin_super ];
crouch_sprites = [ spr_mario_crouch_small, spr_mario_crouch_super ];

check_controls = function () {
	jumpControl = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	gpControl = keyboard_check_pressed(ord("S"));
	crouchControl = keyboard_check(ord("S"));
	leftControl = keyboard_check(ord("A"));
	rightControl = keyboard_check(ord("D"));
	powerControl = keyboard_check(ord("E"));
	joystickX = rightControl - leftControl;
}

apply_walk = function() {
	if gpAirStall > 0 {
		return;
	}
	crouching = false;
	
	if crouchControl && check_ground_at(x, y + 3) &&
	diveOverpowerJoyX == 0 && wallOverpowerJoyX == 0 {
		crouching = true;
		velocityX = 0;
		return;
	}
	
	if diveOverpowerJoyX != 0 {
		if (velocityX < 2 * walkSpeed && diveOverpowerJoyX > 0 ||
			velocityX > 2 * -walkSpeed && diveOverpowerJoyX < 0) {
			velocityX += 2 * diveOverpowerJoyX / abs(diveOverpowerJoyX);
			
			facingDir = diveOverpowerJoyX / abs(diveOverpowerJoyX);
		}
		
		if diveOverpowerJoyX > 0 {
			diveOverpowerJoyX--;
		}
		else {
			diveOverpowerJoyX++;
		}
	}
	else if wallOverpowerJoyX != 0 {
		if (velocityX < walkSpeed && wallOverpowerJoyX > 0 ||
			velocityX > -walkSpeed && wallOverpowerJoyX < 0) {
			velocityX += wallOverpowerJoyX / abs(wallOverpowerJoyX);
			
			facingDir = wallOverpowerJoyX / abs(wallOverpowerJoyX);
		}
		
		if wallOverpowerJoyX > 0 {
			wallOverpowerJoyX--;
		}
		else {
			wallOverpowerJoyX++;
		}
	}
	else if joystickX != 0 {
		facingDir = joystickX;
		
		if (velocityX < walkSpeed && joystickX > 0 ||
			velocityX > -walkSpeed && joystickX < 0) {
			velocityX += joystickX;
		}
	}
	else if velocityX > 0 {
		velocityX--;
	}
	else if velocityX < 0 {
		velocityX++;
	}
	
	if !check_ground_at(x + velocityX, y) {
		x += velocityX;
	}
	else {
		velocityX = 0;
		wallOverpowerJoyX = 0;
	}
}

apply_gravity = function() {
	if gpControl && !check_ground_at(x, y + 3) && gpAirStall == 0 {
		gpAirStall = 10;
		return;
	}
	else if jumpControl {
		gpAirStall = 0;
	}
	else if gpAirStall > 0 {
		gpAirStall--;
		
		if image_xscale > 0 {
			image_angle -= 36;
		}
		else {
			image_angle += 36;
		}
		
		if gpAirStall = 0 {
			gpAirStall--;
		}
		
		return;
	}
	else if gpAirStall < 0 {
		velocityY = gpStrength;
		
		if check_ground_at(x, y + velocityY) {
			gpAirStall = 0;
			
			effect_create_layer("Effects", ef_smoke, x, y, 4, c_grey);
		}
	}
	
	if jumpControl && check_ground_at(x, y + 6) {
		if crouchControl {
			velocityY = -jumpStrength / 3 * 2;
			diveOverpowerJoyX = facingDir * 30;
		}
		else {
			velocityY = -jumpStrength;
		}
	}
	else if check_ground_at(x + joystickX * 8, y) && !check_ground_at(x, y + 8) {
		effect_create_layer("Effects", ef_smoke, x, y, 4, c_grey);
		velocityY = -jumpStrength;
		wallOverpowerJoyX = -joystickX * 14;
	}
	else if jumpControl && !hasAerialSpun && wallOverpowerJoyX == 0 {
		if crouchControl {
			diveOverpowerJoyX = facingDir * 30;
		}
		else {	
			spinFrame = 0;
			velocityY = -spinStrength;
			hasAerialSpun = true;
		
			create_star_effect();
		}
	}
	else if check_ground_at(x, y + velocityY) && velocityY > 1 {
		velocityY = 0;
		
		hasAerialSpun = false;
	}
	else if check_ground_at(x, y + velocityY) && velocityY < 0 {
		velocityY = 0;
	}
	else if !check_ground_at(x, y + velocityY) {
		y += velocityY;
		
		if velocityY < terminalFallSpeed {		
			velocityY++;
		}
	}
	
	image_angle = 0;
}

check_ground_at = function(cx, cy) {
	for (i = 0; i < array_length(collideable_terrain); i++) {
		if place_meeting(cx, cy, collideable_terrain[i]) {
			return true;
		}
	};
	
	for (i = 0; i < array_length(breakable_terrain); i++) {
		if place_meeting(cx, cy, breakable_terrain[i]) {
			if place_meeting(cx, cy, breakable_terrain[i]) && gpAirStall < 0 && powerUp != "Small" {
				instance_destroy(instance_place(cx, cy, breakable_terrain[i]));
				
				return false;
			}
			
			if place_meeting(x, y + velocityY, breakable_terrain[i]) && velocityY < 0 && powerUp != "Small" {
				instance_destroy(instance_place(x, y + velocityY, breakable_terrain[i]));
				
				velocityY = 0;
			}
			
			return true;
		}
	};
	
	if place_meeting(x, y + velocityY, obj_question_block) && velocityY < 0 {
		instance_place(x, y + velocityY, obj_question_block).get_hit_below();
				
		velocityY = 0;
	}
	
	if place_meeting(cx, cy,obj_question_block) && gpAirStall < 0 {
		instance_place(x, y + velocityY, obj_question_block).get_hit_above();
	}
	
	if place_meeting(cx, cy, obj_question_block) {
		return true;
	}
	
	return false;
}

create_star_effect = function() {
		effect_create_layer("Effects", ef_star, x, y - 30, 5, c_red);
		effect_create_layer("Effects", ef_star, x, y, 5, c_yellow);
		effect_create_layer("Effects", ef_star, x - 30, y - 15, 5, c_blue);
		effect_create_layer("Effects", ef_star, x + 30, y - 15, 5, c_white);
		effect_create_layer("Effects", ef_star, x - 30, y + 30, 5, c_white);
		effect_create_layer("Effects", ef_star, x + 30, y + 30, 5, c_blue);
}

use_power = function() {
	if powerCooldown > 0 {
		powerCooldown--;
		return;
	}
	
	switch powerUp {
	case "Fire":
		powerCooldown = 12;
	default:
		break;
	}
}

pick_up_power_up = function() {
	if place_meeting(x, y, obj_item) {
		lastPower = powerUp;
		
		switch obj_item.itemType {
		case "Super Mushroom":
			if powerUp == "Small" {
				powerUp = "Super";
			}
			
			break;
		default:
			break;
		}
		
		if powerUp != lastPower {
			powerTransition = 0;
		}
		
		instance_destroy(instance_place(x, y, obj_item));
	}
}

animate = function() {
	image_xscale = facingDir * 2;
	image_yscale = 2;
	
	if spinFrame < 4 {
		sprite_index = spin_sprites[array_get_index(power_ups, powerUp)];
		image_index = floor(spinFrame);
		spinFrame += .3;
	}
	else if crouching {
		sprite_index = crouch_sprites[array_get_index(power_ups, powerUp)];
	}
	else if gpAirStall != 0 || diveOverpowerJoyX != 0 {
		sprite_index = gp_sprites[array_get_index(power_ups, powerUp)];
	}
	else if !check_ground_at(x, y + 8) {
		sprite_index = jump_sprites[array_get_index(power_ups, powerUp)];
	}
	else if abs(velocityX) > 0 {
		sprite_index = walk_sprites[array_get_index(power_ups, powerUp)];
	}
	else {
		sprite_index = stand_sprites[array_get_index(power_ups, powerUp)];
	}
	
	if powerUp == "Small" {
		mask_index = spr_hitbox_small;
	}
	else {
		mask_index = spr_hitbox_super;
	}
}

transition_power = function(pre, post) {
	if powerTransition = 0 {
		obj_game_manager.playable = false;
	}
	else if powerTransition = 60 {
		obj_game_manager.playable = true;
		lastPower = post;
	}
	else if powerTransition < 60 {
		if powerTransition % 2 == 1 {
			powerUp = pre;
			lastPower = post;
		}
		else {
			powerUp = post;
		}
	}
	
	powerTransition++;
}