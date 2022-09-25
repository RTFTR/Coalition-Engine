if start
time++;
var _turn = turn;
if array_length(turn_time) >= (_turn + 1)
{
	if time == turn_time[_turn] end_turn();
}
else end_turn();

// Down here you can make your turn codes
if _turn == 0
{
	if time == 30
	{
		//Bullet_GasterBlaster(0,320,180,2,2,390,320,180,30,50,40)
		Set_BoardAngle(360,290);
		for(var i = 0;i < 50; i++)
		{
			Bullet_Bone_Top(640 + i * 70, 70, -3, 0, 1, 0, 0);
			Bullet_Bone_Bottom(0 - i * 70, 70, 3, 0, 1, 0, 0);
			Bullet_Bone_Right(480 + i * 70, 70, -3, 0, 1, 0, 0);
			Bullet_Bone_Left(0 - i * 70, 70, 3, 0, 1, 0, 0);
		}
		//for (var i = 0; i < 4; ++i)
		//{
		//	a = Bullet_Bone(0,0,60,0,0)
		//	a.len_dir = i*90
		//}
		with(obj_battle_bullet_parents)
		{
			axis = 1;
			axis_override = true;
			TweenFire(id, EaseInOutSine, TWEEN_MODE_PATROL, false, 0, 80, "axis_override_angle", -40, 40)
			//lenable = 1;
			//len = 40;
			//len_angle = 1
			//len_dir_move = 2
			//len_target = obj_battle_board;
			//len_angle_extra = 30;
		}
		
		//Battle_SoulMode(SOUL_MODE.GREEN);
		//Set_GreenBox();
		//for(var i = 0;i < 40; i++)
		//{
		//	Bullet_Arrow(90 + i * 6, 3, irandom(360), irandom(2));
		//}
		//var a = Make_Platform(320, 320, 0, 0, 40);
		//TweenFire(a, EaseOutSine, TWEEN_MODE_LOOP, false, 0, 40, "x", 350, 290);
	}
}
if _turn == 1
{
	if time == 1
	Battle_SetSoulPos(380, 380, 30, EaseOutQuad);
}
