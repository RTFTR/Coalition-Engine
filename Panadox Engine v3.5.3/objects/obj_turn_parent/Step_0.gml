if start
time++;
var _turn = turn;
if array_length(turn_time) >= (_turn + 1)
{
	if time == turn_time[_turn]
	end_turn();
}
else end_turn();

// Down here you can make your turn codes
if _turn = 0
{
	if time == 1
	{
		//Bullet_GasterBlaster(0,320,180,2,2,390,320,180,30,50,40)
		for(var i=0;i < 50; i++)
		Bullet_Bone_Gap_V(390+i*10,320,-3,10)
	}
}
