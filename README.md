HA VILLAMOS ADDUTY-T HASZNÁLSZ AKKOR IGY KELL KINÉZZEN A Command Triggerje 

RegisterCommand('duty', function(s, a, r)
    Először hívjuk meg a villamos_aduty:setDutya 
    TriggerServerEvent('villamos_aduty:setDutya', not duty)

    Majd hívjuk meg a customDuty:checkGroup 
    TriggerServerEvent('customDuty:checkGroup')
end, false)
