sprites = [ spr_boomerang, spr_boomerang, spr_boomerang,
spr_boomerang, spr_boomerang, spr_hatchet ];

startY = y;

minY = -20;
maxY = 20;
mid = (maxY + minY) / 2;
range = (maxY - minY) / 2;

sprite_index = sprites[item_id];

adjust_float_y = function() {
    floatY = mid + sin(get_timer() / 1000000) * range;
}