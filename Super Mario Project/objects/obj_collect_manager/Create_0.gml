global.coins = 0;
citizens_kingdom1 = [];
global.collecting = false;

global.citizens_saved = [ 0, 0, 0, 0, 0, 0, 0, 0 ];

save_citizen = function(saved_name) {
    obj_game_manager.playable = false;
    global.collecting = true;
    
    global.citizens_saved[global.current_kingdom]++;
    
    alarm[0] = 180;
    
    for (i = 0; i < instance_number(obj_npc); i++) {
        if instance_find(obj_npc, i).hidden_until_saved && 
        instance_find(obj_npc, i).npc_name == saved_name {
            instance_find(obj_npc, i).hidden_until_saved = false;
        }
        
    }
}