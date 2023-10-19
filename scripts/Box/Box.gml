function __Box() constructor
{
	/**
		Gets the amount of items in the box
		@param {real} Box_ID The ID of the box
	*/
	static ItemCount = function(Box_ID) {
		return array_length(global.Box[Box_ID]);
	}
	/**
		Gets the first empty slot of a box
		@param {real} Box_ID The Box ID to check (0 - Overworld, 1 - D.Box A, 2 - D.Box B)
	*/
	static GetFirstEmptySlot = function(Box_ID) {
		for (var i = 0, num = 0; i < 10; ++i)
			if global.Box[Box_ID, i] num = i + 1;
		return num;
	}
	///@desc Loads the Info of the Items of the Box
	static InfoLoad = function() {
		with oOWController
		{
			for (var i = 0, n = BoxData.Count(Box_ID); i < n; ++i) {
				BoxData.Info(global.Box[Box_ID, i]);
				box_name[i] = name;
			}
		}
	}
	/**
		Gets the Infos of the Item in the Box
		@param {real} Item The Item to get the info
	*/
	static Info = function(item) {
		with oOWController
		{
			name = "";

			switch item {
				case 1:
					name = "Pie";
				break;
				case 2:
					name = "I. Noodles";
				break;
				case 3:
					name = "Steak";
				break;
				case 4:
					name = "SnowPiece";
				break;
				case 5:
					name = "L. Hero";
				break;
				case 6:
					name = "Sea Tea";
				break;
			}
			if global.item_uses_left[item] > 1 name += " x" + string(global.item_uses_left[item])
		}
	}
	/**
		Gets the number of items in the Box
		@param ID The ID of the Box
	*/
	static Count = function(ID) {
		for (var i = 0, num = 0; i < 10; ++i)
			if global.Box[ID, i] num++;
		return num;
	}
	/**
		idk
	*/
	static Shift = function(Box_ID)
	{
		var i = 0;
		repeat BoxData.ItemCount(Box_ID) - 1
		{
			if global.Box[Box_ID, i] == 0 && global.Box[Box_ID, i + 1] != 0
			{
				array_delete(global.Box[Box_ID], i, 1);
				array_push(global.Box[Box_ID], 0);
			}
			++i;
		}
	}
}