if !obj_game_manager.playable {
	return;
}


if poppingOut = "Up" {
    if itemType == "Coin" {
        if place_meeting(x, y, obj_question_block) || 
            place_meeting(x, y + 32, obj_question_block) {
    		y -= 4;
    	}
    	else {
    		if alarm[0] < 1 {
                alarm[0] = 45;
            }
    	}
    }
    else {
       	if place_meeting(x, y, obj_question_block) {
       		y -= 1;
       	}
       	else {
       		poppingOut = "No";
       	}
    }
}
else if poppingOut = "Down" {
	if itemType == "Coin" {
        if place_meeting(x, y, obj_question_block) || 
            place_meeting(x, y - 32, obj_question_block) {
    		y += 4;
    	}
    	else {
    		if alarm[0] < 1 {
                alarm[0] = 30;
            }
    	}
    }
    else {
       	if place_meeting(x, y, obj_question_block) {
       		y += 1;
       	}
       	else {
       		poppingOut = "No";
       	}
    }
}
else if array_contains(still_items, itemType) {
	sit_still();
}
else {
	wobble();
}

animate();