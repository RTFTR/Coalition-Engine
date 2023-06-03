///@desc Turn Making
event_inherited();

#region Turn 0 Blue Soul
TurnCreate(0, 0, 30, function() {
	Slam(DIR.DOWN, 15);
	Bullet_BoneWall(DIR.DOWN, 100, 50, 20);
	Make_Platform(200, 330, 2, 0, 40);
});

TurnCreate(0, 1, 75, function() {
	Battle_SoulMode(SOUL_MODE.RED);
});

TurnCreate(0, 2, 120, function() {
	for (var i = 45; i <= 315; i += 90)
		Blaster_Circle([320, 320], [600, 150], [i, i], [i + 180, i + 180], [2, 2], [30, 30, 20])
});
TurnCreate(0, 3, 170, function() {
	for (var i = 0; i <= 360; i += 90)
		Blaster_Circle([320, 320], [600, 150], [i, i], [i + 180, i + 180], [2, 2], [30, 30, 20])
});
TurnCreate(0, 4, 220, function() {
	var dir = time * 2.5;
	Blaster_Circle([320, 320], [600, 150], [dir, dir], [dir + 180, dir + 180], [1, 2], [30, 30, 20])
}, (520 - 220) / 3, 3)
#endregion
#region Turn 1 Orange Soul
TurnCreate(1, 0, 30, function() {
	{
		Battle_SoulMode(SOUL_MODE.ORANGE);
		TweenFire(oGlobal, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 300, "camera_angle", 0, 360)
	}
});
TurnCreate(1, 1, 60, function() {
	Bullet_BoneBottom(250, 140, 2, 1)
}, (180 - 60) / 30, 30)

#endregion
#region Turn 2 Bone Cube
TurnCreate(2, 0, 1, function() {
	with(Battle_BoneCube([320, 320], [0, 40, 20], [.5, -.1, -.2], [120, 120, 120])) {
		type = 1;
		TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 60, "scalex", 640, 120)
		TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 60, "scaley", 640, 120)
		TweenFire(id, EaseOutQuart, TWEEN_MODE_ONCE, false, 0, 60, "scalez", 640, 120)
		for(var i = 0; i < 8; ++i)
		{
			TweenFire(id, EaseInOutSine, TWEEN_MODE_BOUNCE, false, 50+i*80, 40, "scalex", 120, 90)
			TweenFire(id, EaseInOutSine, TWEEN_MODE_BOUNCE, false, 50+i*80, 40, "scaley", 120, 90)
			TweenFire(id, EaseInOutSine, TWEEN_MODE_BOUNCE, false, 50+i*80, 40, "scalez", 120, 90)
		}
	}
})
TurnCreate(2, 1, 40, function() {
	{
		var pos = [random_range(100, 540), random_range(150, 200)];
		var a = Battle_BoneCube(pos, [0, 10, 20], [.6, -1, .3], [20, 20, 20], 60, EaseOutQuad)
		a.direction = point_direction(pos[0], pos[1], oSoul.x, oSoul.y)
		TweenFire(a, EaseInBack, TWEEN_MODE_ONCE, false, 0, 50, "speed", 0, 9)
	}
}, 15, 40)
#endregion
#region Turn 3 Axis bone
TurnCreate(3, 0, 1, function() {Battle_SoulMode(SOUL_MODE.RED)});
TurnCreate(3, 1, 30, function() {
	Set_BoardAngle(360,290);
	for(var i = 0; i < 50; i++)
	{
		Bullet_BoneTop(640 + i * 70, 70, -3, 0, 1, 0, 0);
		Bullet_BoneBottom(0 - i * 70, 70, 3, 0, 1, 0, 0);
		Bullet_BoneRight(480 + i * 70, 70, -3, 0, 1, 0, 0);
		Bullet_BoneLeft(0 - i * 70, 70, 3, 0, 1, 0, 0);
	}
	oBulletBone.axis = 1;
});
#endregion
#region Turn 4 Board Moving
TurnCreate(4, 0, 35, function() {
	Slam(DIR.RIGHT);
	Set_BoardPos(510, 320, 35, EaseLinear);
});
TurnCreate(4, 1, 70, function() {
	Bullet_BoneWall(DIR.RIGHT, 35, 10, 30);
});
TurnCreate(4, 2, 90, function() {
	Slam(DIR.DOWN);
});
TurnCreate(4, 3, 120, function() {
	Set_BoardPos(130, 320, 580, EaseLinear);
});
TurnCreate(4, 4, 100, function() {
	Bullet_BoneGapV(oBoard.x - 90, random_range(340, 370), 2.5, 20);
}, 10, 60);
#endregion
#region Turn 5 Corridor Axis
TurnCreate(5, 0, 30, function() {
	Battle_SoulMode(SOUL_MODE.RED);
	Set_BoardSize(70, 70, 450, 450, 90, EaseLinear);
});
TurnCreate(5, 1, 120, function() {
	for (var i = 0; i < 200; ++i) {
		Bullet_BoneGapV(-i * 12, sin(i/15)*20+320, 4, 25, 0, 0, 0);
	}
	oBulletBone.axis = 1;
	Set_BoardAngle(-540, 720, EaseLinear);
	with oSoul
	{
		Blend = c_blue;
		TweenEasyBlend(c_red, c_blue, 0, 30, EaseLinear);
		alarm[0] = 1
	}
	TweenFire(oSoul, EaseLinear, TWEEN_MODE_ONCE, false, 0, 720, "draw_angle", 270, -270);
});
#endregion
#region Turn 6 Board Cover
TurnCreate(6, 0, 30, function() {
	Battle_SoulMode(SOUL_MODE.YELLOW)
	with instance_create_depth(360,320,0,oBoardCover) {
		up = irandom_range(10,20);
		down = irandom_range(10,20);
		left = irandom_range(10,20);
		right = irandom_range(10,20);
	}
	//instance_create_depth(250,320,0,oBoardCover,
	//{
	//	image_angle : 45
	//});
});
TurnCreate(6, 1, 570, function() {
	with oBoardCover
	{
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 30, "up", up, 0);
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 30, "down", down, 0);
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 30, "left", left, 0);
		TweenFire(id, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 30, "right", right, 0);
	}
});
TurnCreate(6, 2, 599, function() {
	instance_destroy(oBoardCover);
});
#endregion
#region Turn 7 Purple Soul
TurnCreate(7, 0, 1, function() {
	Battle_SoulMode(SOUL_MODE.PURPLE);
});
#endregion
#region Turn 8 Test
TurnCreate(8, 0, 1, function() {
	for (var i = 0, X = random_range(-10, 10); i < 17; ++i) {
		Bullet_Bone(X + i * 40, 200, 25, 1.5, 1.5, 0, 0, 0, -45, 0, 0, 300);
	}
	audio_play(snd_bone);
}, 9999, 90);
TurnCreate(8, 1, 46, function() {
	for (var i = 0, X = random_range(-10, 10); i < 17; ++i) {
		Bullet_Bone(X + i * 40, 200, 25, -1.5, 1.5, 0, 0, 0, -135, 0, 0, 300);
	}
	audio_play(snd_bone);
}, 9999, 90);
#endregion
#region Turn 9 Test
TurnCreate(9, 0, 31, function() {
	Bullet_BoneGapV(245, 320-dsin(time)*30, 4, 30);
}, 9999, 8);
TurnCreate(9, 1, 75, function() {
	var a = Bullet_BoneFullV(240, 0, 0, 0, 0, 1);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 0,  40, "speed", 5, 0);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 40, 40, "speed", 0, -5);
	
	var a = Bullet_BoneFullV(400, 0, choose(1,2), 0, 0, 1);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 0,  40, "speed", -3, 0);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 40, 40, "speed", 0, 3);
}, 9999, 150);
TurnCreate(9, 2, 150, function() {
	var a = Bullet_BoneFullV(400, 0, 0, 0, 0, 1);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 0,  40, "speed", -5, 0);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 40, 40, "speed", 0, 5);
	
	var a = Bullet_BoneFullV(240, 0, choose(1,2), 0, 0, 1);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 0,  40, "speed", 3, 0);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 40, 40, "speed", 0, -3);
}, 9999, 150);
#endregion
#region Turn 10 Test
TurnCreate(10, 0, 1, function() {
	temp_bone = Bullet_Bone(640, 150, 0, 0, 0);
	for (var i = 0, spd = random_range(-1, 1); i < 180; ++i) {
		other_bones[i] = Bullet_Bone(640, 150, 30, -2.5, spd, 0, 1, 0, i * 10);
	}
});
TurnCreate(10, 1, 1, function() {
	if instance_exists(other_bones[0])
	{
		temp_bone.x = other_bones[0].x;
		temp_bone.y = other_bones[0].y;
		var a = Bullet_Bone(temp_bone.x, temp_bone.y, 30, 0, 0, 0, 1, 0, random(360), 0, 1);
		a.direction = a.image_angle;
		TweenFire(a, EaseOutQuad, TWEEN_MODE_ONCE, false, 320 - time, 60, "speed", 0, 5);
	}
},9999, 3);
#endregion
