adjust_float_y();

if cloud_id == 0 {
  float_towards_location(global.player.x + global.player.facingDir * - 30, global.player.y - 10 + floatY);
}
else {
  float_towards_location(global.player.x + global.player.facingDir * - (60 + global.player.velocityX), global.player.y + floatY);
}