///@desc Enemy Drawing
//Wiggling
var E_Sprites = array_length(enemy_sprites),
	temp = enemy_sprite_wiggle,
	FinalPosition = [0, 0], FinalSprites = [], FinalIndex = [];
array_copy(FinalSprites, 0, enemy_sprites, 0, E_Sprites);
array_copy(FinalIndex, 0, enemy_sprite_index, 0, E_Sprites);

wiggle_timer = wiggle ? wiggle_timer + 1 : 0;

//Slamming
if SlammingEnabled
{
	if Slamming {
		SlamTimer++;
		var _slam_dir = SlamDirection / 90;
		if SlamTimer
			FinalSprites[SlamSpriteNumber] = SlamSprites[_slam_dir, SlamSpriteIndex];
		if SlamTimer and SlamTimer < 25
			FinalIndex[SlamSpriteNumber] = SlamSpriteTargetIndex[_slam_dir, SlamTimer / 5];
	}
	if SlamTimer == 25 Slamming = false;
	if !Slamming
	{
		SlamTimer = 0;
		array_copy(FinalSprites, 0, enemy_sprites, 0, E_Sprites);
		array_copy(FinalIndex, 0, enemy_sprite_index, 0, E_Sprites);
	}
}

for (var i = 0; i < E_Sprites; ++i) {
	if enemy_sprite_draw_method[i] == ""
	{
		draw_sprite_ext(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0],
			y + enemy_sprite_pos[i][1],
			enemy_sprite_scale[i][0], enemy_sprite_scale[i][1],
			0, c_white, image_alpha);
		break;
	}
	__CoalitionEngineError(array_length(temp[i]) < 5, string("Amount of arguments supplied in the array 'enemy_sprite_wiggle' on the {0}th dimension is incorrect, expected 5 got {1}", i, array_length(enemy_sprite_pos[i])));
	if temp[i][0] == "sin"
		FinalPosition = [
				sin(wiggle_timer * temp[i][1]) * temp[i][3],
				sin(wiggle_timer * temp[i][2]) * temp[i][4]
			]
	if temp[i][0] == "cos"
		FinalPosition = [
				cos(wiggle_timer * temp[i][1]) * temp[i][3],
				cos(wiggle_timer * temp[i][2]) * temp[i][4]
			]
	if enemy_sprite_draw_method[i] == "ext"
		draw_sprite_ext(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0] + FinalPosition[0],
			y + enemy_sprite_pos[i][1] + FinalPosition[1],
			enemy_sprite_scale[i][0], enemy_sprite_scale[i][1],
			0, c_white, image_alpha);
	if enemy_sprite_draw_method[i] == "pos"
	{
		__CoalitionEngineError(array_length(enemy_sprite_pos[i]) < 8, string("Amount of arguments supplied in the array 'enemy_sprite_pos' on the {0}th dimension is incorrect, expected 8 got {1}", i, array_length(enemy_sprite_pos[i])));
		draw_sprite_pos(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0] + FinalPosition[0],
			y + enemy_sprite_pos[i][1] + FinalPosition[1],
			x + enemy_sprite_pos[i][2] + FinalPosition[0],
			y + enemy_sprite_pos[i][3] + FinalPosition[1],
			x + enemy_sprite_pos[i][4],
			y + enemy_sprite_pos[i][5],
			x + enemy_sprite_pos[i][6],
			y + enemy_sprite_pos[i][7],
			image_alpha);
	}
}


//Don't delete, this prevents the enemy draw inside the board
Battle_Masking_Start(true);
draw_rectangle_color(x - enemy_max_width / 2, y - enemy_total_height,
	x + enemy_max_width / 2, y, c_black, c_black, c_black, c_black, 0);
Battle_Masking_End();
