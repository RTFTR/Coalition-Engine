///Draws a surface normally (top-left origin), but rotates around the center origin
function draw_surface_rotated_ext(_surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
    var _halfW = surface_get_width(_surf) * 0.5 * _xscale,
		_halfH = surface_get_height(_surf) * 0.5 * _yscale,
    
		_rad = degtorad(_rot),
    
		_rotX = -_halfW * cos(_rad) - _halfH * sin(_rad),
		_rotY = -_halfW * -sin(_rad) - _halfH * cos(_rad),

		//If you want to *always* draw from center origin, remove `_half`s below
		_surfX = _x + _halfW + _rotX,
		_surfY = _y + _halfH + _rotY;

    draw_surface_ext(_surf, _surfX, _surfY, _xscale, _yscale, _rot, _col, _alpha);
}