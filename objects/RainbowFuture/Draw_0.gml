/// @description Draw the effect
counter++;
    var vRes = shader_get_uniform(Rainbow_Future_Shader,"vRes");
    var vTime = shader_get_uniform(Rainbow_Future_Shader,"vTime");
    var vSwitch = shader_get_uniform(Rainbow_Future_Shader,"vSwitch");
    var yOffset = shader_get_uniform(Rainbow_Future_Shader,"yOffset");
    shader_set(Rainbow_Future_Shader);
    shader_set_uniform_f(vRes,__view_get( e__VW.WPort, 0 ),__view_get( e__VW.HPort, 0 ));
    shader_set_uniform_f(vTime,counter);
    shader_set_uniform_f(vSwitch,vswitch);
    shader_set_uniform_f(yOffset,y_offset0);
    
    if(!surface_exists(mainSurface))
        mainSurface = surface_create(__view_get( e__VW.WPort, 0 ),__view_get( e__VW.HPort, 0 ));
    
    surface_set_target(mainSurface);
    draw_clear_alpha(c_white,1);
    surface_reset_target();
    
    draw_surface_stretched(mainSurface,0,0,__view_get( e__VW.WPort, 0 ),__view_get( e__VW.HPort, 0 ));
    
    shader_reset();

