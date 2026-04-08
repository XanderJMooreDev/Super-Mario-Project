if !obj_game_manager.playable {
	return;
}


if poppingOut = "Up" {
	if place_meeting(x, y, obj_question_block) {
		y -= 1;
	}
	else {
		poppingOut = "No";
	}
}
else if poppingOut = "Down" {
	if place_meeting(x, y, obj_question_block) {
		y += 1;
	}
	else {
		poppingOut = "No";
	}
}
else if array_contains(still_items, itemType) {
	sit_still();
}
else {
	wobble();
}

animate();