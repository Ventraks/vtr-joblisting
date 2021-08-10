ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Create blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-1083.0645751954,-245.82865905762,37.763278961182)

	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 57)
	SetBlipAsShortRange(blip, true)
    
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Job Center')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local peds= {
        `cs_paper`,
    }
    exports['bt-target']:AddTargetModel(peds, {
        options = {
            {
                event = "target:joblisting",
                icon = "fas fa-address-book",
                label = "Find a job",
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
