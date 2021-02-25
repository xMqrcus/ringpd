local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP", "xmq_ringpd")
vRPclient = Tunnel.getInterface("vRP","xmq_ringpd")

RegisterServerEvent('xmq:ringpd')
AddEventHandler('xmq:ringpd', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local players = {}
    local users = vRP.getUsers()
  
    for k, v in pairs(users) do
      local player = vRP.getUserSource({tonumber(k)})
      if vRP.hasPermission({k, "police.service"}) then
        table.insert(players, player)
      end
    end
  
    for k, v in pairs(players) do
        TriggerClientEvent("pNotify:SendNotification", v ,{text = "En borger har ringet på klokken på Mission Row Politistation", type = "error", queue = "global", timeout = 8000, layout = "BottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    end
end)