//Plays gameover audio
part_system_destroy(ps);
part_type_destroy(p);
state++;
bgm = audio_play(aud, true, true);
var a = instance_create_depth(0, 0, 0, obj_2D5Camera);
with a
{
	TweenFire(id, "o", TWEEN_MODE_ONCE, false, 0, 120, "camXDisplace", 0, 150);
	TweenFire(id, "o", TWEEN_MODE_ONCE, false, 0, 120, "camYDisplace", 0, 50);
	TweenFire(id, "o", TWEEN_MODE_ONCE, false, 0, 120, "camDist", -600, -300);
	TweenFire(id, "o", TWEEN_MODE_ONCE, false, 20, 60, "camFov", 90, 65);
	TweenEasyMove(40, 50, 120, 130, 0, 120, "o");
	TweenFire(id, "io", TWEEN_MODE_PATROL, false, 120, 240, "camXDisplace", 150, -150);
	TweenFire(id, "io", TWEEN_MODE_PATROL, false, 120, 300, "camYDisplace", 50, -50);
	TweenFire(id, "io", TWEEN_MODE_PATROL, false, 120, 240, "x", 120, 480);
	TweenFire(id, "io", TWEEN_MODE_PATROL, false, 120, 300, "y", 130, 250);
}

