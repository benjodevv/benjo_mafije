ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local CopsConnected  = 0
ESX.RegisterServerCallback('vuleprodaja:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('vule:dajnesto', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local reward = math.floor(Config.Cenapojednom * Config.Maksimalnodroge)
		xPlayer.removeInventoryItem('heroin', Config.Maksimalnodroge)
		xPlayer.addAccountMoney('black_money', reward)
end)

ESX.RegisterServerCallback('vule:idegas', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

