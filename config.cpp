			// Salvage a vehicle
            class GADDSalvage: ExileAbstractAction
            {
                title = "<t color='#ff0000'>GADD Salvage Vehicle</t>";
                condition = "(!(alive (ExileClientInteractionObject)))";
                action = "_this call GADD_SalvageVehicle";
			};