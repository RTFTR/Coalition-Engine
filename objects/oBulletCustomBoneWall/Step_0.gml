//Changes warning box color
if warn_color_swap
{
	WarnTimer++;
	if !(WarnTimer % 5) and time_warn
	{
		var change = (WarnTimer % 10) == 5;
		warn_color = change ? c_yellow : c_red;
		warn_alpha_filled = change ? 0.25 : 0.5;
	}
}

if time_warn == 0 and state == 1
{
	//Play sound
	if sound_create audio_play(snd_bonewall);
	state = 2;
	for (var i = round(-width / 2),
			sprite = object_get_sprite(object),
			spacing = sprite_get_height(sprite); i < width / 2; i += spacing) {
		var X = x + lengthdir_x(i, image_angle + 90),
			Y = y + lengthdir_y(i, image_angle + 90),
			bone = Bullet_Bone(X, Y, height * sqrt(2), 0, 0, type,,, image_angle,, false, time_stay + time_move * 2 + time_warn);
		with bone
		{
			TweenFire(self, other.ease[0], 0, 0, 0, other.time_move,
			"x>", x - lengthdir_x(other.distance[1] * sqrt(2) - 20, image_angle),
			"y>", y - lengthdir_y(other.distance[1] * sqrt(2) - 20, image_angle));
			TweenFire(self, other.ease[1], 0, 0, other.time_move + other.time_stay, other.time_move,
			"x>", x + lengthdir_x(other.distance[0], image_angle),
			"y>", y + lengthdir_y(other.distance[0], image_angle));
		}
	}
}
if state >= 2
{
	if timer == ceil(time_move + time_stay + time_move) instance_destroy();
	timer++;
}