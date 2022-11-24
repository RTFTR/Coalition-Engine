draw_set_color(c_white)
uni_resolution_hoz = shader_get_uniform(shdGauHor, "resolution")
uni_resolution_vert = shader_get_uniform(shdGauVer, "resolution")
var_resolution_x = 640
var_resolution_y = 480
uni_blur_amount_hoz = shader_get_uniform(shdGauVer, "blur_amount")
uni_blur_amount_vert = shader_get_uniform(shdGauHor, "blur_amount")
var_blur_amount = 5
duration = -1
final_surface = application_surface
surf = surface_create(640, 480)
depth = -1000
