itemType = "Error";
velocityX = 0;
velocityY = 0;
terminalFallSpeed = 7;

still_items = [ "Fire Flower", "Boomerang Flower", "Cloud Flower", "Raccoon Leaf", "Super Bell" ];

poppingOut = "Up";

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
		velocityX = 3;
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

animate = function() {
	switch itemType {
		case "Super Mushroom":
			sprite_index = spr_power_super_mushroom;
			break;
		case "Fire Flower":
			sprite_index = spr_power_fire_flower;
			break;
		case "Boomerang Flower":
			sprite_index = spr_power_boomerang_flower;
			break;
		case "Cloud Flower":
			sprite_index = spr_power_cloud_flower;
			break;
		case "Raccoon Leaf":
			sprite_index = spr_power_raccoon_leaf;
			break;
		case "Super Bell":
			sprite_index = spr_power_super_bell;
			break;
		default:
			show_debug_message(itemType);
	}
}