_paramDaytimeHour = "paramDaytimeHour" call BIS_fnc_getParamValue;
if (_paramDaytimeHour == 0) then {
setDate [2024, 3, 1, (round(random 24)), (round(random 55))];//(round(random 1440))
} else {
setDate [2024, 3, 1, _paramDaytimeHour, 0];
};
call ghst_fnc_acquirelocations;
[] spawn ghst_fnc_randweather;

//Enemy Unit list
call ghst_fnc_unitlist;

[["AA1","AA2","AA3","AA4"],"B_APC_Tracked_01_AA_F",(random 360),false] spawn ghst_fnc_basedef;

[(getmarkerpos "eairspawn"),(getmarkerpos "center"),[10000,10000],600,2,[true,15],[false,"ColorRed"]] spawn ghst_fnc_eair;

_PARAM_AISkill = "PARAM_AISkill" call BIS_fnc_getParamValue;
[[(getmarkerpos "Respawn_West"),1000],[500,500],(4 + round(random 2)),[false,"ColorRed"],(_PARAM_AISkill/10)] spawn ghst_fnc_randespawn;


waituntil {! isnil "SHK_Taskmaster_Tasks"};

call ghst_fnc_randomobj;	