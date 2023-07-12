event_inherited();

var soul = oSoul,
	dir_e = ((mode == 2 or mode == 3) ? 45 : 0);
image_index = index + mode;
image_angle = dir + dir_e + dir_a;
len -= spd;

//Yellow or Diagonal Yellow
if mode == 1 or mode == 3
{
	if len <= spd * 30 and !flipped
	{
		TweenFire(id, spd > 7 ? EaseOutBack : EaseOutSine, TWEEN_MODE_ONCE, false, 0, 105 / spd, "dir", dir, dir - 180)
		flipped = 1;
	}
}

if global.Autoplay
	if len < 60
		if IsNearest()
		{
			do dir += 360; until dir > 0;
			dir %= 360;
			for(var i = 0; i < oSoul.ShieldAmount; ++i)
			{
				var DrawAngle = round(soul.ShieldDrawAngle[i]/90)*90;
				soul.ShieldTargetAngle[i] = dir;
				
				if DrawAngle == 270 and dir == 0	soul.ShieldDrawAngle[i] -= 360;
				if DrawAngle == 0 and dir == 270	soul.ShieldDrawAngle[i] = 360;
				if soul.ShieldTargetAngle[i] < 0		soul.ShieldTargetAngle[i] += 360;
			
				soul.ShieldTargetAngle[i] %= 360;
			
				//if JudgeMode == "Lenient"
				//{
				//	var input = [vk_right, vk_up,vk_left,vk_down];
				//	keyboard_key_press(input[min(dir / 90, 0)]);
				//}
			}
		}

x = len * dcos(dir + dir_e + dir_a) + soul.x;
y = len * -dsin(dir + dir_e + dir_a) + soul.y;

