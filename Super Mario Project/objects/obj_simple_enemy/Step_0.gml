if obj_game_manager.playable && abs(image_yscale) == 1 {
	if dying {
		y += 3;
		x += 1;
		return;
	}
	
	walk();
}