ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vtr_joblisting:setJob')
AddEventHandler('vtr_joblisting:setJob', function(job)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.setJob(job, 0)
end)
