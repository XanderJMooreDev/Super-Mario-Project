if image_index == 3 {
    effect_create_layer("Effects", ef_smoke, x, y, 4, c_white);
    instance_destroy();
}

image_index++;

alarm[0] = 10;