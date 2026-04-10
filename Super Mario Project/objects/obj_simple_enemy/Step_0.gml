if obj_game_manager.playable && abs(image_yscale) == 1 {
	if dying {
		y += 5;
		x += 2;
		return;
	}
	
	walk();
}