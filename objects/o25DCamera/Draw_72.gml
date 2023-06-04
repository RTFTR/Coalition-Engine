///@desc Update 3D camera
var _camW = camera_get_view_width(camera);
var _camH = camera_get_view_height(camera);
var _camX = camera_get_view_x(camera) + x;
var _camY = camera_get_view_y(camera) + y;

var _viewMat = matrix_build_lookat(_camX, _camY, camDist, _camX + camXDisplace, _camY + camYDisplace, 0, 0, 1, 0);
var _projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 1, 30000);

camera_set_view_mat(camera, _viewMat);
camera_set_proj_mat(camera, _projMat);

camera_apply(camera);
