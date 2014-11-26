/*V1.2.1 Script By: Ghost attach selected vehicle to helicopter. Check ghst_slingattach.sqf for instructions.
*/

_heli = _this select 0;
_caller = _this select 1;
_id = _this select 2;

if (isnil "ghst_sling_veh") exitwith {hintsilent "No object to sling";};

_veh = ghst_sling_veh;

//if ((speed _heli < 40) and (speed _heli > -40) and (((getposatl _heli select 2) > 10) or ((surfaceIsWater getposasl _heli) and ((getposaslw _heli select 2) > 10)))) then {

_veh_name = getText (configFile >> "cfgVehicles" >> (typeof _veh) >> "displayName");

_veh allowdamage false;

if !(isnil "_id") then {
	_heli removeaction _id;
};
if !(isnil "ghst_slingload") then {
	_heli removeaction ghst_slingload;
};
if !(isnil "ghst_slingdetach") then {
	_heli removeaction ghst_slingdetach;
};
if !(isnil "ghst_slingcancel") then {
	_heli removeaction ghst_slingcancel;
};


slung = true;

_veh attachto [_heli,[0,4,-10]];
hintsilent format ["%1 Slung", _veh_name];
	
ghst_slingdetach = _heli addAction ["<t color='#ff0000'>Release Vehicle</t>", "scripts\sling\ghst_slingdetach.sqf", [_veh,_veh_name], 5, true, true, "","alive _target and _this == driver _target and (speed _target < 40) and (speed _target > -40) and (((getposatl _target select 2) < 16 and (getposatl _target select 2) > 10) or ((surfaceIsWater getposasl _target) and ((getposaslw _target select 2) < 16 and (getposaslw _target select 2) > 10)))"];
	
while {alive _heli} do {
	sleep 5;
	};
detach _veh;
_veh allowdamage true;
/*
} else {
hintsilent "Altitude must be between 10-16 \nSpeed must be Under 40km/h";
};
*/