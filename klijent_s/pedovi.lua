
Citizen.CreateThread(function()
	
	for _,v in pairs(Config.Organizacije) do
	  RequestModel(GetHashKey(v.model))
	  while not HasModelLoaded(GetHashKey(v.model)) do
		Wait(1)
	  end
		
	  PostaviPeda = CreatePed(4, v.model, v.coords , v.heading, false, true)
	  FreezeEntityPosition(PostaviPeda, true) 
	  SetEntityInvincible(PostaviPeda, true)
	  SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
	end
end)

Citizen.CreateThread(function()
	
	for _,v in pairs(Config.Diler) do
	  RequestModel(GetHashKey(v.model))
	  while not HasModelLoaded(GetHashKey(v.model)) do
		Wait(1)
	  end
		
	  PostaviPeda = CreatePed(4, v.model, v.coords , v.heading, false, true)
	  FreezeEntityPosition(PostaviPeda, true) 
	  SetEntityInvincible(PostaviPeda, true)
	  SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
	end
end)