/// @desc
var _vw = camera_get_view_width(view_camera[0])/2;
var _vh = camera_get_view_height(view_camera[0])/2;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(_vw, _vh/2, "A TITLE", 2, 2, 0);
draw_set_halign(TEXT_ALIGN_DEFAULT_W);
draw_set_valign(TEXT_ALIGN_DEFAULT_H);

//Blinking
if (title_alarm % 60 == 0)
{
	title_alarm = 0;
	blink_display = !blink_display;
}
title_alarm++;
if (blink_display == true)
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_vw, _vh*2 - (_vh/2), "Press Enter to Begin");
	draw_set_halign(TEXT_ALIGN_DEFAULT_W);
	draw_set_valign(TEXT_ALIGN_DEFAULT_H);
}
