Overworld_ID = obj_OverworldController.OverWorld_ID;

layer_set_visible(layer_get_id("TileCollision"), global.show_hitbox);
layer_set_visible(layer_get_id("TileCollisionEvent"), global.show_hitbox);

var lay_id = layer_get_id("Background"),
	back_id = layer_background_get_id(lay_id);
layer_background_sprite(back_id, BackgroundSprite);
