local function noti(text)
    game:GetService"StarterGui":SetCore("SendNotification", {
        Title = "harun anti",
        Text = text,
        Icon = "rbxassetid://3378216096"
    })
end

local plr = game:GetService"Players".LocalPlayer

local wlplr = {}

local function check(p)
    p.CharacterAdded:Connect(function()
        pcall(function()
            local n = p.Name
            table.insert(wlplr, n)
            local t = tick()
            repeat
                task.wait()
            until (tick()-t >= 3) or (p.Character:FindFirstChild("Head") ~= nil)
            for i,v in pairs(wlplr) do
                if v == n then
                    table.remove(wlplr, i)
                end
            end
        end)
    end)
end


game:GetService"Players".PlayerAdded:Connect(function(a)
    pcall(function()
        pcall(function()
            check(a)
        end)
        local n = a.Name

        table.insert(wlplr, n)
        local t = tick()

        repeat
            task.wait()
        until (tick()-t >= 3) or (a.Character:FindFirstChild("Head") ~= nil)
        for i,v in pairs(wlplr) do
            if v == n then
                table.remove(wlplr, i)
            end
        end
    end)
end)
game:GetService"Players".PlayerRemoving:Connect(function(a)
    pcall(function()
        local n = a.Name

        table.insert(wlplr, n)
        local t = tick()

        task.wait(2)
        for i,v in pairs(wlplr) do
            if v == n then
                table.remove(wlplr, i)
            end
        end
    end)
end)

for i,v in pairs(game.Players:GetChildren()) do
    if v.Name ~= plr.Name then
        pcall(function()
            check(v)
        end)
    end
end

--ok
noti("loaded anti")

local seats = {}
local seatpos = {}
for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Seat") then
        table.insert(seats, v)
        table.insert(seatpos, v.CFrame)
    end
end

local t = false

--kinda useless
local wl = {}
for i,v in pairs(plr.Backpack:GetChildren()) do
    if v:IsA("Tool") then table.insert(wl, v) end
end
plr.CharacterAdded:Connect(function()
    task.wait(1)
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") then table.insert(wl, v) end
    end
end)

workspace.DescendantRemoving:Connect(function(v)
    local s, e = pcall(function()
        if t then return end
        if v:IsDescendantOf(plr.Character) then return end
        local bl = false
        for j,k in pairs(wlplr) do
            pcall(function()
                if v:IsDescendantOf(game.Players[k].Character) then
                    bl = true
                end
            end)
        end
        if bl then return end
        if (v:IsA("Humanoid") and v.Health > 0) or (v.Parent.Name == "LeftKneeRigAttachment") then
            task.spawn(function()
                pcall(function()
                    if v.Parent.Parent:FindFirstChild"BoomBox" then
                        local bb = v.Parent.Parent:FindFirstChild"BoomBox"
                        bb.AncestryChanged:Wait()
                        bb:Destroy()
                    end
                end)
                pcall(function()
                    if v.Parent:FindFirstChild"BoomBox" then
                        local bb = v.Parent:FindFirstChild"BoomBox"
                        bb.AncestryChanged:Wait()
                        bb:Destroy()
                    end
                end)
            end)
            t = true
            noti("attempt detected")
            local seat = nil
            local spos = nil
            local s, e = pcall(function()

                local oldpos = plr.Character.PrimaryPart.CFrame
                local oldheight = workspace.FallenPartsDestroyHeight
    
                local f = false
                repeat
                    local rando = math.random(1, #seats)
                    seat = seats[rando]
                    spos = seatpos[rando]

                    if seat.Occupant == nil then f = true end
                    task.wait()
                until f == true
    
                if seat == nil then return end
                
                local oldseatpos = seat.CFrame
    
                workspace.FallenPartsDestroyHeight = 0/0
    
                plr.Character.Humanoid:ChangeState("GettingUp")
                plr.Character.PrimaryPart.Velocity = Vector3.new()
    
                task.spawn(function()
                    for i = 1, 100 do
                        plr.Character:SetPrimaryPartCFrame(oldpos)
                    end
                end)
    
                seat.CFrame = oldpos
                seat:Sit(plr.Character.Humanoid)
                seat.CanCollide = false
    
                task.wait(1.5)
                for i,v in pairs(plr.Character:GetChildren()) do
                    if v:IsA("Tool") and not table.find(wl, v) then
                        v:Destroy()
                    end
                end
    
                workspace.FallenPartsDestroyHeight = oldheight
                plr.Character.Humanoid.Sit = false
                plr.Character.Humanoid.Jump = true
                plr.Character.Humanoid:ChangeState("GettingUp")
    
                task.wait(.3)
                local oldp = seat.Parent
                seat.Parent = game:GetService"ReplicatedStorage"
                seat.Parent = oldp
    
                seat.CFrame = oldseatpos
                --try a new strat to make it save
                seat.CFrame = spos
                
                plr.Character:SetPrimaryPartCFrame(oldpos)
    
                --again
                workspace.FallenPartsDestroyHeight = oldheight
                plr.Character.Humanoid.Sit = false
                plr.Character.Humanoid.Jump = true
                plr.Character.Humanoid:ChangeState("GettingUp")
                t = false
            end)
            if e then
                seat.CFrame = spos
                t = false
                print(e)
            end
            if not s then print(e) end
        end
    end)
end)

local function ins()
    plr.Character.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") and not table.find(wl, tool) then
            Instance.new("Humanoid", workspace):Destroy()
        end
    end)
end
ins()
plr.CharacterAdded:Connect(ins)
