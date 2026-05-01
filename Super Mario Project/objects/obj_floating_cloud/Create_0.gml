floatY = 0;

minY = -10;
maxY = 10;
mid = (maxY + minY) / 2;
range = (maxY - minY) / 2;

image_xscale = .7;
image_yscale = .7;

float_towards_location = function(fx, fy) {
    x += (fx - x) / 4;
    y += (fy - y) / 4;
}

adjust_float_y = function() {
    floatY = mid + sin(get_timer() / 1000000) * range;
}