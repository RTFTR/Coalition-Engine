var default_halign = draw_get_halign();
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(fnt_logo);
//draw_text(320, y + 200,"Coalition\nEngine");
draw_text(320, y + 200,"UNDERTALE");
hint += 1/60;
if hint
{
	draw_set_font(fnt_cot);
	draw_set_color(c_ltgray);
	draw_text(320,y + 300, "Press Z to Begin\nPress C for settings");
}

//Settings
draw_set_font(fnt_mnc);
draw_set_color(c_white);
var tcol =
[
	make_color_hsv(global.timer % 255, 255, 255),
	make_color_hsv((global.timer + 255 * .25) % 255, 255, 255),
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
	if i == 0
	{
		draw_set_color(c_red);
		draw_rectangle(300,dy,400,dy+15,0);
		draw_set_color(c_yellow);
		draw_rectangle(300,dy,300+audio_get_master_gain(0)*100,dy+15,0);
	}
	draw_set_color(c_white);
}
var input = input_check_pressed("right") - input_check_pressed("left"),
	input_v = input_check_pressed("down") - input_check_pressed("up"),
	InputH_h = input_check("right") - input_check("left"),
	InputH_v = input_check("down") - input_check("up")
if is_setting
{
	setting += input_v;
	setting = Posmod(setting, array_length(setting_name));
	if input != 0 audio_play(snd_menu_switch);

	if setting == 0 setting_var[0] += InputH_h;
	if setting == 1 setting_var[1] += input;
}
setting_var[0] = clamp(setting_var[0], 0, 100);
setting_var[1] = clamp(setting_var[1], 0, 1);
setting_var[1] = 1;
global.easy = setting_var[1];
global.easy = 1;

global.Volume = setting_var[0];
Save_Settings();

audio_master_gain(setting_var[0] / 100);


draw_set_halign(default_halign);
var SettingsY = is_setting * -480;
var RainbowY = .5 - is_setting * 3;
y = lerp(y, SettingsY, 0.2);
if instance_exists(RainbowFuture)
	RainbowFuture.y_offset0 = lerp(RainbowFuture.y_offset0, RainbowY, 0.2);

Effect_SetParam(shdNoise, "seed", random(100));

var col = merge_color(c_white, make_color_hsv(global.timer % 255, 255, 255),0.65);
draw_cube_width(320,y+100,40-cos(global.timer/35)*10,sin(degtorad(global.timer)),cos(degtorad(global.timer)),col,3)
draw_cube_width(320,y+100,20-cos(global.timer/35)*10,sin(degtorad(global.timer)*1.4),-cos(degtorad(global.timer)*.6),col,3)

