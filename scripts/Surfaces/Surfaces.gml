///Draws a surface normally (top-left origin), but rotates around the center origin
function draw_surface_rotated_ext(_surf, _x, _y, _xscale, _yscale, _rot, _col, _alpha) {
	var _halfW = surface_get_width(_surf) * 0.5 * _xscale,
		_halfH = surface_get_height(_surf) * 0.5 * _yscale,
		_rotX = -_halfW * dcos(_rot) - _halfH * dsin(_rot),
		_rotY = -_halfW * -dsin(_rot) - _halfH * dcos(_rot),
		//If you want to *always* draw from center origin, remove `_half`s below
		_surfX = _x + _halfW + _rotX,
		_surfY = _y + _halfH + _rotY;
	draw_surface_ext(_surf, _surfX, _surfY, _xscale, _yscale, _rot, _col, _alpha);
}

function draw_surface_tiled_area(surface, subimg, xx, yy, x1, y1, x2, y2) {
	var left, top, width, height, X, Y,
		sw = surface_get_width(surface),
		sh = surface_get_height(surface),
		i = x1 - ((x1 % sw) - (xx % sw)) - sw * ((x1 % sw) < (xx % sw)),
		j = y1 - ((y1 % sh) - (yy % sh)) - sh * ((y1 % sh) < (yy % sh)),
		jj = j;
	for (; i <= x2; i += sw) {
		for (; j <= y2; j += sh) {
			left = (i <= x1) ? x1 - i : 0;
			X = i + left;
			top = (j <= y1) ? y1 - j : 0;
			Y = j + top;
			width = (x2 <= i + sw) ? (sw - (i + sw - x2) + 1) - left : sw - left;
			height = (y2 <= j + sh) ? (sh - (j + sh - y2) + 1) - top : sh - top;
			draw_surface_part(surface, left, top, width, height, X, Y);
		}
		j = jj;
	}
}
