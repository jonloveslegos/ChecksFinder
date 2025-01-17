global.fn_is_flag = function(_tile) {
	with(_tile) {
		return marked
	}
}
global.fn_is_unmarked_bomb = function(_tile) {
	with(_tile) {
		return !marked && type == "bomb"
	}
}

function scr_reveal_tile(_tile) {
	with (_tile) {
		if (global.canclick == true && revealed == false && marked == false)
		{
		    revealed = true
		    scr_gen_pieces(x,y,global.tile_data.foreground)
		    if (global.clicked == false)
		    {
		        global.clicked = true
		        scr_generate_room(x, y)
		    }
		    if (type == "bomb")
		    {
		        with(obj_tile)
		        {
					if (!revealed && global.other_settings.pieces_recursive) {
						scr_gen_pieces(x,y,global.tile_data.foreground)
					}
		            revealed = true
		        }
		        global.canclick = false
		        // Send Deathlink if enabled
		        if (global.ap.deathlink == 1)
		        {
		        	var deathlink_time = scr_unix_timestamp()
		        	var deathlink_send = [{
		        		cmd: "Bounce",
		        		tags: ["DeathLink"],
		        		data: {
		        			time: deathlink_time,
		        			source: global.ap.slotname,
		        			cause: ""
		        		},
		        	}]
		        	scr_send_packet(deathlink_send)
		        }
		        alarm[0] = 30
		        audio_play_sound(snd_explosion,0,false)
		    }
		    else
		    {
		        if (type == "none" && scr_count_surrounding(self,global.fn_is_bomb) == 0)
		        {
		            scr_uncover_surrounding(self)
		        }
		        audio_play_sound(snd_digright,0,false)
		    }
		}
		else if (global.canclick == true && revealed == true)
		{
		    var _flags = scr_count_surrounding(self,global.fn_is_flag)
		    var _unmarked_bombs = scr_count_surrounding(self,global.fn_is_unmarked_bomb)
		    if (_flags == scr_count_surrounding(self,global.fn_is_bomb))
		    {
		        if (_unmarked_bombs > 0)
		        {
		            with(obj_tile)
		            {
						if (!revealed) {
							scr_gen_pieces(x,y,global.tile_data.foreground)
						}
		                revealed = true
		            }
		            global.canclick = false
		            alarm[0] = 30
		            audio_play_sound(snd_explosion,0,false)
		        }
		        else
		        {
		            scr_uncover_surrounding(self)
		            audio_play_sound(snd_digright,0,false)
		        }
		    }
		}
	}
}
