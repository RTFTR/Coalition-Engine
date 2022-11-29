audio_play(snd_logo);
hint = 0;
TweenFire(self,EaseLinear,TWEEN_MODE_ONCE,false,0,120,"hint",0,1)
y = 480;

instance_create_depth(0,0,1,RainbowFuture);
instance_create_depth(320,240,-1,Duster);
if choose(0,1) instance_create_depth(0,0,1,Bloomer);
var shd = choose(
//shdSepia,
//shdInvert,
shdNoise
)
Effect_Shader(shd);
is_setting = false;
setting = 0;
setting_var = [global.Volume, 0];
setting_name = ["Master Volume", "Easy Mode"];

global.easy = 0;

