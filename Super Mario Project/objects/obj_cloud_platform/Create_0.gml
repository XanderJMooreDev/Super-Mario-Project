check_ground_at = function(cx, cy) {
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(cx, cy, obj_mario.collideable_terrain[i]) {
			return true;
		}
	};
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(cx, cy, obj_mario.breakable_terrain[i]) {
			return true;
		}
	};
	
	if place_meeting(cx, cy, obj_question_block) {
        return true;
	}
	
	if place_meeting(cx, cy,obj_question_block) && gpAirStall < 0 {
		instance_place(x, y + velocityY, obj_question_block).get_hit_above();
	}
	
	if place_meeting(cx, cy, obj_question_block) {
		return true;
	}
	
	return false;
}

if check_ground_at(x, y) {
    instance_destroy();
}

image_xscale = .1;
image_yscale = .1;