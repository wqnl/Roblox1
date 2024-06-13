-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "WQNL_GUI"
screenGui.Enabled = true
screenGui.ResetOnSpawn = false

-- Create Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 0

-- Create Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "WQNL Menu"
title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSans
title.TextSize = 24

-- Make the frame draggable
local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Create ESP Toggle
local espLabel = Instance.new("TextLabel", frame)
espLabel.Size = UDim2.new(0, 100, 0, 40)
espLabel.Position = UDim2.new(0, 10, 0, 60)
espLabel.Text = "ESP"
espLabel.TextColor3 = Color3.new(1, 1, 1)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.SourceSans
espLabel.TextSize = 18

local espToggle = Instance.new("TextButton", frame)
espToggle.Size = UDim2.new(0, 100, 0, 40)
espToggle.Position = UDim2.new(0, 120, 0, 60)
espToggle.Text = "On"
espToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.Font = Enum.Font.SourceSans
espToggle.TextSize = 18

-- ESP variables
local espEnabled = true

-- Load the ESP library and turn it on
local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/wqnl/Roblox1/main/ESP.lua"))()
esp.Boxes = true
esp.Names = true
esp.Tracers = true
esp.Players = true
esp:Toggle(true)

-- Toggle ESP
espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = espEnabled and "On" or "Off"
    esp:Toggle(espEnabled)
end)

-- Create Hitbox Toggle
local hitboxLabel = Instance.new("TextLabel", frame)
hitboxLabel.Size = UDim2.new(0, 100, 0, 40)
hitboxLabel.Position = UDim2.new(0, 10, 0, 110)
hitboxLabel.Text = "Hitboxes"
hitboxLabel.TextColor3 = Color3.new(1, 1, 1)
hitboxLabel.BackgroundTransparency = 1
hitboxLabel.Font = Enum.Font.SourceSans
hitboxLabel.TextSize = 18

local hitboxToggle = Instance.new("TextButton", frame)
hitboxToggle.Size = UDim2.new(0, 100, 0, 40)
hitboxToggle.Position = UDim2.new(0, 120, 0, 110)
hitboxToggle.Text = "On"
hitboxToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
hitboxToggle.TextColor3 = Color3.new(1, 1, 1)
hitboxToggle.Font = Enum.Font.SourceSans
hitboxToggle.TextSize = 18

-- Hitbox variables
local hitboxesEnabled = true
local size = Vector3.new(10, 10, 10)
local trans = 1

-- Function to apply hitboxes
local function applyHitboxes()
    if hitboxesEnabled then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "soldier_model" and v:IsA("Model") and not v:FindFirstChild("friendly_marker") then
                local pos = v:FindFirstChild("HumanoidRootPart").Position
                for _, bp in pairs(workspace:GetChildren()) do
                    if bp:IsA("BasePart") then
                        local distance = (bp.Position - pos).Magnitude
                        if distance <= 5 then
                            bp.Transparency = trans
                            bp.Size = size
                        end
                    end
                end
            end
        end
    end
end

-- Toggle Hitboxes
hitboxToggle.MouseButton1Click:Connect(function()
    hitboxesEnabled = not hitboxesEnabled
    hitboxToggle.Text = hitboxesEnabled and "On" or "Off"
    applyHitboxes()
end)

-- Initial hitbox application
task.wait(1)
applyHitboxes()

-- Function to handle when a new descendant is added to the workspace
local function handleDescendantAdded(descendant)
    task.wait(1)
    if descendant.Name == "soldier_model" and descendant:IsA("Model") and not descendant:FindFirstChild("friendly_marker") then
        if hitboxesEnabled then
            local pos = descendant:FindFirstChild("HumanoidRootPart").Position
            for _, bp in pairs(workspace:GetChildren()) do
                if bp:IsA("BasePart") then
                    local distance = (bp.Position - pos).Magnitude
                    if distance <= 5 then
                        bp.Transparency = trans
                        bp.Size = size
                    end
                end
            end
        end
    end
end

-- Connect the handleDescendantAdded function to the DescendantAdded event of the workspace
task.spawn(function()
    workspace.DescendantAdded:Connect(handleDescendantAdded)
end)

-- Toggle GUI visibility with Insert key and focus mouse
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
        if screenGui.Enabled then
            UserInputService.MouseIconEnabled = true
            UserInputService.InputMode = Enum.UserInputType.MouseMovement
        else
            UserInputService.MouseIconEnabled = false
            UserInputService.InputMode = Enum.UserInputType.None
        end
    end
end)

-- Store the time when the code starts executing
local start = os.clock()

-- Send a notification saying that the script is loading
StarterGui:SetCore("SendNotification", {
    Title = "wqnl script",
    Text = "wqnl cheat loading...",
    Icon = "",
    Duration = 5
})

-- Store the time when the code finishes executing
local finish = os.clock()

-- Calculate how long the code took to run and determine a rating for the loading speed
local time = finish - start
local rating
if time < 3 then
    rating = "fast"
elseif time < 5 then
    rating = "acceptable"
else
    rating = "slow"
end

-- Send a notification showing how long the code took to run and its rating
StarterGui:SetCore("SendNotification", {
    Title = "Script",
    Text = string.format("wqnl script loaded in %.2f seconds (%s)", time, rating),
    Icon = "",
    Duration = 5
})
