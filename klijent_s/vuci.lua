local Drag = {
	Distance = 3,
	Dragging = false,
	Dragger = -1,
	Dragged = false,
}

function Drag:GetPlayers()
	local Players = {}
    
	for Index = 0, 255 do
		if NetworkIsPlayerActive(Index) then
			table.insert(Players, Index)
		end
	end

    return Players
end

function Drag:GetClosestPlayer()
    local Players = self:GetPlayers()
    local ClosestDistance = -1
    local ClosestPlayer = -1
    local PlayerPed = PlayerPedId()
    local PlayerPosition = GetEntityCoords(PlayerPed, false)
    
    for Index = 1, #Players do
    	local TargetPed = GetPlayerPed(Players[Index])
    	if PlayerPed ~= TargetPed then
    		local TargetCoords = GetEntityCoords(TargetPed, false)
    		local Distance = #(PlayerPosition - TargetCoords)

    		if ClosestDistance == -1 or ClosestDistance > Distance then
    			ClosestPlayer = Players[Index]
    			ClosestDistance = Distance
    		end
    	end
    end
    
    return ClosestPlayer, ClosestDistance
end

RegisterNetEvent("Drag")
AddEventHandler("Drag", function(Dragger)
	Drag.Dragging = not Drag.Dragging
	Drag.Dragger = Dragger
end)
RegisterNetEvent("vaskezzyy:vuci", function()
ExecuteCommand("drag")
end)
RegisterCommand("drag", function(source, args, fullCommand)
	local Player, Distance = Drag:GetClosestPlayer()

	if Distance ~= -1 and Distance < Drag.Distance then
		TriggerServerEvent("Drag", GetPlayerServerId(Player))
	else
		exports['okokNotify']:Alert("", "pridji blize", 4000, 'error')
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			exports['okokNotify']:Alert("", "Benjo Leaks Projekat 2022", 4000, 'success')
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Drag.Dragging then
			local PlayerPed = PlayerPedId()

			Drag.Dragged = true
			AttachEntityToEntity(PlayerPed, GetPlayerPed(GetPlayerFromServerId(Drag.Dragger)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			if Drag.Dragged then
				local PlayerPed = PlayerPedId()

				if not IsPedInParachuteFreeFall(PlayerPed) then
					Drag.Dragged = false
					DetachEntity(PlayerPed, true, false)    
				end
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(500)
		end
	end
end)

