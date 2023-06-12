//Input defines the default profiles as a macro called 
//This macro is parsed when Input boots up and provides the baseline bindings for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The root struct called INPUT_DEFAULT_PROFILES contains the names of each default profile
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

if !variable_global_exists("InputKeys")
global.InputKeys =
[
	vk_up, vk_down, vk_left, vk_right,
	["Z", vk_enter], ["X", vk_shift], "C",
];


INPUT_DEFAULT_PROFILES = {
    
    keyboard_and_mouse:
    {
        up:    [input_binding_key(vk_up)],
        down:  [input_binding_key(vk_down)],
        left:  [input_binding_key(vk_left)],
        right: [input_binding_key(vk_right)],
        
        confirm:  [input_binding_key("Z"), input_binding_key(vk_enter)],
        cancel:   [input_binding_key("X"), input_binding_key(vk_lshift)],
        menu:     [input_binding_key("C")],
        //special: input_binding_key(vk_shift),
        
        //No aiming verbs since we use the mouse for that (see below for aiming verb examples)
        //shoot: input_binding_mouse_button(mb_left),
        
        //pause: input_binding_key(vk_escape),
    },
    
    gamepad:
    {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        accept:  input_binding_gamepad_button(gp_face1),
        cancel:  input_binding_gamepad_button(gp_face2),
        action:  input_binding_gamepad_button(gp_face3),
        special: input_binding_gamepad_button(gp_face4),
        
        aim_up:    input_binding_gamepad_axis(gp_axisrv, true),
        aim_down:  input_binding_gamepad_axis(gp_axisrv, false),
        aim_left:  input_binding_gamepad_axis(gp_axisrh, true),
        aim_right: input_binding_gamepad_axis(gp_axisrh, false),
        shoot:     [input_binding_gamepad_button(gp_shoulderlb), input_binding_gamepad_button(gp_shoulderrb)],
        
        pause: input_binding_gamepad_button(gp_start),
    },
    
    touch:
    {
        up:    input_binding_virtual_button(),
        down:  input_binding_virtual_button(),
        left:  input_binding_virtual_button(),
        right: input_binding_virtual_button(),
        
        accept:  input_binding_virtual_button(),
        cancel:  input_binding_virtual_button(),
        action:  input_binding_virtual_button(),
        special: input_binding_virtual_button(),
        
        pause: input_binding_virtual_button(),
    }
    
};

//Defines which verbs should collide with which other verbs when using input_binding_get_collisions()
//and input_binding_set_safe(). A verb that is not present in a group will collide with all other verbs
INPUT_VERB_GROUPS = {
    //Fill me up!
};