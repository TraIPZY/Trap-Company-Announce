RegisterNetEvent('esx_annonce:showAnnounce')
AddEventHandler('esx_annonce:showAnnounce', function(job, message)
    SendNUIMessage({
        action = 'show',
        job = job,
        message = message
    })
end)
