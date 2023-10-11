///@desc Sets the size of the board with Anim (optional)
///@param {real} up			The Disatance Upwards (Default 65)
///@param {real} down		The Disatance Downards (Default 65)
///@param {real} left		The Disatance Leftwards (Default 283)
///@param {real} right		The Disatance Rightwards (Default 283)
///@param {real} time		The duration of the Anim (0 = instant, Default 30)
///@param {function} ease		The Tween Ease of the Anim, use TweenGMS Easing (i.e. EaseLinear, Default EaseOutQuad)
function Set_BoardSize(up = 65, down = 65, left = 283, right = 283, time = 30, ease = EaseOutQuad, board = oBoard)
{
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "up", board.up, up);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "down", board.down,down);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "left", board.left, left);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "right", board.right, right);
}

///@desc Sets the angle of the board with Anim (optional)
///@param {real} angle		The target angle (Default 0)
///@param {real} time		The duration of the Anim (0 = instant, Default 30)
///@param {function} ease		The Tween Ease of the Anim, use TweenGMS Easing (i.e. EaseLinear, Default EaseOutQuad)
function Set_BoardAngle(angle = 0, time = 30, ease = EaseOutQuad, board = oBoard)
{
	with board
		TweenEasyRotate(image_angle, angle, 0, time, ease);
}

///@desc Sets the x and y position of the board
///@param {real} x	The x position
///@param {real} y	The y position
///@param {real} time	The time taken for the anim
///@param {function} ease	The easing
function Set_BoardPos(xx = 320, yy = 320, time = 30, ease = EaseOutQuad, board = oBoard)
{
	with board
		TweenEasyMove(x, y, xx, yy, 0, time, ease)
}
///Resets the board state to default
///@param {bool} angle_div	Whether the angle of the board be fixed between -90 < x < 90 or not
function ResetBoard(anglediv = true) {
	Set_BoardSize();
	if anglediv oBoard.image_angle %= 90;
	Set_BoardAngle();
	Set_BoardPos();
}

function Set_GreenBox()
{
	Set_BoardAngle();
	Set_BoardSize(42, 42, 42, 42, 20);
	Set_BoardPos(320, 240, 20);
}

///@desc Deals damage to the soul
///@param {real} dmg	The Damage to Yellow HP (Default 1)
///@param {real} kr		The Damage to Purple KR (Default 1)
function Soul_Hurt(dmg = global.damage,kr = global.krdamage)
{
	if !global.inv and can_hurt
	{
		audio_play(snd_hurt);
		global.inv = global.assign_inv + global.player_inv_boost;
		global.hp -= dmg;
		if global.hp > 1 global.kr += kr;
			
		if hit_destroy instance_destroy();
	}
}

function Slam(direction, move = 20, hurt = false)
{
	direction = posmod(direction,360);
	oEnemyParent.Slamming = true;
	oEnemyParent.SlamDirection = direction;
	Battle_SoulMode(SOUL_MODE.BLUE);
	global.slam_power = move;
	global.slam_damage = hurt;
	with oSoul
	{
		dir = direction;
		image_angle = (direction + 90) % 360
		fall_spd = move;
		slam = 1;
	}
}

function Battle_Masking_Start(spr = false, board = oBoard) {
	if oGlobal.camera_enable_z exit;
	if instance_exists(board) and depth >= board.depth
	{
		var shader = spr ? shdClipMaskSpr : shdClipMask;
	
		shader_set(shader);
		var u_mask = shader_get_sampler_index(shader, "u_mask");
	
		texture_set_stage(u_mask, surface_get_texture(board.surface));
		var u_rect = shader_get_uniform(shader, "u_rect");
		
		var window_width = 640,
			window_height = 480;
		shader_set_uniform_f(u_rect, 0, 0, window_width, window_height);
	}
}

function Battle_Masking_End(board = oBoard){
	if oGlobal.camera_enable_z exit;
	if instance_exists(board) shader_reset();
}

function Battle() constructor
{
	///@desc Gets/Sets the turn of the battle
	///@param {real} turn The turn to set it to
	static Turn = function(turn = infinity) {
		if turn != infinity
			oBattleController.battle_turn = turn + 1;
		else return oBattleController.battle_turn - 1;
	}
	///@desc Gets/Sets the State of the battle
	///@param {real} state	The state to set it to
	static State = function(state = infinity) {
		if state != infinity
			oBattleController.battle_state = state;
		else return instance_exists(oBattleController) ? oBattleController.battle_state : -1;
	}
	///@desc Sets the menu dialog of the battle
	///@param {string} text The Menu text
	static SetMenuDialog = function(text) {
		with oBattleController
		{
			__text_writer = scribble("* " + text);
			if __text_writer.get_page() != 0 __text_writer.page(0);
		}
	}
	/**
		Sets the size of the board with Anim (optional)
		@param {real} up			The Disatance Upwards (Default 65)
		@param {real} down		The Disatance Downards (Default 65)
		@param {real} left		The Disatance Leftwards (Default 283)
		@param {real} right		The Disatance Rightwards (Default 283)
		@param {real} time		The duration of the Anim (0 = instant, Default 30)
		@param {function} ease		The Tween Ease of the Anim, use TweenGMS Easing (i.e. EaseLinear, Default EaseOutQuad)
	*/
	static SetBoardSize = function(up = 65, down = 65, left = 283, right = 283, time = 30, ease = EaseOutQuad, board = oBoard)
	{
		TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "up", board.up, up,
				"down", board.down, down, "left", board.left, left, "right", board.right, right);
	}
	/**
		This sets the dialog of the enemy
		@param {Asset.GMObject}	enemy	The enemy of the dialog is assigned to
		@param {real}	turn	The turn of the dialog to set to
		@param {string} text	The text of the dialog
	*/
	static EnemyDialog = function(enemy, turn, text) {
		with enemy
		{
			if !is_array(text) dialog_text[turn] = text;
			else dialog_text = text;
			dialog_init(dialog_text[oBattleController.battle_turn]);
		}
	}
}

///@desc Sets the sprite of the buttons with external images
///@param {string} FileName	Folder name of the sprites (Default Normal)
///@param {string} Format	Format of the sprites (Default .png)
function ButtonSprites(fname = "Normal", format = ".png")
{
	for (var i = 0, buttons, ButtonNames = ["Fight", "Act", "Item", "Mercy"]; i < 4; ++i) {
		buttons[i] = sprite_add("./Sprites/Buttons/"+ fname + "/" + ButtonNames[i] + format, 2, 0, 0, 55, 21);
	}
	with oBattleController
	{
		Button.Sprites = buttons;
	}
}