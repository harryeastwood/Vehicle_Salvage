/**
	Script Name: Salvage Vehicle Script
	Author: [GADD]Monkeynutz
	Description: Salvage Vehicle Script for Exile. Allows for Salvaging Vehicles that are destroyed and turns it into Junk Metal at the player's feet.
	Special thanks: El'Rabito! Thank you to him for the suggestions and testing!
**/

private ["_SalvageVehicle_DISALLOW_DURING_COMBAT","_SalvageVehicle_TIME_TAKEN_TO_SALVAGE","_salvageVehicle_REQUIRE_TOOL","_salvageVehicle_TOOLS","_toolName",
		"_keyDown","_mouseDown","_startTime","_duration","_sleepTime","_progress","_uiControl","_percentage","_progressBarBackground","_progressBarMaxSize",
		"_progressBar","_barColour","_junk","_givenJunk","_scrapVehicle","_vehClass","_vehName","_cfgClass","_toolNameArray","_salvageVehicle_GIVE_JUNK",
		"_salvageVehicle_GIVE_JUNK_PERCENTAGE","_counter"];

_SalvageVehicle_DISALLOW_DURING_COMBAT 	= true;					// Set to true to prevent people salvaging their vehicles during combat.
_SalvageVehicle_TIME_TAKEN_TO_SALVAGE 	= 10; 					// Set in seconds how long you wish for salvaging to take players. (Default = 10)
_salvageVehicle_REQUIRE_TOOL			= false; 				// Set to true means that salvaging a vehicle requires a tool
_salvageVehicle_TOOLS					= ["Exile_Item_Grinder"];	// Set the clasname of the tool required to salvage a vehicle
_salvageVehicle_GIVE_JUNK				= true;					// Set this to true to give junk back to the player when salvaging a wreck, set to false to prevent junk dropping.
_salvageVehicle_GIVE_JUNK_PERCENTAGE	= 100;					// Set the percentage chance of junk to drop. E.g. set to 50 and there's a 50% chance of each item in _givenJunk spawning.
_givenJunk								= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];	// Set the Junk returned to the player for salvaging a vehicle.

// Do not edit below this line unless you know what you are doing!

_scrapVehicle = (_this select 0);
_vehClass = typeOf (_this select 0);
_cfgClass = _vehClass call ExileClient_util_gear_getConfigNameByClassName;
_vehName = getText(configFile >> _cfgClass >> _vehClass >> "displayName");

if (ExileClientActionDelayShown) exitWith { false };
ExileClientActionDelayShown = true;
ExileClientActionDelayAbort = false;

if (ExileClientPlayerIsInCombat && _SalvageVehicle_DISALLOW_DURING_COMBAT) exitWith
{
	["ErrorTitleAndText",["Vehicle Salvage!", "You cannot salvage a vehicle while in combat!"]] call ExileClient_gui_toaster_addTemplateToast;
	ExileClientActionDelayShown = false;
	ExileClientActionDelayAbort = false;	
};

_toolNameArray = [];

if (_salvageVehicle_REQUIRE_TOOL) exitWith
{
	{
		_cfgClass = _x call ExileClient_util_gear_getConfigNameByClassName;	// Should return "CfgMagazines"
		_toolName = getText(configFile >> _cfgClass >> _x >> "displayName");
	
		if !(_x in (items player)) exitWith
		{
			["ErrorTitleAndText",["Vehicle Salvage!", format ["You need to be carrying a %1 to salvage a %2!", _toolName, _vehName]]] call ExileClient_gui_toaster_addTemplateToast;
	
			ExileClientActionDelayShown = false;
			ExileClientActionDelayAbort = false;	
		};
	} forEach _salvageVehicle_TOOLS;
};

["InfoTitleAndText",["Vehicle Salvage!", format ["Salvaging %1!", _vehName]]] call ExileClient_gui_toaster_addTemplateToast;

disableSerialization;
("ExileActionProgressLayer" call BIS_fnc_rscLayer) cutRsc ["RscExileActionProgress", "PLAIN", 1, false];

_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call ExileClient_action_event_onKeyDown"];
_mouseDown = (findDisplay 46) displayAddEventHandler ["MouseButtonDown","_this call ExileClient_action_event_onMouseButtonDown"];
_startTime = diag_tickTime;
_duration = _SalvageVehicle_TIME_TAKEN_TO_SALVAGE;
_sleepTime = _duration / 100;
_progress = 0;
_uiControl = uiNamespace getVariable "RscExileActionProgress";   
_percentage = _uiControl displayCtrl 4002;
_progressBarBackground = _uiControl displayCtrl 4001;  
_progressBarMaxSize = ctrlPosition _progressBarBackground;
_progressBar = _uiControl displayCtrl 4000;  
_barColour = [];
			
player playAction "Exile_Acts_RepairVehicle01_Animation01";
["switchMoveRequest", [netId player, "Exile_Acts_RepairVehicle01_Animation01"]] call ExileClient_system_network_send;
_percentage ctrlSetText "0%";
_progressBar ctrlSetPosition [_progressBarMaxSize select 0, _progressBarMaxSize select 1, 0, _progressBarMaxSize select 3];
_progressBar ctrlSetBackgroundColor [0, 0.78, 0.93, 1];
_progressBar ctrlCommit 0;
_progressBar ctrlSetPosition _progressBarMaxSize; 
_progressBar ctrlCommit _duration;
try
{
	while {_progress < 1} do
	{	
		if (ExileClientActionDelayAbort) then 
		{
			throw 1;
		};

		uiSleep _sleepTime; 
		_progress = ((diag_tickTime - _startTime) / _duration) min 1;
		_percentage ctrlSetText format["%1%2", round (_progress * 100), "%"];
	};
	throw 0;
}
catch
{
	
	switch (_exception) do 
	{
		case 0:
		{
			_barColour = [0.7, 0.93, 0, 1];
			deleteVehicle _scrapVehicle;
 
			if (_salvageVehicle_GIVE_JUNK) then
			{
				_junk = "groundweaponHolder" createVehicle position player;
				if (_salvageVehicle_GIVE_JUNK_PERCENTAGE == 100) then
				{
					["SuccessTitleAndText", ["Vehicle Salvage!", format ["You have successfully Salvaged this %1! Some Junk has fallen on the floor!", _vehName]]] call ExileClient_gui_toaster_addTemplateToast;
				}else
				{
					["SuccessTitleAndText", ["Vehicle Salvage!", format ["You have successfully Salvaged this %1! Some Junk might have fallen on the floor!", _vehName]]] call ExileClient_gui_toaster_addTemplateToast;
				};
				{
					_counter = round (random 100);
					if (_counter >= _salvageVehicle_GIVE_JUNK_PERCENTAGE) then
					{
						_junk addMagazineCargo _x;
					};
				} forEach _givenJunk;
				_junk setPosATL getPosATL player;
			}else
			{
				["SuccessTitleAndText", ["Vehicle Salvage!", format ["You have successfully Salvaged this %1!", _vehName]]] call ExileClient_gui_toaster_addTemplateToast;
			};
		};
		case 1: 	
		{ 
			["ErrorTitleAndText", ["Vehicle Salvage!", "Salvaging Canceled!"]] call ExileClient_gui_toaster_addTemplateToast;
			_barColour = [0.82, 0.82, 0.82, 1];
		};
	};	
	player switchMove "";
	["switchMoveRequest", [netId player, ""]] call ExileClient_system_network_send;
	_progressBar ctrlSetBackgroundColor _barColour;
	_progressBar ctrlSetPosition _progressBarMaxSize;
	_progressBar ctrlCommit 0;
};

("ExileActionProgressLayer" call BIS_fnc_rscLayer) cutFadeOut 2; 
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _keyDown];
(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _mouseDown];
ExileClientActionDelayShown = false;
ExileClientActionDelayAbort = false;
