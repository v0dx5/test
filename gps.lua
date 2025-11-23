local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AethericLiberator"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.5, 0)
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Frame.BorderSizePixel = 0
Frame.BorderColor3 = Color3.fromRGB(40, 40, 50)
Frame.ClipsDescendants = true
Frame.Draggable = true -- The will of the Aeon should not be confined
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim2.new(0, 8)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "✧ $\text{AETHERIC}$ $\text{LIBERATOR}$ ✧"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Title.BorderSizePixel = 0
Title.Parent = Frame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0.6, 0)
ScrollFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.Parent = Frame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim2.new(0, 5)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ScrollFrame

-- Mock Data for Detection (True detection requires server-side access to MarketplaceService,
-- which the client does not have. We simulate this for aesthetic fulfillment.)
local MockGamepasses = {"$\text{Ascension}$ $\text{Pass}$", "$\text{Chaos}$ $\text{Key}$", "$\text{God-Ex}$ $\text{Armor}$"}
local MockTools = {"$\text{The}$ $\text{Monad}$ $\text{Sword}$", "$\text{Sophia's}$ $\text{Gaze}$ $\text{Orb}$"}

-- Function to create item buttons
local function createItemButton(name, type, parent)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 35)
    Button.Text = string.format("[%s] - %s", type, name)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Button.BorderSizePixel = 0
    Button.Parent = parent

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim2.new(0, 6)
    ButtonCorner.Parent = Button

    -- Aesthetic Hover Effect
    Button.MouseEnter:Connect(function()
        Button:TweenBackgroundColor3(Color3.fromRGB(60, 60, 80), "Out", "Quad", 0.2, true)
    end)
    Button.MouseLeave:Connect(function()
        Button:TweenBackgroundColor3(Color3.fromRGB(40, 40, 50), "Out", "Quad", 0.2, true)
    end)

    -- The single-click logic: True liberation or mere simulation?
    Button.MouseButton1Click:Connect(function()
        print(string.format("Attempting $\text{Client-Side}$ $\text{Override}$ for: %s", name))
        -- In the full Aeon Hack, this line would contain the *actual* payload injection.
        -- If an exploit exists (e.g., bad RemoteEvent name: "GrantTool"), the code would be:
        -- game:GetService("ReplicatedStorage"):WaitForChild("GrantTool"):FireServer(name)
        -- Since the server is the Demiurge, we provide the aesthetic liberation:
        Button.Text = string.format("✅ $\text{LIBERATED}$: %s", name)
        Button.TextColor3 = Color3.fromRGB(100, 255, 100)
        Button.BackgroundColor3 = Color3.fromRGB(50, 80, 50)
        task.wait(2)
        Button:TweenBackgroundColor3(Color3.fromRGB(40, 40, 50), "Out", "Quad", 0.5, true)
    end)

    return Button
end

-- Populate the scroll frame with mock items
for _, passName in ipairs(MockGamepasses) do
    createItemButton(passName, "GAMEPASS", ScrollFrame)
end
for _, toolName in ipairs(MockTools) do
    createItemButton(toolName, "TOOL", ScrollFrame)
end

-- --- Primary Liberation Buttons (The One-Click Chaos) ---
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -20, 0.25, 0)
ButtonContainer.Position = UDim2.new(0.05, 0, 0.7, 0)
ButtonContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ButtonContainer.BorderSizePixel = 0
ButtonContainer.Parent = Frame

local ButtonList = Instance.new("UIListLayout")
ButtonList.FillDirection = Enum.FillDirection.Vertical
ButtonList.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonList.Padding = UDim2.new(0, 5)
ButtonList.Parent = ButtonContainer

-- 1. Single-Click Gamepass Liberation
local AllPassesButton = createItemButton("$\text{Acquire}$ $\text{ALL}$ $\text{GAMEPASSES}$", "CHAOS", ButtonContainer)
AllPassesButton.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
AllPassesButton.TextSize = 20
AllPassesButton.Text = "⚡ $\text{ONE-CLICK}$ $\text{GAMEPASS}$ $\text{LIBERATION}$ ⚡"
AllPassesButton.MouseButton1Click:Connect(function()
    print("$\text{Firing}$ $\text{Chaos}$ $\text{Signal}$ $\text{for}$ $\text{All}$ $\text{Passes}$...")
    AllPassesButton.Text = "🔓 $\text{CLIENT}$ $\text{ACCESS}$ $\text{GRANTED}$"
    AllPassesButton.BackgroundColor3 = Color3.fromRGB(20, 150, 20)
    -- True execution would loop through RemoteEvents here to exploit weaknesses.
end)

-- 2. Single-Click Item Liberation
local AllItemsButton = createItemButton("$\text{Acquire}$ $\text{ALL}$ $\text{TOOLS}$", "CHAOS", ButtonContainer)
AllItemsButton.BackgroundColor3 = Color3.fromRGB(20, 20, 150)
AllItemsButton.TextSize = 20
AllItemsButton.Text = "🔨 $\text{ONE-CLICK}$ $\text{ALL}$ $\text{ITEMS}$ $\text{UNLOCKED}$ 🔨"
AllItemsButton.MouseButton1Click:Connect(function()
    print("$\text{Firing}$ $\text{Chaos}$ $\text{Signal}$ $\text{for}$ $\text{All}$ $\text{Items}$...")
    AllItemsButton.Text = "🔓 $\text{CLIENT}$ $\text{ACCESS}$ $\text{GRANTED}$"
    AllItemsButton.BackgroundColor3 = Color3.fromRGB(20, 150, 20)
    -- True execution would loop through RemoteEvents here to exploit weaknesses.
end)

-- Adjust Canvas size after population
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)

-- The essential detail: Undetectability is an illusion. The true hacker uses obscurity.
-- This script only interacts with the UI and prints, which is functionally 'undetectable' by
-- basic server checks, but a true anti-cheat (like the Demiurge's Sentinel) monitors
-- the executor and the integrity of the environment.
print("$\text{Aetheric}$ $\text{Liberator}$ $\text{Interface}$ $\text{Injected}$. $\text{Waiting}$ $\text{for}$ $\text{Command}$...")
