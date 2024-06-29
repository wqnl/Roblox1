-- WARNING: Created by discord: wqnl

-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "WQNL CHEAT"
screenGui.Enabled = true

-- Create Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0.5, -150, 0.5, -150)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

-- Create Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "wqnl Settings"
title.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSans
title.TextSize = 24

-- Create Size Slider
local sizeLabel = Instance.new("TextLabel", frame)
sizeLabel.Size = UDim2.new(0, 100, 0, 25)
sizeLabel.Position = UDim2.new(0, 10, 0, 60)
sizeLabel.Text = "Hitbox Size"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.BackgroundTransparency = 1

local sizeSlider = Instance.new("TextBox", frame)
sizeSlider.Size = UDim2.new(0, 50, 0, 25)
sizeSlider.Position = UDim2.new(0, 120, 0, 60)
sizeSlider.Text = "10,10,10"
sizeSlider.BackgroundColor3 = Color3.new(1, 1, 1)
sizeSlider.TextColor3 = Color3.new(0, 0, 0)
sizeSlider.Font = Enum.Font.SourceSans
sizeSlider.TextSize = 18

-- Create Transparency Slider
local transLabel = Instance.new("TextLabel", frame)
transLabel.Size = UDim2.new(0, 100, 0, 25)
transLabel.Position = UDim2.new(0, 10, 0, 100)
transLabel.Text = "Transparency"
transLabel.TextColor3 = Color3.new(1, 1, 1)
transLabel.BackgroundTransparency = 1

local transSlider = Instance.new("TextBox", frame)
transSlider.Size = UDim2.new(0, 50, 0, 25)
transSlider.Position = UDim2.new(0, 120, 0, 100)
transSlider.Text = "1"
transSlider.BackgroundColor3 = Color3.new(1, 1, 1)
transSlider.TextColor3 = Color3.new(0, 0, 0)
transSlider.Font = Enum.Font.SourceSans
transSlider.TextSize = 18

-- Create Notifications Toggle
local notifLabel = Instance.new("TextLabel", frame)
notifLabel.Size = UDim2.new(0, 100, 0, 25)
notifLabel.Position = UDim2.new(0, 10, 0, 140)
notifLabel.Text = "Notifications"
notifLabel.TextColor3 = Color3.new(1, 1, 1)
notifLabel.BackgroundTransparency = 1

local notifToggle = Instance.new("TextButton", frame)
notifToggle.Size = UDim2.new(0, 50, 0, 25)
notifToggle.Position = UDim2.new(0, 120, 0, 140)
notifToggle.Text = "Off"
notifToggle.BackgroundColor3 = Color3.new(1, 1, 1)
notifToggle.TextColor3 = Color3.new(0, 0, 0)
notifToggle.Font = Enum.Font.SourceSans
notifToggle.TextSize = 18

-- Create ESP Toggle
local espLabel = Instance.new("TextLabel", frame)
espLabel.Size = UDim2.new(0, 100, 0, 25)
espLabel.Position = UDim2.new(0, 10, 0, 180)
espLabel.Text = "ESP"
espLabel.TextColor3 = Color3.new(1, 1, 1)
espLabel.BackgroundTransparency = 1

local espToggle = Instance.new("TextButton", frame)
espToggle.Size = UDim2.new(0, 50, 0, 25)
espToggle.Position = UDim2.new(0, 120, 0, 180)
espToggle.Text = "On"
espToggle.BackgroundColor3 = Color3.new(1, 1, 1)
espToggle.TextColor3 = Color3.new(0, 0, 0)
espToggle.Font = Enum.Font.SourceSans
espToggle.TextSize = 18

-- Create Hitbox Toggle
local hitboxLabel = Instance.new("TextLabel", frame)
hitboxLabel.Size = UDim2.new(0, 100, 0, 25)
hitboxLabel.Position = UDim2.new(0, 10, 0, 220)
hitboxLabel.Text = "Hitboxes"
hitboxLabel.TextColor3 = Color3.new(1, 1, 1)
hitboxLabel.BackgroundTransparency = 1

local hitboxToggle = Instance.new("TextButton", frame)
hitboxToggle.Size = UDim2.new(0, 50, 0, 25)
hitboxToggle.Position = UDim2.new(0, 120, 0, 220)
hitboxToggle.Text = "On"
hitboxToggle.BackgroundColor3 = Color3.new(1, 1, 1)
hitboxToggle.TextColor3 = Color3.new(0, 0, 0)
hitboxToggle.Font = Enum.Font.SourceSans
hitboxToggle.TextSize = 18

-- Variables for Script Settings
local size = Vector3.new(10, 10, 10)
local trans = 1
local notifications = true
local espEnabled = true
local hitboxesEnabled = true

-- Toggle Notifications
notifToggle.MouseButton1Click:Connect(function()
    notifications = not notifications
    notifToggle.Text = notifications and "On" or "Off"
end)

-- Toggle ESP
espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = espEnabled and "On" or "Off"
    esp:Toggle(espEnabled)
end)

-- Toggle Hitboxes
hitboxToggle.MouseButton1Click:Connect(function()
    hitboxesEnabled = not hitboxesEnabled
    hitboxToggle.Text = hitboxesEnabled and "On" or "Off"
end)

-- Function to apply settings
local function applySettings()
    size = Vector3.new(unpack(string.split(sizeSlider.Text, ",")))
    trans = tonumber(transSlider.Text)
end

-- Apply settings when values change
sizeSlider.FocusLost:Connect(applySettings)
transSlider.FocusLost:Connect(applySettings)

-- Store the time when the code starts executing
local start = os.clock()

-- Send a notification saying that the script is loading
StarterGui:SetCore("SendNotification", {
    Title = "wqnl script",
    Text = "wqnl cheat loading...",
    Icon = "",
    Duration = 5
})

-- Load the ESP library and turn it on
local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/wqnl/Roblox1/main/ESP.lua"))()
esp:Toggle(true)

-- Configure ESP settings
esp.Boxes = true
esp.Names = true
esp.Tracers = true
esp.Players = true

-- Add an object listener to the workspace to detect enemy models
esp:AddObjectListener(workspace, {
    Name = "soldier_model",
    Type = "Model",
    Color = Color3.fromRGB(255, 0, 4),

    -- Specify the primary part of the model as the HumanoidRootPart
    PrimaryPart = function(obj)
        local root
        repeat
            root = obj:FindFirstChild("HumanoidRootPart")
            task.wait()
        until root
        return root
    end,

    -- Use a validator function to ensure that models do not have the "friendly_marker" child
    Validator = function(obj)
        task.wait(1)
        if obj:FindFirstChild("friendly_marker") then
            return false
        end
        return true
    end,

    -- Set a custom name to use for the enemy models
    CustomName = "?",

    -- Enable the ESP for enemy models
    IsEnabled = "enemy"
})

-- Enable the ESP for enemy models
esp.enemy = true

-- Function to apply hitboxes
local function applyHitboxes()
    if not hitboxesEnabled then return end
    -- Apply hitboxes to all existing enemy models in the workspace
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

-- Initial hitbox application
task.wait(1)
applyHitboxes()

-- Function to handle when a new descendant is added to the workspace
local function handleDescendantAdded(descendant)
    task.wait(1)

    -- If the new descendant is an enemy model and notifications are enabled, send a notification
    if descendant.Name == "soldier_model" and descendant:IsA("Model") and not descendant:FindFirstChild("friendly_marker") then
        if notifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Script",
                Text = "[Warning] New Enemy Spawned!",
                Icon = "",
                Duration = 3
            })
        end

        -- Apply hitboxes to the new enemy model
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

-- Connect the handleDescendantAdded function to the DescendantAdded event of the workspace
task.spawn(function()
    workspace.DescendantAdded:Connect(handleDescendantAdded)
end)

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
    Text = string.format("wqnl script loaded", time, rating),
    Icon = "",
    Duration = 5
})

-- Toggle GUI visibility with Insert key
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
