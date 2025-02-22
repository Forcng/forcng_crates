ESX = exports['es_extended']:getSharedObject()


-- If You Want To Change The Spawn Codes To Your Items That Will Make The Script Work.
ESX.RegisterUsableItem('loot_crate1', function(src)
    TriggerClientEvent('forcng:openitBaby', src, 'Tier1')
end)

ESX.RegisterUsableItem('loot_crate2', function(src)
    TriggerClientEvent('forcng:openitBaby', src, 'Tier2')
end)

ESX.RegisterUsableItem('loot_crate3', function(src)
    TriggerClientEvent('forcng:openitBaby', src, 'Tier3')
end)


function loserCrate(tier, src)
    local crate = Config.FactionsCrate[tier]
    if not crate then
        return
    end

    local chance = 0
    for _, item in ipairs(crate) do
        chance = chance + item.chance
    end

    local math = math.random(1, chance)
    local chance2 = 0

    for _, item in ipairs(crate) do
        chance2 = chance2 + item.chance
        if math <= chance2 then
            westbumbleFu(src, item.item)
            TriggerClientEvent('forcng:notify', src, 'You have opened a faction crate and received: ' .. item.item)
            -- Used For Debugging, You May Remove These If Needed :)
            print(item.item)
            print(src)
            return
        end
    end
end

function westbumbleFu(src, item)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.addInventoryItem(item, 1)
    end
end

RegisterNetEvent('forcng:removeItem')
AddEventHandler('forcng:removeItem', function(tier)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.removeInventoryItem('loot_crate' .. tier:sub(-1), 1)
        loserCrate(tier, src)
        print("A Loser Just Used His Factions Crate " .. xPlayer.getName())
    end
end)
