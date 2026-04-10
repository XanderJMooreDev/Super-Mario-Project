adjust_float_y();

if cloud_id == 0 {
  float_towards_location(obj_mario.x + obj_mario.facingDir * - 30, obj_mario.y - 10 + floatY);
}
else {
  float_towards_location(obj_mario.x + obj_mario.facingDir * - (60 + obj_mario.velocityX), obj_mario.y + floatY);
}