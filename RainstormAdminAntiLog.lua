local UseLatestVersion = true
--basically breaks rainstorm admin from logging you
local Plr = game:GetService("Players").LocalPlayer
local RJOBID = game.JobId
local RPLACEID = game.PlaceId
local old
old = hookmetamethod(game, "__index", newcclosure(function(...)
    local self, key = ...
    if key:lower() == "jobid" and self == game and checkcaller() then
        return game:GetService("HttpService"):GenerateGUID(false):lower()
    end
    if key:lower() == "userid" and self == Plr and checkcaller() then
        return 183759364
    end
    if key:lower() == "name" and self == Plr and checkcaller() then
        return game:GetService("Players"):GetNameFromUserIdAsync(183759364)
    end
    if key:lower() == "displayname" and self == Plr and checkcaller() then
        return game:GetService("UserService"):GetUserInfosByUserIdsAsync({183759364})[1].DisplayName
    end
    if key:lower() == "accountage" and self == Plr and checkcaller() then
        return math.random(2000, 2500)
    end
    if key:lower() == "placeid" and self == game and checkcaller() then
        return math.random(1000000, 500000000)
    end
    return old(...)
end))
local hook2
hook2 = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "GetClientId" and self == game:GetService("RbxAnalyticsService") then
        return game:GetService("HttpService"):GenerateGUID(false):upper()
    end
    if method == "TeleportToPlaceInstance" and self == game:GetService("TeleportService") then
        args[2] = RJOBID
        args[1] = RPLACEID
    end
    if method == "Teleport" and self == game:GetService("TeleportService") then
        args[1] = RPLACEID
    end
    return hook2(self, unpack(args))
end)

if UseLatestVersion then
    loadstring(game:HttpGet("https://rainstormadmin.000webhostapp.com/RSA"))();
else
    loadstring(game:HttpGet("https://paste.ee/r/pBkwN/0"))() 
end
