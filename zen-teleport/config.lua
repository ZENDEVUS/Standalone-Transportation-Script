Config = {}

Config.TeleportLocations = {
    {
        name = "Wig Shop",
        targetLocation = {
            coords = vector3(114.2435, -204.3250, 54.6653), -- Target (exit)
            marker = {
                type = 1, -- Marker type (e.g., 1 is a cylinder)
                size = vector3(1.5, 1.5, 1.0), -- Size of the marker
                color = { r = 255, g = 0, b = 0, a = 100 }, -- Color of the marker
                drawDistance = 100.0, -- Distance at which the marker is drawn
                bounce = true -- Marker animation
            },
            textUI = {
                message = '[E] - Exit',
                options = {
                    position = 'top-center',
                    icon = 'hand',
                    style = {
                        borderRadius = 0,
                        backgroundColor = '#48BB78',
                        color = 'white'
                    }
                }
            }
        },
        teleportLocation = {
            coords = vector3(119.3327, -203.0751, 54.6201), -- Teleport (entry)
            marker = {
                type = 1, -- Marker type (e.g., 1 is a cylinder)
                size = vector3(1.5, 1.5, 1.0), -- Size of the marker
                color = { r = 0, g = 255, b = 0, a = 100 }, -- Color of the marker
                drawDistance = 100.0, -- Distance at which the marker is drawn
                bounce = true -- Marker animation
            },
            textUI = {
                message = '[E] - Enter',
                options = {
                    position = 'top-center',
                    icon = 'hand',
                    style = {
                        borderRadius = 0,
                        backgroundColor = '#48BB78',
                        color = 'white'
                    }
                }
            }
        }
    },
    -- Add more locations here
}
