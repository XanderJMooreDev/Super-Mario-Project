velocityX = 0;
velocityY = 0;
facingDir = 1;

jumpStrength = 18;
spinStrength = 15;
walkSpeed = 8;
climbSpeed = 6;

spinFrame = 9;
attackFrame = 9;

alive = true;
deathHop = 300;

lastPower = "Small";
powerUp = "Small";
powerCooldown = 0;
powerTransition = 31;

iFrames = 0;

crouching = false;
climbing = false;
warping = 0;

pipeDirection = "Up";

dove = false;

diveOverpowerJoyX = 0;
wallOverpowerJoyX = 0;
joystickX = 0;
terminalFallSpeed = 12;

gpAirStall = 0;
gpStrength = 14;

hasAerialSpun = false;

collideable_terrain = [ obj_chain_chomp_stump, 
layer_tilemap_get_id("Tiles_Grass"),
layer_tilemap_get_id("Tiles_Cave"),
layer_tilemap_get_id("Tiles_Castle"),
layer_tilemap_get_id("Tiles_SMB1"), 
obj_cloud_platform, obj_warp_pipe ];

breakable_terrain = [ obj_breakable_block ];

death_zones = [ obj_death_zone ];

power_ups = [ "Small", "Super", "Fire", "Boomerang", "Cloud", "Raccoon", "Cat" ];
stand_sprites = [ spr_mario_stand_small, spr_mario_stand_super, spr_mario_stand_fire, spr_mario_stand_boomerang, spr_mario_stand_cloud, spr_mario_stand_raccoon, spr_mario_stand_cat];
walk_sprites = [ spr_mario_walk_small, spr_mario_walk_super, spr_mario_walk_fire, spr_mario_walk_boomerang, spr_mario_walk_cloud, spr_mario_walk_raccoon, spr_mario_walk_cat ];
wall_sprites = [ spr_mario_wall_small, spr_mario_wall_super, spr_mario_wall_fire, spr_mario_wall_boomerang, spr_mario_wall_cloud, spr_mario_wall_raccoon, spr_mario_wall_cat ];
jump_sprites = [ spr_mario_jump_small, spr_mario_jump_super, spr_mario_jump_fire, spr_mario_jump_boomerang, spr_mario_jump_cloud, spr_mario_jump_raccoon, spr_mario_jump_cat ];
gp_sprites = [ spr_mario_gp_small, spr_mario_gp_super, spr_mario_gp_fire, spr_mario_gp_boomerang, spr_mario_gp_cloud, spr_mario_gp_raccoon, spr_mario_gp_cat ];
spin_sprites = [ spr_mario_spin_small, spr_mario_spin_super, spr_mario_spin_fire, spr_mario_spin_boomerang, spr_mario_spin_cloud, spr_mario_spin_raccoon, spr_mario_spin_cat ];
crouch_sprites = [ spr_mario_crouch_small, spr_mario_crouch_super, spr_mario_crouch_fire, spr_mario_crouch_boomerang, spr_mario_crouch_cloud, spr_mario_crouch_raccoon, spr_mario_crouch_cat ];
power_sprites = [ spr_mario_crouch_small, spr_mario_crouch_super, spr_mario_power_fire, spr_mario_power_boomerang, spr_mario_crouch_cloud, spr_mario_power_raccoon, spr_mario_power_cat ];

check_controls = function () {
	jumpControl = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
	jumpHoldControl = keyboard_check(vk_space) || keyboard_check(ord("W"));
	gpControl = keyboard_check_pressed(ord("S"));
	crouchControl = keyboard_check(ord("S"));
	leftControl = keyboard_check(ord("A"));
	rightControl = keyboard_check(ord("D"));
	powerControl = keyboard_check(ord("E"));
	joystickX = rightControl - leftControl;
}

apply_walk = function() {
	if gpAirStall > 0 {
		return;
	}
	crouching = false;
	
	if crouchControl && check_ground_at(x, y + 3) &&
	diveOverpowerJoyX == 0 && wallOverpowerJoyX == 0 {
		crouching = true;
		velocityX = 0;
		return;
	}
	
	if diveOverpowerJoyX != 0 {
		if (velocityX < 2 * walkSpeed && diveOverpowerJoyX > 0 ||
			velocityX > 2 * -walkSpeed && diveOverpowerJoyX < 0) {
			velocityX += 2 * diveOverpowerJoyX / abs(diveOverpowerJoyX);
			
			facingDir = diveOverpowerJoyX / abs(diveOverpowerJoyX);
		}
		
		if diveOverpowerJoyX > 0 {
			diveOverpowerJoyX--;
		}
		else {
			diveOverpowerJoyX++;
		}
	}
	else if wallOverpowerJoyX != 0 {
		if (velocityX < walkSpeed && wallOverpowerJoyX > 0 ||
			velocityX > -walkSpeed && wallOverpowerJoyX < 0) {
			velocityX += wallOverpowerJoyX / abs(wallOverpowerJoyX);
			
			facingDir = wallOverpowerJoyX / abs(wallOverpowerJoyX);
		}
		
		if wallOverpowerJoyX > 0 {
			wallOverpowerJoyX--;
		}
		else {
			wallOverpowerJoyX++;
		}
	}
	else if joystickX != 0 {
		facingDir = joystickX;
		
		if (velocityX < walkSpeed && joystickX > 0 ||
			velocityX > -walkSpeed && joystickX < 0) {
			velocityX += joystickX;
		}
	}
	else if velocityX > 0 {
		velocityX--;
	}
	else if velocityX < 0 {
		velocityX++;
	}
	
	if !check_ground_at(x + velocityX, y) {
		x += velocityX;
	}
	else {
        if powerUp == "Cat" && !check_ground_at(x, y + 8) && (leftControl || rightControl) {
            climbing = true;
        }
        
		velocityX = 0;
		wallOverpowerJoyX = 0;
	}
}

apply_climb = function() {
    if check_ground_at(x, y + 8) || !check_ground_at(x + 8 * facingDir, y) || powerControl {
        climbing = false;
        return;
    }
    else {
        climbControl = crouchControl - jumpHoldControl;
        
        if !check_ground_at(x, y + climbSpeed * climbControl) {
            y += climbControl * climbSpeed;
        }
    }
}

apply_gravity = function() {
	if gpControl && !check_ground_at(x, y + 3) && gpAirStall == 0 {
		gpAirStall = 10;
		return;
	}
	else if jumpControl {
		gpAirStall = 0;
	}
	else if gpAirStall > 0 {
		gpAirStall--;
		
		if image_xscale > 0 {
			image_angle -= 36;
		}
		else {
			image_angle += 36;
		}
		
		if gpAirStall = 0 {
			gpAirStall--;
		}
		
		return;
	}
	else if gpAirStall < 0 {
		velocityY = gpStrength;
		
		if check_ground_at(x, y + velocityY) {
			gpAirStall = 0;
			
			effect_create_layer("Effects", ef_smoke, x, y, 4, c_grey);
		}
	}
	
	if jumpControl {
		if check_ground_at(x, y + 6) {
			if crouchControl {
				velocityY = -jumpStrength / 3 * 2;
				diveOverpowerJoyX = facingDir * 30;
				
				return;
			}
			else {
				velocityY = -jumpStrength;
				return;
			}
		}
		else {
			if crouchControl && !dove {
				dove = true;
				velocityY = -jumpStrength / 3 * 2;
				diveOverpowerJoyX = facingDir * 30;
			}
		}
	}
	
	if check_ground_at(x + joystickX * 8, y) && !check_ground_at(x, y + 8) {
		if jumpControl || abs(wallOverpowerJoyX) > 10 {
			effect_create_layer("Effects", ef_smoke, x, y, 4, c_grey);
			velocityY = -jumpStrength;
			wallOverpowerJoyX = -joystickX * 14;
		}
		else if velocityY > 0 {
			velocityY = 3;
			
			if !check_ground_at(x, y + velocityY) {
				y += velocityY;
			}
		}
	}
	
	if jumpControl && !hasAerialSpun && wallOverpowerJoyX == 0 {
		if !crouchControl {	
			spinFrame = 0;
			velocityY = -spinStrength;
			hasAerialSpun = true;
			
			if powerUp == "Fire" {
				fireball = instance_create_layer(x, y, "Instances", obj_player_fireball);
				fireball.image_xscale = facingDir;
			
				fireball = instance_create_layer(x, y, "Instances", obj_player_fireball);
				fireball.image_xscale = -facingDir;
			}
            else if powerUp == "Cloud" && obj_game_manager.cloud_platforms > 0 {
                instance_create_layer(x, y + 52, "Instances", obj_cloud_platform);
                
                for (i = 0; i < obj_game_manager.cloud_platforms; i++) {
                    
                }
            }
		
			create_star_effect();
		}
	}
	else if check_ground_at(x, y + velocityY) && velocityY > 1 {
        
        if !place_meeting(x, y + velocityY, obj_cloud_platform) {
            obj_game_manager.cloud_platforms = 2; 
            instance_destroy(obj_cloud_platform);
        }
        
		velocityY = 0;
		
		hasAerialSpun = false;
		dove = false;
	}
	else if check_ground_at(x, y + velocityY) && velocityY < 0 {
		velocityY = 0;
	}
	else if !check_ground_at(x, y + velocityY) {
		y += velocityY;
		
		if velocityY < terminalFallSpeed {		
			velocityY++;
		}
	}
	
	image_angle = 0;
}

check_ground_at = function(cx, cy) { 
    for (i = 0; i < array_length(death_zones); i++) {
		if place_meeting(cx, cy, death_zones[i]) {
            die();
            
            y += 600;
        }
	};
    
	for (i = 0; i < array_length(collideable_terrain); i++) {
		if place_meeting(cx, cy, collideable_terrain[i]) {
            if place_meeting(cx, cy, obj_cloud_platform) && gpAirStall < 0 {
                instance_destroy(instance_place(cx, cy, obj_cloud_platform));
                
                obj_game_manager.cloud_platforms++;
            }
            else if place_meeting(cx, cy, obj_warp_pipe) { 
                pipe = instance_place(cx, cy, obj_warp_pipe);
                
                if pipe.match_id == -1 {
                    return true;
                }
                
                pipeDirection = pipe.open_dir;
                
                if pipe.open_dir == "Up" && place_meeting(x, y + 8, pipe) && crouchControl && abs(pipe.x - x) < 16 {
                    x = pipe.x;
                    obj_game_manager.playable = false;
                    warping = 1;
                    velocityX = 0;
                    velocityY = 0;
                }
                else if pipe.open_dir == "Down" && place_meeting(x, y - 8, pipe) && jumpHoldControl && abs(pipe.x - x) < 16 {
                    x = pipe.x;
                    obj_game_manager.playable = false;
                    warping = 1;
                    velocityX = 0;
                    velocityY = 0;
                }
                else if pipe.open_dir == "Right" && place_meeting(x - 8, y, pipe) && leftControl && y <= pipe.y + 8 {
                    y = pipe.y - 8;
                    obj_game_manager.playable = false;
                    warping = 1;
                    velocityX = 0;
                    velocityY = 0;
                }
                else if pipe.open_dir == "Left" && place_meeting(x + 8, y, pipe) && rightControl && y <= pipe.y + 8 {
                    y = pipe.y - 8;
                    obj_game_manager.playable = false;
                    warping = 1;
                    velocityX = 0;
                    velocityY = 0;
                }
            }
            
			return true;
		}
	};
	
	for (i = 0; i < array_length(breakable_terrain); i++) {
		if place_meeting(cx, cy, breakable_terrain[i]) {
			if place_meeting(cx, cy, breakable_terrain[i]) && gpAirStall < 0 && powerUp != "Small" {
				instance_destroy(instance_place(cx, cy, breakable_terrain[i]));
				
				return false;
			}
			
			if place_meeting(x, y + velocityY, breakable_terrain[i]) && velocityY < 0 && powerUp != "Small" {
				instance_destroy(instance_place(x, y + velocityY, breakable_terrain[i]));
				
				velocityY = 0;
			}
			
			return true;
		}
	};
	
	if place_meeting(x, y + velocityY, obj_question_block) && velocityY < 0 {
		instance_place(x, y + velocityY, obj_question_block).get_hit_below();
				
		velocityY = 0;
	}
	
	if place_meeting(x, y + velocityY, obj_question_block) && gpAirStall < 0 {
		instance_place(x, y + velocityY, obj_question_block).get_hit_above();
	}
	
	if place_meeting(cx, cy, obj_question_block) {
		return true;
	}
	
	if place_meeting(x, y, obj_player_boomerang) {
		if instance_place(x, y, obj_player_boomerang).velocityX /
		instance_place(x, y, obj_player_boomerang).startDir < 0 {
			instance_destroy(instance_place(x, y, obj_player_boomerang));
			
			if check_ground_at(x, y + 8) {
				return;
			}
			
			velocityY = -jumpStrength;
			velocityX = 3 * facingDir;
		}
	}
    
    if place_meeting(x, y + 8, obj_shell) &&
	!place_meeting(x, y, obj_shell) {
		if instance_place(x, y + 8, obj_shell).velocityX == 0 {
            instance_place(x, y + 8, obj_shell).velocityX = facingDir * 10;
        }
        else {
            instance_place(x, y + 8, obj_shell).velocityX = 0;
        }
            
		if jumpHoldControl {
			velocityY = -jumpStrength;
		}
		else {
			velocityY = -jumpStrength / 2;
		}
	}
    else if place_meeting(x, y, obj_shell) {
        if obj_shell.velocityX = 0 { 
            instance_place(x, y + 8, obj_shell).velocityX = facingDir * 8;
            instance_place(x, y + 8, obj_shell).x += facingDir * 8;
        }
        else if iFrames = 0 {
		  take_damage();
        }
    }
    
    if place_meeting(x, y, obj_chain_chomp) && !instance_place(x, y, obj_chain_chomp).dying {
        take_damage();
        return;
    }
	
	if place_meeting(x, y + 8, obj_simple_enemy) &&
	!place_meeting(x, y, obj_simple_enemy) && 
	instance_place(x, y + 8, obj_simple_enemy).dying == false {
        if instance_place(x, y + 8, obj_simple_enemy).spiky {
            if diveOverpowerJoyX != 0 && powerUp == "Cat" {
                instance_place(x, y + 8, obj_simple_enemy).kill_fall();
                return;
            }
            
            take_damage();
            return;
        }
        else {
		  instance_place(x, y + 8, obj_simple_enemy).kill_stomp();
        }
            
		if jumpHoldControl {
			velocityY = -jumpStrength;
		}
		else {
			velocityY = -jumpStrength / 2;
		}
	}
	else if place_meeting(x, y, obj_simple_enemy) && 
	instance_place(x, y, obj_simple_enemy).dying == false
	&& iFrames = 0 {
        if diveOverpowerJoyX != 0 && powerUp == "Cat" {
            instance_place(x, y, obj_simple_enemy).kill_fall();
        }
        else {
            take_damage();
        }
	}
	
	return false;
}

take_damage = function() {
    if iFrames > 0 {
        return;
    }
    
    lastPower = powerUp;
    
    if powerUp == "Small" {
            powerTransition = 31;
			die();
		}
		else if powerUp = "Super" {
			powerUp = "Small";
			iFrames = 60;
		}
		else if powerUp == "Cloud" {
			powerUp = "Super";
			iFrames = 60;
            
            obj_game_manager.dequeue_cloud();
            obj_game_manager.dequeue_cloud();
		}
		else {
			powerUp = "Super";
			iFrames = 60;
		}
}

create_star_effect = function() {
		effect_create_layer("Effects", ef_star, x, y - 30, 5, c_red);
		effect_create_layer("Effects", ef_star, x, y, 5, c_yellow);
		effect_create_layer("Effects", ef_star, x - 30, y - 15, 5, c_blue);
		effect_create_layer("Effects", ef_star, x + 30, y - 15, 5, c_white);
		effect_create_layer("Effects", ef_star, x - 30, y + 30, 5, c_white);
		effect_create_layer("Effects", ef_star, x + 30, y + 30, 5, c_blue);
}

use_power = function() {
    if attackFrame < 4 {
        if powerUp == "Raccoon" {
            raccoon_attack();
        }
    }
    if attackFrame < 4 {
        if powerUp == "Cat" {
            cat_attack();
        }
    }
    
	if powerCooldown > 0 || !powerControl {
		powerCooldown--;
		return;
	}
	
	switch powerUp {
	case "Fire":
		powerCooldown = 30;
		fireball = instance_create_layer(x, y, "Instances", obj_player_fireball);
		fireball.image_xscale = facingDir;
		break;
	case "Boomerang":
		if !instance_exists(obj_player_boomerang) {
			powerCooldown = 30;
			boomerang = instance_create_layer(x, y, "Instances", obj_player_boomerang);
			boomerang.startDir = facingDir;
			boomerang.throw_start();
		}
		break;
    case "Raccoon":
        powerCooldown = 30;
        attackFrame = 0;
    case "Cat":
        powerCooldown = 30;
        attackFrame = 0;
	default:
		break;
	}
}

pick_up_power_up = function() {
	if place_meeting(x, y, obj_item) {
		lastPower = powerUp;
        
        if powerUp == "Cloud" && instance_place(x, y, obj_item).itemType != "Super Mushroom" {
            obj_game_manager.dequeue_cloud();
            obj_game_manager.dequeue_cloud();
            
            instance_destroy(obj_cloud_platform);
            instance_destroy(obj_cloud_platform);
        }
		
		switch instance_place(x, y, obj_item).itemType {
		case "Super Mushroom":
			if powerUp == "Small" {
				powerUp = "Super";
			}
			
			break;
		case "Fire Flower":
			powerUp = "Fire";
			break;
		case "Boomerang Flower":
			powerUp = "Boomerang";
			break;
		case "Cloud Flower":
            if powerUp != "Cloud" {
                cloud = instance_create_layer(x + 4, y - 10, "Instances", obj_floating_cloud);
                obj_game_manager.enqueue_cloud(cloud);
                cloud = instance_create_layer(x - 4, y - 10, "Instances", obj_floating_cloud);
                obj_game_manager.enqueue_cloud(cloud);
            }
            
			powerUp = "Cloud";
            
			break;
		case "Raccoon Leaf":
			powerUp = "Raccoon";
			break;
		case "Super Bell":
			powerUp = "Cat";
			break;
		default:
			break;
		}
		
		if powerUp != lastPower {
			powerTransition = 0;
		}
		
		instance_destroy(instance_place(x, y, obj_item));
	}
}

raccoon_attack = function() {
    raccoon_range = 16;
    for (i = 0; i < array_length(breakable_terrain); i++) {
		if place_meeting(x - raccoon_range, y, breakable_terrain[i]) {
			instance_destroy(instance_place(x - raccoon_range, y, breakable_terrain[i]));
		}
        
		if place_meeting(x + raccoon_range, y, breakable_terrain[i]) {
			instance_destroy(instance_place(x + raccoon_range, y, breakable_terrain[i]));
		}
	};
    
    if place_meeting(x - raccoon_range, y, obj_simple_enemy) {
        instance_place(x - raccoon_range, y, obj_simple_enemy).kill_fall();
    }
    
    if place_meeting(x + raccoon_range, y, obj_simple_enemy) {
        instance_place(x + raccoon_range, y, obj_simple_enemy).kill_fall();
    }
    
    if place_meeting(x - raccoon_range, y, obj_question_block) {
		instance_place(x - raccoon_range, y, obj_question_block).get_hit_below();
	}
    
    if place_meeting(x + raccoon_range, y, obj_question_block) {
		instance_place(x + raccoon_range, y, obj_question_block).get_hit_below();
	}
}

cat_attack = function() {
    cat_range = 16;
    for (i = 0; i < array_length(breakable_terrain); i++) {
		if place_meeting(x + cat_range * facingDir, y, breakable_terrain[i]) {
			instance_destroy(instance_place(x + cat_range * facingDir, y, breakable_terrain[i]));
		}
	};
    
    if place_meeting(x + cat_range * facingDir, y, obj_simple_enemy) {
        instance_place(x + cat_range * facingDir, y, obj_simple_enemy).kill_fall();
    }
    
    if place_meeting(x + cat_range * facingDir, y, obj_question_block) {
		instance_place(x + cat_range * facingDir, y, obj_question_block).get_hit_below();
	}
}

animate = function() {
	image_xscale = facingDir * 2;
	image_yscale = 2;
	
    if !alive {
        sprite_index = spr_mario_die;
    }
    else if warping {
		sprite_index = stand_sprites[array_get_index(power_ups, powerUp)];
	}
    else if !obj_game_manager.playable && global.collecting {
        if obj_collect_manager.alarm[0] > 80 {
            sprite_index = spin_sprites[array_get_index(power_ups, powerUp)];
            image_index = (obj_collect_manager.alarm[0] - 80) / 6;
        }
        else { 
            sprite_index = jump_sprites[array_get_index(power_ups, powerUp)];
        }
    }
	else if attackFrame < 4 {
		sprite_index = power_sprites[array_get_index(power_ups, powerUp)];
		image_index = floor(attackFrame);
		attackFrame += .2;
	}
    else if climbing {
        if jumpHoldControl || crouchControl {
            sprite_index = spr_mario_climb_cat;
        }
        else {
            sprite_index = spr_mario_stand_wall_cat;
        }
    }
	else if powerCooldown > 25 {
		sprite_index = power_sprites[array_get_index(power_ups, powerUp)];
	}
	else if spinFrame < 4 {
		sprite_index = spin_sprites[array_get_index(power_ups, powerUp)];
		image_index = floor(spinFrame);
		spinFrame += .3;
	}
	else if check_ground_at(x + joystickX * 8, y) && !check_ground_at(x, y + 8) &&
		!(jumpControl || abs(wallOverpowerJoyX) > 10) && velocityY > 0 {
			sprite_index = wall_sprites[array_get_index(power_ups, powerUp)];
	}
	else if crouching {
		sprite_index = crouch_sprites[array_get_index(power_ups, powerUp)];
	}
	else if gpAirStall != 0 || diveOverpowerJoyX != 0 {
        if diveOverpowerJoyX != 0 && powerUp == "Cat" {
            sprite_index = power_sprites[array_get_index(power_ups, powerUp)];
            image_index = 2;
            return;
        }
		sprite_index = gp_sprites[array_get_index(power_ups, powerUp)];
	}
	else if !check_ground_at(x, y + 8) {
		sprite_index = jump_sprites[array_get_index(power_ups, powerUp)];
	}
	else if abs(velocityX) > 0 {
		sprite_index = walk_sprites[array_get_index(power_ups, powerUp)];
	}
	else {
		sprite_index = stand_sprites[array_get_index(power_ups, powerUp)];
	}
	
	if iFrames > 0 && obj_game_manager.playable {
		image_alpha = iFrames % 2;
		
		iFrames--;
	}
    else {
        image_alpha = 1;
    }
	
	if powerUp == "Small" {
		mask_index = spr_hitbox_small;
	}
	else {
		mask_index = spr_hitbox_super;
	}
}

transition_power = function(pre, post) {
	if powerTransition == 0 {
		obj_game_manager.playable = false;
	}
	else if powerTransition == 60 {
        if alive {
            obj_game_manager.playable = true;
        }
        
		lastPower = post;
	}
	else if powerTransition < 60 {
		if powerTransition % 2 == 1 {
			powerUp = pre;
			lastPower = post;
		}
		else {
			powerUp = post;
		}
	}
	
	powerTransition++;
}

die = function() {
	alive = false;
	obj_game_manager.playable = false;
    lastPower = "Small";
    powerUp = "Small";
    
    alarm[1] = 300;
}

enter_pipe = function(direction) {
    switch direction {
        case "Up":
            xShift = 0;
            yShift = 8;
            break;
        case "Down":
            xShift = 0;
            yShift = -8;
            break;
        case "Right":
            xShift = -8;
            yShift = 0;
            break;
        case "Left":
            xShift = 8;
            yShift = 0;
            break;
        default:
            show_debug_message("Improper pipe entrance");
            break;
    }
    
    if place_meeting(x + xShift, y + yShift, obj_warp_pipe) {
        if direction == "Up" {
            if y < instance_place(x, y + yShift, obj_warp_pipe).y {
                y += 2;
                return 1;
            }
        }
        else if direction == "Down" {
            if y > instance_place(x, y + yShift, obj_warp_pipe).y + yShift {
                y -= 2;
                return 1;
            }
        }
        else if direction == "Left" {
            if x < instance_place(x + xShift, y, obj_warp_pipe).x + xShift {
                x += 2;
                return 1;
            }
        }
        else if direction == "Right" {
            if x > instance_place(x + xShift, y, obj_warp_pipe).x {
                x -= 2;
                return 1;
            }
        }
        
        find_pipemate(xShift, yShift);
    }
}

find_pipemate = function(xShift, yShift) {
    pipemate = instance_place(x + xShift, y + yShift, obj_warp_pipe).find_mate();
            
    if pipemate != noone {
        warping = 2;
        
        x = pipemate.x;
        y = pipemate.y;
        
        if pipemate.open_dir == "Left" ||
            pipemate.open_dir == "Right" {
            y -= 8;
        }camera = obj_camera_manager.camera;
        camera_set_view_pos(camera, 
        clamp(x - camera_get_view_width(camera) / 2, 0, room_width - camera_get_view_width(camera)), 
        clamp(y - camera_get_view_height(camera) / 2, 0, room_height - camera_get_view_height(camera)));
        return 1;
    }
    else {
        return 0;
    }
}