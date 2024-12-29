ESX = nil

ESX = exports["es_extended"]:getSharedObject()

local groupToGradeMap = {
    admin1 = 1,
    admin2 = 2,
    admin3 = 3,
    admin4 = 4,
    cm = 5,
    super = 6,
    ac = 7,
    dev = 8,
    man = 9,
    co = 10,
    owner = 11
}


local json = require('json')
local previousJobsFile = "previous_jobs.json"
local playerPreviousJobs = {}

local function loadPreviousJobs()
    local file = io.open(previousJobsFile, "r")
    if file then
        local content = file:read("*a")
        playerPreviousJobs = json.decode(content) or {}
        file:close()
    end
end

local function savePreviousJobs()
    local file = io.open(previousJobsFile, "w")
    if file then
        file:write(json.encode(playerPreviousJobs))
        file:close()
    end
end

loadPreviousJobs()


AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local currentJob = xPlayer.getJob()
    if currentJob.name == 'admin' then
        local previousJob = playerPreviousJobs[source]
        if previousJob then
            playerPreviousJobs[xPlayer.getIdentifier()] = {
                name = previousJob.name,
                grade = previousJob.grade
            }
            savePreviousJobs()
        end
    end
end)


AddEventHandler('esx:playerLoaded', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then return end

    local identifier = xPlayer.getIdentifier()
    local savedJob = playerPreviousJobs[identifier]
    if savedJob then
        local currentJob = xPlayer.getJob()
        if currentJob.name == 'admin' then
            xPlayer.setJob(savedJob.name, savedJob.grade)
            playerPreviousJobs[identifier] = nil
            savePreviousJobs()
        end
    end
end)

RegisterServerEvent('customDuty:checkGroup')
AddEventHandler('customDuty:checkGroup', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local currentJob = xPlayer.getJob()

 
    if currentJob.name == 'admin' then
        local identifier = xPlayer.getIdentifier()
        local previousJob = playerPreviousJobs[identifier]
        if previousJob then
            xPlayer.setJob(previousJob.name, previousJob.grade)
            playerPreviousJobs[identifier] = nil
            savePreviousJobs()
        end
        return
    end


    local group = xPlayer.getGroup()
    local grade = groupToGradeMap[group]

    if grade then
       
        playerPreviousJobs[xPlayer.getIdentifier()] = {
            name = currentJob.name,
            grade = currentJob.grade
        }
        savePreviousJobs()


        xPlayer.setJob('admin', grade)
    end
end)
