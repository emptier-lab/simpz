local simpz = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

simpz.Settings = {
    Theme = {
        Primary = Color3.fromRGB(32, 33, 36),
        Secondary = Color3.fromRGB(42, 43, 49),
        Accent = Color3.fromRGB(114, 137, 218),
        TextColor = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(175, 175, 175),
        Error = Color3.fromRGB(237, 66, 69),
        Success = Color3.fromRGB(87, 242, 135),
        Warning = Color3.fromRGB(254, 231, 92)
    },
    Animation = {
        TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        SpringInfo = {frequency = 5, dampingRatio = 1}
    },
    Flags = {},
    Elements = {}
}

function simpz:Tween(instance, properties)
    local tween = TweenService:Create(instance, simpz.Settings.Animation.TweenInfo, properties)
    tween:Play()
    return tween
end

function simpz:Create(class, properties)
    local instance = Instance.new(class)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    return instance
end

function simpz:AddShadow(element, strength)
    strength = strength or 0.5
    
    local shadow = simpz:Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 24, 1, 24),
        ZIndex = element.ZIndex - 1,
        Image = "rbxassetid://7912134082",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 1 - strength,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(40, 40, 260, 260),
        SliceScale = 0.08,
        Parent = element
    })
    
    return shadow
end

function simpz:AddGlow(element, color, strength)
    color = color or simpz.Settings.Theme.Accent
    strength = strength or 0.5
    
    local glow = simpz:Create("ImageLabel", {
        Name = "Glow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 30, 1, 30),
        ZIndex = element.ZIndex - 1,
        Image = "rbxassetid://7912134082",
        ImageColor3 = color,
        ImageTransparency = 1 - strength,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(40, 40, 260, 260),
        SliceScale = 0.08,
        Parent = element
    })
    
    return glow
end

function simpz:AddStroke(element, color, thickness)
    color = color or simpz.Settings.Theme.Accent
    thickness = thickness or 1
    
    local stroke = simpz:Create("UIStroke", {
        Name = "Stroke",
        Color = color,
        Thickness = thickness,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = element
    })
    
    return stroke
end

function simpz:CreateWindow(title, size)
    title = title or "simpz UI"
    size = size or UDim2.new(0, 550, 0, 400)
    
    if simpz.GUI then
        simpz.GUI:Destroy()
    end
    
    local simpzGUI = simpz:Create("ScreenGui", {
        Name = "simpzGUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = Player.PlayerGui
    })
    
    simpz.GUI = simpzGUI
    
    local MainFrame = simpz:Create("Frame", {
        Name = "MainFrame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.Primary,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = size,
        ClipsDescendants = true,
        Parent = simpzGUI
    })
    
    local Corner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = MainFrame
    })
    
    simpz:AddShadow(MainFrame, 0.6)
    
    local TopBar = simpz:Create("Frame", {
        Name = "TopBar",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 30),
        Parent = MainFrame
    })
    
    local TopBarCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = TopBar
    })
    
    local CornerFix = simpz:Create("Frame", {
        Name = "CornerFix",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -8),
        Size = UDim2.new(1, 0, 0, 8),
        ZIndex = 0,
        Parent = TopBar
    })
    
    local TitleLabel = simpz:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TopBar
    })
    
    local CloseButton = simpz:Create("TextButton", {
        Name = "CloseButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.Error,
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 14,
        Parent = TopBar
    })
    
    local CloseButtonCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = CloseButton
    })
    
    local MinimizeButton = simpz:Create("TextButton", {
        Name = "MinimizeButton",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.Warning,
        Position = UDim2.new(1, -32, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 14,
        Parent = TopBar
    })
    
    local MinimizeButtonCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = MinimizeButton
    })
    
    local ContentContainer = simpz:Create("Frame", {
        Name = "ContentContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(1, 0, 1, -30),
        Parent = MainFrame
    })
    
    local TabContainer = simpz:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(0, 120, 1, 0),
        Parent = ContentContainer
    })
    
    local TabContainerCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = TabContainer
    })
    
    local CornerFix2 = simpz:Create("Frame", {
        Name = "CornerFix",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -8, 0, 0),
        Size = UDim2.new(0, 8, 1, 0),
        ZIndex = 0,
        Parent = TabContainer
    })
    
    local TabList = simpz:Create("ScrollingFrame", {
        Name = "TabList",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 10),
        Size = UDim2.new(1, 0, 1, -10),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = simpz.Settings.Theme.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = TabContainer
    })
    
    local TabListLayout = simpz:Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = TabList
    })
    
    local TabContent = simpz:Create("Frame", {
        Name = "TabContent",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 120, 0, 0),
        Size = UDim2.new(1, -120, 1, 0),
        Parent = ContentContainer
    })
    
    local Window = {
        Gui = simpzGUI,
        MainFrame = MainFrame,
        Tabs = {}
    }
    
    local Dragging = false
    local DragInput
    local DragStart
    local StartPos
    
    local function UpdateDrag(input)
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            UpdateDrag(input)
        end
    end)
    
    local WindowMinimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        WindowMinimized = not WindowMinimized
        if WindowMinimized then
            ContentContainer.Visible = false
            simpz:Tween(MainFrame, {Size = UDim2.new(0, size.X.Offset, 0, 30)})
        else
            simpz:Tween(MainFrame, {Size = size})
            task.wait(0.2)
            ContentContainer.Visible = true
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        simpz:Tween(MainFrame, {Size = UDim2.new(0, size.X.Offset, 0, 0), Position = UDim2.new(0.5, 0, 0.5, size.Y.Offset/2)})
        task.wait(0.2)
        simpzGUI:Destroy()
    end)
    
    function Window:CreateTab(name, icon)
        name = name or "Tab"
        icon = icon or ""
        
        local TabButton = simpz:Create("TextButton", {
            Name = name .. "Tab",
            BackgroundColor3 = simpz.Settings.Theme.Primary,
            Size = UDim2.new(0.9, 0, 0, 32),
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = simpz.Settings.Theme.TextColor,
            TextSize = 12,
            Parent = TabList
        })
        
        local TabButtonCorner = simpz:Create("UICorner", {
            CornerRadius = UDim.new(0, 6),
            Parent = TabButton
        })
        
        simpz:AddStroke(TabButton, simpz.Settings.Theme.Accent, 0)
        
        if icon ~= "" then
            local IconImage = simpz:Create("ImageLabel", {
                Name = "Icon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0.5, 0),
                Size = UDim2.new(0, 20, 0, 20),
                AnchorPoint = Vector2.new(0, 0.5),
                Image = icon,
                Parent = TabButton
            })
            
            TabButton.Text = "  " .. name
            TabButton.TextXAlignment = Enum.TextXAlignment.Center
        end
        
        local TabFrame = simpz:Create("ScrollingFrame", {
            Name = name .. "Frame",
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = simpz.Settings.Theme.Accent,
            Parent = TabContent
        })
        
        local Padding = simpz:Create("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
            Parent = TabFrame
        })
        
        local ElementList = simpz:Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = TabFrame
        })
        
        local Tab = {
            Button = TabButton,
            Frame = TabFrame,
            Elements = {}
        }
        
        table.insert(Window.Tabs, Tab)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Frame.Visible = false
                simpz:Tween(t.Button, {BackgroundColor3 = simpz.Settings.Theme.Primary})
                simpz:Tween(t.Button:FindFirstChildOfClass("UIStroke"), {Thickness = 0})
            end
            
            TabFrame.Visible = true
            simpz:Tween(TabButton, {BackgroundColor3 = simpz.Settings.Theme.Secondary})
            simpz:Tween(TabButton:FindFirstChildOfClass("UIStroke"), {Thickness = 1})
        end)
        
        if #Window.Tabs == 1 then
            TabFrame.Visible = true
            simpz:Tween(TabButton, {BackgroundColor3 = simpz.Settings.Theme.Secondary})
            simpz:Tween(TabButton:FindFirstChildOfClass("UIStroke"), {Thickness = 1})
        end
        
        return Tab
    end
    
    return Window
end

function simpz:CreateSection(tab, title)
    local SectionFrame = simpz:Create("Frame", {
        Name = title .. "Section",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 36),
        Parent = tab.Frame
    })
    
    local SectionCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = SectionFrame
    })
    
    simpz:AddShadow(SectionFrame, 0.3)
    
    local SectionTitle = simpz:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SectionFrame
    })
    
    local ToggleArrow = simpz:Create("ImageLabel", {
        Name = "ToggleArrow",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        Image = "rbxassetid://7072706318", -- Down arrow
        ImageColor3 = simpz.Settings.Theme.TextColor,
        Rotation = 0,
        Parent = SectionFrame
    })
    
    local ContentFrame = simpz:Create("Frame", {
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 36),
        Size = UDim2.new(1, 0, 0, 0),
        ClipsDescendants = true,
        Parent = SectionFrame
    })
    
    local ContentLayout = simpz:Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ContentFrame
    })
    
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if ContentFrame.Visible then
            ContentFrame.Size = UDim2.new(1, 0, 0, ContentLayout.AbsoluteContentSize.Y)
            SectionFrame.Size = UDim2.new(1, 0, 0, 36 + ContentLayout.AbsoluteContentSize.Y)
        end
    end)
    
    local isCollapsed = false
    
    local function ToggleSection()
        isCollapsed = not isCollapsed
        
        if isCollapsed then
            simpz:Tween(SectionFrame, {Size = UDim2.new(1, 0, 0, 36)})
            simpz:Tween(ContentFrame, {Size = UDim2.new(1, 0, 0, 0)})
            simpz:Tween(ToggleArrow, {Rotation = -90})
        else
            simpz:Tween(ContentFrame, {Size = UDim2.new(1, 0, 0, ContentLayout.AbsoluteContentSize.Y)})
            simpz:Tween(SectionFrame, {Size = UDim2.new(1, 0, 0, 36 + ContentLayout.AbsoluteContentSize.Y)})
            simpz:Tween(ToggleArrow, {Rotation = 0})
        end
    end
    
    local ClickDetector = simpz:Create("TextButton", {
        Name = "ClickDetector",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 36),
        Text = "",
        Parent = SectionFrame
    })
    
    ClickDetector.MouseButton1Click:Connect(ToggleSection)
    
    local Section = {
        Frame = ContentFrame,
        Container = tab.Frame,
        Elements = {},
        SetCollapsed = function(collapsed)
            if collapsed ~= isCollapsed then
                ToggleSection()
            end
        end
    }
    
    return Section
end

function simpz:CreateButton(parent, text, callback)
    callback = callback or function() end
    
    local ButtonFrame = simpz:Create("Frame", {
        Name = text .. "Button",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 36),
        Parent = parent.Frame
    })
    
    local ButtonCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = ButtonFrame
    })
    
    simpz:AddShadow(ButtonFrame, 0.2)
    
    local ButtonLabel = simpz:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ButtonFrame
    })
    
    local Button = simpz:Create("TextButton", {
        Name = "Button",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.Accent,
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 80, 0, 24),
        AutoButtonColor = false,
        Font = Enum.Font.Gotham,
        Text = "Execute",
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 12,
        Parent = ButtonFrame
    })
    
    local ButtonInnerCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = Button
    })
    
    simpz:AddGlow(Button, simpz.Settings.Theme.Accent, 0.2)
    
    local ButtonStroke = simpz:AddStroke(Button, simpz.Settings.Theme.Accent, 1)
    
    Button.MouseEnter:Connect(function()
        simpz:Tween(Button, {BackgroundColor3 = simpz.Settings.Theme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)})
    end)
    
    Button.MouseLeave:Connect(function()
        simpz:Tween(Button, {BackgroundColor3 = simpz.Settings.Theme.Accent})
    end)
    
    Button.MouseButton1Down:Connect(function()
        simpz:Tween(Button, {BackgroundColor3 = simpz.Settings.Theme.Accent:Lerp(Color3.fromRGB(0, 0, 0), 0.2)})
    end)
    
    Button.MouseButton1Up:Connect(function()
        simpz:Tween(Button, {BackgroundColor3 = simpz.Settings.Theme.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.2)})
        callback()
    end)
    
    local ButtonElement = {
        Frame = ButtonFrame,
        Button = Button,
        Text = ButtonLabel
    }
    
    if parent.Elements then
        table.insert(parent.Elements, ButtonElement)
    end
    
    return ButtonElement
end

function simpz:CreateToggle(parent, text, default, callback)
    default = default or false
    callback = callback or function() end
    
    local value = default
    
    local ToggleFrame = simpz:Create("Frame", {
        Name = text .. "Toggle",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 36),
        Parent = parent.Frame
    })
    
    local ToggleCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = ToggleFrame
    })
    
    simpz:AddShadow(ToggleFrame, 0.2)
    
    local ToggleLabel = simpz:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ToggleFrame
    })
    
    local ToggleBackground = simpz:Create("Frame", {
        Name = "Background",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = value and simpz.Settings.Theme.Accent or simpz.Settings.Theme.Primary,
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 40, 0, 20),
        Parent = ToggleFrame
    })
    
    local ToggleBackgroundCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = ToggleBackground
    })
    
    simpz:AddStroke(ToggleBackground, simpz.Settings.Theme.Accent, 1)
    
    local Dot = simpz:Create("Frame", {
        Name = "Dot",
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.TextColor,
        BackgroundTransparency = 1,
        Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        Parent = ToggleBackground
    })
    
    local function Toggle()
        value = not value
        simpz:Tween(Dot, {Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)})
        simpz:Tween(ToggleBackground, {BackgroundColor3 = value and simpz.Settings.Theme.Accent or simpz.Settings.Theme.Primary})
        callback(value)
    end
    
    if default then
        callback(true)
    end
    
    ToggleBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle()
        end
    end)
    
    local ToggleElement = {
        Frame = ToggleFrame,
        Value = function() return value end,
        Set = function(newValue)
            if newValue ~= value then
                Toggle()
            end
        end
    }
    
    if parent.Elements then
        table.insert(parent.Elements, ToggleElement)
    end
    
    return ToggleElement
end

function simpz:CreateSlider(parent, text, options, callback)
    options = options or {}
    options.min = options.min or 0
    options.max = options.max or 100
    options.default = options.default or options.min
    options.suffix = options.suffix or ""
    options.precise = options.precise or false
    
    callback = callback or function() end
    
    local value = options.default
    
    local SliderFrame = simpz:Create("Frame", {
        Name = text .. "Slider",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = parent.Frame
    })
    
    local SliderCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = SliderFrame
    })
    
    simpz:AddShadow(SliderFrame, 0.2)
    
    local SliderLabel = simpz:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 0, 36),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SliderFrame
    })
    
    local ValueLabel = simpz:Create("TextLabel", {
        Name = "Value",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 0),
        Size = UDim2.new(0, 50, 0, 36),
        Font = Enum.Font.Gotham,
        Text = tostring(value) .. options.suffix,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SliderFrame
    })
    
    local SliderContainer = simpz:Create("Frame", {
        Name = "Container",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = simpz.Settings.Theme.Primary,
        Position = UDim2.new(0.5, 0, 1, -8),
        Size = UDim2.new(1, -20, 0, 6),
        Parent = SliderFrame
    })
    
    local SliderContainerCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderContainer
    })
    
    local SliderFill = simpz:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = simpz.Settings.Theme.Accent,
        Size = UDim2.new((value - options.min) / (options.max - options.min), 0, 1, 0),
        Parent = SliderContainer
    })
    
    local SliderFillCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderFill
    })
    
    simpz:AddGlow(SliderFill, simpz.Settings.Theme.Accent, 0.3)
    
    local SliderDot = simpz:Create("Frame", {
        Name = "Dot",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.TextColor,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        ZIndex = 2,
        Parent = SliderFill
    })
    
    local SliderDotCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderDot
    })
    
    -- Removed glow to make slider dot invisible
    
    local function UpdateSlider(input)
        local percentX = math.clamp((input.Position.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
        local newValue = options.min + (options.max - options.min) * percentX
        
        if options.precise then
            value = newValue
        else
            value = math.floor(newValue + 0.5)
        end
        
        value = math.clamp(value, options.min, options.max)
        
        ValueLabel.Text = string.format(options.precise and "%.2f%s" or "%d%s", value, options.suffix)
        simpz:Tween(SliderFill, {Size = UDim2.new((value - options.min) / (options.max - options.min), 0, 1, 0)})
        
        callback(value)
    end
    
    SliderContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            UpdateSlider(input)
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    UpdateSlider({Position = {X = Mouse.X, Y = Mouse.Y}})
                else
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    local SliderElement = {
        Frame = SliderFrame,
        Value = function() return value end,
        Set = function(newValue)
            value = math.clamp(newValue, options.min, options.max)
            ValueLabel.Text = string.format(options.precise and "%.2f%s" or "%d%s", value, options.suffix)
            simpz:Tween(SliderFill, {Size = UDim2.new((value - options.min) / (options.max - options.min), 0, 1, 0)})
            callback(value)
        end
    }
    
    if parent.Elements then
        table.insert(parent.Elements, SliderElement)
    end
    
    return SliderElement
end

function simpz:CreateColorPicker(parent, text, default, callback)
    default = default or Color3.fromRGB(255, 0, 0)
    callback = callback or function() end
    
    local color = default
    
    local ColorFrame = simpz:Create("Frame", {
        Name = text .. "ColorPicker",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 36),
        ClipsDescendants = true,
        Parent = parent.Frame
    })
    
    local ColorCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = ColorFrame
    })
    
    simpz:AddShadow(ColorFrame, 0.2)
    
    local ColorLabel = simpz:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ColorFrame
    })
    
    local ColorDisplay = simpz:Create("Frame", {
        Name = "ColorDisplay",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = color,
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 20),
        Parent = ColorFrame
    })
    
    local ColorDisplayCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = ColorDisplay
    })
    
    simpz:AddStroke(ColorDisplay, Color3.fromRGB(255, 255, 255), 1)
    
    local HexLabel = simpz:Create("TextLabel", {
        Name = "HexLabel",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -50, 0.5, 0),
        Size = UDim2.new(0, 70, 1, 0),
        Font = Enum.Font.Gotham,
        Text = string.format("#%02X%02X%02X", 
            math.floor(color.R * 255), 
            math.floor(color.G * 255), 
            math.floor(color.B * 255)),
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = ColorFrame
    })
    
    local ColorPickerButton = simpz:Create("TextButton", {
        Name = "PickerButton",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Parent = ColorFrame
    })
    
    local ColorPickerGui = simpz:Create("Frame", {
        Name = "ColorPickerGui",
        BackgroundColor3 = simpz.Settings.Theme.Primary,
        Position = UDim2.new(0, 0, 1, 5),
        Size = UDim2.new(1, 0, 0, 200),
        Visible = false,
        ZIndex = 5,
        Parent = ColorFrame
    })
    
    local ColorPickerCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = ColorPickerGui
    })
    
    simpz:AddShadow(ColorPickerGui, 0.4)
    
    local Saturation = simpz:Create("ImageLabel", {
        Name = "Saturation",
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 0, 150),
        ZIndex = 6,
        Image = "rbxassetid://4155801252",
        Parent = ColorPickerGui
    })
    
    local SaturationCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = Saturation
    })
    
    local Hue = simpz:Create("ImageLabel", {
        Name = "Hue",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 10, 0, 170),
        Size = UDim2.new(1, -20, 0, 20),
        ZIndex = 6,
        Image = "rbxassetid://3283442737",
        Parent = ColorPickerGui
    })
    
    local HueCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = Hue
    })
    
    local HueSelector = simpz:Create("Frame", {
        Name = "HueSelector",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 3, 1, 0),
        ZIndex = 7,
        Parent = Hue
    })
    
    local HueSelectorCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 2),
        Parent = HueSelector
    })
    
    local SaturationSelector = simpz:Create("Frame", {
        Name = "SaturationSelector",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        ZIndex = 7,
        Parent = Saturation
    })
    
    local SelectorRing = simpz:Create("UIStroke", {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1.6,
        Parent = SaturationSelector
    })
    
    local SelectorCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SaturationSelector
    })
    
    local function UpdateColor()
        ColorDisplay.BackgroundColor3 = color
        HexLabel.Text = string.format("#%02X%02X%02X", 
            math.floor(color.R * 255), 
            math.floor(color.G * 255), 
            math.floor(color.B * 255))
            
        callback(color)
    end
    
    local h, s, v = color:ToHSV()
    
    local function UpdateHue()
        Saturation.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        local huePosition = h
        HueSelector.Position = UDim2.new(huePosition, 0, 0.5, 0)
        color = Color3.fromHSV(h, s, v)
        UpdateColor()
    end
    
    local function UpdateSatVal()
        SaturationSelector.Position = UDim2.new(s, 0, 1 - v, 0)
        color = Color3.fromHSV(h, s, v)
        UpdateColor()
    end
    
    local pickerOpen = false
    
    ColorPickerButton.MouseButton1Click:Connect(function()
        pickerOpen = not pickerOpen
        
        ColorPickerGui.Visible = pickerOpen
        
        if pickerOpen then
            simpz:Tween(ColorFrame, {Size = UDim2.new(1, 0, 0, 36 + 205)})
        else
            simpz:Tween(ColorFrame, {Size = UDim2.new(1, 0, 0, 36)})
        end
    end)
    
    Hue.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            
            connection = RunService.RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    local sizeX = Hue.AbsoluteSize.X
                    local posX = math.clamp(Mouse.X - Hue.AbsolutePosition.X, 0, sizeX)
                    h = posX / sizeX
                    UpdateHue()
                else
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    Saturation.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            
            connection = RunService.RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    local sizeX, sizeY = Saturation.AbsoluteSize.X, Saturation.AbsoluteSize.Y
                    local posX = math.clamp(Mouse.X - Saturation.AbsolutePosition.X, 0, sizeX)
                    local posY = math.clamp(Mouse.Y - Saturation.AbsolutePosition.Y, 0, sizeY)
                    
                    s = posX / sizeX
                    v = 1 - (posY / sizeY)
                    
                    UpdateSatVal()
                else
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UpdateHue()
    UpdateSatVal()
    
    local ColorPickerElement = {
        Frame = ColorFrame,
        Color = function() return color end,
        Set = function(newColor)
            color = newColor
            h, s, v = color:ToHSV()
            UpdateHue()
            UpdateSatVal()
        end
    }
    
    if parent.Elements then
        table.insert(parent.Elements, ColorPickerElement)
    end
    
    return ColorPickerElement
end

function simpz:CreateSoundController(parent, text, options, callback)
    options = options or {}
    options.min = options.min or 0
    options.max = options.max or 100
    options.default = options.default or 75
    
    callback = callback or function() end
    
    local value = options.default
    
    local SoundFrame = simpz:Create("Frame", {
        Name = text .. "Sound",
        BackgroundColor3 = simpz.Settings.Theme.Secondary,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = parent.Frame
    })
    
    local SoundCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = SoundFrame
    })
    
    simpz:AddShadow(SoundFrame, 0.2)
    
    local SoundLabel = simpz:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(0.5, 0, 0, 36),
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SoundFrame
    })
    
    local VolumeIcon = simpz:Create("ImageLabel", {
        Name = "VolumeIcon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 32),
        Size = UDim2.new(0, 18, 0, 18),
        Image = "rbxassetid://7733658133", -- Speaker icon
        ImageColor3 = simpz.Settings.Theme.TextColor,
        Parent = SoundFrame
    })
    
    local MuteButton = simpz:Create("TextButton", {
        Name = "MuteButton",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 32),
        Size = UDim2.new(0, 18, 0, 18),
        Text = "",
        Parent = SoundFrame
    })
    
    local ValueLabel = simpz:Create("TextLabel", {
        Name = "Value",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 0),
        Size = UDim2.new(0, 50, 0, 36),
        Font = Enum.Font.Gotham,
        Text = tostring(value) .. "%",
        TextColor3 = simpz.Settings.Theme.TextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SoundFrame
    })
    
    local SliderContainer = simpz:Create("Frame", {
        Name = "Container",
        BackgroundColor3 = simpz.Settings.Theme.Primary,
        Position = UDim2.new(0, 35, 0, 38),
        Size = UDim2.new(1, -80, 0, 6),
        Parent = SoundFrame
    })
    
    local SliderContainerCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderContainer
    })
    
    local SliderFill = simpz:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = simpz.Settings.Theme.Accent,
        Size = UDim2.new(value / options.max, 0, 1, 0),
        Parent = SliderContainer
    })
    
    local SliderFillCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderFill
    })
    
    simpz:AddGlow(SliderFill, simpz.Settings.Theme.Accent, 0.3)
    
    local SliderDot = simpz:Create("Frame", {
        Name = "Dot",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = simpz.Settings.Theme.TextColor,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 12),
        ZIndex = 2,
        Parent = SliderFill
    })
    
    local SliderDotCorner = simpz:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = SliderDot
    })
    
    -- Removed glow to make slider dot invisible
    
    local isMuted = false
    
    local function UpdateIcon()
        if isMuted then
            VolumeIcon.Image = "rbxassetid://7733774602" -- Mute icon
        else
            if value >= 70 then
                VolumeIcon.Image = "rbxassetid://7733658133" -- Full volume icon
            elseif value >= 30 then
                VolumeIcon.Image = "rbxassetid://7733746798" -- Medium volume icon 
            else
                VolumeIcon.Image = "rbxassetid://7733738052" -- Low volume icon
            end
        end
    end
    
    local function UpdateSlider(input)
        local percentage = math.clamp((input.Position.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
        value = math.floor(options.min + (options.max - options.min) * percentage)
        
        ValueLabel.Text = tostring(value) .. "%"
        simpz:Tween(SliderFill, {Size = UDim2.new(value / options.max, 0, 1, 0)})
        
        isMuted = (value == 0)
        UpdateIcon()
        
        callback(value, isMuted)
    end
    
    SliderContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            UpdateSlider(input)
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    UpdateSlider({Position = {X = Mouse.X, Y = Mouse.Y}})
                else
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    MuteButton.MouseButton1Click:Connect(function()
        isMuted = not isMuted
        
        if isMuted then
            ValueLabel.Text = "0%"
            simpz:Tween(SliderFill, {Size = UDim2.new(0, 0, 1, 0)})
        else
            ValueLabel.Text = tostring(value) .. "%"
            simpz:Tween(SliderFill, {Size = UDim2.new(value / options.max, 0, 1, 0)})
        end
        
        UpdateIcon()
        callback(isMuted and 0 or value, isMuted)
    end)
    
    UpdateIcon()
    
    local SoundElement = {
        Frame = SoundFrame,
        Value = function() return isMuted and 0 or value end,
        IsMuted = function() return isMuted end,
        Set = function(newValue)
            value = math.clamp(newValue, options.min, options.max)
            isMuted = (value == 0)
            
            ValueLabel.Text = tostring(value) .. "%"
            simpz:Tween(SliderFill, {Size = UDim2.new(value / options.max, 0, 1, 0)})
            
            UpdateIcon()
            callback(value, isMuted)
        end,
        Mute = function(mute)
            isMuted = mute
            
            if isMuted then
                ValueLabel.Text = "0%"
                simpz:Tween(SliderFill, {Size = UDim2.new(0, 0, 1, 0)})
            else
                ValueLabel.Text = tostring(value) .. "%"
                simpz:Tween(SliderFill, {Size = UDim2.new(value / options.max, 0, 1, 0)})
            end
            
            UpdateIcon()
            callback(isMuted and 0 or value, isMuted)
        end
    }
    
    if parent.Elements then
        table.insert(parent.Elements, SoundElement)
    end
    
    return SoundElement
end

return simpz
