/// @desc Pause Event
if (keyboard_check_pressed(vk_escape))
{
	global.game_paused = !global.game_paused;
	if (global.game_paused)
	{
		instance_deactivate_all(1);
		if (global.screen_shot == -1) 
		{
			global.screen_shot = sprite_create_from_surface(
			application_surface,0,0,view_wport,view_hport,0,0,0,0);
		}
		
	}
	if !(global.game_paused)
	{
		instance_activate_all();
		global.screen_shot = -1;
	}
}
/*else
{
	if(sprite_exists(global.screen_shot))
	{
        sprite_delete(global.screen_shot);
    }
}*/



