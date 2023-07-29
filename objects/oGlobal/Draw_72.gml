///@desc Update 3D camera
if camera_enable_z
{
	var camera = Main_Camera,
		_camW = camera_get_view_width(camera),
		_camH = camera_get_view_height(camera),
		_camX = camera_get_view_x(camera) + x,
		_camY = camera_get_view_y(camera) + y,

		_viewMat = matrix_build_lookat(
		_camX + (dcos(camAngleX) * dcos(camAngleY)) * camDist,
		_camY + (dsin(camAngleY)) * camDist,
		(dsin(camAngleX) * dcos(camAngleY)) * camDist,
		_camX + camXDisplace, _camY + camYDisplace, 0, 0, 1, 0),
		_projMat = matrix_build_projection_perspective_fov(camFov, camAsp, 1, 30000);

	camera_set_view_mat(camera, _viewMat);
	camera_set_proj_mat(camera, _projMat);

	camera_apply(camera);
}