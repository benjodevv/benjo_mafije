ESX = nil
local ox_inventory = exports.ox_inventory

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
        
    end
     while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()


end)
Objects = {}
AddEventHandler("onResourceStop", function(res)
  if GetCurrentResourceName() == res then


    for i = 1, #Objects do
      DeleteObject(Objects[i])
    end


  end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	
	for _,v in pairs(Config.Organizacije) do  
	  RequestModel(GetHashKey(v.prop))
	  while not HasModelLoaded(v.prop) do Wait(100) print("cekam model", model) end
		
    PostaviSef = CreateObject(v.prop, v.lokacija, false, true)
    SetEntityHeading(PostaviSef, v.headings)
    FreezeEntityPosition(PostaviSef, true) 
    SetEntityInvincible(PostaviSef, true)
    --SetBlockingOfNonTemporaryEvents(PostaviSef, true)
    PlaceObjectOnGroundProperly(PostaviSef)
    table.insert(Objects, PostaviSef)
    SetModelAsNoLongerNeeded(v.prop)

    --return PostaviSef
  end 
end)


  

Citizen.CreateThread(function()
    for k, v in pairs(Config.Organizacije) do
      exports.qtarget:RemoveZone(v.ImeSefa.. 'sefovi')
      exports.qtarget:AddBoxZone(v.ImeSefa.. 'sefovi', v.lokacija, v.widths, v.lengths, {
        name= v.namas,
        heading= v.headings,
        debugPoly= v.debug,
        minZ= v.lokacija.z -1,
        maxZ= v.lokacija.z +2,
        }, {
          options = {
            {
              event = "otvorisef",
              icon = "fas fa-sign-in-alt",
              label = "Otvori sef",
              job = v.job,
            }
          },
          distance = 3.5
      })
    end
end)

RegisterNetEvent('otvorisef',function()
    
       
    for k, v in pairs(Config.Organizacije) do     
        if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then  
            TriggerEvent('ox_inventory:openInventory', 'stash',  v.ImeSefa )
        end
    end  
end)
