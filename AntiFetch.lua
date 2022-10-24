local old
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
    return old(self, unpack(args))
end)
warn("AntiSpy Loaded")
