var default_halign = draw_get_halign();
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(font_logo);
draw_text(320,y + 200,"Coalition\nEngine");
if hint
{
	draw_set_font(font_cot);
	draw_set_color(c_ltgray);
	draw_text(320,y + 300, "Press Z to Begin\nPress C for settings");
}

//Settings
draw_set_font(font_mnc);
draw_set_color(c_white);
var tcol =
[
	make_color_hsv(global.timer % 255, 255, 255),
	make_color_hsv((global.timer + 255 / 4) % 255, 255, 255),
	make_color_hsv((global.timer + 255 * .5) % 255, 255, 255),
	make_color_hsv((global.timer + 255 * .75) % 255, 255, 255)
];
// If you want to make the text a rotating rainbow color, do tcol[0], tcol[1]...
draw_text_transformed_color(320, y + 485, "Settings", 2, 2, 0,
							tcol[0], tcol[3], tcol[3], tcol[0], 1);
for (var i = 0, n = array_length(setting_name); i < n; ++i)
{
	var dy = y + 480 + 120;
	var col = c_white;
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if i == setting col = c_yellow;
	draw_set_color(col);
	draw_text(0, dy + i * 40, setting_name[i]);
	draw_set_halign(fa_right);
	draw_text(640, dy + i * 40, setting_var[i]);
	draw_set_color(c_white);
}
var input = input_check_pressed("right") - input_check_pressed("left");
var input_v = input_check_pressed("down") - input_check_pressed("up");
setting += input_v;
setting = Posmod(setting, array_length(setting_name));
if input != 0 sfx_play(snd_menu_switch);

if setting == 0 setting_var[0] += input * 5;
if setting == 1 setting_var[1] += input * 5;

setting_var[0] = clamp(setting_var[0], 0, 100);
setting_var[1] = clamp(setting_var[1], 0, 150);


audio_master_gain(setting_var[0] / 100);
obj_global.effect_param[0, 1] = setting_var[1] / 100;


draw_set_halign(default_halign);
var SettingsY = is_setting * -480;
var RainbowY = .5 - is_setting * 3;
y = lerp(y, SettingsY, 0.2);
RainbowFuture.y_offset0 = lerp(RainbowFuture.y_offset0, RainbowY, 0.2);

Effect_SetParam(shd_Noise, "seed", random(100))

