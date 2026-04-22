saveable_array = [ "Toad1", "Toad2", "Toad3", "Toad4" ];

saveable_sprites = [ spr_npc_toad_red, spr_npc_toad_yellow, spr_npc_toad_red, spr_npc_toad_purple ];

sprite_index = saveable_sprites[array_get_index(saveable_array, saveable_name)];

talked_to = false;

dialogue_toad1 = [ "Thanks for saving me, Mario! Kamek somehow warped me up here and I couldn't get down!",
"Is he doing this to all of us? Toadsworth must be losing it!",
"I'd better get back there quick. We'll need all the help we can get, so please, help save more of us!" ];

dialogue_toad2 = [ "I was about to break those blocks, but Bowser Jr. stole my pickaxe!",
"If you had a Raccoon Leaf, you could break through it. But the block up there is guarded by a Chain Chomp. Too scary for me!",
"I'd better get back to rebuild the castle. Thank you, Mario!" ];

dialogue_toad3 = [ "Thank you Mario!",
"But our Princess is in another castle!",
"At least, I think. I got teleported here before I could figure out what was happening!",
"I'd better get back and see what's going on with the castle!" ];

dialogue_toad4 = [ "Yikes! I couldn't get out of these blocks!",
"This area is pretty neat, though. Far away from the pressures of the kingdom...",
"Well, it was nice while it lasted. Back to serving the monarchy." ];

saveable_interaction_dialogues = [ dialogue_toad1, dialogue_toad2, dialogue_toad3, dialogue_toad4 ];

save = function() {
    effect_create_layer("Effects", ef_smoke, x, y, 5, c_white);
    obj_collect_manager.save_citizen(saveable_name);
    instance_destroy();
}