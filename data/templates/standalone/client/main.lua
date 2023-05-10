AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
end)

