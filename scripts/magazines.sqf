/*
V1.2 Script by Ghost (main design by Kronzky) Will add all items, magazines to an ammo box. no more manual typing of weapon/magazine/item names.
put null0 = this execVM "scripts\magazines.sqf"; in the initline of an ammo box.
*/

_wepcount = 30;
_magcount = 30;

clearMagazineCargoGlobal _this;
clearWeaponCargoGlobal _this;
clearItemCargoGlobal _this;

_weaponsList = [];

_this addItemCargoGlobal ["FirstAidKit",_magcount];

_magazinesList = [];
_namelist = [];
_cfgmagazines = configFile >> "cfgmagazines";
for "_i" from 0 to (count _cfgmagazines)-1 do {
	_magazine = _cfgmagazines select _i;
	if (isClass _magazine) then {
		_mCName = configName(_magazine);
		_mDName = getText(configFile >> "cfgmagazines" >> _mCName >> "displayName");
		_mModel = getText(configFile >> "cfgmagazines" >> _mCName >> "model");
		_mType = getNumber(configFile >> "cfgmagazines" >> _mCName >> "type");
		_mscope = getNumber(configFile >> "cfgmagazines" >> _mCName >> "scope");
		_mPic =  getText(configFile >> "cfgmagazines" >> _mCName >> "picture");
		_mDesc = getText(configFile >> "cfgmagazines" >> _mCName >> "Library" >> "libTextDesc");	

		if ((_mCName!="") && (_mDName!="") && (_mModel!="") && (_mPic!="")) then {
			if !(_mDName in _namelist) then {
				_magazinesList = _magazinesList + [[_mCName]];
					_namelist = _namelist + [_mDName];
			};
		};
	};
	/*
	if (_i % 10==0) then {
		hintsilent format["Loading magazines List... (%1)",count _magazinesList];
		sleep .0001;
};*/
};
hint "";
_namelist = nil;

for "_i" from 0 to (count _weaponsList)-1 do {
	_weapon = _weaponsList select _i;
	_this addWeaponCargoGlobal [_weapon select 0,_wepcount];
};

for "_i" from 0 to (count _magazinesList)-1 do {
	_magazine = _magazinesList select _i;
	_this addMagazineCargoGlobal [_magazine select 0,_magcount];
};