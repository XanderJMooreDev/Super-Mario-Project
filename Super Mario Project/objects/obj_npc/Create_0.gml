npc_array = [ "Toadsworth", "Toad1" ];

npc_sprites = [ spr_npc_toadsworth, spr_npc_toad_red ];

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

npc_first_interaction_dialogues = [ dialogue_toadsworth_1, dialogue_toad1 ];
npc_repeat_interaction_dialogues = [ dialogue_toadsworth_2, dialogue_toad1 ];