image_blend = global.game_color.textbox_background
shader_set(sh_cond);
draw_self()
shader_reset()
var _c = global.game_color.input_text
draw_text_transformed_color(x+2, y+0.5, text, 0.42, 0.42, 0, _c, _c, _c, _c, 1)
