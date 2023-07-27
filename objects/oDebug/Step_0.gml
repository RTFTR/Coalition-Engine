//Surfaces
if !surface_exists(MainOptionSurf) MainOptionSurf = surface_create(640, 480);
if !surface_exists(SubOptionSurf) SubOptionSurf = surface_create(640, 480);

//Main Option Scrolling
if MainOptionDisplaceYTarget < MainOptionMaxY
{
	MainOptionLerp = lerp(MainOptionLerp, 0.12, 0.09);
	MainOptionDisplaceYTarget = round(lerp(MainOptionDisplaceYTarget, MainOptionMaxY, MainOptionLerp));
}
else if MainOptionDisplaceYTarget > 0
{
	MainOptionLerp = lerp(MainOptionLerp, 0.12, 0.09);
	MainOptionDisplaceYTarget = round(lerp(MainOptionDisplaceYTarget, 0, MainOptionLerp));
}
else
{
	MainOptionLerp = 0.16;
}
MainOptionDisplaceX = lerp(MainOptionDisplaceX, MainOptionDisplaceXTarget, 0.16);
MainOptionDisplaceY = lerp(MainOptionDisplaceY, MainOptionDisplaceYTarget, 0.16);

if point_in_rectangle(mouse_x, mouse_y, 20, 20, 240, 460)
{
	var displace = mouse_wheel_up() - mouse_wheel_down();
	displace *= 20;
	MainOptionDisplaceYTarget += displace;
}

//Sub-Option Scrolling
if State != DEBUG_STATE.MAIN
{
	if SubOptionDisplaceYTarget < SubOptionMaxY
	{
		SubOptionLerp = lerp(SubOptionLerp, 0.12, 0.09);
		SubOptionDisplaceYTarget = round(lerp(SubOptionDisplaceYTarget, SubOptionMaxY, SubOptionLerp));
	}
	else if SubOptionDisplaceYTarget > 0
	{
		SubOptionLerp = lerp(SubOptionLerp, 0.12, 0.09);
		SubOptionDisplaceYTarget = round(lerp(SubOptionDisplaceYTarget, 0, SubOptionLerp));
	}
	else
	{
		SubOptionLerp = 0.16;
	}
	SubOptionDisplaceX = lerp(SubOptionDisplaceX, SubOptionDisplaceXTarget, 0.16);
	SubOptionDisplaceY = lerp(SubOptionDisplaceY, SubOptionDisplaceYTarget, 0.16);
	
	var BaseX = 270 + SubOptionDisplaceX,
		RightX = BaseX + 200;
	if point_in_rectangle(mouse_x, mouse_y, BaseX, 20, RightX, 460)
	{
		var displace = mouse_wheel_up() - mouse_wheel_down();
		displace *= 60;
		SubOptionDisplaceYTarget += displace;
		if State == DEBUG_STATE.SPRITES && mouse_check_button_pressed(mb_right)
		{
			MainOptionDisplaceXTarget = 0;
			SubOptionDisplaceXTarget = 0;
			SubOptionDrawSprite = -1;
		}
	}
}