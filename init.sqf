// Create a mission entry for the server and client RPT file, easier to debug when you know what mission created the error
diag_log text ""; 
diag_log text format["|=============================   %1   =============================|", missionName]; // stamp mission name
diag_log text "";

enableSaving [false, false];


/** SOB specials
*Ohne LEA
*/
enable_lea_addon = false;

/**
* Disable ingame AI radio and local callouts
*/
0 fadeRadio 0;
enableRadio false;
enableSentences false;
player disableConversation false;


CIVILIAN setFriend [WEST, 1];
WEST setFriend [CIVILIAN, 1];
EAST setFriend [CIVILIAN, 1];
INDEPENDENT setFriend [CIVILIAN, 1];

// Wait until player is initialized
if (!isDedicated) then {waitUntil {!isNull player && isPlayer player};};

tf_no_auto_long_range_radio = true;


execVM "shk_taskmaster.sqf";

[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};
