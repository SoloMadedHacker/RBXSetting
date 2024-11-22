-- Loading the Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoloMadedHacker/KavoUIRBX/main/KavoUIDraggable.lua"))()

-- Creating the UI
local Window = Library.CreateLib("Roblox Admin Panel Settings", "DarkTheme")

-- Sending a Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Notification";
    Text = "Loaded Settings, please use with caution.";
    Duration = 5;
})

-- Create ScreenGui for the main button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileTopCenterButton"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Only show GUI on mobile
if not game:GetService("UserInputService").TouchEnabled then
    screenGui.Enabled = false
end

-- Create main button
local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(0, 30, 0, 30)
imageButton.Position = UDim2.new(0.50, 166, 0.05, 56)
imageButton.AnchorPoint = Vector2.new(0.5, 0)
imageButton.Image = "rbxassetid://86175028581122"
imageButton.Parent = screenGui

-- Smooth edges
local corner = Instance.new("UICorner", imageButton)
corner.CornerRadius = UDim.new(0, 3)

-- Make the image button draggable
local dragging = false
local dragInput, dragStart, startPos

imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = imageButton.Position
        input.Changed:Connect(function()
            if dragging then
                local delta = input.Position - dragStart
                imageButton.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
            end
        end)
    end
end)

imageButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

imageButton.MouseButton1Click:Connect(function()
Library:ToggleUI()
end) 

-- Creating the "Roblox" Tab
local RobloxTab = Window:NewTab("Roblox")
local RobloxSection = RobloxTab:NewSection("Admin Controls")

-- Set Speed Textbox
RobloxSection:NewTextBox("SetSpeed", "Set", function(value)
    local player = game.Players.LocalPlayer
    local speed = tonumber(value)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") and speed then
        player.Character.Humanoid.WalkSpeed = speed
    end
end)

-- Reset Speed Button
RobloxSection:NewButton("ResetSpeed", "Reset your speed to default (16)", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Set Jump Power Textbox
RobloxSection:NewTextBox("SetJumpPower", "Set", function(value)
    local player = game.Players.LocalPlayer
    local jumpPower = tonumber(value)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") and jumpPower then
        player.Character.Humanoid.JumpPower = jumpPower
    end
end)

-- Reset Jump Power Button
RobloxSection:NewButton("ResetJumpPower", "Reset your jump power to default (50)", function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 50
    end
end)

RobloxSection:NewTextBox("SetGravity", "Set", function(value)
    game.Workspace.Gravity = tonumber(value)
end)

RobloxSection:NewButton("ResetGravity", "Resets your gravity to default (196)", function()
    game.Workspace.Gravity = 196.2
end)


-- Reset Character Button
RobloxSection:NewButton("Reset", "Resets your character", function()
    local player = game.Players.LocalPlayer
    if player then
        player:LoadCharacter()
    end
end)

-- Leave Game Button
RobloxSection:NewButton("LeaveGame", "Leave the current game", function()
    game:Shutdown()
end)

-- Rejoin Game Button
RobloxSection:NewButton("Rejoin", "Rejoin the current game", function()
    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer
    if TeleportService and player then
        TeleportService:Teleport(game.PlaceId, player)
    end
end)
