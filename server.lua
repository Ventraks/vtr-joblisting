ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('joblisting:server:setJob', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(jobs.job, 0)
end)
