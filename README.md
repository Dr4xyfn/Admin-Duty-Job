HA VILLAMOS ADDUTY-T HASZNÁLSZ AKKOR IGY KELL KINÉZZEN A Command Triggerje 

RegisterCommand('duty', function(s, a, r)
    -- Először hívjuk meg a villamos_aduty:setDutya eseményt
    TriggerServerEvent('villamos_aduty:setDutya', not duty)

    -- Majd hívjuk meg a customDuty:checkGroup eseményt
    TriggerServerEvent('customDuty:checkGroup')
end, false)

Mindenképpen Hozz létre admin jobot 11 geradeval