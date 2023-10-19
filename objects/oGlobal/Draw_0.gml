//Cut screen
CutScreenSurface.Start();
draw_surface(application_surface, 0, 0);
CutScreenSurface.Finish();
var i = 0, n = ds_list_size(global.sur_list), _list;
repeat n
{
	_list = global.sur_list[| i];
	if i == 0 or is_even(i)
		draw_clear(c_black);
	
	_list[0].Start();
	shader_set(shdCutScreen);
	var ls = shader_get_uniform(shdCutScreen, "u_lineStart"),
		le = shader_get_uniform(shdCutScreen, "u_lineEnd"),
		sd = shader_get_uniform(shdCutScreen, "u_side");
	shader_set_uniform_f_array(ls, _list[3]);
	shader_set_uniform_f_array(le, _list[4]);
	shader_set_uniform_f(sd, is_odd(i) ? -1 : 1);
	CutScreenSurface.Draw(0, 0);
	shader_reset();
	_list[0].Finish();
	var dir = is_odd(i) ? 180 : 0,
		_x = _list[1] * dcos(_list[2] + dir),
		_y = _list[1] * -dsin(_list[2] + dir);
	_list[0].Draw(_x, _y);
	
	if is_odd(i)
	{
		CutScreenSurface.Start();
		draw_surface(application_surface, 0, 0);
		CutScreenSurface.Finish();
	}
	++i;
}

