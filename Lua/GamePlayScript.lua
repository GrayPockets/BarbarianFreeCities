local InjectFreeCityHash = DB.MakeHash("NOTIFICATION_INJECT_FREE_CITY");

ExposedMembers.BarbarianFreeCities = {};

function InjectFreeCity(pPlot, tribeName)
	print("Inject Free City!");

	-- Get Free City Information
	local pPlayer = Players[62];
	if pPlayer == nil then
		print("Could not find player number 62: Free Cities")
		return;
	end
	local pPlayerCities = pPlayer:GetCities();

	ImprovementBuilder.SetImprovementType(pPlot, -1, NO_PLAYER);
			
	local pCity = pPlayerCities:Create( pPlot:GetX(), pPlot:GetY() );
	if pCity == nil then 
		print("Failed to spawn city on plot " .. pPlot:GetX() .. "," .. pPlot:GetY() .. " for unknown reason");
		return;
	end
	print("Injected free city of " .. Locale.Lookup( pCity:GetName() ) .. " on plot " .. pPlot:GetX() .. "," .. pPlot:GetY());

	-- Set new Free City population to current Era
	while pCity:GetPopulation() < Game.GetEras():GetCurrentEra() do
		pCity:ChangePopulation(1);
	end

	-- Notification of new Free City

	for iPlayerId = 0, GameDefines.MAX_PLAYERS-1, 1 do
		if (Players[iPlayerId]:IsHuman() and Players[iPlayerId]:IsAlive()) then
			local pRevealed : boolean = PlayersVisibility[iPlayerId]:IsRevealed(pPlot:GetX(), pPlot:GetY());
			if pRevealed then
				local notificationData:table = {}
				notificationData.Message = Locale.Lookup("LOC_NOTIFICATION_INJECT_FREE_CITY_MESSAGE"); -- Short
				notificationData.Summary = Locale.Lookup("LOC_NOTIFICATION_INJECT_FREE_CITY_SUMMARY", tribeName, pCity:GetName()); -- Long
				notificationData.Icon = "ICON_NOTIFICATION_REBELLION";
				notificationData.AlwaysUnique = true;
				notificationData[ParameterTypes.LOCATION] = { x = pPlot:GetX(), y = pPlot:GetY() };
				print("Notified Player: ", iPlayerId);
				NotificationManager.SendNotification(iPlayerId, InjectFreeCityHash, notificationData);
			end
		end
	end
end

ExposedMembers.BarbarianFreeCities.InjectFreeCity = InjectFreeCity;