local holstered  = true
local blocked	 = false
CreateThread(function()
    while true do
            loadAnimDict("rcmjosh4")
            loadAnimDict("reaction@intimidation@cop@unarmed")
            loadAnimDict("anim@heists@ornate_bank@grab_cash")
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped, false) then
      
                if CheckIfHaveBag(ped)  then
                    if Config.UseAnimations then
                        if CheckIfWeaponNeedBag(ped) then
                            if holstered then
                                blocked   = true
                                    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                                    TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                    
                                        Citizen.Wait(100)
                                        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                        Citizen.Wait(400)
                                    ClearPedTasks(ped)
                                holstered = false
                            else
                                blocked = false
                            end
                            Wait(50)
                        else
                            if not holstered then
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                                        Wait(500)
                                    TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                                        Wait(60)
                                    ClearPedTasks(ped)
                                holstered = true
                            end
                            Wait(40)
                        end
                        Wait(50)
                    end
                else
                    if CheckIfWeaponNeedBag(ped) then
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                        Notify()
                    end
                end
            else
                holstered = true
            end
        Wait(40)
    end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(50)
	end
end

function CheckIfWeaponNeedBag(ped)
    
    for k,v in pairs(Config.Weapons) do
        if GetSelectedPedWeapon(ped) == GetHashKey(v) then
            return true
        end
    end
end

function CheckIfHaveBag(ped)
    local bag = GetPedDrawableVariation(ped, 5)
    for k,v in pairs(Config.Bag) do
        if bag == v then
            return true
        end
    end
end