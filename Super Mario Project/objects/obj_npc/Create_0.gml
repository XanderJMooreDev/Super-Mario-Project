npc_array = [ "Toadsworth", "Toad1", "Toad2", "Toad3", "Toad4" ];

npc_sprites = [ spr_npc_toadsworth, spr_npc_toad_red, spr_npc_toad_green, spr_npc_toad_red ,spr_npc_toad_purple ];

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

npc_first_interaction_dialogues = [ dialogue_toadsworth_1, dialogue_toad1, dialogue_toad2, dialogue_toad3, dialogue_toad4 ];
npc_repeat_interaction_dialogues = [ dialogue_toadsworth_2, dialogue_toad1, dialogue_toad2, dialogue_toad3, dialogue_toad4 ];