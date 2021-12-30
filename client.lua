ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Create blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(vector3(Config.Blip))

	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 57)
	SetBlipAsShortRange(blip, true)
    
	BeginTextCommandSetBlipName("STRING")
    	AddTextComponentString('Job Center')
	EndTextCommandSetBlipName(blip)
end)

local pedspawned = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.Location) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(v.Cords - pos)
			
			if dist < 40 and pedspawned == false then
				TriggerEvent('spawn:ped',v.Cords,v.h)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(npc)
			end
		end
	end
end)

RegisterNetEvent('spawn:ped')
AddEventHandler('spawn:ped',function(coords, heading)
    local hash = Config.Ped
    if not HasModelLoaded(hash) then
	RequestModel(hash)
	Wait(10)
    end
		
    while not HasModelLoaded(hash) do 
	Wait(10)
    end

    pedspawned = true
    npc = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
		
    end
end)

Citizen.CreateThread(function()
    local peds = Config.Ped
    exports['bt-target']:AddTargetModel(peds, {
        options = {
            {
                event = "target:joblisting",
                icon = "fas fa-address-book",
                label = "Get a job",
                job = {"all"}
            },
        },
        distance = 3.0
    })
end)

RegisterNetEvent('target:joblisting')
AddEventHandler('target:joblisting',function()
    TriggerEvent("nh-context:joblisting")
end)

RegisterNetEvent('nh-context:joblisting', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Job Center",
            txt = ""
        },
        {
            id = 2,
            header = "Reporter",
            txt = "Start working as a reporter",
            params = {
                event = "jobs:client:setJob",
                args = {
                    job = 'reporter'
                }
            }
        },
		{
            id = 3,
            header = "Fisherman",
            txt = "Start working as a fisherman",
            params = {
                event = "jobs:client:setJob",
                args = {
                    job = 'fisherman'
                }
            }
        },
		{
            id = 4,
            header = "Lumberjack",
            txt = "Start working as a lumberjack",
            params = {
                event = "jobs:client:setJob",
                args = {
                    job = 'lumberjack'
                }
            }
        },
		{
            id = 5,
            header = "Unemployed",
            txt = "Leave your current job",
            params = {
                event = "jobs:client:setJob",
                args = {
                    job = 'unemployed'
                }
            }
        },
    })
end)

RegisterNetEvent('joblisting:client:setJob', function(jobs)
	TriggerServerEvent('joblisting:server:setJob', jobs.job)
    ESX.ShowNotification('Your new job is '.. jobs.job)
end)
