vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "xmq_ringpd")

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local timer = 1


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if timer == 0 then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),442.61642456055,-981.08001708984,30.689317703247) < 4 then
        DrawText3Ds(442.61642456055,-981.08001708984,30.689317703247+0.2, "~w~Tryk ~b~[E]~w~ for at ringe på klokken")
        if IsControlPressed(0,38) then
          TriggerServerEvent("xmq:ringpd")
          timer = 300
        end
      end
    end

    if timer > 0 then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),442.61642456055,-981.08001708984,30.689317703247) < 4 then
        DrawText3Ds(442.61642456055,-981.08001708984,30.689317703247+0.2, "~w~Du skal vente ~r~ "..timer.. "~w~ sekunder for at ringe på klokken.")
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    while timer > 0 do
      Citizen.Wait(1000)
      timer = timer-1
    end
  end
end)