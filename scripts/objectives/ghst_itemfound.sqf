//removes addaction and deletes object and sets task to complete
//ghst_itemfound = _intelobj addAction ["<t color=""#ffff00"">Grab Intel</t>", "scripts\objectives\ghst_itemfound.sqf", [tskitem], 6, true, false, "","alive _target"];

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_tsk = _this select 3;

_host removeaction _id;

deletevehicle _host;

_caller sidechat "I found intel";

_caller addrating 5000;

[[_tsk],"fnc_ghst_tsk_complete",false,false] spawn BIS_fnc_MP;