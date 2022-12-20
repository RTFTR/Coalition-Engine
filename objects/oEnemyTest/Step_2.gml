var _turn = oBattleController.battle_turn - 1;
if instance_exists(oBulletBone) {
	with oBulletBone {
		sprite_index = sprBonePap;
	}
}
if instance_exists(oGB)
	with oGB
	{
		sprite_index = sprOSTGB;
		image_blend = make_color_rgb(183, 190, 182);
	}