/// @description Resize stuff

if(window_w != window_get_width() or window_h != window_get_height()){
    __view_set( e__VW.WPort, 0, window_get_width( ));
    __view_set( e__VW.HPort, 0, window_get_height( ));

    __view_set( e__VW.WView, 0, window_get_width( ));
    __view_set( e__VW.HView, 0, window_get_height( ));

    surface_resize(application_surface,window_get_width(),window_get_height());
    display_set_gui_size(window_get_width(),window_get_height());
    }

window_w = window_get_width();
window_h = window_get_height();

