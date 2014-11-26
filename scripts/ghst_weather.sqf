//V1.4 Script by: Ghost - Random weather every 20-40 mins
//execvm "scripts\ghst_weather.sqf";
private ["_rain","_winddir","_windstr","_overcast"];

//initial weather setting
_overcast = (3 + round(random 6)) / 10;

if (paramsArray select 1 == 1) then {
	_rain = floor(random 9) / 10;
} else {
	_rain = (paramsArray select 1);
};

_winddir = round(random 360);
_windstr = floor(random 6) / 10;

//diag_log format ["OVERCAST %1: RAIN %2: WINDDIR %3: WINDSTR %4", _overcast, _rain, _winddir, _windstr];

//send weather info to clients
missionNamespace setVariable ["ghst_weather", [_overcast, _rain, _winddir, _windstr]];
publicvariable "ghst_weather";

_delay = 86400;
skipTime -24;
[_delay] call fnc_ghst_UpdateWeather;
skipTime 24;

sleep 1;

simulWeatherSync;

//looping dynamic weather
while {true} do {
	private ["_overcastnext","_rainnext","_winddirnext","_windstrnext","_rain","_winddir","_windstr","_overcast"];

	sleep 1200 + round(random 1200);
		
	_ghst_weather = missionNamespace getvariable "ghst_weather";

	_overcast = _ghst_weather select 0;
	_rain = _ghst_weather select 1;
	_winddir = _ghst_weather select 2;
	_windstr = _ghst_weather select 3;
	
	//get random weather
	_overcastnext = (_overcast + (round((random(0.2)-0.1) * 100)) / 100);
	if (_overcastnext > 1) then {_overcastnext = 1;};
	if (_overcastnext < 0.2) then {_overcastnext = 0.2;};
	_rainnext = (_rain + (round((random(0.2)-0.1) * 100)) / 100);
	if (_rainnext > 1) then {_rainnext = 1;};
	if (_rainnext < 0) then {_rainnext = 0;};
	if (paramsArray select 1 == 0) then {_rainnext = 0;};
	_winddirnext = _winddir;
	_windstrnext = (_windstr + (round((random(0.2)-0.1) * 100)) / 100);
	if (_windstrnext > 7) then {_windstrnext = 7;};
	if (_windstrnext < 0) then {_windstrnext = 0;};

	//diag_log format ["OVERCAST %1: RAIN %2: WINDDIR %3: WINDSTR %4", _overcastnext, _rainnext, _winddirnext, _windstrnext];
	//send weather info to clients
	missionNamespace setVariable ["ghst_weather", [_overcastnext, _rainnext, _winddirnext, _windstrnext]];
	publicvariable "ghst_weather";
	
	sleep 10;
	
	[[900],"fnc_ghst_UpdateWeather"] spawn Bis_fnc_MP;
	
};