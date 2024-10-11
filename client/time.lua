local function updateTime()
    while true do
        SendNUIMessage({
            message = 'info',
            value = {
                time = GlobalState["tempo"]
            }
        })
        Wait(500)
    end
end

CreateThread(updateTime)
