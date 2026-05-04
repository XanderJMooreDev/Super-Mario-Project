hp = 2;

damage = function() {
    show_debug_message(hp);
    hp--;
    effect_create_layer("Effects", ef_smoke, x + sprite_width / 2, y, 7, c_maroon);
    
    if hp <= 0 {
        instance_destroy();
    }
}