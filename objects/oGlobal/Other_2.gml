/// @description Initialization

Initialize();

window_set_caption("Coalition Engine");
window_set_caption("Undertale");

window_center();

room_speed = 60;
instance_create_depth(0,0,0,obj_SharedTweener); // Tweener


room_goto_next();
