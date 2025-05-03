local VORPcore = exports.vorp_core:GetCore()
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local T = Translation.Langs[Config.Lang]

RegisterNetEvent('Fox:BuyBalloon', function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local money = Character.money
    local coast = Config.BallonPrice

    if Config.EnableTax then
        if money >= Config.BallonPrice then
            Character.removeCurrency(0, coast)
            TriggerClientEvent('Fox:SpawnBalloon', src)
            VORPcore.NotifyRightTip(src, T.TaxOfUse .. ' ' .. coast .. ' ' .. T.ToUseBalloon, 4000)
        else
            VORPcore.NotifyRightTip(src, T.IfNecessary .. ' ' .. coast .. ' ' .. T.ToUseBalloon, 4000)
        end
    else
        TriggerClientEvent('Fox:SpawnBalloon', src)
    end
end)


for i = 1, #Config.Itens do
    VorpInv.RegisterUsableItem(Config["Itens"][i]["Name"], function(data)
        local itemName = Config["Itens"][i]["Name"]
        local itemQuant = Config["Itens"][i]["Quant"]
        local source = data.source


        if source then
            VorpInv.subItem(source, itemName, itemQuant)
            TriggerClientEvent('Fox:SpawnBalloon2', source)
            VorpInv.CloseInv(source)
        end
    end)
end
