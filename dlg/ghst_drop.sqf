/*
V1 script by: Ghost - Creates a c130 and flys to point on map specified by left click and drops selected vehicle.
ghst_drop = [player,"spawnmarker",300] call ghst_fnc_drop;
*/
//if (!isserver) exitwith {};
#include "def_VEHsel.hpp"

_host = _this select 0;
_spawnmark = _this select 1;
_dir = _this select 2;

if (cargodrop) exitwith {_host groupchat "Air Support Busy";};

cargodrop = true;

_vehiclelist = ghst_vehiclelist;


#ifndef VBS
 disableSerialization;
#endif

// fill dialog with vehicle names
createDialog "Selectvehicle";
sleep .1;
_ctrlList = findDisplay DLG_VEH_IDD displayCtrl DLG_VEH_LIST;

for "_i" from 0 to (count _vehicleList)-1 do {
	_vehicle = _vehicleList select _i;
	lbAdd [DLG_VEH_LIST,format["%1",_vehicle select 1]];
	lbSetPicture [DLG_VEH_LIST, _i, _vehicle select 2];
	lbSetValue [DLG_VEH_LIST, _i, _i];
};
lbSort (findDisplay DLG_VEH_IDD displayCtrl DLG_VEH_LIST); 

// put the selection somewhat in the middle of the displayed listing
_i=(_index -9) max 0;
lbSetCurSel [DLG_VEH_LIST, _i];
lbSetCurSel [DLG_VEH_LIST, _index];

// preview controls
_ctrlPic = findDisplay DLG_VEH_IDD displayCtrl DLG_VEH_PIC;
_ctrlName = findDisplay DLG_VEH_IDD displayCtrl DLG_VEH_NAME;
_ctrlDesc = findDisplay DLG_VEH_IDD displayCtrl DLG_VEH_DESC;

_VEHidx=lbValue [DLG_VEH_LIST, _index];
_lstidx=_index;
_lstpos=-1;
DLG_VEH_SELECTED=false;
while {ctrlVisible DLG_VEH_LIST} do {
	_index = lbCurSel DLG_VEH_LIST;
	_posidx = _index;
#ifdef VBS	
	if !(isNil "DLG_VEH_SEL") then {
		if (DLG_VEH_SEL select 3) then {
			_posidx = _ctrlList lbPosIndex [DLG_VEH_SEL select 1,DLG_VEH_SEL select 2];
		};
	};
#endif	
	if (DLG_VEH_SELECTED) then {
		_VEHidx=lbValue [DLG_VEH_LIST, _index];
		closeDialog DLG_VEH_IDD;
	};
	if (_posidx==-1) then {
		_posidx = _index;
	};
	if (_lstpos!=_posidx) then {
		_lbidx = lbValue [DLG_VEH_LIST, _posidx];
		_wDName = (_vehicleList select _lbidx) select 1;
		_wPic = (_vehicleList select _lbidx) select 2;
		_wDesc = (_vehicleList select _lbidx) select 3;
		_ctrlPic ctrlSetText _wPic;
		_ctrlName ctrlSetText _wDName;
		_ctrlDesc ctrlSetStructuredText parseText (_wDesc);
		_lstpos=_posidx;
	};
	sleep .1;
};
if (_lstidx==_index) exitWith {};

_vehsel=(_vehicleList select _VEHidx) select 0;

if (ghst_vehsel != "none" && DLG_VEH_SELECTED) then {
_veh_name = (configFile >> "cfgVehicles" >> (_vehsel) >> "displayName") call bis_fnc_getcfgdata;

_spawnair1 = getmarkerpos _spawnmark;

openMap true;

_host groupchat format ["Left click on the map where you want %1 drop", _veh_name];

mapclick = false;

onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

waituntil {mapclick or !(visiblemap)};
if (!visibleMap) exitwith {
	hint "Air Drop Ready";
	cargodrop=false;
	};
_pos = [clickpos select 0, clickpos select 1, 300];

sleep 1;

openMap false;

//hint format ["%1", _pos];

_airdrop1 = createGroup WEST;

_dir = [_spawnmark, _pos] call BIS_fnc_dirTo;

_air1_array = [_spawnair1, _dir, _air_type, _airdrop1] call BIS_fnc_spawnVehicle;
_air1 = _air1_array select 0;
_air1 setpos [getpos _air1 select 0, getpos _air1 select 1, 500];
_air1 setVelocity [55 * (sin _dir), 55 * (cos _dir), 0];
sleep 1;
_air1 flyinheight 300;
_air1 setSpeedMode "Normal";

_air1 sidechat "I am inbound with cargo";
	
sleep 10;

_air1 setpos [(_pos select 0), (_pos select 1)-1500, 300];

While {alive _air1} do {

_air1 domove _pos;

waituntil {(_air1 distance _pos) < 150};

_airpos = [getpos _air1 select 0, getpos _air1 select 1, 0];

_chute1 = createVehicle ["B_Parachute_02_F",_airpos, [], 0, "FLY"];
_chute1 setpos [(getpos _chute1 select 0) -20, getpos _chute1 select 1, 300]; 

_ghst_drop = createVehicle [_vehsel,_airpos, [], 0, "none"];
	if (_vehsel iskindof "2b14_82mm_base") then {
	{_ghst_drop addmagazine "8Rnd_82mmHE_2B14"} foreach [1,2];
	};
	if (_vehsel iskindof "M252_base") then {
	{_ghst_drop addmagazine "8Rnd_81mmHE_M252"} foreach [1,2];
	};

_ghst_drop attachTo [_chute1,[0,0,1],"paraEnd"];
_ghst_drop addEventHandler ["killed", {_this call ghst_fnc_vehdelete}];
[_ghst_drop, "ColorGrey", _veh_name] call ghst_fnc_tracker;

	[_ghst_drop,_chute1] spawn { 
				_veh = _this select 0;
				_chute = _this select 1;
				waituntil {(getposatl _veh select 2) < 0.5}; 
				detach _veh;
				_veh setposatl [(getposatl _veh select 0),(getposatl _veh select 1)+5,0];
				//deletevehicle _chute;			
			};

if (true) exitwith {};
};

_air1 sidechat "Air drop complete heading home";
sleep 60;

{deletevehicle _x} foreach crew _air1;
deletevehicle _air1;
sleep 5;
deletegroup _airdrop1;

sleep 65;
};
hint "Air Drop Ready";

cargodrop=false;

if (true) exitwith {};