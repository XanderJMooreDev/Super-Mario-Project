find_mate = function() {
    for (i = 0; i < instance_number(obj_warp_pipe); i++) {
        if instance_find(obj_warp_pipe, i).match_id == match_id &&
        instance_find(obj_warp_pipe, i).x != x {
            return instance_find(obj_warp_pipe, i);
        }
    }
}

switch open_dir {
    case "Up":
        image_angle = 0;
        break;
    case "Left":
        image_angle = 90;
        break;
    case "Down":
        image_angle = 180;
        break;
    case "Right":
        image_angle = 270;
        break;
    default:
        show_debug_message("Improper pipe facing direction");
        break;
}