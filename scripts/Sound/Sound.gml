///@desc Plays the audio with chosen volume and pitch
///@param soundid			The ID of the sound (i.e. snd_hurt)
///@param {bool} single		If the same sound is played, that sound will be stopped and this one will play instead (Default False)
///@param {bool} loops		Whether the audio loops
///@param {real} volume		The volume of the audio (Max 1, Min 0, Default 1)
///@param {real} pitch		The pitch of the audio (Default 1)
///@param {real} time		The time taken for the audio to change it's volume (In Miliseconds, Default 0)
function audio_play(soundid,single = false,loops = false,volume = 1,pitch = 1,time = 0)
{
	if single audio_stop_sound(soundid);
	var audio = audio_play_sound(soundid, 50, loops);
	audio_sound_gain(audio,volume,time);
	audio_sound_pitch(audio,pitch);
	return audio;
}

///@desc Plays a sound effect
///@param soundid		The ID of the sound (i.e. snd_hurt)
///@param {real} volume	The volume of the audio (Max 1, Min 0, Default 1)
function sfx_play(soundid, volume = 1)
{
	var audio = audio_play_sound(soundid, 1, 0)
	audio_sound_gain(audio, volume, 0);
}
