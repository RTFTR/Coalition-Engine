function Battle_SetMenuDialog(text)
{
	with(obj_battle_controller)
	{
		text_writer = scribble("* " + text);
		if text_writer.get_page() != 0 text_writer.page(0);
	}
}


function Set_BoardSize(up = 65, down = 65, left = 283, right = 283, time = 15, ease = EaseOutQuad)
{
	var board = obj_battle_board;
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "up", board.up, up);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "down", board.down,down);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "left", board.left, left);
	TweenFire(board, ease, TWEEN_MODE_ONCE, false, 0, time, "right", board.right, right);
}

function Soul_Hurt(dmg = 1,kr = 1)
{
	if !global.inv and obj_battle_soul.visible
	{
		sfx_play(snd_hurt);
		global.inv = global.assign_inv + global.player_inv_boost;
			
		{
			global.hp -= dmg;
			if global.hp > 1 global.kr += kr;
		}
			
		if hit_destroy instance_destroy();
	}
}

function Battle_Masking_Start(spr = false) {
	
	var board = obj_battle_board;
	if instance_exists(board) and depth >= board.depth
	{
		var shader = spr ? shd_clip_mask_spr : shd_clip_mask;
	
		shader_set(shader);
		var u_mask = shader_get_sampler_index(shader, "u_mask");
	
		texture_set_stage(u_mask, surface_get_texture(board.surface));
		var u_rect = shader_get_uniform(shader, "u_rect");
		
		var window_width = 640;
		var window_height = 480;
		shader_set_uniform_f(u_rect, 0, 0, window_width, window_height);
	}


}

function Battle_Masking_End(){
	var board = obj_battle_board;
	if instance_exists(board) shader_reset();
}

