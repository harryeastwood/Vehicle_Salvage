/**
	Script Name: Salvage Vehicle Script
	Author: [GADD]Monkeynutz
	Description: Salvage Vehicle Script for Exile. Allows for Salvaging Vehicles that are destroyed and turns it into Junk at the player's feet.
	Special thanks: El'Rabito! Thank you to him for the suggestions and testing!
**/

// Set to true to prevent people salvaging their vehicles during combat.
SalvageVehicle_DISALLOW_DURING_COMBAT 	= true;

// Set in seconds how long you wish for salvaging to take players. (Default = 10)
SalvageVehicle_TIME_TAKEN_TO_SALVAGE 	= 10;

// Set to true means that salvaging a vehicle requires a tool
salvageVehicle_REQUIRE_TOOL				= true;

// Set to true if you want Cars, tanks, aircraft and boats to require different tools. (Must have _salvageVehicle_REQUIRE_TOOL set to true)
salvageVehicle_REQUIRE_TOOL_DIFFERENT	= false;

// Set the clasname of the tools required to salvage all vehicles
salvageVehicle_TOOLS					= ["Exile_Item_Grinder"];

// Set the tools required for JUST cars. (_salvageVehicle_REQUIRE_TOOL AND _salvageVehicle_REQUIRE_TOOL_DIFFERENT must be set to true)
salvageVehicle_REQUIRE_TOOLS_CAR		= ["Exile_Item_Grinder","Exile_Item_Foolbox"];

// Set the tools required for JUST tanks. (_salvageVehicle_REQUIRE_TOOL AND _salvageVehicle_REQUIRE_TOOL_DIFFERENT must be set to true)
salvageVehicle_REQUIRE_TOOLS_TANK		= ["Exile_Item_Grinder","Exile_Item_Foolbox","Exile_Item_Wrench"];

// Set the tools required for JUST aircraft. (_salvageVehicle_REQUIRE_TOOL AND _salvageVehicle_REQUIRE_TOOL_DIFFERENT must be set to true)
salvageVehicle_REQUIRE_TOOLS_AIR		= ["Exile_Item_Grinder","Exile_Item_Foolbox","Exile_Item_Wrench"];

// Set the tools required for JUST boats. (_salvageVehicle_REQUIRE_TOOL AND _salvageVehicle_REQUIRE_TOOL_DIFFERENT must be set to true)
salvageVehicle_REQUIRE_TOOLS_SHIP		= ["Exile_Item_Grinder","Exile_Item_Foolbox","Exile_Item_Wrench"];

// Set this to true to give junk back to the player when salvaging a wreck, set to false to prevent junk dropping.
salvageVehicle_GIVE_JUNK				= true;

// Set this to true to make junk drops specific to Cars, Tanks, Aircraft and Boats. (_salvageVehicle_GIVE_JUNK must be true)
salvageVehicle_GIVE_JUNK_DIFFERENT		= false;

// Set the percentage chance of junk to drop. E.g. set to 50 and there's a 50% chance of each item in _givenJunk spawning.
salvageVehicle_GIVE_JUNK_PERCENTAGE	= 100;

// Set the Junk returned to the player for salvaging a vehicle.
salvageVehicle_givenJunk				= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];

// Set the Junk returned to the player for salvaging a car only.
salvageVehicle_givenJunkCar				= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];

// Set the Junk returned to the player for salvaging a Tank only.
salvageVehicle_givenJunkTank			= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];

// Set the Junk returned to the player for salvaging an Aircraft only.
salvageVehicle_givenJunkAir				= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];

// Set the Junk returned to the player for salvaging a Boat only.
salvageVehicle_givenJunkShip			= [["Exile_Item_JunkMetal", 1],["Exile_Item_MetalPole", 1],["Exile_Item_MetalBoard", 1]];