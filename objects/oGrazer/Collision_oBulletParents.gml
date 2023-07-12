if !Interval
{
	audio_play(snd_noise);
	global.TP++;
	image_alpha = 1;
	Interval = 15;
}
else Interval--;