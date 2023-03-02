var STATE = oBattleController.battle_state,
	MENU = oBattleController.menu_state;
image_angle += draw_angle;
if (STATE = 0 or STATE = 2) and (MENU != 5) and !IsGrazer
	draw_self();
//Grazing (Unused, unless a better method is found)
//if GrazeTimer GrazeTimer--;
//if IsGrazer
//{
//	draw_sprite_ext(sprSoulGraze, 0, x, y, 2, 2, image_angle, c_white, GrazeAlpha);
//	GrazeAlpha -= 1/40;
//}
image_angle -= draw_angle;


//Green soul shield drawing
if mode = SOUL_MODE.GREEN
	if STATE == 2
	{
		draw_set_circle_precision(16);
		draw_circle_colour(x - 0.5, y - 0.5, 30, c_green, c_green, 1);
		gpu_set_blendmode(bm_add);
		for(var i = 0; i < ShieldAmount; i++)
		{
			var ShieldAng = ShieldDrawAngle[i],
				ShieldDistance = lengthdir_xy(ShieldLen[i], ShieldAng);
			draw_sprite_ext(sprGreenShield, 0, ShieldDistance.x + x, ShieldDistance.y + y, 1, 1, ShieldAng - 90, ShieldColor[i], 1);
			if ShieldAlpha[i] > 0
			{
				gpu_set_blendmode(bm_normal);
				draw_sprite_ext(sprGreenShield, 1, ShieldDistance.x + x, ShieldDistance.y + y, 1, 1, ShieldAng - 90, ShieldHitCol[i], ShieldAlpha[i]);
				gpu_set_blendmode(bm_add);
			}
			
			var ShieldWidth = [lengthdir_x(30, ShieldAng + 90),
								lengthdir_y(30, ShieldAng + 90)];
				 _x = lengthdir_x(ShieldLen[i] + 16, ShieldAng) + x + ShieldWidth[0];
				 _y = lengthdir_y(ShieldLen[i] + 16, ShieldAng) + y + ShieldWidth[1];
			var __x = lengthdir_x(ShieldLen[i] + 16, ShieldAng) + x - ShieldWidth[0],
				__y = lengthdir_y(ShieldLen[i] + 16, ShieldAng) + y - ShieldWidth[1];
			with oBulletParents
				with other
				{
					for(var i = 0; i < 5; ++i)
					{
						if global.show_hitbox
						{
							draw_set_color(c_white)
							draw_line(_x, _y, __x, __y)
						}
						if collision_line(_x, _y, __x, __y, other, false, false) and other.Color == i
						{
							DestroyArrow(other);
							part_type_color1(ShieldParticleType, ShieldHitCol[i]);
							repeat irandom_range(5, 10)
							{
								var sc = random_range(3, 5);
								part_type_scale(ShieldParticleType, sc, sc);
								part_particles_create(ShieldParticleSystem, random_range(_x, __x), random_range(_y, __y), ShieldParticleType, 1);
							}
						}
						 _x -= lengthdir_x(1,ShieldAng);
						__x -= lengthdir_x(1,ShieldAng);
						 _y -= lengthdir_y(1,ShieldAng);
						__y -= lengthdir_y(1,ShieldAng);
					}
				
					 _x += lengthdir_x(5,ShieldAng);
					__x += lengthdir_x(5,ShieldAng);
					 _y += lengthdir_y(5,ShieldAng);
					__y += lengthdir_y(5,ShieldAng);
					if other.JudgeMode == "Lenient" and other.len <= 50
					{
						var input = [input_check_pressed("right"), input_check_pressed("up"),
									input_check_pressed("left"), input_check_pressed("down")];
						if input[min(posmod(other.dir / 90,360), 0)]
							DestroyArrow(other);
					}
				}
		}
		gpu_set_blendmode(bm_normal);
	}

if mode == SOUL_MODE.PURPLE and STATE == 2
{
	var TopLine =		oBoard.y - oBoard.up + 15,
		BottomLine =	oBoard.y + oBoard.down - 15,
		LeftLine =		oBoard.x - oBoard.left + 15,
		RightLine =		oBoard.x + oBoard.right - 15,
		XDifference = (RightLine - LeftLine) / (Purple.HLineAmount - 1),
		YDifference = (BottomLine - TopLine) / (Purple.VLineAmount - 1);
	draw_set_alpha(Purple.Mode == 0 ? 1 : 0.3);
	for(var i = TopLine; i <= BottomLine; i += YDifference)
	{
		draw_set_color(c_purple);
		draw_line(LeftLine, i, RightLine, i);
		draw_set_color(c_white);
	}
	draw_set_alpha(Purple.Mode == 1 ? 1 : 0.3);
	for(var i = LeftLine; i <= RightLine; i += XDifference)
	{
		draw_set_color(c_purple);
		draw_line(i, TopLine, i, BottomLine);
		draw_set_color(c_white);
	}
	Purple.ForceAlpha = lerp(Purple.ForceAlpha, 0, 0.08);
	draw_set_alpha(Purple.ForceAlpha);
	draw_set_color(c_purple);
	Battle_Masking_Start();
	draw_rectangle(oBoard.x - oBoard.left, oBoard.y - oBoard.up,
					oBoard.x + oBoard.right, oBoard.y + oBoard.down, 0);
	Battle_Masking_End();
	draw_set_color(c_white);
	draw_set_alpha(1);
}



show_hitbox();