local balloon = nil
local Blips = {}
local spawnedBlips = {}
local activeButchers = {}
local spawnedButchers = {}

local T = Translation.Langs[Config.Lang] or {}
local Keys = {
    ["G"] = 0x5415BE48,
    ["E"] = 0xCEFD9220
}

local buttons_prompt = GetRandomIntInRange(0, 0xFFFFFF)

function CreatePrompt(label, key, group)
    local prompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(prompt, key)
    local str = CreateVarString(10, 'LITERAL_STRING', label)
    PromptSetText(prompt, str)
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetStandardMode(prompt, true)
    PromptSetGroup(prompt, group)
    PromptRegisterEnd(prompt)
    return prompt
end

function Button_Prompt()
    Buyballon = CreatePrompt(T.PressButton or "Comprar Balão", Keys["G"], buttons_prompt)
end

local function verificarPrompts()
    if PromptHasStandardModeCompleted(Buyballon) and not balloonCooldown then
        TriggerServerEvent('Fox:BuyBalloon')
    end
end

-- Thread para interação
Citizen.CreateThread(function()
    Button_Prompt()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local waitTime = 500

        for _, location in pairs(Config.BalloonLocations) do
            local distance = Vdist(playerCoords, location.coords.x, location.coords.y, location.coords.z)
            if distance < 1.5 then
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsUsing(ped)
                local isBalloon = GetEntityModel(vehicle) == `hotairballoon01`

                if not isBalloon then
                    waitTime = 0
                    local item_name = CreateVarString(10, 'LITERAL_STRING', T.namelabel or "Comprar Balão")
                    PromptSetActiveGroupThisFrame(buttons_prompt, item_name)
                    verificarPrompts()
                end
            end
        end
        Citizen.Wait(waitTime)
    end
end)

-- Thread para blips e npcs
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        for i, v in ipairs(Config.BalloonLocations) do
            local distance = #(playerCoords - v.coords)

            if v.blip and not spawnedBlips[i] then
                local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords.x, v.coords.y, v.coords.z)
                SetBlipSprite(blip, v.blip, true)
                SetBlipScale(blip, 0.2)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Vendedor de Balão")
                spawnedBlips[i] = blip
            end

            if distance < v.distancia and not activeButchers[i] then
                spawnButcher(i, v)
            elseif distance >= v.distancia and activeButchers[i] then
                deleteButcher2(i)
            end
        end
        Wait(1000)
    end
end)

function spawnButcher(index, v)
    local x, y, z = v.coords.x, v.coords.y, v.coords.z - 1

    local hashModel = GetHashKey(v.npcmodel)
    if not IsModelValid(hashModel) then
        print("Modelo inválido: " .. v.npcmodel)
        return
    end

    RequestModel(hashModel)
    while not HasModelLoaded(hashModel) do Wait(100) end

    local npc = CreatePed(hashModel, x, y, z, v.heading, false, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
    SetEntityCanBeDamaged(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    spawnedButchers[index] = npc
    activeButchers[index] = true
end

function deleteButcher2(index)
    if spawnedButchers[index] and DoesEntityExist(spawnedButchers[index]) then
        DeleteEntity(spawnedButchers[index])
        spawnedButchers[index] = nil
    end
    activeButchers[index] = nil
end

function deleteButcher(index)
    deleteButcher2(index)
    if spawnedBlips[index] then
        RemoveBlip(spawnedBlips[index])
        spawnedBlips[index] = nil
    end
end

RegisterNetEvent('Fox:SpawnBalloon')
AddEventHandler('Fox:SpawnBalloon', function()
    local playerPed = PlayerPedId()
    local pCoords = GetEntityCoords(playerPed)
    local hash = GetHashKey('hotAirBalloon01')
    local locationFound = false

    for _, location in pairs(Config.BalloonLocations) do
        local dist = #(pCoords - location.coords)
        if dist <= location.distancia then
            locationFound = true

            RequestModel(hash)
            while not HasModelLoaded(hash) do Wait(10) end

            if balloon and DoesEntityExist(balloon) then DeleteEntity(balloon) end

            balloon = CreateVehicle(hash, location.Spawnballon.x, location.Spawnballon.y, location.Spawnballon.z, location.heading or 0.0, true, true)
            SetModelAsNoLongerNeeded(hash)

            TriggerEvent('Notify', 'sucesso', 'Balão spawnado com sucesso!')
            break
        end
    end

    if not locationFound then
        TriggerEvent('Notify', 'negado', 'Você não está próximo de nenhum ponto de balão.')
    end
end)


RegisterNetEvent('Fox:SpawnBalloon2')
AddEventHandler('Fox:SpawnBalloon2', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local head = GetEntityHeading(playerPed)
    local hash = GetHashKey('hotAirBalloon01')

    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end

    if balloon and DoesEntityExist(balloon) then DeleteEntity(balloon) end

    balloon = CreateVehicle(hash, coords.x, coords.y - 2.0, coords.z, head, true, true)
    SetModelAsNoLongerNeeded(hash)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for index in pairs(spawnedButchers) do
            deleteButcher(index)
        end
        print("Limpando npcs e blips de balão...")
    end
end)
