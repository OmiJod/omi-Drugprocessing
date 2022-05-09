local QBCore = exports["qb-core"]:GetCoreObject()
local Config = {
	ItemToGive = "cokebaggy", -- Item to give after the proccess
	ItemToTake = "coke_brick", -- Item to take before
	Coords = vector3(2430.88, 4971.21, 42.35), -- Coords
}

QBCore.Functions.CreateCallback("qb-drug:server:getConfig", function(source, cb)
	cb(Config)
end)

-- Adds The After Process Product You want After The Progress BAr Is Finished

RegisterServerEvent("drug:addbaggies", function()
	local src = source
	local ped = GetPlayerPed(src)
	local Player = QBCore.Functions.GetPlayer(src)
	local Coords = GetEntityCoords(ped)

	if #(Config.Coords - Coords) < 3 then -- lets check here if the player is close to the place
		TriggerEvent("drug:overallproccess", Player)
		if Player.Functions.GetItemByName(Config.ItemToTake) ~= nil then -- lets check if the player has the item
			Player.Functions.RemoveItem(Config.ItemToTake, 1) -- Lets take the item
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.ItemToTake], "remove")
			TriggerClientEvent("QBCore:Notify", src, "Making Drug Bags", "success", 8000)
			Player.Functions.AddItem(Config.ItemToGive, 8) -- Lets give the item
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[Config.ItemToGive], "add") -- Lets give the item
			TriggerEvent("qb-log:server:CreateLog","default",GetCurrentResourceName(),"default","Drug started by "..Player.PlayerData.citizenid)
		end
	else
		TriggerEvent("qb-log:server:CreateLog","anticheat",GetCurrentResourceName(),"red","Player: "..Player.PlayerData.citizenid.." tried to exploit resource: "..GetCurrentResourceName())
		DropPlayer(src, "Trying to exploit resource: " .. GetCurrentResourceName())
	end
end)
