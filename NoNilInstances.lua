local old
local CoolDown = false
local Whitelisted = {script}
old = hookfunction(getnilinstances, newcclosure(function(...)
    if not CoolDown then
        CoolDown = true
        local self, key = ...
        local nilInstances = getnilinstances()
        local currentTable = {}
        for _,v in pairs(nilInstances) do
            if not table.find(Whitelisted, v) then
                table.insert(currentTable, v)
            end
        end
        CoolDown = false
        return currentTable
    else
        return old(...)
    end
    return old(...)
end))
do
    while true do
        for _,v in pairs(getnilinstances()) do
            if v:IsA("LocalScript") then
                task.spawn(function()
                    local Output = nil
                    local Time = nil
                    local success, err = pcall(function()
                        Time = tick()
                        Output = decompile(v)
                    end)
                    if success and (tick() - Time <= 0.5) then
                        if Output:find("--SynapseX Decompiler") then
                            table.insert(Whitelisted, v)
                        end
                    end
                end)
            end
        end
        game.DescendantAdded:Wait()
    end
end
