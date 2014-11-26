/* IntlightON by Dixon: calls the Interior light on or off, the following line need to be on your C130.
nul = [this] execVM "scripts\Dix_Halo\IntLightSwitch.sqf";
*/

_veh = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_veh setVariable ["Light_available",false];
_pos = [0,6,-2];


		_IntLights1 = "Chemlight_blue" createVehicle (position _veh);
		_IntLights1 attachto [_veh, _pos];
		_IntLights = createVehicle ["#lightpoint", position _veh, [], 0, "NONE"]; 
		_IntLights lightAttachObject [_veh, _pos];
		_IntLights setLightColor [250,250,250];
		_IntLights setLightAttenuation [0.3,0,0,500]; 
		_IntLights setLightIntensity 100;

Waituntil {_veh getvariable "Light_available"};
Deletevehicle _IntLights;
Deletevehicle _IntLights1;