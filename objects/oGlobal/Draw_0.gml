if global.timer >= 1
{
	//if keyboard_check_pressed(vk_space) SpliceScreen(320, 240, random(360), 40, 40, 40, 5);
	//Cut screen
	var n = ds_list_size(global.sur_list), i = 0, _list;
	if n > 1 CutScreenSurface = CanvasGetAppSurf(true);
	repeat n
	{
		_list = global.sur_list[| i];
		if is_even(i) draw_clear_alpha(c_black, 1);
	
		_list[0].Start();
		shader_set(shdCutScreen);
		shader_set_uniform_f_array(CutLineStart, _list[3]);
		shader_set_uniform_f_array(CutLineEnd, _list[4]);
		shader_set_uniform_f(CutSide, is_odd(i) ? -1 : 1);
		CutScreenSurface.Draw(0, 0);
		shader_reset();
		_list[0].Finish();
		var dir = is_odd(i) ? 180 : 0,
			_x = lengthdir_x(_list[1], _list[2] + dir),
			_y = lengthdir_y(_list[1], _list[2] + dir);
		_list[0].Draw(_x, _y);
		if is_odd(i)
		{
			CutScreenSurface = CanvasGetAppSurf(true);
		}
		++i;
	}
}