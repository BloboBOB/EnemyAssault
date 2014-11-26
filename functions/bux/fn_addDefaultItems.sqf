private ["_unit"];

_unit = _this select 0;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
//_unit linkItem "ItemRadio";
_unit linkItem "tf_fadak";

// Insurgents would probably use goat fat :D
_unit addItem "AGM_EarBuds";

for "_i" from 1 to 2 do {_unit addItem "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItem "AGM_CableTie";};
for "_i" from 1 to 4 do {_unit addItem "AGM_Bandage";};
