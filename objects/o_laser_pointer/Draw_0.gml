/// @description Draw Laser

var x1 = x - 1;
var y1 = y - 1;
var x2 = mouse_x - 1;
var y2 = mouse_y - 1;

//script returns collision point as an array. if no collision, it returns x2 and y2 as the array.
var point = collision_line_find_nearest_point(x1, y1, x2, y2, 1, o_solid_wall, true);

//draw laser line and dot
draw_line_width_color(x1, y1, point[0], point[1], 2, c_red, c_red);
draw_circle_color(point[0], point[1], 3, c_red, c_red, false);

//draw laser pointer sprite
draw_self();