// Feather disable all


function TPGrid(grid, _x, _y)
{
	/// @function TPGrid(grid,x,y)
	/// @param grid
	/// @param x
	/// @param y
	/// @return {array}
	
	// CALL ONLY ONCE
	static _ = TGMS_BuildProperty(TPGrid,
		function(_value, _data) 
		{
			ds_grid_set(_data[0], _data[1], _data[2], _value);
		},
		function(_data)
		{
			return ds_grid_get(_data[0], _data[1], _data[2]);
		}
	);
	
	return [ TPGrid, [ grid, _x, _y] ];
}


