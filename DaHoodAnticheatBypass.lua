local function demolish(s)
    pcall(function()
        s.Disabled = true
    end)
end

game:GetService("ScriptContext"):SetTimeout(2)

local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if self.IsA(self, "RemoteEvent") and string.lower(method) == "fireserver" then
        if args[1] == "CHECKER_1" then
            demolish(getcallingscript())
            return task.wait(9e9)
        end
        if args[1] == "OneMoreTime" then
            demolish(getcallingscript())
            return task.wait(9e9)
        end
        if args[1] == "TeleportDetect" then
            demolish(getcallingscript())
            return task.wait(9e9)
        end
    end
    
    return old(self, unpack(args))
end))
