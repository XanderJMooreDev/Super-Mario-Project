saveable_array = [ "Toad1", "Toad2", "Toad3", "Toad4", "Toad5", 
"Toad6", "Toad7", "Toad8", "Toad9", "Toad10", "Toad11" ];

saveable_sprites = [ spr_npc_toad_red, spr_npc_toad_yellow, 
spr_npc_toad_red, spr_npc_toad_purple, spr_npc_toad_yellow,
spr_npc_toad_green, spr_npc_toad_purple_raccoon,
spr_npc_toad_blue, spr_npc_toad_red, spr_npc_toad_green_fire,
spr_npc_toadette ];

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

dialogue_toad5 = [ "I need to get back home! My neighbors are having a party right now!",
"Oh, they all got teleported too?",
"The party's probably off then...",
"I'd better get home anyway. The turnips won't pluck themselves." ];

dialogue_toad6 = [ "It seems like all of us Toad Towners ended up in this area.",
"We wanted to have a party, but we can't do that without the Princess.",
"I guess Toadsworth said you had to save us before you could go after her, huh?",
"He's a smart guy, but he can't keep up with the castle anymore.",
"Anyway, I guess I should get home. Could you help save my neighbors? I'd appreciate it!" ];

dialogue_toad7 = [ "I assume you used a Super Bell to get here. The climbing ability is super cool, but I prefer gliding through the air.",
"If you want to glide, you can hit that block over there. It'll give you a Raccoon Leaf, which will let you have a cool tail like me.",
"Also, you can use it to defeat enemies."];

dialogue_toad8 = [ "This guy is my best friend! We've been friends since around the time the Princess came along.",
"He moved into Toad Town, so I had to follow him! What luck we got trapped here together, it felt like no time at all!",
"Well, time to get back to town! Thank you!"];

dialogue_toad9 = [ "That Toad is my neighbor. We were friends when we were young, but he started following me around.",
"It's some kind of cruel poetry that we get trapped in a box together, and he wouldn't stop talking.",
"Maybe I need to move to New Donk City. Do they accept Toads there?" ];

dialogue_toad10 = [ "I hope you don't mind I took that Fire Flower. I thought I'd use it took rescue myself, but there's some Rexes down there.",
"I'm terribly afraid of Rexes. They squish down like an accordian, it's so creepy.",
"So I think I'll just go back home instead." ];

dialogue_toadette = [ "Hi, Mario! This area seems particularly dense with enemies. Bowser Jr. really didn't hold back on flooding this place with his worst.",
"How is Toadsworth doing? I guess the castle needs some help, huh? I help with a lot of the maintenance, and this kingdom is looking a little worse for wear.",
"I hope to see you around the kingdom!" ];

saveable_interaction_dialogues = [ dialogue_toad1, 
dialogue_toad2, dialogue_toad3, dialogue_toad4, 
dialogue_toad5, dialogue_toad6, dialogue_toad7,
dialogue_toad8, dialogue_toad9, dialogue_toad10,
dialogue_toadette ];

save = function() {
    effect_create_layer("Effects", ef_smoke, x, y, 5, c_white);
    array_push(obj_ui_manager.saved_sprites, sprite_index);
    obj_collect_manager.save_citizen(saveable_name);
    instance_destroy();
}