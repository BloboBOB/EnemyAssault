/*
V1.3.1 Script by: Ghost put this in POW init: this setCaptive true; this setBehaviour "Careless"; ghst_hostjoin = this addAction ["Rescue Hostage", "scripts\ghst_hostjoin.sqf", [], 6, true, true, "","alive _target"];
*/

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;

if (not alive _host) exitwith {
hint "Unit Not Alive"; 
_host removeaction _id;
};

[_host] joinsilent (group _caller);
_caller groupchat format ["lets go %1, were getting you out of here", name _host];

_host enableAI "Move";
_host setBehaviour "AWARE";
//_host switchmove "";
[[_host,""],"fnc_ghst_global_switchmove",true,false] spawn BIS_fnc_MP;
_host setcaptive false;

_host domove (position _caller);

//_host removeaction _id;
removeAllActions _host;