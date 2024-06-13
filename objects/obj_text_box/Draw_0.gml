shader_set(sh_cond);
draw_self()
shader_reset()
var _temp_color = draw_get_color()
draw_set_color(text_colour)
draw_text_transformed(x+2, y+0.5, text, 0.08, 0.08, 0)
draw_set_color(_temp_color)