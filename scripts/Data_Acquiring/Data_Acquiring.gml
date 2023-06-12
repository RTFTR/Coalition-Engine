function sprite_data_begin() {
	global.sprBuff = ds_map_create();
}

function sprite_pragma(){
	gml_pragma("global", "sprite_data_begin()");
}


function sprite_data_end(){
	// Deletes all data required for sprite_getpixel

	//Delete all buffers
	for(var i = 0,n = ds_map_size(global.sprBuff); i < n; i++){
	    var arr = global.sprBuff[? i];
    
	    for(var j = 0,k = array_length_1d(arr); j < k; j++)
	        if buffer_exists(arr[j]) buffer_delete(arr[j]);
	}

	//Delete map
	ds_map_destroy(global.sprBuff);
}

/// @description Returns an array with the color info of a pixel inside a sprite
/// @param  sprite
/// @param  subimg
/// @param  x
/// @param  y
function sprite_getpixel(_sprite, _subimg, _x, _y) {
	//Important vars
	var sprW = sprite_get_width(_sprite),
		sprH = sprite_get_height(_sprite),
		sprX = sprite_get_xoffset(_sprite),
		sprY = sprite_get_yoffset(_sprite),

	//Check if buffer already exists
		exists = 0,
	//0 = doesn't exist
	//1 = sprite array exists
	//2 = subimg element exists

		key = string(_sprite);

	if (ds_map_exists(global.sprBuff, key)){
	    var arr = global.sprBuff[? key];
    
	    exists++;
    
	    if (array_length_1d(arr) > _subimg && buffer_exists(arr[_subimg])){
	        exists = 2;
	    }
	}

	//Create sprite array
	if !exists {
	    var arr = array_create(_subimg + 1);
    
	    for(var i = 0, n = _subimg + 1; i < n; i++){
	        arr[i] = -1;
	    }
    
	    global.sprBuff[? key] = arr;
    
	    exists++;
	}

	//Create buffer
	if (exists == 1){
	    var arr = global.sprBuff[? key],
    
			buff = buffer_create(4 * sprW * sprH, buffer_fixed, 1);
	    arr[@ _subimg] = buff;
    
	    var surf = surface_create(sprW, sprH);
    
	    surface_set_target(surf);
    
	    draw_clear_alpha(c_white, 0);
    
	    gpu_set_blendmode_ext(bm_one, bm_zero);
    
	    draw_sprite(_sprite, _subimg, sprX, sprY);
    
	    gpu_set_blendmode(bm_normal);
    
	    surface_reset_target();
    
	    buffer_get_surface(arr[_subimg], surf, 0);
    
	    surface_free(surf);
    
	    exists++;
	}

	//Get pixel
	if (exists == 2){
	    var arr = global.sprBuff[? key],
			buff = arr[_subimg];
    
	    buffer_seek(buff, buffer_seek_start, 4 * (sprW * _y + _x));
		
		for(var i = 0, clr; i < 4; ++i)
			clr[i] = buffer_read(buff, buffer_u8);
    
	    return clr;
	}
}