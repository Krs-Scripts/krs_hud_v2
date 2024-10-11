local swimming = false
local stress = 0

AddEventHandler('esx_status:onTick', function(data)
    local id = lib.callback.await('krs_hud:check', false, cache.playerId)
    local hunger, thirst
    
    for i = 1, #data do
        local status = data[i]
        if status.name == 'thirst' then
            thirst = math.floor(status.percent)
        elseif status.name == 'hunger' then
            hunger = math.floor(status.percent)
        elseif status.name == 'stress' then
            stress = math.floor(status.percent)
        end
    end
    
    swimming = IsPedSwimming(cache.ped)
    
    SendNUIMessage({
        message = 'update_hud',
        health = math.ceil(GetEntityHealth(cache.ped) - 100),
        armor = math.ceil(GetPedArmour(cache.ped)),
        thirst = thirst,
        hunger = hunger,
        stress = stress,
        stamina = GetPlayerStamina(cache.playerId),
        oxygen = GetPlayerUnderwaterTimeRemaining(cache.playerId) * 10,
        isTalking = Voice().isTalking,
        microphone = Voice().mode,
        active = swimming,
        id = cache.serverId,
    })
end)