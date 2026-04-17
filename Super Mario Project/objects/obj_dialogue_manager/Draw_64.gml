if dialogueOption >= 0 {
    draw_set_colour(c_white);
    draw_sprite_ext(spr_dialogue_box, 0, window_get_width() / 2, window_get_height() / 6,
    5, 5, 0, c_white, 1);
    draw_set_colour(c_black);
    draw_text_ext_transformed(window_get_width() / 6 + 10, window_get_height() / 6 - 70, dialogue[dialogueOption], 20, 420, 1.5, 1.5, 0);
}