///@desc Plays the audio with chosen volume and pitch
///@param soundid			The ID of the sound (i.e. snd_hurt)
///@param {bool} single		If the same sound is played, that sound will be stopped and this one will play instead (Default False)
///@param {bool} loops		Whether the audio loops
///@param {real} volume		The volume of the audio (Max 1, Min 0, Default 1)
///@param {real} pitch		The pitch of the audio (Default 1)
///@param {real} time		The time taken for the audio to change it's volume (In Miliseconds, Default 0)
function audio_play(soundid, single = false, loops = false, volume = 1, pitch = 1, time = 0)
{
	if single audio_stop_sound(soundid);
	var audio = audio_play_sound(soundid, 1, loops, volume, 0, pitch);
	audio_sound_gain(audio,volume,time);
	return audio;
}

///@desc Sticks the audio to given time
///@param {Asset.GMSound} Audio		The audio to stick
///@param {real} Time				The target time to set the audio with
///@param {real} Margin				The margin of error of the audio, Default 0.05 sec / 3 frames
function audio_sync_to_time(aud, time, margin = 3/60)
{
	if abs(audio_sound_get_track_position(aud) - time) >= margin
		audio_sound_set_track_position(aud, time);
}