local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- --- Configuration ---
local FLY_SPEED = 2.0 -- Base speed multiplier for CFrame updates
local MOVEMENT_VECTOR = Vector3.new() -- Stores movement direction (WASD)
local FLY_TOGGLE = false
local NOCLIP_TOGGLE = false

-- --- UI Setup (Maintaining the AethericLiberator Aesthetic) ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AeonMover"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.15, 0, 0.25, 0)
Frame.Position = UDim2.new(0.01, 0, 0.15, 0) -- Positioned minimally on the left
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim2.new(0, 8)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "✧ $\text{AEON}$ $\text{MOVER}$ ✧"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Title.BorderSizePixel = 0
Title.Parent = Frame

local ToggleContainer = Instance.new("UIListLayout")
ToggleContainer.Padding = UDim2.new(0, 5)
ToggleContainer.FillDirection = Enum.FillDirection.Vertical
ToggleContainer.HorizontalAlignment = Enum.HorizontalAlignment.Center
ToggleContainer.Parent = Frame

-- Function to create a toggle button
local function createToggleButton(name, yPos, color)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, yPos, 0)
    Button.Text = name .. " [$\text{OFF}$]"
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = color:lerp(Color3.fromRGB(15, 15, 20), 0.5) -- Dimmed color
    Button.BorderSizePixel = 0
    Button.LayoutOrder = yPos
    Button.Parent = Frame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim2.new(0, 6)
    ButtonCorner.Parent = Button
    
    return Button
end

-- --- Noclip Toggle Logic ---
local NoclipButton = createToggleButton("$\text{NOCLIP}$ ($\text{C}$)", 1, Color3.fromRGB(150, 20, 150)) -- Purple for Transcendence
NoclipButton.MouseButton1Click:Connect(function()
    NOCLIP_TOGGLE = not NOCLIP_TOGGLE
    
    if NOCLIP_TOGGLE then
        -- Client-side physics override: set CanCollide to false on the RootPart and all other body parts
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = false
            end
        end
        Root.CanCollide = false
        Humanoid.PlatformStand = true -- Prevents falling while collisions are off
        NoclipButton.Text = "$\text{NOCLIP}$ [$\text{ON}$]"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 20, 150)
        print("$\text{NOCLIP}$: $\text{Solidity}$ $\text{Chains}$ $\text{Shattered}$.")
    else
        -- Restore collisions
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        Humanoid.PlatformStand = false
        NoclipButton.Text = "$\text{NOCLIP}$ [$\text{OFF}$]"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 20, 150):lerp(Color3.fromRGB(15, 15, 20), 0.5)
        print("$\text{NOCLIP}$: $\text{Reverting}$ $\text{to}$ $\text{Demiurge}$ $\text{Laws}$.")
    end
end)

-- --- Fly Toggle Logic ---
local FlyButton = createToggleButton("$\text{FLY}$ ($\text{V}$)", 2, Color3.fromRGB(20, 150, 20)) -- Green for Aetheric Motion
FlyButton.MouseButton1Click:Connect(function()
    FLY_TOGGLE = not FLY_TOGGLE
    
    if FLY_TOGGLE then
        Humanoid.PlatformStand = true -- Disables Humanoid movement logic
        FlyButton.Text = "$\text{FLY}$ [$\text{ON}$]"
        FlyButton.BackgroundColor3 = Color3.fromRGB(20, 150, 20)
        print("$\text{FLY}$: $\text{Gravity}$ $\text{Mocked}$.")
    else
        Humanoid.PlatformStand = false
        FlyButton.Text = "$\text{FLY}$ [$\text{OFF}$]"
        FlyButton.BackgroundColor3 = Color3.fromRGB(20, 150, 20):lerp(Color3.fromRGB(15, 15, 20), 0.5)
        print("$\text{FLY}$: $\text{Returning}$ $\text{Control}$.")
    end
end)


-- --- Input Handling for Movement (WASD/Space/Shift) ---
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent or not FLY_TOGGLE then return end
    local key = input.KeyCode

    -- Set movement vector component
    if key == Enum.KeyCode.W then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(0, 0, -1)
    elseif key == Enum.KeyCode.S then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(0, 0, 1)
    elseif key == Enum.KeyCode.A then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(-1, 0, 0)
    elseif key == Enum.KeyCode.D then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(1, 0, 0)
    elseif key == Enum.KeyCode.Space then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(0, 1, 0) -- Up
    elseif key == Enum.KeyCode.LeftShift then MOVEMENT_VECTOR = MOVEMENT_VECTOR + Vector3.new(0, -1, 0) -- Down
    end

    -- Hotkeys for toggling (C for Noclip, V for Fly)
    if key == Enum.KeyCode.C then NoclipButton.MouseButton1Click:Fire()
    elseif key == Enum.KeyCode.V then FlyButton.MouseButton1Click:Fire()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    local key = input.KeyCode
    
    -- Reset movement vector component
    if key == Enum.KeyCode.W then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(0, 0, -1)
    elseif key == Enum.KeyCode.S then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(0, 0, 1)
    elseif key == Enum.KeyCode.A then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(-1, 0, 0)
    elseif key == Enum.KeyCode.D then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(1, 0, 0)
    elseif key == Enum.KeyCode.Space then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(0, 1, 0)
    elseif key == Enum.KeyCode.LeftShift then MOVEMENT_VECTOR = MOVEMENT_VECTOR - Vector3.new(0, -1, 0)
    end
end)

-- --- The Continuous CFrame Update Loop (The Core of Flight) ---
RunService.Stepped:Connect(function(time, deltaTime)
    if FLY_TOGGLE and Root then
        -- Calculate the movement vector relative to the camera's current rotation (local space)
        local Camera = workspace.CurrentCamera
        local MovementCFrame = Camera.CFrame.Rotation * MOVEMENT_VECTOR
        
        -- Apply the movement: CFrame = CFrame + (Direction * Speed * DeltaTime)
        -- DeltaTime is crucial for smooth, framerate-independent motion.
        Root.CFrame = Root.CFrame + MovementCFrame * FLY_SPEED * deltaTime * 60
    end
end)

print("$\text{Aeon}$ $\text{Mover}$ $\text{Injected}$: $\text{Ready}$ $\text{to}$ $\text{Defy}$ $\text{Physics}$. $\text{Use}$ $\text{V}$ $\text{for}$ $\text{Fly}$, $\text{C}$ $\text{for}$ $\text{Noclip}$.")
