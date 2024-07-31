-- variables
local vehicle, vehicleNet
local Inventory = exports.ox_inventory

-- get net id function
local getNetId = function(ent)
    Citizen.Wait(100)
    local vNetId = NetworkGetEntityFromNetworkId(ent)
    if Debug then print(vNetId) end
    return vNetId
end

-- check to see if player has housing
AddEventHandler('ox:playerLoaded', function(source)
    local player = Ox.GetPlayer(source)
    if not player or not player.charId then return end

    local charid, stateid = player.charId, player.stateId
    print('Loaded: '..charid, stateid)
end)

lib.callback.register('mihotels:rentalfee', function(source, cost)
    local player = Ox.GetPlayer(source)
    Inventory:AddItem(source, 'money', math.random(150, 250), true)
    
end)

lib.callback.register('mihotels:create:vehicle', function(source, model, data)
    local player = Ox.GetPlayer(source)
    vehicle = Ox.CreateVehicle({
        model = model, owner = player.charid,
    }, data.garage, data.garage.w)
    -- load vehicle properties
    vehicleNet = getNetId(vehicle)
    if Debug then
        print(player.stateId, vehicle) print(vehicleNet)
    end
end)

lib.callback.register('mihotels:delete:vehicle', function(source)
    local txt = { id = 'rentalerror', title = 'Cannot turn in Vehicle',
    description = 'This is not the rental vehicle you took out'}
    local player = Ox.GetPlayer(source)
    local entity = GetVehiclePedIsIn(player, false)
    if entity == 0 and getNetId(vehicle) ~= vehicleNet then
    DoNotif(txt, Err) return end
    if getNetId(vehicle) == vehicleNet and
    vehicle.group == group then
        vehicle.delete()
    end
    return true
end, false)