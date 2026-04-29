check_ground_at = function(cx, cy) {
	for (i = 0; i < array_length(global.player.collideable_terrain); i++) {
		if place_meeting(cx, cy, global.player.collideable_terrain[i]) {
			return true;
		}
	};
	
	for (i = 0; i < array_length(global.player.breakable_terrain); i++) {
		if place_meeting(cx, cy, global.player.breakable_terrain[i]) {
			return true;
		}
	};
	
	if place_meeting(cx, cy, obj_question_block) {
        return true;
	}
	
	return false;
}

if check_ground_at(x, y) || ds_queue_empty(global.cloud_platforms) {
    instance_destroy();
}

obj_game_manager.dequeue_cloud();

image_xscale = .1;
image_yscale = .1;