//Modified from Hardmode Sans by Siki
enum SHAPE {
	CUBE = 0,
	REGULAR_TETRAHEDRON = 1,
	REGULAR_OCTAHEDRON = 2,
	REGULAR_DODECAHEDRON = 3,
	REGULAR_ICOSAHEDRON = 4
}
vert_list = [];
vert_list_draw = [];
edge_list = [];
angles = array_create(3, 0);
angleAdd = array_create(3, 0);
scalex = 0;
scaley = 0;
scalez = 0;
type = 0;
///@desc add the nodes to the list
function add_vert(X, Y, Z, list)
{
	list ??= vert_list;
	var _prop = [X, Y, Z];
	array_push(list, _prop);
}

function update_vert()
{
	vert_list_draw = [];
	var X, Y, Z, XX, YY, ZZ, i = 0;
	repeat(array_length(vert_list))
	{
		_prop = vert_list[i];
		X = _prop[0] * scalex;
		Y = _prop[1] * scaley;
		Z = _prop[2] * scalez;
		YY = Y * dcos(angles[0]) - Z * dsin(angles[0]);
		ZZ = Y * dsin(angles[0]) + Z * dcos(angles[0]);
		Y = YY;
		Z = ZZ;
		ZZ = Z * dcos(angles[1]) - X * dsin(angles[1]);
		XX = Z * dsin(angles[1]) + X * dcos(angles[1]);
		Z = ZZ;
		X = XX;
		XX = X * dcos(angles[2]) - Y * dsin(angles[2]);
		YY = X * dsin(angles[2]) + Y * dcos(angles[2]);
		X = XX;
		Y = YY;
		add_vert(X, Y, Z, vert_list_draw);
		i++;
	}
}

///@desc add the edges of the nodes (connect the nodes)
function add_edge()
{
	_prop = [argument0, argument1, Bullet_Bone(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)];
	_prop[2].retract_on_end = true;
	array_push(edge_list, _prop);
}

//Set the shape using the struct format in instance_create_depth
if !variable_instance_exists(id, "shape") shape = SHAPE.CUBE;

switch shape
{
	case SHAPE.CUBE:
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
		break;
	case SHAPE.REGULAR_TETRAHEDRON:
		add_vert(-2 * sqrt(2) / 3, 0, -1 / 3);
		add_vert(sqrt(2) / 3, sqrt(6) / 3, -1 / 3);
		add_vert(sqrt(2) / 3, -sqrt(6) / 3, -1 / 3);
		add_vert(0, 0, 1);
		add_edge(0, 1);
		add_edge(0, 2);
		add_edge(0, 3);
		add_edge(1, 2);
		add_edge(1, 3);
		add_edge(3, 2);
	break
	case SHAPE.REGULAR_OCTAHEDRON:
		add_vert(0, 1, 0);
		add_vert(0, 0, 1);
		add_vert(0, 0, -1);
		add_vert(1, 0, 0);
		add_vert(-1, 0, 0);
		add_vert(0, -1, 0);
		add_edge(0, 1);
		add_edge(0, 2);
		add_edge(0, 3);
		add_edge(0, 4);
		add_edge(5, 1);
		add_edge(5, 2);
		add_edge(5, 3);
		add_edge(5, 4);
		break;
	case SHAPE.REGULAR_DODECAHEDRON:
		add_vert(1, 1, 1);
		add_vert(1, 1, -1);
		add_vert(-1, 1, 1);
		add_vert(-1, 1, -1);
		add_vert(1 / Phi, Phi, 0);
		add_vert(-1 / Phi, Phi, 0);
		add_vert(0, 1 / Phi, Phi);
		add_vert(0, 1 / Phi, -Phi);
		add_vert(Phi, 0, 1 / Phi);
		add_vert(-Phi, 0, 1 / Phi);
		add_vert(Phi, 0, -1 / Phi);
		add_vert(-Phi, 0, -1 / Phi);
		add_vert(1, -1, 1);
		add_vert(1, -1, -1);
		add_vert(-1, -1, 1);
		add_vert(-1, -1, -1);
		add_vert(0, -1 / Phi, Phi);
		add_vert(0, -1 / Phi, -Phi);
		add_vert(1 / Phi, -Phi, 0);
		add_vert(-1 / Phi, -Phi, 0);
		add_edge(4, 5);
		add_edge(0, 4);
		add_edge(1, 4);
		add_edge(2, 5);
		add_edge(3, 5);
		add_edge(0, 6);
		add_edge(2, 6);
		add_edge(1, 7);
		add_edge(3, 7);
		add_edge(6, 16);
		add_edge(7, 17);
		add_edge(0, 8);
		add_edge(1, 10);
		add_edge(2, 9);
		add_edge(3, 11);
		add_edge(8, 10);
		add_edge(9, 11);
		add_edge(8, 12);
		add_edge(9, 14);
		add_edge(10, 13);
		add_edge(11, 15);
		add_edge(12, 16);
		add_edge(13, 17);
		add_edge(14, 16);
		add_edge(15, 17);
		add_edge(18, 19);
		add_edge(12, 18);
		add_edge(13, 18);
		add_edge(14, 19);
		add_edge(15, 19);
	break;
	case SHAPE.REGULAR_ICOSAHEDRON:
		var points = [[0, 1, Phi], [0, -1, Phi], [0, 1, -Phi], [0, -1, -Phi], [1, Phi, 0], [-1, Phi, 0], [1, -Phi, 0], [-1, -Phi, 0], [Phi, 0, 1], [-Phi, 0, 1], [Phi, 0, -1], [-Phi, 0, -1]];
		for (var i = 0; i < 12; i++)
		{
			var xx = points[i][0],
				yy = points[i][1],
				z = points[i][2];
			add_vert(xx, yy, z);
		}
		for (var i = 0; i < 8; i += 2) {
			add_edge(i, i + 1);
		}
		add_edge(4, 0);
		add_edge(4, 2);
		add_edge(4, 8);
		add_edge(4, 10);
		add_edge(5, 0);
		add_edge(5, 2);
		add_edge(5, 9);
		add_edge(5, 11);
		add_edge(6, 1);
		add_edge(6, 3);
		add_edge(6, 8);
		add_edge(6, 10);
		add_edge(7, 1);
		add_edge(7, 3);
		add_edge(7, 9);
		add_edge(7, 11);
		add_edge(0, 8);
		add_edge(0, 9);
		add_edge(1, 8);
		add_edge(1, 9);
		add_edge(2, 10);
		add_edge(2, 11);
		add_edge(3, 10);
		add_edge(3, 11);
		add_edge(8, 10);
		add_edge(9, 11);
	break
}

update_vert();