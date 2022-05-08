local QBCore = exports['qb-core']:GetCoreObject() 

-- Removes The Commodity You want  The Moment You Trigger The Event So That There are No Duplicting Glitch

RegisterServerEvent("drug:removebrick")
AddEventHandler("drug:removebrick", function(x,y,z)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)

		if 	TriggerClientEvent("QBCore:Notify", src, "Making Drug Bags", "success", 8000) then 
			Player.Functions.RemoveItem('coke_brick', 1)  -- Change Me To what Ever You wanna Process
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke_brick'], "remove")   -- Change Me To what Ever You wanna Process
		end
	end)

-- Adds The After Process Product You want After The Progress BAr Is Finished 

RegisterServerEvent("drug:addbaggies")
AddEventHandler("drug:addbaggies", function(x,y,z)
          local src = source
          local Player = QBCore.Functions.GetPlayer(src)
    
            if 	TriggerClientEvent("QBCore:Notify", src, "Making Drug Bags", "success", 8000) then
                Player.Functions.AddItem('cokebaggy', 8) -- Change Me To what Ever You want as The Out Come
                TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggy'], "add") -- Change Me To what Ever You want as The Out Come
            end
        end)

QBCore.Functions.CreateCallback('drug:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "coke_brick" then  -- Change Me Too
					cb(true)
			    else
					cb(false)
				end
	        end
		end	
	end
end)