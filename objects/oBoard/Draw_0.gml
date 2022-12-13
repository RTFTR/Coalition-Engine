var _color = image_blend,
	_angle = image_angle,
	_alpha = image_alpha;

if !surface_exists(surface) surface = surface_create(640, 480);

surface_set_target(surface);
draw_clear_alpha(c_white, 0);
draw_clear_alpha(c_black, 0);
draw_sprite_ext(sprPixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, c_white, _alpha);
surface_reset_target()

var _frame_x = frame_x,
	_frame_y = frame_y,
	_frame_w = frame_w,
	_frame_h = frame_h;

for (var i = 0; i < 4; ++i)
	draw_sprite_ext(sprPixel, 0, _frame_x[i], _frame_y[i], _frame_w[i], _frame_h[i], _angle, _color, _alpha);

//Drawing of the Cover Board
for (var i = 0, n = instance_number(oBoardCover); i < n; ++i) {
	var BoardCoverID = instance_find(oBoardCover, i),
		l5d = [lengthdir_x(5, image_angle), lengthdir_y(5, image_angle)];
	
	draw_surface_part(BoardCoverID.surface, bg_x, bg_y, bg_w + 10, bg_h + 10,
						x - lengthdir_x(bg_w / 2, image_angle) - l5d[0],
						y - lengthdir_x(bg_h / 2, image_angle) - l5d[1]);
}

image_blend = _color;
image_angle = _angle;
image_alpha = _alpha;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;
