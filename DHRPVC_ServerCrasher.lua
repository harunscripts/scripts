-- harun
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = {
    ReplicatedStorage.GiveBox,
    ReplicatedStorage.GiveCat
}

for i = 1, 400 do
    for _, v in pairs(Remotes) do
        v:FireServer()
    end
end

repeat task.wait() until #Player.Backpack:GetChildren() >= 800
task.wait(3)
for i,v in pairs(Player.Backpack:GetChildren()) do
    v.Parent = Player.Character
    v.Handle:Destroy()
end
task.wait(5)
Player.Character:BreakJoints()
