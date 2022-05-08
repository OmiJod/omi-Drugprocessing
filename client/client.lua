local QBCore = exports["qb-core"]:GetCoreObject()

local isProcessing = false
CreateThread(function()
	Wait(100)
	QBCore.Functions.TriggerCallback(
		"qb-drug:server:getConfig",
		function(config) -- get the info from the server, so no dumping stuff
			exports["qb-target"]:AddBoxZone("drugprocessing", config.Coords, 2.75, 1, {
				name = "drugprocessing",
				heading = 312,
				debugPoly = false,
				minZ = 38.75,
				maxZ = 42.75,
			}, {
				options = {
					{
						event = "drug:overallproccess",
						icon = "fas fa-hammer",
						label = "Process Drug",
						item = config.ItemToTake, --Change Me on server.lua
					},
				},
				distance = 2,
			})
		end
	)
end)
-- Events

RegisterNetEvent("drug:overallproccess", function()
	local player = PlayerPedId() -- Use this so no loop over all the players
	FreezeEntityPosition(player, true)
	QBCore.Functions.Progressbar("drug-", "Breaking down the drug..", 30000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
		anim = "machinic_loop_mechandplayer",
		flags = 16,
	}, {}, {}, function() -- Done
		FreezeEntityPosition(player, false)
		TriggerServerEvent("drug:addbaggies")
		isProcessing = false
	end, function() -- Cancel
		isProcessing = false
		ClearPedTasksImmediately(player)
		FreezeEntityPosition(player, false)
	end)
end)
