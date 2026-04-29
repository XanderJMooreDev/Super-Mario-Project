effect_create_layer("Effects", ef_smoke, x, y, 4, c_white);

cloud = instance_create_layer(global.player.x - (4 * global.player.facingDir), global.player.y - 10, "Instances", obj_floating_cloud);
obj_game_manager.enqueue_cloud(cloud);