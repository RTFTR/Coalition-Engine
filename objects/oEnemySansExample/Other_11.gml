///@desc Set attacks
live;
SetAttack(0, function() {
	if time == 1
	{
		with oBoard
		{
			//TweenEasyRotate(0, 45, 0, 30, "o")
			//ConvertToVertex();
			//var index = InsertPolygonPoint(4, 320, 255);
			//TweenFire(id, "oSine", 0, 0, 0, 60, TPArray(Vertex, index + 1), 255, 100);
		}
		Board.SetSize(42, 42, 42, 42);
		Board.SetPos(, 240);
		SoulSetMode(SOUL_MODE.GREEN);
		//Bullet_Arrow(60, 7, 0);
		//Bullet_Arrow(90, 7, 0,, 1);
		//Bullet_Arrow(120, 7, 0, 1);
		//Bullet_Arrow(150, 7, 0, 2);
		//Bullet_Arrow(180, 7, 0, 3);
	}
	BattleData.EnemyDialog(self, BattleData.Turn() + 1, "override")
	//if time == 160 end_turn();
});

SetAttack(1, function() {
	if time == 60 Board.SetSize(8, 8, 8, 8);
	if time == 120 end_turn();
});
SetAttack(2, function() {
	if time == 1 Board.SetSize(70, 70, 150, 150, 0);
	if time == 20
	{
		Slam(270);
		//Bullet_CustomBoneWall(0, 140, [250, 150], 90, 90);
		//Bullet_CustomBoneWall(180, 140, [250, 150], 90, 90);
		//Bullet_CustomBoneWall(45, 140, [250, 150], 90, 90);
		//Bullet_CustomBoneWall(135, 140, [250, 150], 90, 90);
		repeat 4 
			Bullet_CustomBoneWall(random(360), 140, [250, 100], 90, 90,,,,,, 80);
	}
});