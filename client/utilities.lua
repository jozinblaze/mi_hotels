-- teleport function
Teleport = function(ped, x, y, z, w)
    DoScreenFadeOut(100)
    Citizen.Wait(1000)
    SetEntityCoords(ped, x, y, z, false, false, false, false)
    SetEntityHeading(ped, w)
    DoScreenFadeIn(750)
end

-- load shell function
CreateShell = function(shell, model, coord, head)
    shell = CreateObject(model, coord.x,
    coord.y, coord.z, true, false, false)
    SetEntityHeading(shell, head)
    FreezeEntityPosition(shell, true)
end

-- delete shell function
DeleteShell = function(shell)
    if not shell then
        print('not shell to delete') return end
    DeleteEntity(shell)
    shell = nil
end