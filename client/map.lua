local function updateRadarMap()
    while true do
        SetRadarBigmapEnabled(false, false)
        SetRadarZoom(1000)
        Wait(500)
    end
end

CreateThread(updateRadarMap)

local function updateMap()

    local x = -0.025
    local y = -0.040
    local w = 0.16
    local h = 0.20

    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end

    lib.notify({title = 'Krs Factions', icon = 'fa-solid fa-id-badge', description = 'Map Loading...', type = 'inform'})

    SetMinimapClipType(1)

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    SetMinimapComponentPosition('minimap', 'L', 'B', 0.0, y, w, h)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', x + 0.17, y + 0.09, 0.072, 0.162)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.025, -0.065, 0.19, 0.22)

    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    Wait(50)
    SetRadarBigmapEnabled(false, false)

    lib.notify({title = 'Krs Factions', icon = 'fa-solid fa-id-badge', description = 'Map Has Loaded!', type = 'inform'})
end

AddEventHandler('esx:playerLoaded', function()
    updateMap()
end)

AddEventHandler('esx:onPlayerSpawn', function()
    updateMap()
end)

AddEventHandler('esx:onPlayerLogout', function()
    updateMap()
end)