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
                event = "nh:jobs:reporter",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            id = 3,
            header = "Fisherman",
            txt = "Start working as a fisherman",
            params = {
                event = "nh:jobs:fisherman",
                args = {
                    number = 2,
                    id = 3
                }
            }
        },
		{
            id = 4,
            header = "Lumberjack",
            txt = "Start working as a lumberjack",
            params = {
                event = "nh:jobs:lumberjack",
                args = {
                    number = 3,
                    id = 4
                }
            }
        },
		{
            id = 5,
            header = "Unemployed",
            txt = "Leave your current job",
            params = {
                event = "nh:jobs:unemployed",
                args = {
                    number = 8,
                    id = 9
                }
            }
        },
    })
end)

RegisterNetEvent('nh:jobs:reporter', function()
	TriggerServerEvent('vtr-joblisting:setJob', 'reporter')
    ESX.ShowNotification('Your new job is Reporter!')
end)

RegisterNetEvent('nh:jobs:fisherman', function()
	TriggerServerEvent('vtr-joblisting:setJob', 'fisherman')
    ESX.ShowNotification('Your new job is Fisherman')
end)

RegisterNetEvent('nh:jobs:lumberjack', function()
	TriggerServerEvent('vtr-joblisting:setJob', 'lumberjack')
    ESX.ShowNotification('Your new job is Lumberjack')
end)

RegisterNetEvent('nh:jobs:unemployed', function()
	TriggerServerEvent('vtr-joblisting:setJob', 'unemployed')
    ESX.ShowNotification('Your new job is Unemployed')
end)