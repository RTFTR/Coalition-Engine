function audio_play(soundid,single = false,loops = false,volume = 1,pitch = 1,time = 0)
{
	if single audio_stop_sound(soundid);
	var audio = audio_play_sound(soundid, 50, loops);
	audio_sound_gain(audio,volume,time);
	audio_sound_pitch(audio,pitch);
	return audio;
}
function sfx_play(soundid, volume = 1)
{
	var audio = audio_play_sound(soundid, 1, 0)
	audio_sound_gain(audio, volume, 0);
}
