npc_array = [ "Toadsworth", "Toad1", "Toad2", "Toad3", "Toad4", 
"Toad5", "Toad6", "Toad7", "Toad8", "Toad9", "Toad10" ];

npc_sprites = [ spr_npc_toadsworth, 
spr_npc_toad_red, spr_npc_toad_green, 
spr_npc_toad_red ,spr_npc_toad_purple, 
spr_npc_toad_yellow, spr_npc_toad_green,
spr_npc_toad_purple_raccoon, spr_npc_toad_blue, 
spr_npc_toad_red, spr_npc_toad_green_fire ];

sprite_index = npc_sprites[array_get_index(npc_array, npc_name)];

talked_to = false;

dialogue_toadsworth_1 = [ "Mario! Thank goodness you're here!", 
"That scoundrel Bowser Jr. has sent our Princess to his prison!", 
"No less, he's scattered our Toads all across the kingdom!",
"The castle can't survive long without our Toads to perform upkeep.",
"Please, before you set off to look for the Princess, could you find enough Toads to help me with the castle?" ];

dialogue_toadsworth_2 = [ "The castle can't survive long without our Toads to perform upkeep.",
"Please, before you set off to look for the Princess, could you find enough Toads to help me with the castle?",
"Toads are scattered all across the kingdom. Search in places that might be tricky to get to!",
"If you're struggling to reach someplace, try using some of the power-ups all across the kingdom!",
"They give you special abilities, and some will even help you reach new heights!" ];

dialogue_toad1 = [ "I oversee this cave. It used to be a storage area, but clearly, we have nothing left to store here.",
"Was it not enough to take our Princess?" ];

dialogue_toad2 = [ "The structural integrity of the castle is compromised. It's up to me to get it fixed up.",
"It'll be tough without my tools, but I'm pretty headstrong." ];

dialogue_toad3 = [ "No Princess here, that's for sure. Are you trying to save her?",
"I hope Bowser Jr. isn't too much of a problem, but hey, you're Mario!" ];

dialogue_toad4 = [ "Toadsworth is having us specialty-less Toads keep watch for invaders.",
"Not sure why when that Petey Piranha guy is already in our castle." ];

dialogue_toad5 = [ "The Princess ordered this wall to be put up. It was supposed to keep us safe from intruders.",
"Maybe we need to build a roof. Who needs sunlight and fresh air anyway?" ];

dialogue_toad6 = [ "We're all trying to keep up with the town. We rely on each other to eat, survive, everything.",
"Not much we can do but wait for the Princess to restore the order." ];

dialogue_toad7 = [ "My Raccoon Tail isn't awfully useful here.",
"It's a shame our town doesn't have gratuitous platforming all over the place.",
"At least I can use it to break some of the brick blocks scattered all over." ];

dialogue_toad8 = [ "Living with all my friends is the best life I could ask for! If only the Princess were still around, I'd have no worries!",
"I'm sure you'll bring her back quickly." ];

dialogue_toad9 = [ "Turns out moving to New Donk is gonna be a no-go for me.",
"The city is nice and all, but I disagree with Mayor Pauline's policies.",
"She thinks she can solve the city's problems with singing alone?",
"That city will be a run-down dystopia within the year, mark my words." ];

dialogue_toad10 = [ "Fire power is super helpful here! I can keep us safe from the Goombas and Koopa Troopas around here. I'm even trying to get over my fear of Rexes.",
"I need to be able to defend the people here. That's what Captain Toad would do if he were around." ];

npc_first_interaction_dialogues = [ dialogue_toadsworth_1, 
dialogue_toad1, dialogue_toad2, dialogue_toad3, 
dialogue_toad4, dialogue_toad5, dialogue_toad6,
dialogue_toad7, dialogue_toad8, dialogue_toad9,
dialogue_toad10 ];
npc_repeat_interaction_dialogues = [ dialogue_toadsworth_2, 
dialogue_toad1, dialogue_toad2, dialogue_toad3, 
dialogue_toad4, dialogue_toad5, dialogue_toad6,
dialogue_toad7, dialogue_toad8, dialogue_toad9,
dialogue_toad10 ];