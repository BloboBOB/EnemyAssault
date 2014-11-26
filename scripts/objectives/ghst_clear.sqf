//V1.1 By: Ghost - gives all clear when enemy units are less than 3
if (!isserver) exitwith {};
waitUntil{!(isNil "BIS_fnc_init")};

_position_mark = _this select 0;//position to search units around
_radarray = _this select 1;//radius around position to search for units
	_radx = ((_radarray select 0) + 300);//radius x
	_rady = ((_radarray select 1) + 300);//radius y
_locselname = _this select 2;//name of location	
_side = _this select 3;//side of enemy

//create task
["tsk_clear","Eliminate All Enemy in %2","Eliminate all enemy presence in %2.",true,[],"created",_position_mark, _locselname] call SHK_Taskmaster_add;

sleep 60;

//create trigger for no enemy left
_trg1=createTrigger["EmptyDetector",_position_mark];
_trg1 setTriggerArea[_radx,_rady,0,false];
_trg1 setTriggerActivation[format ["%1", _side];,"PRESENT",false];
_trg1 setTriggerStatements["count thislist < 3","['tsk_clear','succeeded'] call SHK_Taskmaster_upd;", "deleteVehicle _trg1;"];