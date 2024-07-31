
-- load blip function
local loadblip = function(data)
  local blip = AddBlipForCoord(data.loc.x, data.loc.y, data.loc.z)
    SetBlipSprite(blip, 826) SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6) SetBlipColour(blip, 53)
    SetBlipAsShortRange(blip, true) BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.label) EndTextCommandSetBlipName(blip)
end

-- load hotel door target function
local loadtargets = function(data)
    local zone = exports.ox_target:addBoxZone({
        coords = data.zone.coords,
        size = data.zone.size,
        rotation = data.zone.rotation,
        debug = Debug,
        options = {
            name = data.id,
            icon = 'fa-solid fa-hotel',
            label = 'Enter Hotel Room',
            canInteract = function(_, distance)
                return distance < 1.5
            end,
            onSelect = function()
                print('ID: '..data.id, 'Name: '..data.label, 'Address: '..data.dest)
            end
        }
    })
end

local loadvalets = function(data)
    local ped = { obj = nil, spawned = false}
    local model, crd = lib.requestModel('s_m_y_valet_01'), data.valet
    ped.obj = CreatePed(1, model, crd.x, crd.y, crd.z-1, crd.w, true, false)
    TaskStartScenarioInPlace(ped.obj, 'WORLD_HUMAN_VALET', 0, true)
    FreezeEntityPosition(ped.obj, true)
    SetBlockingOfNonTemporaryEvents(ped.obj, true)
    SetEntityInvincible(ped.obj, true)

    local pdm = { obj = nil, spawned = false }
    local podium, pcrds = lib.requestModel('prop_valet_03'),
    GetOffsetFromEntityInWorldCoords(ped.obj, 0.0, 0.6, 0.0)
    pdm.obj = CreateObject(podium, pcrds.x, pcrds.y, pcrds.z-1, true, false, false)
    SetEntityHeading(pdm.obj, crd.w)
    PlaceObjectOnGroundProperly(pdm.obj)
    SetEntityCollision(pdm.obj, true, true)
end

function LoadHotels()
  for _, hotels in pairs(Hotel.List) do
    -- loading hotel blips
    loadblip(hotels)
    -- load target zones
    loadtargets(hotels)
    -- load valet
    loadvalets(hotels)
  end
end

LoadHotels()