local function sequence()
	pcall(function()
	    local testing = Instance.new("ScreenGui")
    	local ImageLabel = Instance.new("ImageLabel")
    	testing.Name = "testing"
    	testing.Parent = game:GetService("CoreGui")
    	testing.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    	ImageLabel.Parent = testing
    	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    	ImageLabel.BackgroundTransparency = 1.000
    	ImageLabel.Position = UDim2.new(0.5, -123, 0.5, -123)
    	ImageLabel.Size = UDim2.new(0, 247, 0, 247)
    	ImageLabel.Image = "rbxassetid://6862780932"
    	ImageLabel.ImageTransparency = 1.000
    	local s = Instance.new("Sound", workspace)
    	for i = 1, 10 do
    		ImageLabel.ImageTransparency = ImageLabel.ImageTransparency - 0.1
    		task.wait()
    	end
	end)
	Close()
end
sequence()
