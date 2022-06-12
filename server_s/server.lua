ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory


print("Benjo Leaks mod 2k22")

RegisterNetEvent('vule:akohocestavi')
AddEventHandler('vule:akohocestavi', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugapersona = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and Config.Mafije[xJob.name] then
		if drugapersona then 
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('vule:znacipokusava', target)
					return
				end
			end
		end
	end
end)

RegisterNetEvent('vule:izbaciizvozila')
AddEventHandler('vule:izbaciizvozila', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('vule:idegas2', target)
end)

RegisterNetEvent('vule:vuci')
AddEventHandler('vule:vuci', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugapersona = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and Config.Mafije[xJob.name] then
		if drugapersona then 
			if src ~= target then
				TriggerClientEvent('vule:vuci2', target, src)
				return
			end
		end
	end
end)

RegisterServerEvent("vule:vucemdrugiput")
AddEventHandler("vule:vucemdrugiput", function(Target)
	local Source = source
	TriggerClientEvent("vule:dosadno", Target, Source)
end)

RegisterServerEvent('vaskezzyy:vezivanje')
AddEventHandler('vaskezzyy:vezivanje', function(target)
  TriggerClientEvent('vaskezzyy:vezivanje', target)
end)

RegisterServerEvent('vaskezzyy:notifikacija')
AddEventHandler('vaskezzyy:notifikacija', function(target, msg)
	--TriggerClientEvent('esx:showNotification', target, msg)
	TriggerClientEvent('okokNotify:Alert', target, "", msg, 2500, 'info')
end)
----------------------------------------Sefovi

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName then
		for k, v in pairs(Config.Organizacije) do
			ox_inventory:RegisterStash(v.ImeSefa, v.label, v.slots, v.weight, v.owner, v.job)
		end
	end
end)




