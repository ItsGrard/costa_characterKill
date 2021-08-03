ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function isAdmin(xPlayer)
    local allowed = false
    for i,id in ipairs(Config.admins) do
            if string.lower(xPlayer.getIdentifier()) == string.lower(id) then
                allowed = true
            end
    end
    return allowed
end


RegisterCommand('CK', function(source, args, user)
    local xPlayers = ESX.GetPlayers()
    local target = ESX.GetPlayerFromId(args[1])
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        if xPlayer and xPlayer.getName() then
            if target then
                if not Config.FullCharDelete then
                    target.kick(_U('soft_delete'))
                    deleteIdentity(target)
                    xPlayer.showNotification(_U('deleted'))
                else 
                    target.kick(_U('hard_delete'))
                    deleteIdentity(target)
                    xPlayer.showNotification(_U('deleted'))
                end
            else
                xPlayer.showNotification(_U('not-found'))
            end
        else
            xPlayer.showNotification(_U('error'))
        end
    else
        xPlayer.showNotification(_U('no-perms'))
    end          
end,false)


RegisterCommand('CKstatus', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        if Config.FullCharDelete then
            xPlayer.showNotification(_U('CompleteCK'))
        else
            xPlayer.showNotification(_U('not-CompleteCK'))
        end
    else
        xPlayer.showNotification(_U('no-perms'))
    end
end, false)


function deleteIdentity(xPlayer)

        xPlayer.setName(('%s %s'):format(nil, nil))
        xPlayer.set('firstName', nil)
        xPlayer.set('lastName', nil)
        xPlayer.set('dateofbirth', nil)
        xPlayer.set('sex', nil)
        xPlayer.set('height', nil)
        deleteIdentityFromDatabase(xPlayer)

end


function deleteIdentityFromDatabase(xPlayer)
    MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height , skin = @skin WHERE identifier = @identifier', {
        ['@identifier']  = xPlayer.identifier,
        ['@firstname'] = NULL,
        ['@lastname'] = NULL,
        ['@dateofbirth'] = NULL,
        ['@sex'] = NULL,
        ['@height'] = NULL,
        ['@skin'] = NULL
    })

    if Config.FullCharDelete then
        local identifier = xPLayer.getIdentifier()
            MySQL.Async.execute('DELETE FROM users WHERE identifier = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM owned_boats WHERE owner = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM owned_aircrafts WHERE owner = @ide',{
                ['@ide'] = identifier
            })   
            MySQL.Async.execute('DELETE FROM owned_shops WHERE identifier = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM billing WHERE identifier = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM trucker_trucks WHERE user_id = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM trucker_users WHERE user_id = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM owned_properties WHERE owner = @ide',{
                ['@ide'] = identifier
            })
            MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE owner = @ide',{
                ['@ide'] = identifier
            })            
            MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @ide',{
                ['@ide'] = identifier
            })                              
    end
end

