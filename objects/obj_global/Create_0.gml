depth = -10000;
global.timer = 0;

global.zoom_level = 1;
global.cam_width = 640;
global.cam_height = 480;

global.camera_x = 0;
global.camera_y = 0;
global.camera_angle = 0;
global.cam_target = noone;
view_camera[0] = camera_create_view(x,y,640,480,0,noone,-1,-1,320,240);
global.Main_Camera = view_camera[0];

global.shake = 0;
global.shake_length = 1;
global.shake_random = 0;
global.shake_magnitude = 1.5;

global.soul_x = 0;
global.soul_y = 0;

quit_timer = 0;

fader_color = c_black;
fader_alpha = 0;

pause = false;
pauseSurf = surface_create(640, 480);
pauseSurfBuffer = buffer_create(640 * 480 * 4, buffer_fixed, 1);


