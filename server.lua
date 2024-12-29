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

-- Tárolja a játékosok előző munkáját
local playerPreviousJobs = {}

RegisterServerEvent('customDuty:checkGroup')
AddEventHandler('customDuty:checkGroup', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local currentJob = xPlayer.getJob()
    
    -- Ha a játékos már admin munkában van, állítsuk vissza az előző munkáját
    if currentJob.name == 'admin' then
        local previousJob = playerPreviousJobs[source]
        if previousJob then
            xPlayer.setJob(previousJob.name, previousJob.grade)
            playerPreviousJobs[source] = nil -- Töröljük az előző munkát
        end
        return
    end

    -- Ellenőrizzük a játékos csoportját
    local group = xPlayer.getGroup()
    local grade = groupToGradeMap[group]

    if grade then
        -- Mentjük az előző munkát
        playerPreviousJobs[source] = {
            name = currentJob.name,
            grade = currentJob.grade
        }

        -- Hozzáadjuk a játékost az admin munkához
        xPlayer.setJob('admin', grade)
    end
end)
