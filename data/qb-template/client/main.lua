local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData
local PlayerGang
local PlayerJob

local function ReloadPlayerData()
    if LocalPlayer.state['isLoggedIn'] then
		QBCore.Functions.GetPlayerData(function(_PlayerData)
            PlayerData = _PlayerData
            PlayerGang = PlayerData.gang
            PlayerJob = PlayerData.job
        end)
	end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	ReloadPlayerData()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    Wait(200)
    ReloadPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function()
    ReloadPlayerData()
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    ReloadPlayerData()
end)