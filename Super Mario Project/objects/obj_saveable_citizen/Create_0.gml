saveable_array = [ "Toad1" ];

saveable_sprites = [ spr_npc_toad_red ];

sprite_index = saveable_sprites[array_get_index(saveable_array, saveable_name)];

talked_to = false;

dialogue_toad1 = [ "Thanks for saving me, Mario! Kamek somehow warped me up here and I couldn't get down!",
"Is he doing this to all of us? Toadsworth must be losing it!",
"I'd better get back there quick. We'll need all the help we can get, so please, help save more of us!" ];

saveable_interaction_dialogues = [ dialogue_toad1 ];

save = function() {
    effect_create_layer("Effects", ef_smoke, x, y, 5, c_white);
    obj_collect_manager.save_citizen(saveable_name);
    instance_destroy();
}