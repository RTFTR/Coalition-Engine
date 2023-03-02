/// @descr Name and file loaded
// Happens after naming/resetting process is done
// Save reload etc etc
global.data.name = name;
oGlobal.fader_color = c_black;
TweenFire(oGlobal,EaseLinear,TWEEN_MODE_ONCE,false,0,20,"fader_alpha",1,0);
//room_goto_next();
room_goto(room_overworld);
