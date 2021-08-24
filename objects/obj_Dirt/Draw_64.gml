/// @desc
//draw healthbar if being mined to monitor integrety for now
current_hp = floor((integrety/integrety_max)*100);
if (integrety < integrety_max) draw_healthbar(x,y-2, x+16, y-2,current_hp,c_black,c_red,c_green,0,0,0);