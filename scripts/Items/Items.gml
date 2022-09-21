///@desc Loads the Info of the Items
function Item_Info_Load(){
	for (var i = 0, n = array_length(global.item); i < n; ++i)
	{
		Item_Info(global.item[i]);
		item_name[i] = name;
		item_heal[i] = heal;
		item_desc[i] = desc;
	}
}

///@desc Gets the Infos of the Item
///@param {real} Item The Item to get the info
function Item_Info(item){
	name = "";
	heal = 0;
	stats = "";
	desc = "";
	
	switch item
	{
		case 1:
			name = "Pie";
			heal = global.hp_max;
			desc = "Random slice of pie which is so cold you cant eat it.";
			break;
		case 2:
			name = "I. Noodles";
			heal = 90;
			desc = "Hard noodles, your teeth broke";
			break;
		case 3:
			name = "Steak";
			heal = 60;
			desc = "Steak that looks like a MTT which somehow fits in your pocket";
			break;
		case 4:
			name = "SnowPiece";
			heal = 45;
			desc = "Bring this to the end of the world, but the world isnt round";
			break;
		case 5:
			name = "L. Hero";
			heal = 40;
			stats = "Your ATK raised by 4!";
			desc = "You arent legendary nor a hero.";
			break;
	}
	if global.item_uses_left[item] > 1 name += " x" + string(global.item_uses_left[item])
}

///@desc Use the item
///@param {real} item The item to use
function Item_Use(item){
	var heal_text = "";
	switch item
	{
		case 1:
			switch global.item_uses_left[item]
			{
				case 2:
				heal_text = "You ate the Butterscotch Pie.";
				break
				case 1:
				heal_text = "You eat the Butterscotch Pie.";
				break
			}
			break;
		case 2:
			heal_text = "You ate the Instant Noodles.";
			break;
		case 3:
			heal_text = "You ate the Face Steak.";
			break;
		case 4:
			heal_text = "You ate the Snow Piece.";
			break;
		case 5:
			heal_text = "You ate the Legendary Hero.";
			global.player_attack_boost += 4;
			break;
	}
	global.item_uses_left[item]--;
	Item_Info(item);
	audio_play(snd_item_heal);
	
	if global.item_heal_override_kr
		if global.hp + heal >= global.hp_max global.kr = 0;
	global.hp = min(global.hp + heal, global.hp_max);
	var hp_text = "[delay, 333]\n* You recovered " + string(heal) + " HP!";
	if global.hp >= global.hp_max hp_text = "[delay, 333]\n* Your HP has been maxed out."
	var stat_text = (stats == "" ? "" : "[delay, 333]\n* " + stats);
	
	if !global.item_uses_left[item] Item_Shift(menu_choice[2], 0);
	
	default_menu_text = menu_text;
	menu_choice[2] = 0;
	menu_text_typist.reset();
	menu_text = heal_text + hp_text + stat_text;
	text_writer = scribble("* " + menu_text);
	menu_text = default_menu_text;
	if text_writer.get_page() != 0 text_writer.page(0);
	
	menu_state = -1;
}

///@desc Shifts the Item position
function Item_Shift(item,coord){
	global.item[n] = coord;
	for (var i = item, n = array_length(global.item); i < n; ++i) global.item[i] = global.item[i + 1];
}

function Item_Space(){
	var space = 0;
	
	for (var i = 0, n = array_length(global.item); i < n; ++i) if global.item[i] != 0 space += 1;
	return space;
}
