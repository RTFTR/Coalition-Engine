var _color = image_blend;
var _angle = image_angle;
var _alpha = image_alpha;

if !surface_exists(surface) surface = surface_create(640, 480);
	
surface_set_target(surface);
draw_clear_alpha(c_white, 0);
draw_clear_alpha(c_black, 0);
draw_sprite_ext(spr_pixel, 0, bg_x, bg_y, bg_w, bg_h, _angle, c_white, _alpha);
surface_reset_target()

var _frame_x = frame_x;
var _frame_y = frame_y;
var _frame_w = frame_w;
var _frame_h = frame_h;

draw_sprite_ext(spr_pixel, 0, _frame_x[0], _frame_y[0], _frame_w[0], _frame_h[0], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[1], _frame_y[1], _frame_w[1], _frame_h[1], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[2], _frame_y[2], _frame_w[2], _frame_h[2], _angle, _color, _alpha);
draw_sprite_ext(spr_pixel, 0, _frame_x[3], _frame_y[3], _frame_w[3], _frame_h[3], _angle, _color, _alpha);

image_blend = _color;
image_angle = _angle;
image_alpha = _alpha;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;

