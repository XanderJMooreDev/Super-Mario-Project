hit = false;

get_hit_below = function() {
	if !hit {
		sprite_index = spr_empty_block;
		hit = true;
		
		item = instance_create_layer(x + 16, y - 16, "Instances", obj_item);
		item.itemType = itemContained;
		item.poppingOut = "Up";
	}
}

get_hit_above = function() {
	if !hit {
		sprite_index = spr_empty_block;
		hit = true;
		
		item = instance_create_layer(x + 16, y - 16, "Instances", obj_item);
		item.itemType = itemContained;
		item.poppingOut = "Down";
	}
}