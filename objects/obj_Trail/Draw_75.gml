draw_set_color(col);
draw_set_alpha(alpha);
draw_line_width(x1, y1, x2, y2, size);
draw_circle(x2, y2, size / 2, 0);
t++;
if t = 1
	s = size;
if t > 1
	size -= 12 / (dur - 1);
if size <= 0
	instance_destroy();
draw_set_color(c_white);
draw_set_alpha(1);