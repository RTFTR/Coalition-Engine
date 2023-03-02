//Fading methods
for(var i = 0, n = array_length(Fade.Activate); i < n; ++i)
{
	if Fade.Activate[i, 0]
	{
		Fade.Timer++;
		var duration = Fade.Activate[i, 1],
			delay = Fade.Activate[i, 2];
		switch i
		{
			case FADE.CIRCLE:
				if Fade.Timer <= duration
					FadeTime += 1 / duration;
				if Fade.Timer >= duration + delay and FadeTime > 0
					FadeTime -= 1 / duration;
				draw_circular_bar(320, 240, FadeTime * 60, 60, c_black, 900, 1, 900);
			break
			case FADE.LINES:
				if Fade.Timer <= duration
					FadeTime += 1 / duration
				if Fade.Timer >= duration + delay and FadeTime > 0
					FadeTime -= 1 / duration;
				for(var ii = 0, nn = Fade.Activate[i, 3]; ii < nn; ++ii)
				{
					var Left = ii * 640 / nn;
					draw_sprite_ext(sprPixel, 0, Left, 0, FadeTime * 640 / nn, 480, 0, c_black, 1);
				}
			break
		}
	}
}

//Draws above shaders
if global.ShowFPS and !global.debug and room != rRestart  //Prevent debug UI overlap
{
	draw_set_font(fnt_dotum);
	draw_set_halign(fa_right);
	draw_set_color(c_red);
	draw_text(635, 5, "FPS: " + string(fps));
	draw_set_halign(fa_left);
	draw_set_color(c_white);
}