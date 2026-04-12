walkSpeed = 2;
velocityX = 0;
velocityY = 0;
terminalFallSpeed = 7;

slideVelocity = 0;

iFrames = 0;

dying = false;

turnOnEdge = false;
spiky = false;
standStill = false;
upsideDown = false;

enemy_types = [ "Goomba", "Troopa_G", "Troopa_G_No_Shell", "Spiny", "Piranha Plant", "Piranha Plant U", "Rex", "Rex_Stomped" ];
enemy_walk_sprites = [ spr_goomba, spr_troopa_g_walk, spr_troopa_g_walk_no_shell, spr_spiny, spr_piranha_plant, spr_piranha_plant, spr_rex, spr_rex_stomped ];

assign_properties = function() {
    turnOnEdge = false;
    
	switch enemyType {
        case "Troopa_G":
            image_xscale = 1.5;
            image_yscale = 1.5;
            break;
        case "Spiny":
            spiky = true;
            break;
        case "Piranha Plant":
            spiky = true;
            standStill = true;
            break;
        case "Piranha Plant U":
            spiky = true;
            standStill = true;
            upsideDown = true;
            break;
		default:
			break;
	}
    
    if upsideDown {
        image_yscale *= -1;
    }
}

walk = function() { 
    if iFrames > 0 {
        iFrames--;
    }
    
    if standStill {
        sit_still();
        return;
    }
    
	if turnOnEdge = false {
		wobble();
	}
}

sit_still = function() {
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.collideable_terrain[i]) {
			velocityY = 0;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.breakable_terrain[i]) {
			velocityY = 0;
			return;
		}
	}
	
	if place_meeting(x + velocityX, y + velocityY, obj_question_block) {
		velocityY = 0;
		return;
	}
	
    if upsideDown {
        y += velocityY;
        
   			
        if velocityY < terminalFallSpeed {
           velocityY--; 
        }
    }
    else { 
        y += velocityY;
        
   			
        if velocityY < terminalFallSpeed {
           velocityY++; 
        }
    }
}

wobble = function() {
    if slideVelocity > 0 {
        velocityX = slideVelocity;
        slideVelocity -= .5;
    } 
    else if slideVelocity < 0 {
        velocityX = slideVelocity;
        slideVelocity += .5;
    }
    else {
        if velocityX > walkSpeed {
    		velocityX = walkSpeed;
    	}
        
        if velocityX < -walkSpeed {
    		velocityX = -walkSpeed;
    	}
    }
    
    if abs(slideVelocity) < 1 {
        slideVelocity = 0;
    }
    
	if velocityX = 0 {
		velocityX = walkSpeed;
	}
	
	sit_still();
	
	for (i = 0; i < array_length(obj_mario.collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.collideable_terrain[i]) {
			velocityX *= -1;
        
            slideVelocity = 0;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.breakable_terrain[i]) {
			velocityX *= -1;
        
            slideVelocity = 0;
 			return;
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) || place_meeting(x + velocityX, y, obj_simple_enemy) {
		velocityX *= -1;
        
        slideVelocity = 0;
		return;
	}
	
	if place_meeting(x + velocityX, y, obj_shell) && slideVelocity == 0 {
        if instance_place(x + velocityX, y, obj_shell).velocityX != 0 {
            kill_fall();
            
            return;
        }
        
		velocityX *= -1;
        
        slideVelocity = 0;
		return;
	}
	
	x += velocityX;
}

kill_stomp = function() { 
    if iFrames > 0 {
        return;
    }
    
    if enemyType == "Rex" {
        enemyType = "Rex_Stomped";
        walkSpeed = 3;
        velocityX *= 3/2;
        iFrames = 30;
        return;
    }
    
    if enemyType == "Troopa_G" {
        enemyType = "Troopa_G_No_Shell";
        
        instance_create_layer(x, y, "Instances", obj_shell);
        
        slideVelocity = 8 * velocityX;
        
        iFrames = 30;
        return;
    }
    
	dying = true;
	image_yscale = image_yscale / 2;
	y += sprite_height / 2;
	alarm[0] = 30;
}

kill_fall = function() { 
	dying = true;
	image_yscale *= -1;
	
	if y > obj_mario.y + 300 {
		instance_destroy();
	}
}

animate = function() {
    if slideVelocity > 0 {
        if enemyType == "Troopa_G_No_Shell" {
            sprite_index = spr_troopa_g_eject;
        }
    }
    else {
        sprite_index = enemy_walk_sprites[array_get_index(enemy_types, enemyType)];
    }
    
    if velocityX != 0 {
        image_xscale = image_yscale * velocityX / abs(velocityX);
    }
}

assign_properties();