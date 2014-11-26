_veh = _this select 0;//aircraft to initiate script on.
_pos = [0,6,-2]; 	// location of lights xyz on C130J 

player setVariable ["dix_halojump", true];

player groupchat "Get ready to jump";
hint "Get ready to jump";

_para_light1 = "Chemlight_red" createVehicle (position _veh);
_para_light1 attachto [_veh, _pos];
_para_light = createVehicle ["#lightpoint", position _veh, [], 0, "NONE"]; 
_para_light lightAttachObject [_veh, _pos];
_para_light setLightColor [250,0,0];
_para_light setLightAttenuation [0.3,0,0,500]; 
_para_light setLightIntensity 200;

sleep 15;// length of red light (ready light)

Deletevehicle _para_light;
Deletevehicle _para_light1;

{[ [[_x],"scripts\Dix_Halo\halo_addaction.sqf"], "BIS_fnc_execVM", _x, false] call BIS_fnc_MP;} foreach crew _veh; 

player groupchat "Jumpers Go";
hint "Jumpers Go";

_para_light3 = "Chemlight_green" createVehicle (position _veh);
_para_light3 attachto [_veh, _pos];
_para_light2 = createVehicle ["#lightpoint", position _veh, [], 0, "NONE"];   
_para_light2 lightAttachObject [_veh, _pos];
_para_light2 setLightColor [0,250,0];
_para_light2 setLightAttenuation [0.3,0,0,500]; 
_para_light2 setLightIntensity 200;


sleep 20;// length of green light (jump light)

Deletevehicle _para_light2;
Deletevehicle _para_light3;

sleep 10;// the amount time after green light is off that halo is still available

player setVariable ["dix_halojump", false];