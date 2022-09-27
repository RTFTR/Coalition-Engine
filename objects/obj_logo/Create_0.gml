sfx_play(snd_logo);
hint = 0;
alarm[0] = 120;
y = 480;

instance_create_depth(0,0,1,RainbowFuture)
if choose(0,1) 
	instance_create_depth(0,0,1,Bloomer)
var shd = choose(
shd_Sepia,
shd_Invert,
shd_Noise
)
Effect_Shader(shd)
is_setting = false;
setting = 0;
setting_var = [100, 100];
setting_name = ["Master Volume", "Brightness"];

