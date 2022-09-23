///@desc Enemy Drawing
var E_Sprites = array_length(enemy_sprites);
for (var i = 0; i < E_Sprites; ++i)
draw_sprite_ext(enemy_sprites[i], enemy_sprite_index[i],
				x+ enemy_sprite_pos[i, 0], y + enemy_sprite_pos[i, 1],
				enemy_sprite_scale[i, 0], enemy_sprite_scale[i, 1],
				0,c_white,image_alpha);
