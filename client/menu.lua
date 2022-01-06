local isOpen = false
local checkbox = {
    one = true
}
local list = {
    'Avant Gauche',
    'Avant Droite',
    'Arriere Gauche',
    'Arriere Droite',
    'Capot',
    'Coffre'
}
local listIndex = 1

local vehMain = RageUI.CreateMenu("Véhicule", "Menu Véhicule")
vehMain.Closed = function()
    isOpen = false
    RageUI.Visible(vehMain, false)
end


function OpenVehiculeMenu()
    local pVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if isOpen then 
        isOpen = false
        RageUI.Visible(vehMain, false)
    else
        isOpen = true
        RageUI.Visible(vehMain, true)
        Citizen.CreateThread(function()
            while isOpen do
                Wait(1)
                RageUI.IsVisible(vehMain, function()
                    RageUI.Button('Démarrer/Fermer le moteur', description, {}, true, {
                        onSelected = function()
                            PowerEngine()
                        end
                    })
                    RageUI.List("Ouvrir/Fermer les portes", list, listIndex, nil, {}, true, {
                        onSelected = function()
                            Door(listIndex)
                        end,
                        onListChange = function(Index)
                            listIndex = Index
                        end
                    })
                    RageUI.Separator("↓ Infos Véhicule ↓")
                    RageUI.Button('Plaque', description, {RightLabel = "["..GetVehicleNumberPlateText(pVeh).."]"}, true, {})
                    RageUI.Button('État Global', description, {RightLabel = "["..GetEntityHealth(pVeh).."]"}, true, {})
                    RageUI.Button('État Carosserie', description, {RightLabel = "["..GetVehicleBodyHealth(pVeh).."]"}, true, {})
                    RageUI.Button('État Moteur', description, {RightLabel = "["..GetVehicleEngineHealth(pVeh).."]"}, true, {})
                    RageUI.Button('Niveau Essence', description, {RightLabel = "["..GetVehicleFuelLevel(pVeh).."]"}, true, {})
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if IsControlJustPressed(0, 344) then
		    if IsPedInAnyVehicle(PlayerPedId()) then
                OpenVehiculeMenu()
            else
                Notif('Vous devez etre dans un véhicule pour acceder a ce menu')
            end
        end
	end
end)
