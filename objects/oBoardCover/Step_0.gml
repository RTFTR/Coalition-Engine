image_angle += rotate;
if !surface_exists(surface) surface = surface_create(640, 480);

// Frames
var _frame_x = frame_x,
	_frame_y = frame_y,
	_frame_w = frame_w,
	_frame_h = frame_h;

// Background/Surface
point_xy(x - left, y - up);
bg_x = point_x;
bg_y = point_y;
bg_w = left + right;
bg_h = up + down;

var side_h = (up + down) + thickness_frame * 2,
	side_v = (left + right) + thickness_frame * 2;

// Top
point_xy((x - left) - thickness_frame, (y - up) - thickness_frame);
_frame_x[0] = point_x;
_frame_y[0] = point_y;
_frame_w[0] = side_v;
_frame_h[0] = thickness_frame;

// Bottom
point_xy((x - left) - thickness_frame, y + down);
_frame_x[1] = point_x;
_frame_y[1] = point_y;
_frame_w[1] = side_v;
_frame_h[1] = thickness_frame;

// Left
point_xy((x - left) - thickness_frame, (y - up) - thickness_frame);
_frame_x[2] = point_x;
_frame_y[2] = point_y;
_frame_w[2] = thickness_frame;
_frame_h[2] = side_h;

// Right
point_xy(x + right, (y - up) - thickness_frame);
_frame_x[3] = point_x;
_frame_y[3] = point_y;
_frame_w[3] = thickness_frame;
_frame_h[3] = side_h;

frame_x = _frame_x;
frame_y = _frame_y;
frame_w = _frame_w;
frame_h = _frame_h;



//Check if soul is colliding
var soul = oSoul,
	_angle = image_angle,
	//Distances from center of board
	UR = point_distance(0, 0, right, up), 
	LR = point_distance(0, 0, left, up),
	LD = point_distance(0, 0, left, down),
	RD = point_distance(0, 0, right, down),
	//Corner locations
	corners = [
		[x + (UR - 2)  * dcos(_angle - 45),  y + (UR + 10) * -dsin(_angle - 45)],
		[x + (LR - 2)  * dcos(_angle + 45),  y + (LR + 10) * -dsin(_angle + 45)],
		[x + (LD + 15) * dcos(_angle + 135), y + (LD + 10) * -dsin(_angle + 135)],
		[x + (RD + 15) * dcos(_angle + 225), y + (RD + 10) * -dsin(_angle + 225)],
	];
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