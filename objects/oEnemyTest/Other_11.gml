event_inherited();
#region Intro
TurnCreate(0, 0, 1, function()
{
	enemy_sprite_index[2] = 0;
	audio_play(snd_bone);
	Bullet_BoneFullH(245, 7, 1);
	Bullet_BoneFullH(395, -7, 1);
	Bullet_BoneFullV(245, 7, 1);
	Bullet_BoneFullV(395, -7, 1);
},40, 5);
TurnCreate(0, 1, 200, function()
{
	Blaster_Aim(random(360), [random_range(100, 540), random_range(100, 380)], [1.3, 2], [30, 30, 10]);
}, 297/12, 12);
TurnCreate(0, 2, 497, function()
{
	dialog_init("Always wondered why someone use their strongest attack first.");
});
TurnCreate(0, 3, 499, function()
{
	audio_play(BGM, 0, 1);
	with oGlobal
	{
		Song.Activate = true;
		Song.Name = "Save, Load T.K. Mix";
	}
	wiggle = true;
});
#endregion
#region Turn 1
TurnCreate(1, 0, 30, function()
{
	Slam(irandom(3) * 90);
}, 10, 60);
TurnCreate(1, 1, 60, function()
{
	if (oSoul.dir % 180)
	{
		Bullet_BoneGapV(280, 320, 3, 16);
		Bullet_BoneGapV(360, 320, -3, 16);
	}
	else
	{
		Bullet_BoneGapH(320, 280, 3, 16);
		Bullet_BoneGapH(320, 360, -3, 16);
	}
}, 10, 60);
TurnCreate(1, 2, 690, function() {
	var a = Bullet_Bone(320, 320, 0, 0, 0, 0, 1);
	TweenFire(a, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 60, "length", 0, 90);
	TweenFire(a, EaseInOutBack, TWEEN_MODE_ONCE, false, 90, 120, "image_angle", 90, 270);
	a = Bullet_Bone(320, 320, 0, 0, 0, 0, 1, 0, 0);
	TweenFire(a, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 60, "length", 0, 90);
	TweenFire(a, EaseInOutBack, TWEEN_MODE_ONCE, false, 90, 120, "image_angle", 0, 180);
});
TurnCreate(1, 3, 820, function() {Battle_SoulMode(SOUL_MODE.RED)});
#endregion
#region Turn 2
TurnCreate(2, 0, 1, function()
{
	Blaster_Circle([320, 295], [600, random_range(100, 200)], [time * 5, time * 5], [time * 5, time * 5 + choose(1, -1) * random_range(10, 30)], [1, 2], [30, 90 - time, 30]);
}, 36, 2);
TurnCreate(2, 1, 200, function()
{
	var i = irandom(3) * 90,
	xx = random_range(280, 360),
	yy = random_range(265, 335);
	switch i
	{
		case 0:
		Bullet_BoneGapV(390, yy, -2, 25);
		xx = 410;
		break
		case 90:
		Bullet_BoneGapH(xx, 205, 2, 25);
		yy = 185;
		break
		case 180:
		Bullet_BoneGapV(250, yy, 2, 25);
		xx = 230;
		break
		case 270:
		Bullet_BoneGapH(xx, 365, -2, 25);
		yy = 385
		break
	}
	Blaster_Circle([xx, yy], [600, 0], [i, i], [i + 180, i + 180], [1, 2], [40, 20, 40]);
}, 10, 90);
TurnCreate(2, 2, 200, function()
{
	var a = Bullet_BoneFullH(295, 0, choose(1, 2));
	a.image_alpha = 0;
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 0, 20, "image_alpha", 0, 0.5);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 20, 10, "image_alpha", 0.5, 1);
	TweenFire(a, EaseOutSine, TWEEN_MODE_ONCE, false, 0, 20, "y", 295, 225);
	TweenFire(a, EaseLinear, TWEEN_MODE_ONCE, false, 30, 1, "vspeed", 0, 2.5);
}, 15, 60);
TurnCreate(2, 3, 1160, function()
{
	for (var i = 0; i < 12; ++i) {
		Blaster_Circle([320, 295], [600, 0], [i * 30, i * 30], [i * 30, i * 30], [0.6, 2], [20, 20, 40])
	}
});
#endregion
