depth = -10000
uni_resolution_hoz = shader_get_uniform(shd_GaussianBlurHor, "resolution")
uni_resolution_vert = shader_get_uniform(shd_GaussianBlurVer, "resolution")
var_resolution_x = 640
var_resolution_y = 480
uni_blur_amount_hoz = shader_get_uniform(shd_GaussianBlurVer, "blur_amount")
uni_blur_amount_vert = shader_get_uniform(shd_GaussianBlurHor, "blur_amount")
var_blur_amount = 5
duration = -1
final_surface = application_surface;
surf = noone;

