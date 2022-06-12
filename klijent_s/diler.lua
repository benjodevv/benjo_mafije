ESX								= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

---------------------------------------NH-CONTEXT-------------------------------------------------------

RegisterNetEvent('nh-context:katalogprodaje', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Prodaja droge",
            txt = "Budite diskretni"
        },
        {
            id = 2,
            header = "Heroin",
            txt = "Cena 500$ po komadu",
            params = {
                event = "prodajadroge",
            }
        },
    })
end)


------------------------------------------------------BOX-ZONA---------------------------------------------------


Citizen.CreateThread(function()
	for k, v in pairs(Config.Diler) do
	  exports.qtarget:RemoveZone(v.name.. 'diler')
	  exports.qtarget:AddBoxZone(v.name.. 'diler', v.coords, v.width, v.length, {
		name= v.nama,
		heading= v.heading,
		debugPoly= v.debug,
		minZ= v.coords.z -1,
		maxZ= v.coords.z +2,
		}, {
		  options = {
			{
			  event = v.event,
			  icon = "fas fa-sign-in-alt",
			  label = "Pricaj sa dilerom",
			  job = v.job,
			}
		  },
		  distance = 3.5
	  })
	end
  end)
---------------------------------------------------------PRODAJA-----------------------------------
RegisterNetEvent("prodajadroge", function()

ESX.TriggerServerCallback('vuleprodaja:getItemAmount', function(quantity)
		if quantity >= Config.Maksimalnodroge then
			ESX.TriggerServerCallback('vule:idegas', function(CopsConnected)
				if CopsConnected >= Config.Policijazaprodaju then
					FreezeEntityPosition(playerPed, true)
					exports.ox_inventory:Progress({
						duration = 10000,
						label = 'Prodajes drogu',
						useWhileDead = false,
						canCancel = true,
						disable = {
							move = false,
							car = true,
							combat = true,
							mouse = false
						},
					}, function(cancel)
						if not cancel then
							FreezeEntityPosition(playerPed, false)
							ESX.TriggerServerCallback('vule:dajnesto', function()
							end)
							blip = false
						end
					end)

				else
					blip = false
				end
			end)
		else
			blip = false
			exports['republika_notifikacije']:Alert("", "Nemas dovoljno heroina", 2500, 'error')
		end
	end, 'heroin')
end)
