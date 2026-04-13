chainChomp = noone;
ctrX = x + sprite_width / 2;
ctrY = y - sprite_height;

show_debug_message(ctrY);

create_chain_chomp = function() {
    chainChomp = instance_create_layer(x + 50, y - 50, "Instances", obj_chain_chomp);
    chain = [
        instance_create_layer(x, y, "Instances", obj_chain),
        instance_create_layer(x, y, "Instances", obj_chain),
        instance_create_layer(x, y, "Instances", obj_chain)
    ];
    chainChomp.stump = self;
}

create_chain_chomp();