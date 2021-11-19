local ZonelimitN = false
local ZonelimitO = false
local closestZone = 1

Citizen.CreateThread(function()
	for i = 1, #Agent.zones, 1 do
	local blip = AddBlipForRadius(Agent.zones[i].x, Agent.zones[i].y, Agent.zones[i].z, Agent.radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 11)
	SetBlipAlpha (blip, 128)
    local blip1 = AddBlipForCoord(x, y, z)
	SetBlipSprite (blip1, sprite)
	SetBlipDisplay(blip1, true)
	SetBlipScale  (blip1, 0.9)
	SetBlipColour (blip1, 11)
    SetBlipAsShortRange(blip1, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		Citizen.Wait(10000)
		for i = 1, #Agent.zones, 1 do
			dist = Vdist(Agent.zones[i].x, Agent.zones[i].y, Agent.zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(Agent.zones[closestZone].x, Agent.zones[closestZone].y, Agent.zones[closestZone].z, x, y, z)
		local vehicle = GetVehiclePedIsIn(player, false)
		local speed = GetEntitySpeed(vehicle)
		if dist <= Agent.radius then
			if not ZonelimitN then
				ZonelimitN = true
				ZonelimitO = false
			end
		else
			if not ZonelimitO then
				if Agent.speedlimitador then
				SetVehicleMaxSpeed(vehicle, 1000.00)
				end
				ZonelimitO = true
				ZonelimitN = false
			end
			Citizen.Wait(200)
		end
	if ZonelimitN then
		Citizen.Wait(10)
		if Agent.speedlimitador then
		mphs = 2.237
		maxspeed = Agent.speedlimitador/mphs
		SetVehicleMaxSpeed(vehicle, maxspeed)
		end

	end
end
end)