//V1.5.5 spawns a unit to be rescued
if (!isserver) exitwith {};
waitUntil{!(isNil "BIS_fnc_init")};

_position_mark = _this select 0;//position to search buildings around
_rad = _this select 1;//radius around position to search for buildings
_campmark = _this select 2;//position where camp site is
_unit_type = _this select 3;//unit to be rescued "B_Helipilot_F"
_locselname = _this select 4;//name of location

//create random number
_rnum = str(round (random 999));

//create unit to be rescued
_wGrp = createGroup WEST;
_pow = _wgrp createUnit [_unit_type,_position_mark, [], 0, "NONE"];
_VarName = ("ghst_pow" + _rnum);
_pow setVehicleVarName _VarName;
//_pow Call Compile Format ["%1=_This ;",_VarName];
missionNamespace setVariable [_VarName,_pow];
publicVariable _VarName;
_veh_name = name _pow;

removeAllAssignedItems _pow;
removeallweapons _pow;
_pow setCaptive true;
_pow setunitpos "UP";
_pow setBehaviour "Careless";
dostop _pow;
//_pow playActionNow "Surrender";
_pow playmove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";
_pow disableAI "MOVE";

//add save action
[[_pow],"fnc_ghst_hostjoin",true,true] spawn BIS_fnc_MP;

//send unit to random building
//null0 = [_position_mark,_rad,[_pow],[false,"ColorGreen",false],[3,6,EAST],((paramsArray select 3)/10),false] execvm "scripts\objectives\ghst_PutinBuild.sqf";
ghst_Build_objs = ghst_Build_objs + [_pow];

//create task
_tsk = "tsk_pow" + _rnum;
//create task
[_tsk,format ["Rescue %1 in %2", _veh_name,_locselname],format ["Rescue the POW %1. He is held up in one of the buildings or around %2. Once located bring him back to base.", _veh_name,_locselname],true,[],"created",_position_mark] call SHK_Taskmaster_add;

/*
//create trigger for man dying
_trig1stat = format ["!(alive %1)", _pow];
_trig1act = format ["['%1','failed'] call SHK_Taskmaster_upd;", _tsk];
_trg1 = createTrigger["EmptyDetector",_position_mark];
_trg1 setTriggerArea[0,0,0,false];
_trg1 setTriggerActivation["NONE","PRESENT",false];
_trg1 setTriggerStatements[_trig1stat, _trig1act, "deleteVehicle thistrigger;"];
*/
//create trigger for save point
_trig2cond = "this and ((getposatl (thislist select 0)) select 2 < 1)";
_trig2act = format ["[%1] joinsilent grpNull; ['%2','succeeded'] call SHK_Taskmaster_upd; if (vehicle %1 != %1) then {unassignVehicle (%1); (%1) action ['EJECT', vehicle %1]; [%1] allowGetin false; dostop %1; %1 setCaptive true;};", _pow, _tsk];
_trg2 = createTrigger["EmptyDetector", _campmark];
_trg2 setTriggerArea[10,10,0,false];
_trg2 setTriggerActivation["VEHICLE","PRESENT",false];
_trg2 triggerAttachVehicle [_pow];
_trg2 setTriggerStatements[_trig2cond, _trig2act, "deleteVehicle thistrigger;"];

while {true} do {
	if (triggerActivated _trg2) exitwith {deletevehicle _pow;};
	if (!(triggerActivated _trg2) and !(alive _pow)) exitwith {[_tsk,"failed"] call SHK_Taskmaster_upd; deletevehicle _pow; deleteVehicle _trg2;};
	sleep 5;
};


