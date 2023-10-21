///@desc Loads the Info of the Items
function Item_Info_Load(){
	var i = 0;
	repeat(Item_Count())
	{
		Item_Info(global.item[i]);
		item_name[i] = name;
		item_heal[i] = heal;
		item_desc[i] = desc;
		item_throw_txt[i] = throw_txt;
		item_battle_desc[i] = battle_desc;
		i++;
	}
}

///@desc Gets the Infos of the Item
///@param {real} Item The Item to get the info
function Item_Info(item){
	name = "";
	heal = 0;
	stats = "";
	desc = "";
	throw_txt = "";
	battle_desc = "";
	
	switch item
	{
		case ITEM.PIE:
			name = "Pie";
			heal = global.hp_max;
			desc = "Random slice of pie which is so\n  cold you cant eat it.";
			throw_txt = "Throw pie";
			battle_desc = "Heals FULL HP";
		break;
		case ITEM.INOODLES:
			name = "I. Noodles";
			heal = 90;
			desc = "Hard noodles, your teeth broke";
			throw_txt = "Throw IN";
			battle_desc = "Heals 90 HP";
		break;
		case ITEM.STEAK:
			name = "Steak";
			heal = 60;
			desc = "Steak that looks like a MTT which\n  somehow fits in your pocket";
			throw_txt = "Throw expensive mis-steak";
			battle_desc = "Heals 60 HP";
		break;
		case ITEM.SNOWP:
			name = "SnowPiece";
			heal = 45;
			desc = "Bring this to the end of the world,\n  but the world isnt round";
			throw_txt = "snowball fight go brr";
			battle_desc = "Heals 45 HP";
		break;
		case ITEM.LHERO:
			name = "L. Hero";
			heal = 40;
			stats = "Your ATK raised by 4!";
			desc = "You arent legendary nor a hero.";
			throw_txt = "congrats you now bad guy";
			battle_desc = "Heals 40 HP";
		break;
		case ITEM.SEATEA:
			name = "Sea Tea";
			heal = 10;
			stats = "Your SPD increased!";
			desc = "HOW U HOLD A TEA WITHOUT CUP OMG";
			throw_txt = "you threw liquid.";
			battle_desc = "+10 HP - SPD+";
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
		case ITEM.PIE:
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
		case ITEM.INOODLES:
			heal_text = "You ate the Instant Noodles.";
		break;
		case ITEM.STEAK:
			heal_text = "You ate the Face Steak.";
		break;
		case ITEM.SNOWP:
			heal_text = "You ate the Snow Piece.";
		break;
		case ITEM.LHERO:
			heal_text = "You ate the Legendary Hero.";
			global.player_attack_boost += 4;
		break;
		case ITEM.SEATEA:
			heal_text = "You drank the sea tea.";
			global.spd *= 2;
			audio_play(snd_spdup);
			with oBattleController.Effect
			{
				SeaTea = true;
				SeaTeaTurns = 4;
			}
		break;
	}
	
	if global.item_uses_left[item] > 0
		global.item_uses_left[item]--;
	Item_Info(item);
	audio_play(snd_item_heal);
	
	if global.item_heal_override_kr
		if global.hp + heal >= global.hp_max global.kr = 0;
	
	global.hp = min(global.hp + heal, global.hp_max);
	var hp_text = "[delay, 333]\n* You recovered " + string(heal) + " HP!";
	
	if global.hp >= global.hp_max hp_text = "[delay, 333]\n* Your HP has been maxed out."
	
	//If is in battle
	if instance_exists(oBattleController)
	{
		var stat_text = "";
		if stats != ""
			stat_text = "[delay, 333]\n* " + stats;
		if !global.item_uses_left[item] Item_Shift(menu_choice[2], 0);
	
		default_menu_text = menu_text;
		menu_choice[2] = 0;
		menu_text_typist.reset();
		menu_text = heal_text + hp_text + stat_text;
		__text_writer = scribble("* " + menu_text);
		menu_text = default_menu_text;
		if __text_writer.get_page() != 0 __text_writer.page(0);
	
		menu_state = -1;
	}
	
	//If is in overworld
	if instance_exists(oOWController)
	{
		if !global.item_uses_left[item] Item_Shift(menu_choice[1], 0);
		healing_text = heal_text + hp_text;
		return healing_text;
	}
}

///@desc Shifts the Item position and resize the global item array
function Item_Shift(item, coord){
	var i = item, n = Item_Count();
	global.item[n] = coord;
	repeat n - item
	{
		global.item[i] = global.item[i + 1];
		++i;
	}
	array_resize(global.item, n - 1);
}

///@desc Number of valid items
///@return {real}
function Item_Space(){
	var i = 0, space = 0;
	repeat Item_Count()
		if global.item[i++] != 0
			space++;
	return space;
}

///@desc Adds an item on the selected position
///@param {real} Item		The item to add (Use the Item ID from Item_Info)
///@param {real} Position	The item position to add (Default last)
function Item_Add(item, pos = Item_Count()) {
	global.item[pos] = item;
}

///@desc Removes an item on the selected position
///@param {real} Position	The item position to remove
function Item_Remove(item) {
	Item_Shift(item, 0);
}

///@desc Gets the number of items
///@return {real}
function Item_Count() {
	return array_length(global.item);
}

///@desc Converts item Slot to item ID
///@param {real} slot The slot of the item in the global item array
///@return {real}
function Item_SlotToId(item) {
	return global.item[item];
}
