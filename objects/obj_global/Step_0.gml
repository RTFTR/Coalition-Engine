// Camera movement
{
    var cam = view_camera[0],
    
        cam_scale_x = global.camera_scale_x,
        cam_scale_y = global.camera_scale_y,
        
        cam_width  = global.camera_view_width/cam_scale_x,
        cam_height = global.camera_view_height/cam_scale_y,
        
        cam_angle  = camera_angle,
        
        cam_target = global.camera_target,
        
        cam_shake_x = 0,
        cam_shake_y = 0;

    camera_set_view_size (cam,  cam_width, cam_height);
    camera_set_view_angle(cam, cam_angle             );
    
    if (global.camera_shake_i > 0) global.camera_shake_t += 30 * delta_time;
    else camera_set_view_pos(cam, camera_get_view_x(cam), camera_get_view_y(cam));
    
    if (global.camera_shake_t > 0) {
        global.camera_shake_t --;
        global.camera_shake_i --;
        
        camera_set_view_pos(cam, camera_get_view_x(cam) + cam_shake_x, camera_get_view_y(cam) + cam_shake_y);
    }

    if  (cam_target != noone&&instance_exists(cam_target)) {
        var camToX = cam_target.x-cam_width *0.5,
            camToY = cam_target.y-cam_height*0.5;
        
        camera_set_view_target(cam, cam_target     );
        camera_set_view_pos   (cam, camToX, camToY );
    }
}