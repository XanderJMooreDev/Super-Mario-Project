npc_array = [ "Toadsworth" ];
npc_first_interaction_dialogues = [ dialogue_toadsworth ];

talked_to = false;

dialogue_toadsworth = [ "Mario! Thank goodness you're here!", 
"That scoundrel Bowser Jr. has sent our Princess to his prison!", 
"No less, he's scattered our Toads all across the kingdom!",
"The castle can't survive long without our Toads to perform upkeep.",
"Please, before you set off to look for the Princess, could you find enough Toads to help me with the castle?" ];

interact = function() {
    talked_to = true;
    
}