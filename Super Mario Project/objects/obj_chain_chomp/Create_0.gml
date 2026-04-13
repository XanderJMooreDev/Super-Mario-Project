walkSpeed = 2;
velocityX = 0;
velocityY = 0;
terminalFallSpeed = 4;
hopStrength = 8;

timesToStump = 0;

collideable_terrain = [];

alarm[0] = 120;

angleX = 0;
angleY = 0;

iFrames = 0;

dying = false;

walk = function() { 
    if iFrames > 0 {
        iFrames--;
    }
    
    if place_meeting(x, y, obj_chain_chomp_stump) && angleX == 0 {
        timesToStump++;
    }
    
    if timesToStump > 30 {
        timesToStump = 0;
        attempt_snap();
    }
    
    wobble();
}

sit_still = function() {
    
    if array_length(collideable_terrain) == 0 {
       array_copy(collideable_terrain, 0, obj_mario.collideable_terrain, 0, array_length(obj_mario.collideable_terrain));
       array_delete(collideable_terrain, 2, 1);
    }
        
	for (i = 0; i < array_length(collideable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, collideable_terrain[i]) {
            angleX = 0;
            angleY = 0;
			velocityY = -hopStrength;
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y + velocityY, obj_mario.breakable_terrain[i]) {
			velocityY = -hopStrength;
			return;
		}
	}
	
	if place_meeting(x + velocityX, y + velocityY, obj_question_block) {
        if place_meeting(x + velocityY, y + 8, obj_question_block) {
           velocityY = -hopStrength;
        }
		return;
	}
	
	if abs(y + velocityY - stump.y) > 130 {
        hit_edge();
		return;
	}
    
    y += velocityY;
    
        
    if velocityY < terminalFallSpeed && angleX == 0 {
        velocityY++; 
    }
}

wobble = function() {
    if velocityX > walkSpeed {
        velocityX = walkSpeed;
    }
    
    if velocityX < -walkSpeed {
        velocityX = -walkSpeed;
    }
    
	if velocityX == 0 && angleX == 0 {
		velocityX = walkSpeed;
	}
	
	sit_still();
	
	for (i = 0; i < array_length(collideable_terrain); i++) {
		if place_meeting(x + velocityX, y, collideable_terrain[i]) {
			hit_edge();
			return;
		}
	}
	
	for (i = 0; i < array_length(obj_mario.breakable_terrain); i++) {
		if place_meeting(x + velocityX, y, obj_mario.breakable_terrain[i]) {
			hit_edge();
            instance_destroy(instance_place(x + velocityX, y, obj_mario.breakable_terrain[i]));
 			return;
		}
	}
	
	if place_meeting(x + velocityX, y, obj_question_block) || place_meeting(x + velocityX, y, obj_simple_enemy) {
		hit_edge();
		return;
	}
	
	if place_meeting(x + velocityX, y, obj_shell) {
        if instance_place(x + velocityX, y, obj_shell).velocityX != 0 {
            kill_fall();
            
            return;
        }
        
		velocityX *= -1;
		return;
	}
	
	if abs(x + velocityX - stump.x) > 130 {
		hit_edge();
		return;
	}
	
	x += velocityX;
}

kill_fall = function() { 
	dying = true;
	image_yscale *= -1;
	
	if y > obj_mario.y + 300 {
		instance_destroy();
	}
}

attempt_snap = function() {
    if abs(obj_mario.x - stump.ctrX) == 0 {
        angleX = 0;
        angleY = 1;
    }
    else if abs(obj_mario.y - stump.ctrY) == 0 {
        angleX = 1;
        angleY = 0;
    }
    else {
        if abs(obj_mario.x - stump.ctrX) > abs(obj_mario.y - stump.ctrY) {
            angleX = (obj_mario.x - stump.ctrX) / abs(obj_mario.x - stump.ctrX);
            angleY = (obj_mario.y - stump.ctrY) / abs(obj_mario.x - stump.ctrX);
        }
        else {
            angleX = (obj_mario.x - stump.ctrX) / abs(obj_mario.y - stump.ctrY);
            angleY = (obj_mario.y - stump.ctrY) / abs(obj_mario.y - stump.ctrY);
        }
    }
    
    velocityX = angleX * 8;
    velocityY = angleY * 8;

    alarm[1] = 180;
}

hit_edge = function() {
    if angleX != 0 {
        velocityX = 0;
        velocityY = 0;
    }
    else {
        velocityX *= -1;
    }
}

animate = function() {
    if velocityX != 0 {
        image_xscale = velocityX / abs(velocityX);
    }
}