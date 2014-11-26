/*V1.2.2 Script By: Ghost Put This in helicopter Init will slingload object around 10 meters below
ghst_slingload = this addAction ["Sling Vehicle", "scripts\sling\ghst_slingload.sqf", [], 1, false, true, "","alive _target and _this == driver _target"];
this addAction ["<t color=""#ffff00"">Slingload Vehicle</t>", "scripts\sling\ghst_slingload.sqf", [], 1, false, true, "","alive _target and _this == driver _target"];
*/
private ["_veh","_veharray","_veh_type_array"];

_heli = _this select 0;
_caller = _this select 1;
_id = _this select 2;

if (_heli iskindof "B_Heli_Transport_01_F") then {
	_veh_type_array = ["StaticWeapon","MRAP_01_base_F","Offroad_01_base_F","Ship_F","Quadbike_01_base_F","Hatchback_01_base_F","SUV_01_base_F","UGV_01_base_F"];
} else {
	_veh_type_array = ["StaticWeapon","Car_F","Ship_F"];
};

_heli removeaction _id;

ghst_slingcancel = _heli addAction ["<t color='#ff0000'>Cancel Slingload</t>", "scripts\sling\ghst_slingcancel.sqf", [], 5, false, true, "","alive _target and _this == driver _target"];

ghst_slingattach = _heli addAction ["<t color='#00ff00'>Sling Vehicle</t>", "scripts\sling\ghst_slingattach.sqf", [], 6, true, true, "","alive _target and _this == driver _target and (speed _target < 40) and (speed _target > -40) and (((getposatl _target select 2) < 16 and (getposatl _target select 2) > 10) or ((surfaceIsWater getposasl _target) and ((getposaslw _target select 2) < 16 and (getposaslw _target select 2) > 10)))"];

[] call BIS_fnc_PiP;
ghst_sling_cameratarget = "Sign_Sphere25cm_F" createVehicleLocal (getposatl _heli);
sleep 0.1;
ghst_sling_cameratarget attachto [_heli ,[0,4,-12]];
_cam_loc = ([0,3.5,-3]);//
ghst_sling_pip = ["rendertarget0",[[_heli,_cam_loc],ghst_sling_cameratarget],_heli] call BIS_fnc_PIP;
ghst_sling_pip camCommit 0;

slung = false;
while {!slung} do {
	
	_veharray = nearestobjects [ghst_sling_cameratarget, _veh_type_array, 10];
	ghst_sling_veh = _veharray select 0;

	//if (!(isnil "ghst_sling_veh") and (speed _heli < 40) and (speed _heli > -40) and (((getposatl _heli select 2) > 10) or ((surfaceIsWater getposasl _heli) and ((getposaslw _heli select 2) > 10)))) then {
	if !(isnil "ghst_sling_veh") then {
	
		_veh_name = getText (configFile >> "cfgVehicles" >> (typeof ghst_sling_veh) >> "displayName");
		_wPic =  getText(configFile >> "cfgvehicles" >> (typeof ghst_sling_veh) >> "picture");
		hintsilent parseText format ["Nearest Vehicle: %1<br/><img size='2.5' image='%2'/><br/>Altitude must be between 10-16 and Speed must be Under 40km/h",_veh_name, _wPic];

	} else {
	
		hintsilent "Altitude must be between 10-16 \nSpeed must be Under 40km/h";
		
	};
	
	sleep 0.5;
	
};