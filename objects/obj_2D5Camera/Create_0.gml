// Camera
camera	= view_camera[0];

// Set up 3D camera
camDist	= -300;
camFov	= 90;
camAsp	= camera_get_view_width(camera) / camera_get_view_height(camera);
camXDisplace = 0;
camYDisplace = 0;

// Rotation
allowRotation = true;
camSensitivityX = 1;
camSensitivityY = 1;

camAngleXRaw = 90;
camAngleYRaw = 0;
camAngleX = camAngleXRaw;
camAngleY = camAngleYRaw;

// Vars
mouse_x_prev = 0;
mouse_y_prev = 0;
