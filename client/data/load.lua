--[[    Variables    ]]--
local shell = { spawned = false, obj = nil }
local entry, exit

local test = {
    address = 'Apartments: 636 Spanish Ave.', mngr_ped = 'a_f_m_ktown_01',
    mngr_loc = vec4(-395.293, 146.683, 65.722, 89.084),
    name = 'A1012', shell = 'shell_v16low',

    door_iside = vec3(-381.45, 150.1, 71.5), door_oside = vec3(-383.45, 152.9, 65.7),

    telp_iside = vec4(-380.933, 150.203, 71.037, 277.953),
    telp_oside = vec4(-383.899, 152.799, 65.531, 100.705),

    head_iside = 10.0, head_oside = 10.0,
    shell_loc = vec3(-375.546, 155.902, 70.50), shell_head = -80,

    contract = 12, cost = 4200, deposit = 700
}

local device = {
    name = 'xm_prop_x17_laptop_mrsr', loc = vec3(-373.034, 151.085, 73.216), rot = 177.96,
    obj = nil
}

--[[    Event: Load Gen Class Shell    ]]--
RegisterNetEvent('mi:hsg:load_apartment:shell')
AddEventHandler('mi:hsg:load_apartment:shell', function()
    -- load shell
    shell.obj = CreateObject(test.shell, test.shell_loc.x, test.shell_loc.y,
    test.shell_loc.z, true, false, false)
    SetEntityHeading(shell.obj, test.shell_head)
    FreezeEntityPosition(shell.obj, true)

    entry = exports.ox_target:addSphereZone({
        coords = test.door_iside.xyz,
        radius = 0.5, debug =  Debug,
        options = {
            {
                icon = 'fa-solid fa-door-open', label = 'Leave your Home',
                canInteract = function(_, distance) return distance < 1.5 end,
                onSelect = function()
                    Teleport(cache.ped, test.telp_oside.x, test.telp_oside.y,
                    test.telp_oside.z-1, test.telp_oside.w)
                    local txt = { id = 'ent_gen', title = 'Exiting: ' .. test.name,
                    desc = 'You unlocked your door' }
                    TriggerEvent('notif', txt, Cor)
                end
            },
        }
    })

    -- load management device
    device.obj = CreateObject(device.name, device.loc.x, device.loc.y,
    device.loc.z, true, false, false)
    SetEntityHeading(device.obj, device.rot)
    FreezeEntityPosition(device.obj, true)

end)

--TriggerEvent('mi:hsg:load_apartment:shell')

RegisterNetEvent('mi:hsg:load_apartment:door')
AddEventHandler('mi:hsg:load_apartment:door', function()
    entry = exports.ox_target:addSphereZone({
    coords = test.door_oside.xyz,
    radius = 0.5, debug =  Debug,
    options = {
        {
            icon = 'fa-solid fa-door-open', label = 'Enter your Home',
            canInteract = function(_, distance) return distance < 1.5 end,
            onSelect = function()
                Teleport(cache.ped, test.telp_iside.x, test.telp_iside.y,
                test.telp_iside.z-1, test.telp_iside.w)
                local txt = { id = 'ent_gen', title = 'Entering: ' .. test.name,
                desc = 'You unlocked your door' }
                TriggerEvent('notif', txt, Cor)
            end
        },
    },
})
end)

--TriggerEvent('mi:hsg:load_apartment:door')