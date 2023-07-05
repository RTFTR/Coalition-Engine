sprite_index = sprPixel;
image_yscale = 200;
Event = function()
{
	with obj_OverworldCharMain
	{
		scribble_typists_add_event("sansfite", sansfightstart)
		OW_Dialog("sans fight time[delay,60][sansfite]")
	}
}