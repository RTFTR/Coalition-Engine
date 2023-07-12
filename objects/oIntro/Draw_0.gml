var logo_state = (menu_state == INTRO_MENU_STATE.LOGO),
	first_time = (menu_state == INTRO_MENU_STATE.FIRST_TIME),
	naming_states = (menu_state == INTRO_MENU_STATE.NAMING) 
				or (menu_state == INTRO_MENU_STATE.NAME_CHECKING) 
				or (menu_state == INTRO_MENU_STATE.NAME_CONFIRM);
	

if logo_state
{
	var default_halign = draw_get_halign();
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_set_font(fnt_logo);
	draw_text_transformed(Titlepos[0], Titlepos[1], LogoText, TitleScale, TitleScale, 0);
	draw_set_font(fnt_cot);
	
	if hint
	{
		draw_set_color(c_ltgray);
		draw_text(DescX, 300, "[PRESS Z OR ENTER]");
	}
	
	draw_set_color(c_white);
	draw_set_halign(default_halign);
}

else if first_time
{
	var default_halign = draw_get_halign();
	draw_set_color(c_ltgray);
	draw_set_font(fnt_dt_sans);
	
	var instruction_label = "--- Instruction ---",
		instruction_text = "[Z or ENTER] - Confirm";
		instruction_text += "\n[X or SHIFT] - Cancel";
		instruction_text += "\n[C or CTRL] - Menu (In-game)";
		instruction_text += "\n[F4] - Fullscreen";
		instruction_text += "\n[Hold ESC] - Quit";
		instruction_text += "\nWhen HP is 0, you lose.";
		
	draw_set_halign(fa_center);
	draw_text(320, 40, instruction_label);
	
	draw_set_halign(fa_left);
	draw_text(170, 100, instruction_text);
	
	var textOption = ["Begin Game", "Settings"];
	for (var i = 0; i < 2; i++)
	{
		var color = (menu_choice[0] == i) ? c_yellow : c_white;
		draw_set_color(color);
		draw_text(170, 345 + (i * 40), textOption[i]);
	}
	
	draw_set_color(c_white);
	draw_set_halign(default_halign);
}

else if naming_states
{
	#region // Naming letters and options
		draw_set_alpha(naming_alpha[0]);

		var default_halign = draw_get_halign(),
			default_valign = draw_get_valign();
		draw_set_halign(fa_center);
		draw_set_color(c_white);
		draw_set_font(fnt_dt_sans);
		draw_text(320, 60, "Name the fallen human.")
		draw_set_halign(default_halign);
	
		var xLetters = 7,
			yLetters = 8,
			charIndex = [1, 1], 
			charLength = [26, 26],
			textOption = ["Quit", "Backspace", "Done"];
		
		// Capital letters
		for (var yCharCount = 0; yCharCount < yLetters; yCharCount++)
		{
			for (var xCharCount = 0; xCharCount < xLetters; xCharCount++)
			{
				if charIndex[0] <= charLength[0]
				{
					var drawX = 120 + (xCharCount * 64),
						drawY = 152 + (yCharCount * 28),
						shakeX = random_range(-1, 1), 
						shakeY = random_range(-1, 1),
						color = (naming_choice == charIndex[0] and naming_choice <= 26) ? c_yellow : c_white,
						text = string_char_at(naming_letter[0], charIndex[0]);
						letter[xCharCount, yCharCount] = text;
					
					draw_set_color(color);
					draw_text(drawX + shakeX, drawY + shakeY, letter[xCharCount, yCharCount]);
					draw_set_color(c_white);
				charIndex[0]++
				}
			}
		}
	
		// Non-capital letters
		for (var yCharCount = 0; yCharCount < yLetters; yCharCount++)
		{
			for (var xCharCount = 0; xCharCount < xLetters; xCharCount++)
			{
				if charIndex[1] <= charLength[1]
				{
					var drawX = 120 + (xCharCount * 64),
						drawY = 272 + (yCharCount * 28),
						shakeX = random_range(-1, 1), 
						shakeY = random_range(-1, 1),
						color = (((naming_choice - 26) == charIndex[1] and (naming_choice - 26) <= 26) ? c_yellow : c_white),
						letter;
						letter[xCharCount, yCharCount] = string_char_at(naming_letter[1], charIndex[1]);
					draw_set_color(color);
					draw_text(drawX + shakeX, drawY + shakeY, letter[xCharCount, yCharCount]);
					draw_set_color(c_white);
				charIndex[1]++;
				}
			}
		}
	
		// Options
		for (var i = 0; i < 3; i++)
		{
			draw_set_halign(fa_center);
			var	color = ((naming_choice - 53) == i and (naming_choice - 53) <= 3) ? c_yellow : c_white;
			draw_set_color(color);
			draw_text(146 + (174 * i), 400, textOption[i]);
			draw_set_halign(default_halign);
			draw_set_color(c_white);
		}
		
		draw_set_alpha(1);
	#endregion

	#region // Name
		draw_set_halign(fa_center);
		var state = (menu_state == INTRO_MENU_STATE.NAME_CHECKING or menu_state == INTRO_MENU_STATE.NAME_CONFIRM),
			shake_x = state * random_range(-1, 1),
			shake_y = state * random_range(-1, 1);
	
		draw_text_ext_transformed(name_x + shake_x, name_y + shake_y, name, -1, -1, name_scale, name_scale, shake_x + shake_y);
		draw_set_halign(default_halign);
	#endregion
	
	#region // Name description and confirmation
	if menu_state != INTRO_MENU_STATE.NAME_CONFIRM
	{
		draw_set_halign(fa_left);
		draw_set_alpha(naming_alpha[1]);
		CheckName(name);
		// Name description load script here
		draw_text(180, 60, name_desc);
		
		var confirmOption = "Go back";
		if name_usable
			var confirmOption = ["No", "Yes"];
		draw_set_halign(fa_center);		
		for (var i = 0; i < 2; i++)
		{
			var color = (name_confirm == i) ? c_yellow : c_gray
			if name_usable
				color = (name_confirm == i) ? c_yellow : c_white
			draw_set_color(color);
			draw_text(150 + (340 * i) , 400, confirmOption[i]);
		}
		
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_set_halign(default_halign);
		draw_set_valign(default_valign);
	}
	#endregion
}

/*var default_halign = draw_get_halign();
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(fnt_logo);
draw_text_transformed(Titlepos[0], Titlepos[1], LogoText, TitleScale, TitleScale, 0);

if hint
{
	draw_set_font(fnt_cot);
	draw_set_color(c_ltgray);
	draw_text(DescX, 300, "Press Z to Begin\nPress C for settings\nPress Y to view Replays");
}
//Settings
draw_set_font(fnt_mnc);
draw_set_color(c_white);
var tcol =
[
	make_color_hsv(global.timer % 255, 255, 255),
	//make_color_hsv((global.timer + 255 * .25) % 255, 255, 255),
	//make_color_hsv((global.timer + 255 * .5) % 255, 255, 255),
	//make_color_hsv((global.timer + 255 * .75) % 255, 255, 255)
];

draw_set_halign(default_halign);

var col = merge_color(c_white, tcol[0], 0.65),
	TrigoVal =
	[
		cos(global.timer / 35),
		dsin(global.timer),
		dcos(global.timer),
		dsin(global.timer * 1.4),
		dcos(global.timer * 0.6),
	];
draw_cube_width(CubePos[0], CubePos[1], 40 - TrigoVal[0] * 10, TrigoVal[1], TrigoVal[2], col, 3);
draw_cube_width(CubePos[0], CubePos[1], 20 - TrigoVal[0] * 10, TrigoVal[3], -TrigoVal[4], col, 3);

