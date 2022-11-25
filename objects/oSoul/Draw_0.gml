var STATE = oBattleController.battle_state;
var MENU = oBattleController.menu_state;
image_angle += draw_angle;
if (STATE = 0 or STATE = 2) and (MENU != 5)
	draw_self();
image_angle -= draw_angle;

//Green soul shield drawing
if mode = SOUL_MODE.GREEN
	if Battle_GetState() == 2
	{
		var ShieldAng = ShieldDrawAngle;
		draw_set_circle_precision(16)
		draw_circle_colour(x, y, 30, c_green, c_green, 1);
		_x = lengthdir_x(ShieldLen, ShieldAng) + x;
		_y = lengthdir_y(ShieldLen, ShieldAng) + y;
		draw_sprite_ext(spr_GreenShield, ShieldIndex, _x, _y, 1, 1, ShieldAng - 90, c_white, 1);
		
		var ShieldWidth = [lengthdir_x(30, ShieldAng + 90),
							lengthdir_y(30, ShieldAng + 90)];
			 _x = lengthdir_x(ShieldLen + 13, ShieldAng) + x + ShieldWidth[0];
			 _y = lengthdir_y(ShieldLen + 16, ShieldAng) + y + ShieldWidth[1];
		var __x = lengthdir_x(ShieldLen + 13, ShieldAng) + x - ShieldWidth[0];
		var __y = lengthdir_y(ShieldLen + 16, ShieldAng) + y - ShieldWidth[1];
		with(oBulletParents)
			with(other)
			{
				for(var i = 0; i < 5; ++i)
				{
					if global.show_hitbox
					{
						draw_set_color(c_white)
						draw_line(_x, _y, __x, __y)
					}
					if collision_line(_x, _y, __x, __y, other, false, false)
						DestroyArrow(other);
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
					if input[min(Posmod(other.dir/90,360),0)]
						DestroyArrow(other);
				}
			}
	}


show_hitbox()

