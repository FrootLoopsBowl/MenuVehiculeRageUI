function Notif(notifmsg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(notifmsg)
    DrawNotification(0,1)
end

function DoorOpenClose(value)
    local pVeh = GetVehiclePedIsIn(PlayerPedId(), false)

    if GetVehicleDoorAngleRatio(pVeh, value) > 0 then
        SetVehicleDoorShut(pVeh, value, false)
        Notif('Vous avez fermé une porte')       
    else
        SetVehicleDoorOpen(pVeh, value, false, false)
        Notif('Vous avez ouvert une porte')
    end
end

function Door(value)
    if value == 1 then
        DoorOpenClose(0)
    elseif value == 2 then
        DoorOpenClose(1)
    elseif value == 3 then
        DoorOpenClose(2)
    elseif value == 4 then
        DoorOpenClose(3)
    elseif value == 5 then
        DoorOpenClose(4)
    elseif value == 6 then
        DoorOpenClose(5)
    end
end

function PowerEngine()
    local pVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if GetIsVehicleEngineRunning(pVeh) then
        SetVehicleEngineOn(pVeh, false, false, true)
        SetVehicleUndriveable(pVeh, true)
        Notif('Vous avez coupé le moteur')
    elseif not GetIsVehicleEngineRunning(pVeh) then
        SetVehicleEngineOn(pVeh, true, false, true)
        SetVehicleUndriveable(pVeh, false)
        Notif('Vous avez démarré le moteur')
    end
end