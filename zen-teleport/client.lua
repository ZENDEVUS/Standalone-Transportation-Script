local isPlayerNear = false
local currentLocationIndex = nil
local isAtTeleportLocation = false

-- Function to display the TextUI
function showTextUI(message, options)
    lib.showTextUI(message, options)
end

-- Function to hide the TextUI
function hideTextUI()
    lib.hideTextUI()
end

-- Function to teleport the player with a fade effect and notification
function teleportPlayer(teleportLocation, locationName)
    DoScreenFadeOut(1000)
    Wait(1000)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, teleportLocation.x, teleportLocation.y, teleportLocation.z, false, false, false, true)
    Wait(1000)
    DoScreenFadeIn(1000)
    lib.notify({
        title = 'Teleportation',
        description = 'Successfully teleported to ' .. locationName,
        type = 'success'
    })
end

-- Function to draw a marker
function drawMarker(marker, location)
    DrawMarker(marker.type, location.x, location.y, location.z - 1.0, 0, 0, 0, 0, 0, 0, marker.size.x, marker.size.y, marker.size.z, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bounce, true, 2, false, nil, nil, false)
end

-- Monitor player position and key press
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        isPlayerNear = false

        for index, location in ipairs(Config.TeleportLocations) do
            -- Draw markers for both target and teleport locations
            if #(playerCoords - location.targetLocation.coords) < location.targetLocation.marker.drawDistance then
                drawMarker(location.targetLocation.marker, location.targetLocation.coords)
            end
            if #(playerCoords - location.teleportLocation.coords) < location.teleportLocation.marker.drawDistance then
                drawMarker(location.teleportLocation.marker, location.teleportLocation.coords)
            end

            -- Handle teleport to location
            if #(playerCoords - location.teleportLocation.coords) < 1.0 then
                if not isPlayerNear then
                    showTextUI(location.teleportLocation.textUI.message, location.teleportLocation.textUI.options)
                    isPlayerNear = true
                    currentLocationIndex = index
                    isAtTeleportLocation = true
                end

                if IsControlJustPressed(0, 38) and currentLocationIndex == index then -- "E" key
                    teleportPlayer(location.targetLocation.coords, location.name)
                    hideTextUI()
                    showTextUI(location.targetLocation.textUI.message, location.targetLocation.textUI.options)
                    isAtTeleportLocation = false
                end
            -- Handle exit from location
            elseif #(playerCoords - location.targetLocation.coords) < 1.0 then
                if not isPlayerNear then
                    showTextUI(location.targetLocation.textUI.message, location.targetLocation.textUI.options)
                    isPlayerNear = true
                    currentLocationIndex = index
                    isAtTeleportLocation = false
                end

                if IsControlJustPressed(0, 38) and currentLocationIndex == index then -- "E" key
                    teleportPlayer(location.teleportLocation.coords, location.name)
                    hideTextUI()
                    showTextUI(location.teleportLocation.textUI.message, location.teleportLocation.textUI.options)
                    isAtTeleportLocation = true
                end
            elseif currentLocationIndex == index then
                hideTextUI()
                isPlayerNear = false
                currentLocationIndex = nil
            end
        end

        Wait(0)
    end
end)