if place_meeting(x, y, obj_mario) {
    obj_game_manager.respawnX = x;
    obj_game_manager.respawnY = y;
}

if x == obj_game_manager.respawnX &&
    y == obj_game_manager.respawnY {
    image_index = 1;
}
else {
    image_index = 0;
}