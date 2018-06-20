# Vehicle Salvage v1.0.1
Quick, easy, vehicle salvage script for Exile.
Scroll wheel on the blown up vehicle, progress bar appears on the screen like it would for raiding/repairing etc. Junk Metal as a reward at your feet and the bodies of the occupants will also appear in front of you.
If you need help with my scripts, visit my discord: https://discord.gg/Sm3HGwV - Perma Join link

## Install Instructions!
- Simply, drop the GADD_Apps folder into your mission.pbo (Exile.Tanoa.pbo etc.)
- Customize the settings of the script by editing the "Customize.sqf".
- Add the line from initPlayerLocal into your initPlayerLocal.sqf at the top somewhere near other includes or what not.
- Copy Pasta the block of code from comfig.cpp and add it under class CfgInteractionMenus in your config.cpp under each vehicle type... E.g. class car, class tank, class boat etc. Like so...

class Car 
	{
		targetType = 2;
		target = "Car";

		class Actions 
		{
			class ScanLock: ExileAbstractAction
			{
				title = "Scan Lock";
				condition = "('Exile_Item_ThermalScannerPro' in (magazines player)) && !ExilePlayerInSafezone && ((locked ExileClientInteractionObject) != 1)";
				action = "_this call ExileClient_object_lock_scan";
			};

			// Locks a vehicle
			class Lock: ExileAbstractAction
			{
				title = "Lock";
				condition = "((locked ExileClientInteractionObject) isEqualTo 0) && ((locked ExileClientInteractionObject) != 1)";
				action = "true spawn ExileClient_object_lock_toggle";
			};

			// Unlocks a vehicle
			class Unlock: ExileAbstractAction
			{
				title = "Unlock";
				condition = "((locked ExileClientInteractionObject) isEqualTo 2) && ((locked ExileClientInteractionObject) != 1)";
				action = "false spawn ExileClient_object_lock_toggle";
			};

			// Repairs a vehicle to 100%. Requires Duckttape
			class Repair: ExileAbstractAction
			{
				title = "Repair";
				condition = "true";
				action = "['RepairVehicle', _this select 0] call ExileClient_action_execute";
			};

			// Hot-wires a vehicle
			class Hotwire: ExileAbstractAction
			{
				title = "Hotwire";
				condition = "((locked ExileClientInteractionObject) isEqualTo 2) && ((locked ExileClientInteractionObject) != 1)";
				action = "['HotwireVehicle', _this select 0] call ExileClient_action_execute";
			};

			// Flips a vehicle so the player doesnt have to call an admin
			// Check if vector up is fucked
			class Flip: ExileAbstractAction
			{
				title = "Flip";
				condition = "call ExileClient_object_vehicle_interaction_show";
				action = "_this call ExileClient_object_vehicle_flip";
			};

			// Fills fuel from a can into a car
			class Refuel: ExileAbstractAction
			{
				title = "Refuel";
				condition = "call ExileClient_object_vehicle_interaction_show";
				action = "_this call ExileClient_object_vehicle_refuel";
			};

			// Drains fuel from a car into an empty jerry can
			class DrainFuel: ExileAbstractAction
			{
				title = "Drain Fuel";
				condition = "call ExileClient_object_vehicle_interaction_show";
				action = "_this call ExileClient_object_vehicle_drain";
			};
			// Salvage a vehicle
           		class GADDSalvage: ExileAbstractAction
            		{
                	title = "<t color='#ff0000'>GADD Salvage Vehicle</t>";
                	condition = "(!(alive (ExileClientInteractionObject)))";
                	action = "_this call GADD_SalvageVehicle";
			};
		};
	};
