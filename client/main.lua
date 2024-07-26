-- initial start to verify correct loading
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      if Debug then print('error loading ' .. resourceName) end
    else
      if Debug then print(resourceName .. ' started') end
      --TriggerEvent('mih:init:load:doors')
    end
end)

-- load hotel blips
function LoadBlips()
  for _, hotels in pairs(Hotel.List) do
      local blipData = hotels.blip
      local blip = AddBlipForCoord(blipData.x, blipData.y, 0)
      SetBlipSprite(blip, Hotel.Blip.spr) SetBlipDisplay(blip, 4)
      SetBlipScale(blip, Hotel.Blip.scl) SetBlipColour(blip, Hotel.Blip.clr)
      SetBlipAsShortRange(blip, true) BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Hotel.Blip.lbl) EndTextCommandSetBlipName(blip)
  end
end

LoadBlips()