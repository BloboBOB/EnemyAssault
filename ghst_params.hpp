class EmtpyLine1
{
	title = ":: Mission Settings";
	values[]={0,0};
	texts[]={ "",""};
	default = 0;
};
class paramDaytimeHour
{
	title = "    Time of Day:";
	values[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,0};
	texts[] = {"0100","0200","0300","0400","0500","0600","0700","0800","0900","1000","1100","1200","1300","1400","1500","1600","1700","1800","1900","2000","2100","2200","2300","2400","Random"};
	default = 12;
};
/*
//class paramDaytimeHour
#define DAYTIMEHOUR_DEFAULT	12
#include "\a3\functions_f\Params\paramDaytimeHour.hpp"
*/
class PARAM_Rain
{
	title= "    Weather Setting:";
	values[]= {0,1,3,6,90,99};
	texts[]= {"Random Weather and No Rain","Random Weather and Rain","%30 Rain","%60 Rain","Stormy Heavy Rain","Stormy no Rain"};
	default= 1;
};
class PARAM_Teamdead
{
	title = "    Fail Mission when Team is killed:";
	values[] = {1,0};
	texts[] = {"Yes","No"};
	default = 0;
};
class PARAM_AISkill
{
	title= "    AI Accuracy and Speed Skill";
	values[]= { 1,2,3,4,5,6,7,8,9,10 };
	texts[]= { "0.1","0.2","0.3","0.4","0.5","0.6","0.7","0.8","0.9","1.0" };
	default= 3;
	code = "";
};
class PARAM_Tasks
{
	title = "    Number of Tasks:";
	values[] = {8,7,6,5,4,3,2,1};
	texts[] = {"8","7","6","5","4","3","2","1"};
	default = 6;
};
class PARAM_Enemy
{
	title = "    Type of Enemy:";
	values[] = {2,1,0};
	texts[] = {"Random","Greek Army","Iranian Army"};
	default = 1;
};
class PARAM_Kavala
{
	title = "    Number of Locations:";
	values[] = {3,2,1,0};
	texts[] = {"ALL","Half","Kavala Only","Random"};
	default = 3;
};
class PARAM_Fatigue
{
	title = "    Player Fatigue:";
	values[] = {1,0};
	texts[] = {"ON","OFF"};
	default = 0;
};
class PARAM_PlayerVehicles
{
	title = "    Number of Player Vehicles Allowed:";
	values[] = {1,2,3,4,5,6};
	texts[] = {"1","2","3","4","5","6"};
	default = 3;
};
class EmtpyLine2
{
	title = ":: Mod Settings";
	values[]={0,0};
	texts[]={ "",""};
	default = 0;
};
/*class PARAM_HeadlessClient
{
	title = "Headless Client:";
	values[] = {1,0};
	texts[] = {"ON","OFF"};
	default = 0;
};
*/