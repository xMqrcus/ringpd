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
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),441.49606323242,-980.39044189453,30.792869567871) < 1.5 then
        DrawText3Ds(441.49606323242,-980.39044189453,30.792869567871+0.2, "~w~Tryk ~b~[E]~w~ for at ringe på klokken")
        if IsControlPressed(0,38) then
          TriggerServerEvent("xmq:ringpd")
          TriggerServerEvent('3dme:shareDisplay', "Ringer på klokken")
          timer = 60
        end
      end
    end

    if timer > 0 then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),441.49606323242,-980.39044189453,30.792869567871) < 1.5 then
        DrawText3Ds(441.49606323242,-980.39044189453,30.792869567871+0.2, "~w~Du skal vente ~r~ "..timer.. "~w~ sekunder for at ringe på klokken.")
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

function ringpdlyd(source)
  PlaySound(source, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
end

RegisterNetEvent("ringpdlyd")
AddEventHandler("ringpdlyd", function()
  PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
end)