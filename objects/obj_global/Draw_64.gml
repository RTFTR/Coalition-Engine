if quit_timer >= 1
	draw_sprite_ext(spr_quit_msg, quit_timer / 14, 4, 4, 2, 2, 0, c_white, quit_timer / 15);

draw_set_color(fader_color);
draw_set_alpha(fader_alpha);
draw_rectangle(0, 0, 640, 480, false);

draw_set_color(c_white);
draw_set_alpha(1);

