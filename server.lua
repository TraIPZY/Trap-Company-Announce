ESX = exports['es_extended']:getSharedObject()

local AnnounceCooldown = {}
local COOLDOWN_TIME = 30 * 60 -- 30 minutes en secondes

RegisterCommand('ann', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    -- Doit avoir un job
    if xPlayer.job.name == 'unemployed' then
        TriggerClientEvent('esx:showNotification', source,
            '❌ Tu dois être employé pour faire une annonce.')
        return
    end

    local jobName = xPlayer.job.name
    local currentTime = os.time()

    -- Vérification cooldown
    if AnnounceCooldown[jobName] then
        local remaining = COOLDOWN_TIME - (currentTime - AnnounceCooldown[jobName])
        if remaining > 0 then
            local minutes = math.ceil(remaining / 60)
            TriggerClientEvent('esx:showNotification', source,
                ('⏳ Attends encore %d minute(s) avant une nouvelle annonce.'):format(minutes))
            return
        end
    end

    local message = table.concat(args, " ")
    if message == "" then
        TriggerClientEvent('esx:showNotification', source,
            '❌ Message invalide.')
        return
    end

    -- Enregistre le cooldown
    AnnounceCooldown[jobName] = currentTime

    -- Envoie l’annonce
    TriggerClientEvent(
        'esx_annonce:showAnnounce',
        -1,
        xPlayer.job.label,
        message
    )
end)




AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    print('^4████████╗██████╗  █████╗ ██████╗ ')
    print('^4╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗')
    print('^4   ██║   ██████╔╝███████║██████╔╝')
    print('^4   ██║   ██╔══██╗██╔══██║██╔═══╝ ')
    print('^4   ██║   ██║  ██║██║  ██║██║     ')
    print('^4   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ')
    print('^7')
    print('^6   Discord : https://discord.gg/rjjU2y93X7')
    print('^8   Créé par TRAPZY')
    print('^3   © TRAP Development')

end)
