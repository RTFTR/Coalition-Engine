event_inherited();
#region Intro
TurnCreate(0, 0, 1, function()
{
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
});
#endregion
#region Turn 1
TurnCreate(1, 0, 1, function()
{
	Slam(DIR.LEFT);
});
#endregion