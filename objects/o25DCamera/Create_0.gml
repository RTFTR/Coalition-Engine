// Camera
camera	= view_camera[0];

// Set up 3D camera
camDist	= -300;
camFov	= 90;
camAsp	= camera_get_view_width(camera) / camera_get_view_height(camera);
camXDisplace = 0;
camYDisplace = 0;