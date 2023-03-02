function textsetskippable(_element, _parameter_array, _character_index)
{
	global.TextSkipEnabled = _parameter_array[0];
}

function setsprite(_element, _parameter_array, _character_index)
{
	if instance_exists(oBattleController)
	{
		//Enemy name, Enemy sprite number, target image index
		var enemy = asset_get_index(_parameter_array[0]);
		if instance_exists(enemy)
			enemy.enemy_sprite_index[_parameter_array[1]] = _parameter_array[2];
	}
}

function flash(_element, _parameter_array, _character_index)
{
	with oGlobal
		fader_alpha = !fader_alpha;
	if _parameter_array[0] audio_play(snd_noise);
}
function sansfightstart(_element, _parameter_array, _character_index)
{
	oOWPlayer.Encounter_Begin();
}