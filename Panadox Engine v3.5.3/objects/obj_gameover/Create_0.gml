x = global.soul_x;
y = global.soul_y;
global.player_attack_boost = 0;
global.player_def_boost = 0;
image_speed = 0;
image_blend = c_red;

window_set_caption("Game Over");

time = 0;
state = 0;
alpha = 0;
allowC = true;

ps = part_system_create();
part_system_depth(ps, 0);

p = part_type_create();
part_type_sprite(p, spr_soul_slice, true, true, true);
part_type_direction(p, 0, 360, 0, 0);
part_type_speed(p, 1, 3, 0, 0);
part_type_gravity(p, 0.12, 270);


alarm[0] = 40;

gameover_text = "[pause]You cannot give\nup just yet...[pause][/page]" +string(global.name)+ "![delay,500]\nStay determined...";
gameover_text_voice = snd_text_voice_asgore;
gameover_writer = scribble(gameover_text);
if gameover_writer.get_page() != 0 gameover_writer.page(0);

gameover_typist = scribble_typist()
	.in(0.25, 0)
	.sound_per_char(gameover_text_voice, 1, 1," ^!.?,:/\\|*")


