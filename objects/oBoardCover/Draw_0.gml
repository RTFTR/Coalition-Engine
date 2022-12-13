var _color = image_blend,
	_angle = image_angle,
	_alpha = image_alpha;

if !surface_exists(surface) surface = surface_create(640, 480);

var _frame_x = frame_x,
	_frame_y = frame_y,
	_frame_w = frame_w,
	_frame_h = frame_h;

var soul = oSoul,
	l5d = [lengthdir_x(5, image_angle), lengthdir_y(5, image_angle - 90)],
	Distances = [
		sqrt(sqr(right)+sqr(up)),
		sqrt(sqr(left)+sqr(up)),
		sqrt(sqr(left)+sqr(down)),
		sqrt(sqr(right)+sqr(down)),
	],
	//Corner locations
	corners = [
		[x+lengthdir_x(Distances[0]-2,_angle-45),y+lengthdir_y(Distances[0]+10,_angle-45)],
		[x+lengthdir_x(Distances[1]-2,_angle+45),y+lengthdir_y(Distances[1]+10,_angle+45)],
		[x+lengthdir_x(Distances[2]+15,_angle+135),y+lengthdir_y(Distances[2]+10,_angle+135)],
		[x+lengthdir_x(Distances[3]+15,_angle+225),y+lengthdir_y(Distances[3]+10,_angle+225)],
	];

//Check if soul is colliding
contains_soul = rectangle_in_triangle(soul.x - 8, soul.y - 8, soul.x + 8, soul.y + 8,
					corners[0, 0], corners[0, 1],
					corners[1, 0], corners[1, 1],
					corners[2, 0], corners[2, 1])
				or
				rectangle_in_triangle(soul.x - 8, soul.y - 8, soul.x + 8, soul.y + 8,
					corners[1, 0], corners[1, 1],
					corners[2, 0], corners[2, 1],
					corners[3, 0], corners[3, 1])
				or
				rectangle_in_triangle(soul.x - 8, soul.y - 8, soul.x + 8, soul.y + 8,
					corners[2, 0], corners[2, 1],
					corners[3, 0], corners[3, 1],
					corners[0, 0], corners[0, 1])
				or
				rectangle_in_triangle(soul.x - 8, soul.y - 8, soul.x + 8, soul.y + 8,
					corners[3, 0], corners[3, 1],
					corners[0, 0], corners[0, 1],
					corners[1, 0], corners[1, 1])

//Draws the board
surface_set_target(surface);
draw_clear_alpha(c_white, 0);
draw_clear_alpha(c_black, 0);
draw_sprite_ext(sprPixel, 0, bg_x - l5d[0], bg_y - l5d[1], bg_w + 10, bg_h + 10, _angle, c_black, _alpha);
for (var i = 0; i < 4; ++i)
	draw_sprite_ext(sprPixel, 0, _frame_x[i], _frame_y[i], _frame_w[i], _frame_h[i], _angle, _color, _alpha);
surface_reset_target();

//Shows hitbox
if global.show_hitbox {
	draw_set_alpha(0.3);
	draw_set_color(c_red);
	draw_triangle(
		corners[0, 0], corners[0, 1],
		corners[1, 0], corners[1, 1],
		corners[2, 0], corners[2, 1],
		0);
	draw_set_color(c_green);
	draw_triangle(
		corners[1, 0], corners[1, 1],
		corners[2, 0], corners[2, 1],
		corners[3, 0], corners[3, 1], 0);
	draw_set_color(c_blue);
	draw_triangle(
		corners[2, 0], corners[2, 1],
		corners[3, 0], corners[3, 1],
		corners[0, 0], corners[0, 1], 0);
	draw_set_color(c_yellow);
	draw_triangle(
		corners[3, 0], corners[3, 1],
		corners[0, 0], corners[0, 1],
		corners[1, 0], corners[1, 1], 0);
	draw_set_color(c_white);
}

image_blend = _color;
image_angle = _angle;
image_alpha = _alpha;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;

image_xscale = right + left;
image_yscale = up + down;
