/*
V1.2 By: Ghost
Creates a marker that stays with a vehicle until its dead. ghst_tracker = [vehname, "color"] execvm "dta\scripts\ghst_tracker.sqf";
*/
if !(local player) exitwith {};
_veh = _this select 0;
_mcolor = _this select 1;
_veh_name = _this select 2;

//_vehtype = typeof _veh;
_vehpos = getpos _veh;

_mtext = format ["%1", _veh_name];
_mark1 = [_vehpos,_mcolor,_mtext] call fnc_ghst_mark_point;

sleep 1;
while {alive _veh} do {
	_mark1 setmarkerposlocal (getpos _veh);
	if (isnil "_veh") exitwith {};
	sleep 1;
};
deletemarkerlocal _mark1;