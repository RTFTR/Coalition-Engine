draw_text(0,0,"Menu State: " + string(menu_state));
draw_text(0,20,"Button Choice: " + string(menu_button_choice));
var temp_text = ["Enemy Choice", "Enemy Act Choice", "Item Number"];
for (var i = 0; i < 3; ++i)
draw_text(0,40+(20 * i), temp_text[i] + ": " + string(menu_choice[i]));
draw_text(0,120,"Menu Typer State: " + string(menu_text_typist.get_state()));
draw_text(0,140,"Turn: " + string(battle_turn));
draw_text(0,160,"Battle State: " + string(battle_state));

