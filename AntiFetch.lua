local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if (method == "GetHttpResultHistory" and self == game:GetService("LogService")) and checkcaller() then
        return {}
    end
    if (method == "GetOutputDevices" and self == game:GetService("SoundService")) and checkcaller() then
        return {}
    end
    if (method == "GetCameraDevices" and self == game:GetService("VideoCaptureService")) and checkcaller() then
        return {}
    end
    if (method == "GetClientId" and self == game:GetService("RbxAnalyticsService")) and checkcaller() then
        return game:GetService("HttpService"):GenerateGUID(false):upper()
    end
    if (method == "GetUserAgent" and self == game:GetService("HttpService")) and checkcaller() then
        return ""
    end
    return old(self, unpack(args))
end)
warn("AntiSpy Loaded")
