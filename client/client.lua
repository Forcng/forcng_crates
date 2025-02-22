RegisterNetEvent('forcng:notify')
AddEventHandler('forcng:notify', function(message)
    lib.notify({
        title = 'Faction Crate',
        description = message,
        type = 'success',
        position = 'center-right',
        icon = 'fa-solid fa-cube',
        iconColor = 'green'
    })
end)

RegisterNetEvent('forcng:openitBaby')
AddEventHandler('forcng:openitBaby', function(tier)
    local playerPed = PlayerPedId()

    local animDict = "amb@prop_human_parking_meter@male@base"
    local animName = "base"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end

    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)

    lib.progressBar({
        duration = 5000,
        label = "Opening Loot Crate...",
        useWhileDead = false,
        canCancel = true
    })

    ClearPedTasks(playerPed)
    TriggerServerEvent('forcng:removeItem', tier)
end)
