var soul = oSoul;
var dir_e = ((mode == 2 or mode == 3) ? 45 : 0);
if id = instance_nearest(soul.x, soul.y, oGreenArr) if len <= 170 index = 4;
image_index = index + mode;
image_angle = dir + dir_e + dir_a;
len -= spd;

//Yellow or Diagonal Yellow
if mode == 1 or mode == 3
{
	if len <= spd*30 and !flipped
	{
		TweenFire(id, spd > 7 ? EaseOutBack : EaseOutSine, TWEEN_MODE_ONCE, false, 0, 105/spd, "dir", dir, dir - 180)
		flipped = 1;
	}
}

if global.Autoplay
	if len < 60
		if IsNearest()
		{
			do dir += 360; until dir > 0;
			dir %= 360;
			var DrawAngle = round(soul.ShieldDrawAngle/90)*90;
			soul.ShieldTargetAngle = dir;
			
			if DrawAngle == 270 and dir == 0	soul.ShieldDrawAngle -= 360;
			if DrawAngle == 0 and dir == 270	soul.ShieldDrawAngle = 360;
			if soul.ShieldTargetAngle < 0		soul.ShieldTargetAngle += 360;
			
			soul.ShieldTargetAngle %= 360;
			
			if JudgeMode == "Lenient"
			{
				var input = [vk_right, vk_up,vk_left,vk_down];
				keyboard_key_press(input[min(dir / 90, 0)]);
			}
		}

x = lengthdir_x(len, dir + dir_e + dir_a) + soul.x;
y = lengthdir_y(len, dir + dir_e + dir_a) + soul.y;

gpu_set_blendmode_ext(bm_src_color, bm_dest_alpha)
draw_self();
gpu_set_blendmode(bm_normal)

