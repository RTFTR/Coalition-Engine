//Modified from Hardmode Sans by Siki
vert_list = [];
vert_list_draw = [];
edge_list = [];
angles = [0, 0, 0];
angleAdd = [0, 0, 0];
scalex = 0;
scaley = 0;
scalez = 0;
type = 0;
function add_vert(argument0, argument1, argument2, argument3)
{
	argument3 ??= vert_list;
	var _prop = ds_list_create();
	_prop[0] = argument0;
	_prop[1] = argument1;
	_prop[2] = argument2;
	array_push(argument3, _prop);
}

function update_vert()
{
	vert_list_draw = [];
	for (var i = 0, n = array_length(vert_list); i < n; i++)
	{
		_prop = vert_list[i];
		var X = _prop[0];
		var Y = _prop[1];
		var Z = _prop[2];
		X *= scalex;
		Y *= scaley;
		Z *= scalez;
		var YY = Y * dcos(angles[0]) - Z * dsin(angles[0]);
		var ZZ = Y * dsin(angles[0]) + Z * dcos(angles[0]);
		Y = YY;
		Z = ZZ;
		ZZ = Z * dcos(angles[1]) - X * dsin(angles[1]);
		var XX = Z * dsin(angles[1]) + X * dcos(angles[1]);
		Z = ZZ;
		X = XX;
		XX = X * dcos(angles[2]) - Y * dsin(angles[2]);
		YY = X * dsin(angles[2]) + Y * dcos(angles[2]);
		X = XX;
		Y = YY;
		add_vert(X, Y, Z, vert_list_draw);
	}
}

function add_edge()
{
	_prop = [];
	_prop[0] = argument0;
	_prop[1] = argument1;
	_prop[2] = Bullet_Bone(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
	_prop[2].retract_on_end = true;
	array_push(edge_list, _prop);
}

add_vert(1, 1, 1);
add_vert(1, 1, -1);
add_vert(1, -1, 1);
add_vert(1, -1, -1);
add_vert(-1, 1, 1);
add_vert(-1, 1, -1);
add_vert(-1, -1, 1);
add_vert(-1, -1, -1);
add_edge(0, 1);
add_edge(0, 2);
add_edge(0, 4);
add_edge(1, 3);
add_edge(1, 5);
add_edge(2, 3);
add_edge(2, 6);
add_edge(3, 7);
add_edge(4, 5);
add_edge(4, 6);
add_edge(5, 7);
add_edge(6, 7);
update_vert();