lib.callback.register('krs_hud:check', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    local id = source

    return id
end)


local function updateOsDate()
    while true do
        local time = os.date("%d.%m.%Y | %H:%M:%S") 
        -- print("Data e ora corrente:", time)
        GlobalState["tempo"] = time
        Wait(1000)
    end
end

CreateThread(updateOsDate)