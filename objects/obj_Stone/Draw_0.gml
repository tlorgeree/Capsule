/// @desc
//draw healthbar if being mined to monitor integrity for now
draw_self();
current_hp = floor((integrity/integrity_max)*100);
if (integrity < integrity_max) draw_healthbar(x,y-2, x+16, y-2,current_hp,c_black,c_red,c_green,0,0,0);
