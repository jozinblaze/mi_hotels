-- initial start to verify correct loading
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      if Debug then print('error loading ' .. resourceName) end
    else
      if Debug then print(resourceName .. ' started') end
      TriggerEvent('mih:init:load:doors')
    end
end)


function LoadHousingDoors()
  for _, v in ipairs(Data.housing) do
    -- debug to load all names in client console
    if debug then print('loaded house: ' .. v) end
    -- get information and input into different targets
    local door = exports.ox_target:addBoxZone({
      coords = v.coords, size = v.size,
      rotation = v.rotation, debug = Debug,
      options = {
        {
          name = v.name, icon = 'fa-solid fa-door-open',
          label = 'Interact with Door',
          onSelect = function()
            if Debug then print('door menu opened') end
            -- menu to interact with door
          end,
          canInteract = function(_, distance)
            return distance < 2.0 end
        }
      }
    })
  end
end

RegisterNetEvent('mih:init:load:doors')
AddEventHandler('mih:init:load:doors', function()
  -- variables for targets
  local icon, label = 'fa-solid fa-door-open', 'Interact with Door'
  -- for loop to load all doors
  for _, v in ipairs(Data.housing) do
    -- debug to load all names in client console
    if debug then print('loaded house: ' .. v) end
    -- get information and input into different targets
    local door = exports.ox_target:addBoxZone({
      coords = v.coords, size = v.size,
      rotation = v.rotation, debug = Debug,
      options = {
        {
          name = v.name, icon = icon, label = label,
          onSelect = function()
            if Debug then print('door menu opened') end
            -- menu to interact with door
          end,
          canInteract = function(_, distance)
            return distance < 2.0 end
        }
      }
    })
  end
end)