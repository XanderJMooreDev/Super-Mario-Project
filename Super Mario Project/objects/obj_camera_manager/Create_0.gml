camera = view_camera[0];

follow_object = function(object) {
    targetX = object.x - (camera_get_view_width(camera) / 2);
    targetY = object.y - (camera_get_view_height(camera) / 2);
    
    targetX = clamp(targetX, 0, room_width - camera_get_view_width(camera));
    targetY = clamp(targetY, 0, room_height - camera_get_view_height(camera));
    
    camX = lerp(camera_get_view_x(camera), targetX, 0.6);
    camY = lerp(camera_get_view_y(camera), targetY, 0.4);
    camera_set_view_pos(camera, camX, camY);
}