local QBCore = exports['qb-core']:GetCoreObject() 

local isProcessing = false

-- Events

RegisterNetEvent('drug:overallproccess', function()
    local player = GetPlayerPed(-1)
    FreezeEntityPosition(player, true)
    TriggerServerEvent('drug:removebrick')
    playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 30000)

    QBCore.Functions.Progressbar("drug-", "Breaking down the drug..", 30000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        FreezeEntityPosition(player, false)
        TriggerServerEvent('drug:addbaggies')
        isProcessing = false
    end, function() -- Cancel
        isProcessing = false
        ClearPedTasksImmediately(player)
        FreezeEntityPosition(player, false)
    end)
end)

-- Change This Box Zone Where Ever You want To

exports["qb-target"]:AddBoxZone("drugprocessing", vector3(2430.88, 4971.21, 42.35), 2.75, 1, {
    name="drugprocessing",
    heading=312,
    --debugPoly=true,
    minZ=38.75,
    maxZ=42.75
}, {
	options = {
		{
			event = "drug:overallproccess",     
			icon = "fas fa-hammer",
			label = "Process Drug",
            item = "coke_brick",  --Change Me To The Drug You need To Process For Example coke_brick
		}
	},
	distance = 2
});

function playAnimPed(animDict, animName, duration, buyer, x,y,z)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(pilot, animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end