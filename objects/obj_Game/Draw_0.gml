/// @desc
if ((global.game_paused) && (global.screen_shot != -1))
{
	
	draw_sprite_ext(global.screen_shot,0,0,0,1/3,1/3,0,c_white,1);
	
	draw_set_halign(fa_center);
	draw_text(view_wport[0]/6, view_hport[0]/6, "Paused");
	draw_set_halign(fa_left);
}