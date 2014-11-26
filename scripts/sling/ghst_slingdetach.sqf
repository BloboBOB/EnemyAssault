/*V1.3.1 Script By: Ghost detaches selected vehicle from helicopter. Check ghst_slingattach.sqf for instructions.
*/

_heli = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_array1 = _this select 3;
_veh = _array1 select 0;
_veh_name = _array1 select 1;

//if ((speed _heli < 40) and (speed _heli > -40) and (((getposatl _heli select 2) > 10) or ((surfaceIsWater getposasl _heli) and ((getposaslw _heli select 2) > 10)))) then {

if !(isnil "_id") then {
	_heli removeaction _id;
};
if !(isnil "ghst_slingload") then {
	_heli removeaction ghst_slingload;
};
if !(isnil "ghst_slingattach") then {
	_heli removeaction ghst_slingattach;
};
if !(isnil "ghst_slingcancel") then {
	_heli removeaction ghst_slingcancel;
};

_veh allowdamage true;

detach _veh;

hintsilent format ["%1 Released", _veh_name];

ghst_slingload = _heli addAction ["<t color='#ffff00'>Slingload Vehicle</t>", "scripts\sling\ghst_slingload.sqf", [], 5, false, true, "","alive _target and _this == driver _target"];

[] call BIS_fnc_PiP;
closeDialog 0;
deletevehicle ghst_sling_cameratarget;
/*
	if (surfaceIsWater getposasl _veh) then {

	_veh setposaslw [getposaslw _veh select 0,getposaslw _veh select 1,0];

	} else {

	_veh setposatl [getposatl _veh select 0,getposatl _veh select 1,0];
	
	};

} else {
hintsilent "Altitude must be between 10-16 \nSpeed must be Under 40km/h";
};
*/	