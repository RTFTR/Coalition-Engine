depth = -10000;
global.timer = 0;

global.zoom_level = 1;
global.zoom_width = 640;
global.zoom_height = 480;

global.camera_x = global.zoom_width * 0.5;
global.camera_y = global.zoom_height * 0.5;

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


