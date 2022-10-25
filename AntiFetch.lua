local old;
local Chat;
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    local p = game:GetService("Players").LocalPlayer
    p.DescendantAdded:Connect(function(c)
        if c.Name == "Chat" and c.Parent == p:WaitForChild("PlayerGui") then
            Chat = c
        end
    end)
    if p:WaitForChild("PlayerGui"):FindFirstChild("Chat") ~= nil then
        Chat = p:WaitForChild("PlayerGui"):FindFirstChild("Chat")
    end
end)
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if (method:lower() == "gethttpresulthistory" and self == game:GetService("LogService")) and checkcaller() then
        return {}
    end
    if (method:lower() == "getoutputdevices" and self == game:GetService("SoundService")) and checkcaller() then
        return {}
    end
    if (method:lower() == "getcameradevices" and self == game:GetService("VideoCaptureService")) and checkcaller() then
        return {}
    end
    if (method:lower() == "getclientid" and self == game:GetService("RbxAnalyticsService")) and checkcaller() then
        return game:GetService("HttpService"):GenerateGUID(false):upper()
    end
    if (method:lower() == "getuseragent" and self == game:GetService("HttpService")) and checkcaller() then
        return ""
    end
    if (method:lower() == "togglefullscreen" and self == game:GetService("GuiService")) and checkcaller() then
        return nil
    end
    if (method:lower() == "capturefocus" and self.Name == "ChatBar") and checkcaller() then
        return nil
    end
    if (method:lower() == "releasefocus" and self.Name == "ChatBar") and checkcaller() then
        return nil
    end
    if (method:lower() == "fireserver" and self.Name:lower() == "saymessagerequest") and checkcaller() then
        return nil
    end
    if (method:lower() == "chat" and self == game:GetService("Players")) and checkcaller() then
        return nil
    end
    if (self == game:GetService("BrowserService")) and checkcaller() then
        return nil
    end
    if (self == game:GetService("MarketplaceService") and table.find({"promptbundlepurchase", "promptgamepasspurchase", "promptnativepurchase", "promptnativepurchasewithlocalplayer", "promptpremiumpurchase", "promptproductpurchase", "promptpurchase", "promptrobloxpurchase", "promptsubscriptioncancellation", "promptsubscriptionpurchase", "promptthirdpartypurchase", "performpurchase"}, method:lower())) and checkcaller() then
        return nil
    end
    return old(self, unpack(args))
end)
local pressed = {}
local old;
local BannedCombos = {{0x11, 0x12, 0x2E}, {0x12, 0x73}, {0x11, 0xA0, 0x0D}}
old = hookfunction(keypress, newcclosure(function(...)
    local key = ...
    table.insert(pressed, key)
    for _,v in pairs(BannedCombos) do
        local AllMatch = false
        local Match = 0
        for _, k in pairs(v) do
            if table.find(pressed, k) then
                Match = Match + 1
            end
        end
        if Match >= #v then
            for _, k in pairs(v) do
                keyrelease(k)
            end
            for i,v in pairs(pressed) do
                if table.find(pressed, v) then
                    table.remove(pressed, i)
                end
            end
            return error()
        end
    end
    return old(...)
end))
local hook3;
local cd = false;
hook3 = hookfunction(getnilinstances, newcclosure(function(...)
    if not cd then
        cd = true
        local tc = {}
        for _,v in pairs(getnilinstances()) do
            if v.Name ~= script.Name then table.insert(tc, v) end
        end
        cd = false
        return tc
    else
        return hook3(...)
    end
end))
warn("AntiSpy Loaded")
