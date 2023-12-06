///@desc Set attacks
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
	}
	BattleData.EnemyDialog(self, BattleData.Turn() + 1, "override")
	//if time == 160 end_turn();
});

SetAttack(1, function() {
	if time == 60 Board.SetSize(8, 8, 8, 8);
	if time == 120 end_turn();
});