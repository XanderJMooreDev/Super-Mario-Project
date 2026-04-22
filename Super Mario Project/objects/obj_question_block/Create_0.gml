hit = false;

if infinite {
    sprite_index = spr_infinite_question_block;
}
else {
    sprite_index = spr_question_block;
}

image_alpha = !invisible;

get_hit_below = function() {
	if !hit {
        if !infinite {
       		sprite_index = spr_empty_block;
            image_alpha = 1;
       		hit = true;
        }
		
		item = instance_create_layer(x + 16, y - 16, "Instances", obj_item);
		item.itemType = itemContained;
		item.poppingOut = "Up";
	}
}

get_hit_above = function() {
	if !hit {
		if !infinite {
       		sprite_index = spr_empty_block;
            image_alpha = 1;
       		hit = true;
        }
		
		item = instance_create_layer(x + 16, y - 16, "Instances", obj_item);
		item.itemType = itemContained;
		item.poppingOut = "Down";
	}
}