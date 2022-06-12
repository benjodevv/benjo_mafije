ESX	= nil

PlayerData = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end


	Citizen.Wait(2000)
	PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
  for k, v in pairs(Config.Organizacije) do
    exports.qtarget:RemoveZone(v.name.. 'garaza')
    exports.qtarget:AddBoxZone(v.name.. 'garaza', v.coords, v.width, v.length, {
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
            label = "Otvori Garazu",
            job = v.job,
          },
          {
            event = "vule:vratiauto3",
            icon = "fa-solid fa-money-bill-1",
            label = "Vrati vozilo",
            job = v.job,
            num = 2,
            canInteract = function()
              return IsPedInAnyVehicle(PlayerPedId(), false)
            end,
          },
        },
        distance = 3.5
    })
  end
end)


RegisterNetEvent('vule:idegas2')
AddEventHandler('vule:idegas2', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)



exports.qtarget:Player({
  options = {
      {
          event = "pretrazi",
          icon = "fas fa-box-circle-check",
          label = "Pretrazi",

      },
  },
  distance = 1.5
})
-----------------------------vozila-------------------------
RegisterNetEvent('nh-context:mafijav', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Meni vozila",
            txt = ""
        },
        {
            id = 2,
            header = "Sultan",
            txt = "Zemunski vozila",
            params = {
                event = "zemunski1",
            }
        },
		{
            id = 3,
            header = "Blista",
            txt = "Zemunski vozila",
            params = {
                event = "zemunski2",
            }
        },
		{
            id = 4,
            header = "Motor",
            txt = "Zemunski vozila",
            params = {
                event = "zemunski3",
            }
        },
    })
end)
RegisterNetEvent("zemunski1", function()

  local ModelHash = "sultan" 
  if not IsModelInCdimage(ModelHash) then return end
  RequestModel(ModelHash) 
  while not HasModelLoaded(ModelHash) do 
    Citizen.Wait(10)
  end
  local MyPed = PlayerPedId()
  local Vehicle = CreateVehicle(ModelHash, vector3(-126.471, 1004.590, 235.73), 50, true, false)
  TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
  print("spawnaovaljda")

end)


RegisterNetEvent("zemunski2", function()

	local ModelHash = "blista" 
	if not IsModelInCdimage(ModelHash) then return end
	RequestModel(ModelHash) 
	while not HasModelLoaded(ModelHash) do 
	  Citizen.Wait(10)
	end
	local MyPed = PlayerPedId()
	local Vehicle = CreateVehicle(ModelHash, vector3(-126.471, 1004.590, 235.73), 50, true, false)
	TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
  print("spawnaovaljda")
  
  end)


  RegisterNetEvent("zemunski3", function()

	local ModelHash = "bf400" 
	if not IsModelInCdimage(ModelHash) then return end
	RequestModel(ModelHash) 
	while not HasModelLoaded(ModelHash) do 
	  Citizen.Wait(10)
	end
	local MyPed = PlayerPedId()
	local Vehicle = CreateVehicle(ModelHash, vector3(-126.471, 1004.590, 235.73), 50, true, false)
	TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
  print("spawnaovaljda")
  
  end)


RegisterNetEvent('vule:vratiauto3', function()
    local vrativozilo = GetLastDrivenVehicle(PlayerPedId())
      DeleteVehicle(vrativozilo)
      exports['okokNotify']:Alert("", "Uspesno ste vratili vozilo", 3000, 'success')
	    print("vratiovaljda")
end)

RegisterNetEvent('nh-context:mafijav2', function()
  TriggerEvent('nh-context:sendMenu', {
      {
          id = 1,
          header = "Meni vozila2",
          txt = ""
      },
      {
          id = 2,
          header = "Sultan",
          txt = "Gsf vozila",
          params = {
              event = "gsf1",
          }
      },
  {
          id = 3,
          header = "Blista",
          txt = "Gsf vozila",
          params = {
              event = "gsf2",
          }
      },
  {
          id = 4,
          header = "Motor",
          txt = "Gsf vozila",
          params = {
              event = "gsf3",
          }
      },
  })
end)
RegisterNetEvent("gsf1", function()

local ModelHash = "sultan" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(103.3126, -1948.77, 20.760), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("gsf2", function()

local ModelHash = "blista" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(103.3126, -1948.77, 20.760), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("gsf3", function()

local ModelHash = "bf400" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(103.3126, -1948.77, 20.760), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)

RegisterNetEvent('nh-context:mafijav3', function()
  TriggerEvent('nh-context:sendMenu', {
      {
          id = 1,
          header = "Meni vozila3",
          txt = ""
      },
      {
          id = 2,
          header = "Sultan",
          txt = "Pink Panteri vozila",
          params = {
              event = "pinkpanteri",
          }
      },
  {
          id = 3,
          header = "Blista",
          txt = "Pink Panteri vozila",
          params = {
              event = "pinkpanteri2",
          }
      },
  {
          id = 4,
          header = "Motor",
          txt = "Pink Panteri vozila",
          params = {
              event = "pinkpanteri3",
          }
      },
  })
end)
RegisterNetEvent("pinkpanteri", function()

local ModelHash = "sultan" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-3209.00, 832.0996, 8.9309), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("pinkpanteri2", function()

local ModelHash = "blista" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-3209.00, 832.0996, 8.9309), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("pinkpanteri3", function()

local ModelHash = "bf400" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-3209.00, 832.0996, 8.9309), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)

RegisterNetEvent('nh-context:mafijav4', function()
  TriggerEvent('nh-context:sendMenu', {
      {
          id = 1,
          header = "Meni vozila2",
          txt = ""
      },
      {
          id = 2,
          header = "Sultan",
          txt = "Gsf vozila",
          params = {
              event = "medelin1",
          }
      },
  {
          id = 3,
          header = "Blista",
          txt = "Gsf vozila",
          params = {
              event = "medelin2",
          }
      },
  {
          id = 4,
          header = "Motor",
          txt = "Gsf vozila",
          params = {
              event = "medelin3",
          }
      },
  })
end)
RegisterNetEvent("medelin1", function()

local ModelHash = "sultan" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-885.090, 16.88713, 44.794), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("medelin2", function()

local ModelHash = "blista" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-885.090, 16.88713, 44.794), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)


RegisterNetEvent("medelin3", function()

local ModelHash = "bf400" 
if not IsModelInCdimage(ModelHash) then return end
RequestModel(ModelHash) 
while not HasModelLoaded(ModelHash) do 
  Citizen.Wait(10)
end
local MyPed = PlayerPedId()
local Vehicle = CreateVehicle(ModelHash, vector3(-885.090, 16.88713, 44.794), 50, true, false)
TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)
print("spawnaovaljda")

end)

