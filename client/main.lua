-- initial start to verify correct loading
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
      if Debug then print('loaded ' .. resourceName) end
    end
end)