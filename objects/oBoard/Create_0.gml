//Adds the board to the global board list
array_push(BattleBoardList, id);
image_alpha = 1;
surface = noone;

x = 320;
y = 320;

up = 65;
down = 65;
left = 283;
right = 283;

frame_x = array_create(4, 0);
frame_y = array_create(4, 0);
frame_w = array_create(4, 0);
frame_h = array_create(4, 0);

bg_x = 0;
bg_y = 0;
bg_w = 0;
bg_h = 0;

thickness_frame = 5;

point_x = 0;
point_y = 0;

rotate = 0;

//Board frame color
image_blend = c_white;

//Polygon board (WIP)
VertexMode = false;
Vertex = array_create_2d(1, 1);

function ConvertToVertex() {
	if VertexMode exit;
	for (var i = 0; i < 4; ++i) {
		Vertex[i] = [frame_x[i], frame_y[i]];
	}
	VertexMode = true;
}
function ConvertToBox(X = x, Y = y, Left = left, Right = right, Up = up, Down = down, angle = image_angle) {
	if !VertexMode exit;
	if array_length(Vertex) == 4
	{
		if is_rectangle(Vertex[0], Vertex[1], Vertex[2], Vertex[3])
		{
			x = X;
			y = Y;
			left = Left;
			right = Right;
			up = Up;
			down = Down;
			image_angle = angle;
		}
	}
	VertexMode = false;
}