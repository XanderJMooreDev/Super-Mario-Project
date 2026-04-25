draw_sprite_ext(spr_coin, 0, 20, 50, 1, 1, 0, c_white, 1);
for (i = 0; i < array_length(saved_sprites); i++) {
    draw_sprite_ext(saved_sprites[i], 0, 20 + 20 * (i % 10), 100 + 32 * floor(i / 10), .5, .5, 0, c_white, 1);
}
draw_set_colour(c_yellow);
draw_text_ext_transformed(50, 29, string_replace_all(string_format(global.coins, 4, 0), " ", 0), 0, 1000, 2, 2, 0);