//====================================================================
#region Default Settings  -  Change them if you want.

global.__OL_cache = {
	line_width	  : 1.0,		// line_width
	line_col	  : c_black,	// line_col
	line_alpha	  : 1.0,		// line_alpha
	tolerance	  : 0.0,		// tolerance
	resolution	  : 1.0,		// resolution
	roundness	  : 1.0,		// roundness
	uv_bound_mode : true,		// uv_bound_mode
}

#endregion
//====================================================================


//====================================================================
#region INTERTAL


global.__OL_cache.__outline_compatible = false;

if (shaders_are_supported()) {
	if (shader_is_compiled(__shd_outline)) {
		global.__OL_cache.__outline_compatible = true;
	}
}

/// @desc Outline system internal function
function __internal_outline_init() {
	if (is_struct(self)) {
		if (!variable_struct_exists(self, "__outline_uniforms_initiated")) {
			__u_outline_line_color	= shader_get_uniform(__shd_outline, "u_line_color");
			__u_outline_pixel_size	= shader_get_uniform(__shd_outline, "u_pixel_size");
			__u_outline_thickness	= shader_get_uniform(__shd_outline, "u_thickness");
			__u_outline_roundness	= shader_get_uniform(__shd_outline, "u_roundness");
			__u_outline_tolerance	= shader_get_uniform(__shd_outline, "u_tolerance");
			__u_outline_uv			= shader_get_uniform(__shd_outline, "u_uv");
				
			variable_struct_set(self, "__outline_uniforms_initiated", true);
		};
		return; // Avoid checking for an instance variable latter
	}
	
	if (!variable_instance_exists(id, "__outline_uniforms_initiated")) {
		__u_outline_line_color	= shader_get_uniform(__shd_outline, "u_line_color");
		__u_outline_pixel_size	= shader_get_uniform(__shd_outline, "u_pixel_size");
		__u_outline_thickness	= shader_get_uniform(__shd_outline, "u_thickness");
		__u_outline_roundness	= shader_get_uniform(__shd_outline, "u_roundness");
		__u_outline_tolerance	= shader_get_uniform(__shd_outline, "u_tolerance");
		__u_outline_uv			= shader_get_uniform(__shd_outline, "u_uv");
				
		variable_instance_set(id, "__outline_uniforms_initiated", true);
	};
};

function __internal_outline_start() {
	if (shader_current() != __shd_outline) && (global.__OL_cache.__outline_compatible) {
		shader_set(__shd_outline);	
	};
};

/// @desc Outline system internal function
function __internal_outline_set_uniforms(_texture, _uv, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd) {
	
	var _w = texture_get_texel_width(_texture);
	var _h = texture_get_texel_height(_texture);
	
	var _color = [
		colour_get_red(_col)/255,
		colour_get_green(_col)/255,
		colour_get_blue(_col)/255,
		_alpha,
	];
	
	shader_set_uniform_f_array(__u_outline_line_color, _color);
	shader_set_uniform_f_array(__u_outline_pixel_size, [_w*(1.0/_res), _h*(1.0/_res)]);
	shader_set_uniform_f(__u_outline_thickness, _thick*_res);
	shader_set_uniform_f(__u_outline_roundness, _round);
	shader_set_uniform_f(__u_outline_tolerance, _tol);
	shader_set_uniform_f(__u_outline_uv, _uv[0], _uv[1], _uv[2], _uv[3]);
};

// Not so internal but I don't wanna create another region
function outline_end() {
	shader_reset();
};

#endregion
//====================================================================


//====================================================================
#region TEXT FUNCTIONS


/// @desc	Set the outline shader for the next draw texts.
/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_set_text(_thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	__internal_outline_init();
	__internal_outline_start();
	var _font = draw_get_font();
	var _texture = font_get_texture(_font);
	var _uv = _uv_bnd ? font_get_uvs(_font) : [0.0, 0.0, 1.0, 1.0];
	__internal_outline_set_uniforms(_texture, _uv, _thick, _col, _alpha, _tol, _res, _round, _uv);
}


/// @desc	Create a baked sprite with an string outlined.
/// @arg font			= The font that will be used with the outline.
/// @arg string			= The string to be writen.
/// @arg colour			= The color of the string.
/// @arg alpha			= The alpha of the string.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_create_sprite_text(_font, _string, _str_col, _str_alpha, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	
	var _cur_font = draw_get_font();
	var _cur_shad = shader_current();
	
	if (_cur_font != _font) {
		draw_set_font(_font);
	}
	if (_cur_shad) {
		shader_reset();
	}
		
	var _halign = draw_get_halign();
	var _valign = draw_get_valign();
	var _str_w = string_width(_string);
	var _str_h = string_height(_string);
	var _xx = 0;
	var _yy = 0;
	
	switch (_halign) {
		case fa_center: {_xx = _str_w*0.5}	break;
		case fa_right:  {_xx = _str_w}		break;
	}
	switch (_valign) {
		case fa_middle: {_yy = _str_h*0.5}	break;
		case fa_bottom: {_yy = _str_h}		break;
	}
	
	var _gap = max(_thick, 0);
	var _wid = _str_w+(_gap*2);
	var _hei = _str_h+(_gap*2);
	var _surf1, _surf2, _surf_spr;
	
	_surf1= surface_create(_wid, _hei);
	surface_set_target(_surf1);
		draw_clear_alpha(0, 0);
		draw_text(_xx+_gap, _yy+_gap, _string);
	surface_reset_target();
	
	_surf2 = surface_create(_wid, _hei)
	outline_set_surface(_surf2, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	surface_set_target(_surf2);
		draw_clear_alpha(0, 0);
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		draw_surface_ext(_surf1, 0, 0, 1, 1, 0, _str_col, _str_alpha);
		gpu_set_blendmode(bm_normal);
	surface_reset_target();
	outline_end();
	
	_surf_spr = sprite_create_from_surface(_surf2, 0, 0, _wid, _hei, false, false, _gap+_xx, _gap+_yy);
	
	if (_cur_font != _font) {
		draw_set_font(_cur_font);
	}
	if (_cur_shad) {
		shader_set(_cur_shad);
	}
	
	surface_free(_surf1);
	surface_free(_surf2);
	
	return _surf_spr;
}


/// @desc	Create a baked sprite with an string outlined with extra formating.
/// @arg font			= The font that will be used with the outline.
/// @arg string			= The string to be writen.
/// @arg sep			= The distance in pixels between lines of text.
/// @arg w				= The maximum withd in pixels of the string before a line break.
/// @arg colour			= The color of the string.
/// @arg alpha			= The alpha of the string.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_create_sprite_text_ext(_font, _string, _sep, _w, _str_col, _str_alpha, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	
	var _cur_font = draw_get_font();
	var _cur_shad = shader_current();
	
	if (_cur_font != _font) {
		draw_set_font(_font);
	}
	if (_cur_shad) {
		shader_reset();
	}
		
	var _halign = draw_get_halign();
	var _valign = draw_get_valign();
	
	var _extra_lines = 4;
	var _gap = max(_thick, 0);
	var _str_w = string_width(_string);
	var _lines = floor(_str_w/_w);
	var _wid = (_str_w/_lines)+(2*_gap);
	var _hei = ((_lines+_extra_lines)*_sep)+(2*_gap);
	var _surf1, _surf2, _surf_spr;
	
	var _xx = 0;
	var _yy = 0;
	
	switch (_halign) {
		case fa_center: {_xx = (_str_w/_lines)*0.5}	break;
		case fa_right:  {_xx = (_str_w/_lines)}		break;
	}
	switch (_valign) {
		case fa_middle: {_yy = ((_lines+_extra_lines)*_sep)*0.5}	break;
		case fa_bottom: {_yy = ((_lines+_extra_lines)*_sep)	}		break;
	}
	
	_surf1= surface_create(_wid, _hei);
	surface_set_target(_surf1);
		draw_clear_alpha(0, 0);
		draw_text_ext(_xx+_gap, _yy+_gap, _string, _sep, _w);
	surface_reset_target();
	
	_surf2 = surface_create(_wid, _hei)
	outline_set_surface(_surf2, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	surface_set_target(_surf2);
		draw_clear_alpha(0, 0);	
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		draw_surface_ext(_surf1, 0, 0, 1, 1, 0, _str_col, _str_alpha);
		gpu_set_blendmode(bm_normal)
	surface_reset_target();
	outline_end();
	
	_surf_spr = sprite_create_from_surface(_surf2, 0, 0, _wid, _hei, false, false, _gap+_xx, _gap+_yy);
	
	if (_cur_font != _font) {
		draw_set_font(_cur_font);
	}
	if (_cur_shad) {
		shader_set(_cur_shad);
	}
	
	surface_free(_surf1);
	surface_free(_surf2);
	
	return _surf_spr;
}


/// @desc	Draw an outlined text.
/// @arg x				= The X coordinate of the text.
/// @arg y				= The Y coordinate of the text.
/// @arg string			= The string to be drawed.
/// @arg colour			= The color of the string.
/// @arg alpha			= The alpha of the string.
/// @arg scale			= The scale of the string.
/// @arg angle			= The angle of the string.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_text(_x, _y, _string, _strcol, _str_alpha, _scal, _ang, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	var _halign = draw_get_halign();
	var _valign = draw_get_valign();
	var _str_w = string_width(_string);
	var _str_h = string_height(_string);
	var _xx = 0;
	var _yy = 0;
	
	switch (_halign) {
		case fa_center: {_xx = _str_w*0.5}	break;
		case fa_right:  {_xx = _str_w}		break;
	}
	switch (_valign) {
		case fa_middle: {_yy = _str_h*0.5}	break;
		case fa_bottom: {_yy = _str_h}		break;
	}
	
	var _gap = max(_thick, 0);	
	var _wid = _str_w+(2*_gap);
	var _hei = _str_h+(2*_gap);
	
	var _surf = surface_create(_wid, _hei);
	surface_set_target(_surf);
		draw_clear_alpha(0, 0);
		var _cur_shader = shader_current();
		shader_reset();
		draw_text_color(_xx+_gap, _yy+_gap, _string, c_white, c_white, c_white, c_white, 1.0);
		shader_set(_cur_shader);
	surface_reset_target();
	
	outline_draw_surface_ext(_surf, _x-(_gap+_xx)*_scal, _y-(_gap+_yy)*_scal, _scal, _scal, _ang, _strcol, _str_alpha, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	surface_free(_surf);
	outline_end();
}


/// @desc	Draw an outlined text with extra formating.
/// @arg x				= The X coordinate of the text.
/// @arg y				= The Y coordinate of the text.
/// @arg string			= The string to be drawed.
/// @arg sep			= The distance in pixels between lines of text.
/// @arg w				= The maximum withd in pixels of the string before a line break.
/// @arg colour			= The color of the string.
/// @arg alpha			= The alpha of the string.
/// @arg scale			= The scale of the string.
/// @arg angle			= The angle of the string.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_text_ext(_x, _y, _string, _sep, _w, _strcol, _stralpha, _scal, _ang, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	var _halign = draw_get_halign();
	var _valign = draw_get_valign();
	
	var _extra_lines = 4;
	var _gap = max(_thick, 0);
	var _str_w = string_width(_string);
	var _lines = floor(_str_w/_w);
	var _wid = (_str_w/_lines)+(2*_gap);
	var _hei = ((_lines+_extra_lines)*_sep)+(2*_gap);
	
	var _xx = 0;
	var _yy = 0;
	
	switch (_halign) {
		case fa_center: {_xx = (_str_w/_lines)*0.5}	break;
		case fa_right:  {_xx = (_str_w/_lines)}		break;
	}
	switch (_valign) {
		case fa_middle: {_yy = ((_lines+_extra_lines)*_sep)*0.5}	break;
		case fa_bottom: {_yy = ((_lines+_extra_lines)*_sep)	}		break;
	}
	
	var _surf = surface_create(_wid, _hei);
	surface_set_target(_surf);
		draw_clear_alpha(0, 0);
		var _cur_shader = shader_current();
		shader_reset();
		draw_text_ext(_xx+_gap, _yy+_gap, _string, _sep, _w);
		shader_set(_cur_shader);
	surface_reset_target();
	
	outline_draw_surface_ext(_surf, _x-(_gap+_xx)*_scal, _y-(_gap+_yy)*_scal, _scal, _scal, _ang, _strcol, _stralpha, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	surface_free(_surf);
}

#endregion
//====================================================================


//====================================================================
#region SPRITE FUNCTIONS


/// @desc	Set the outline shader for the next draw sprite.
/// @arg sprite			= The sprite to be drawned.
/// @arg subimg			= The subimg of the sprite to be used.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_set_sprite(_spr, _subimg, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	__internal_outline_init();
	__internal_outline_start();
	var _texture = sprite_get_texture(_spr, _subimg);
	var _uv = _uv_bnd ? sprite_get_uvs(_spr, _subimg) : [0.0, 0.0, 1.0, 1.0];
	__internal_outline_set_uniforms(_texture, _uv, _thick, _col, _alpha, _tol, _res, _round, _uv);
	return _spr;
}

/// @desc	Create a baked sprite with outline.
/// @arg sprite			= The sprite to be drawned.
/// @arg col			= The color of the sprite.
/// @arg alpha			= The alpha of the sprite.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_create_sprite(_spr, _spr_col, _spr_alpha, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	
	var _cur_shad = shader_current();
	if (_cur_shad) {
		shader_reset();
	}
	
	var _gap = max(_thick, 0);
	var _wid = sprite_get_width(_spr)+_gap*2;
	var _hei = sprite_get_height(_spr)+_gap*2;
	var _x = sprite_get_xoffset(_spr);
	var _y = sprite_get_yoffset(_spr);
	
	var _surf1 = surface_create(_wid, _hei);
	var _surf2 = surface_create(_wid, _hei);
	var _surf_spr = -1;
	
	for (var i = 0, n = sprite_get_number(_spr); i < n; i++) {
		surface_set_target(_surf1);
			draw_clear_alpha(0, 0);
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			draw_sprite(_spr, i, _x+_gap, _y+_gap);
			gpu_set_blendmode(bm_normal)
		surface_reset_target();
		
		outline_set_surface(_surf2, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
		surface_set_target(_surf2);
			draw_clear_alpha(0, 0);
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			draw_surface_ext(_surf1, 0, 0, 1, 1, 0, _spr_col, _spr_alpha);
			gpu_set_blendmode(bm_normal)
		surface_reset_target();
		outline_end();
		
		if !(sprite_exists(_surf_spr)) {
			_surf_spr = sprite_create_from_surface(_surf2, 0, 0, _wid, _hei, false, false, _gap, _gap);
		} else {
			sprite_add_from_surface(_surf_spr, _surf2, 0, 0, _wid, _hei, false, false);
		}
	}
	sprite_set_offset(_surf_spr, _x+_gap, _y+_gap);
	
	if (_cur_shad) {
		shader_set(_cur_shad);
	}
	
	surface_free(_surf1);
	surface_free(_surf2);
	
	return _surf_spr;
}

/// @desc	Draw an outlined sprite.
/// @arg sprite			= The sprite to be drawned.
/// @arg subimg			= The subimg of the sprite to be used.
/// @arg x				= The X coordinate of the sprite.
/// @arg y				= The Y coordinate of the sprite.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_sprite(_spr, _subimg, _x, _y, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	outline_set_sprite(_spr, _subimg, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	draw_sprite(_spr, _subimg, _x, _y);
	outline_end();
}

/// @desc	Draw an outlined sprite with extra formating.
/// @arg sprite			= The sprite to be drawned.
/// @arg subimg			= The subimg of the sprite to be used.
/// @arg x				= The X coordinate of the sprite.
/// @arg y				= The Y coordinate of the sprite.
/// @arg xscale			= The horizontal scaling of the sprite.
/// @arg yscale			= The vertical scaling of the sprite.
/// @arg rot			= The rotation of the sprite.
/// @arg colour			= The color of the sprite.
/// @arg alpha			= The alpha of the sprite.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_sprite_ext(_spr, _subimg, _x, _y, _xscal, _yscal, _rot, _spr_col, _spr_alpha, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {
	outline_set_sprite(_spr, _subimg, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	draw_sprite_ext(_spr, _subimg, _x, _y, _xscal, _yscal, _rot, _spr_col, _spr_alpha);
	outline_end();
}

#endregion
//====================================================================


//====================================================================
#region SURFACE FUNCTIONS


/// @desc	Set the outline shader for the next draw surface.
/// @arg surface_id		= The surface to be drawned.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_set_surface(_surf, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {	
	__internal_outline_init();
	__internal_outline_start();
	var _texture = surface_get_texture(_surf);
	var _uv = _uv_bnd ? texture_get_uvs(_texture) : [0.0, 0.0, 1.0, 1.0];
	__internal_outline_set_uniforms(_texture, _uv, _thick, _col, _alpha, _tol, _res, _round, _uv);
	return _surf;
}

/// @desc	Draw an outlined surface.
/// @arg surface_id		= The surface to be drawned.
/// @arg x				= The X coordinate of the surface.
/// @arg y				= The Y coordinate of the surface.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_surface(_surf, _x, _y, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {	
	outline_set_surface(_surf, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	draw_surface(_surf, _x, _y);
	outline_end();
}

/// @desc	Draw an outlined surface with extra formating.
/// @arg surface_id		= The surface to be drawned.
/// @arg x				= The X coordinate of the surface.
/// @arg y				= The Y coordinate of the surface.
/// @arg xscale			= The horizontal scaling of the surface.
/// @arg yscale			= The vertical scaling of the surface.
/// @arg rot			= The rotation of the surface.
/// @arg colour			= The color of the surface.
/// @arg alpha			= The alpha of the surface.

/// @arg [line_width]	= The thickness, in pixels, of the outline.
/// @arg [line_col]		= The color of the outline.
/// @arg [line_alpha]	= The alpha of the outline.
/// @arg [tolerance]	= The minimum alpha value a pixel need to become an outline.
/// @arg [resolution]	= The resolution of the outline.
/// @arg [roundness]	= The roundess factor of the outline.
/// @arg [uv_bound]		= Locks the shader on the sprite uv.
function outline_draw_surface_ext(_surf, _x, _y, _xscal, _yscal, _rot, _surf_col, _surf_alpha, _thick = global.__OL_cache.line_width, _col = global.__OL_cache.line_col, _alpha = global.__OL_cache.line_alpha, _tol = global.__OL_cache.tolerance, _res = global.__OL_cache.resolution, _round = global.__OL_cache.roundness, _uv_bnd = global.__OL_cache.uv_bound_mode) {	
	outline_set_surface(_surf, _thick, _col, _alpha, _tol, _res, _round, _uv_bnd);
	draw_surface_ext(_surf, _x, _y, _xscal, _yscal, _rot, _surf_col, _surf_alpha);
	outline_end();
}

#endregion
//====================================================================