//if global.timer == 30 CURAUD = audio_play(storm)
//if global.timer >= 30
//	AudioStickToTime(CURAUD, (global.timer - 30) / 60)
//if (global.timer >= 145 and global.timer <= 155)
//	SpliceScreen(random(640), random(480), random(360), 5, 365, 5, random_range(10, 30))

var Main = MainOption, Sub = SubOption;
//Surfaces
if !surface_exists(Main.Surf) Main.Surf = surface_create(640, 480);
if !surface_exists(Sub.Surf) Sub.Surf = surface_create(640, 480);

//Main Option Scrolling
if Main.DisplaceYTarget < Main.MaxY
{
	Main.Lerp = lerp(Main.Lerp, 0.12, 0.09);
	Main.DisplaceYTarget = round(lerp(Main.DisplaceYTarget, Main.MaxY, Main.Lerp));
}
else if Main.DisplaceYTarget > 0
{
	Main.Lerp = lerp(Main.Lerp, 0.12, 0.09);
	Main.DisplaceYTarget = round(lerp(Main.DisplaceYTarget, 0, Main.Lerp));
}
else
{
	Main.Lerp = 0.16;
}
Main.DisplaceX = lerp(Main.DisplaceX, Main.DisplaceXTarget, 0.16);
Main.DisplaceY = lerp(Main.DisplaceY, Main.DisplaceYTarget, 0.16);

if point_in_rectangle(mouse_x, mouse_y, 20, 20, 240, 460)
{
	var displace = mouse_wheel_up() - mouse_wheel_down();
	Main.DisplaceYTarget += displace * 20;
}

//Sub-Option Scrolling
if State != DEBUG_STATE.MAIN
{
	if Sub.DisplaceYTarget < Sub.MaxY
	{
		Sub.Lerp = lerp(Sub.Lerp, 0.12, 0.09);
		Sub.DisplaceYTarget = round(lerp(Sub.DisplaceYTarget, Sub.MaxY, Sub.Lerp));
	}
	else if Sub.DisplaceYTarget > 0
	{
		Sub.Lerp = lerp(Sub.Lerp, 0.12, 0.09);
		Sub.DisplaceYTarget = round(lerp(Sub.DisplaceYTarget, 0, Sub.Lerp));
	}
	else
	{
		Sub.Lerp = 0.16;
	}
	Sub.DisplaceX = lerp(Sub.DisplaceX, Sub.DisplaceXTarget, 0.16);
	Sub.DisplaceY = lerp(Sub.DisplaceY, Sub.DisplaceYTarget, 0.16);
	
	var BaseX = 270 + Sub.DisplaceX,
		RightX = BaseX + 200;
	if point_in_rectangle(mouse_x, mouse_y, BaseX, 20, RightX, 460)
	{
		var displace = mouse_wheel_up() - mouse_wheel_down();
		displace *= 60;
		Sub.DisplaceYTarget += displace;
		if State == DEBUG_STATE.SPRITES && mouse_check_button_pressed(mb_right)
		{
			Main.DisplaceXTarget = 0;
			Sub.DisplaceXTarget = 0;
			Sub.DrawSprite = -1;
			if Sub.Stream != -1
			{
				audio_destroy_stream(Sub.Stream);
				Sub.Stream = -1;
			}
			Sub.Audio = -1;
		}
	}
}