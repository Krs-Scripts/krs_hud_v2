local function ShowSpeedometer(isMetric, speed, fuel)
    SendNUIMessage({
        action = "show",
        isMetric = isMetric,
        speed = speed,
        fuel = fuel,
    })
end

local function HideSpeedometer()
    SendNUIMessage({
        action = "hide"
    })
end

local function updateSpeedometer()
    while true do
        if cache.vehicle then
            local speed = GetEntitySpeed(cache.vehicle)
            local fuel = Entity(cache.vehicle).state.fuel
            -- print(fuel)
            ShowSpeedometer(ShouldUseMetricMeasurements(), speed, fuel)
        else
            HideSpeedometer()
        end
        Wait(200)
    end
end

CreateThread(updateSpeedometer)

if Config.radar then
    local function updateRadar()
        while true do
            if cache.vehicle then
                DisplayRadar(true)
            else
                DisplayRadar(false)
            end
            Wait(1000)
        end
    end

    CreateThread(updateRadar)
end