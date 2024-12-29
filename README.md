HA VILLAMOS ADDUTY-T HASZNÁLSZ AKKOR IGY KELL KINÉZZEN A Command Triggerje 

RegisterCommand('duty', function(s, a, r)
 villamos_aduty:setDutya 
    TriggerServerEvent('villamos_aduty:setDutya', not duty)

  customDuty:checkGroup 
    TriggerServerEvent('customDuty:checkGroup')
end, false)
