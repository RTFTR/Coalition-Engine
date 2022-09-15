draw_sprite_ext(spr_gameover,0,320,124,1,1,0,c_white,alpha);
if state == 0
	draw_self();
	
if allowC == true and state < 3
{
	if input_check_pressed("menu")
	{
		audio_stop_all();
		gameover_writer.page(gameover_writer.get_page_count());
		state = 3;
		time = 60;
	}
}


if state == 2
{
	if alpha < 1 alpha += 0.01;
	if alpha == 1
	{
		gameover_writer.starting_format("font_dt_mono",c_white)
		gameover_writer.draw(165, 300, gameover_typist)
		
		if gameover_typist.get_paused() gameover_typist.unpause();

		if gameover_typist.get_state() == 1 and input_check_pressed("confirm") and
		   gameover_writer.get_page() < (gameover_writer.get_page_count() - 1)
			gameover_writer.page(gameover_writer.get_page() + 1)
		else if input_check_pressed("confirm") and 
				gameover_typist.get_state() == 1 and 
				gameover_writer.get_page() >= (gameover_writer.get_page_count() - 1)
		{
			state++;
			audio_sound_gain(bgm,0,2800);
		}
	}
}

if state == 3
{
	if alpha > 0 alpha -= 0.01;
	if alpha <= 0
	{
		time++
		part_system_destroy(ps);
		part_type_destroy(p);
		if gameover_writer.get_page() != 0 gameover_writer.page(0);
	}
	if time >= 60 game_restart();
}

