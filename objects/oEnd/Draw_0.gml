TextY -= .5;

draw_set_font(fnt_cot);
draw_set_halign(fa_center)
draw_text(320, TextY, text);
if TextY == -200
game_restart();