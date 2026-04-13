if obj_game_manager.playable {
    for (i = 0; i < 3; i++) {
        chain[i].x = ctrX + (((chainChomp.x - ctrX) / 4) * (i + 1));
        chain[i].y = ctrY + (((chainChomp.y - ctrY) / 4) * (i + 1));
    }
}