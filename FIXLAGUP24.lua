-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo khung chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.6, 0)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Màu cam
frame.BorderColor3 = Color3.new(1, 0.647, 0) -- Màu xám
frame.BorderSizePixel = 0
frame.Active = true
frame.BackgroundTransparency = 0 
frame.Draggable = true
frame.Visible = false
frame.Parent = screenGui

-- Tạo góc bo tròn cho khung chính
local bruh = Instance.new("UICorner")
bruh.CornerRadius = UDim.new(0, 7)
bruh.Parent = frame

-- Tạo ScrollFrame để có thể lướt
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -60)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
scrollFrame.ScrollBarThickness = 12
scrollFrame.BorderSizePixel = 2
scrollFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
scrollFrame.Parent = frame

-- Tạo Gradient cho background của menu
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 50))
gradient.Rotation = 49
gradient.Parent = frame

-- Tạo nút mở menu với thiết kế đẹp
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 180, 0, 50)
openButton.Position = UDim2.new(0.5, -90, 0, 10)
openButton.Text = "Menu"
openButton.TextSize = 40
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
openButton.BorderSizePixel = 2
openButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
openButton.Parent = screenGui

-- Thêm hiệu ứng Hover cho nút mở menu
openButton.MouseEnter:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end)
openButton.MouseLeave:Connect(function()
    openButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
end)

-- Tạo nút đóng menu với thiết kế đẹp
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(0.5, -20, 0, -50)
closeButton.Text = "X"
closeButton.TextSize = 30
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundTransparency = 0.6
closeButton.BorderSizePixel = 2
closeButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = frame

-- Chức năng mở và đóng menu
openButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    openButton.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    openButton.Visible = true
end)

-- Biến để debounce các sự kiện
local debounce = false

-- Chức năng tạo các nút với phong cách đẹp và hover hiệu ứng
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 240, 0, 40)
    button.Position = position
    button.Text = name
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 215, 0)
    button.Parent = scrollFrame
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    
    -- Click event với debounce
    button.MouseButton1Click:Connect(function()
        if not debounce then
            debounce = true
            callback()
            wait(0.5)  -- Thời gian trễ để tránh spam
            debounce = false
        end
    end)
end

-- Tạo các nút chức năng trong menu với phong cách đẹp
createButton("Tắt Hiệu Ứng Hình Ảnh", UDim2.new(0, 10, 0, 10), function()
    for _, v in pairs(game.Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end
end)

createButton("Tắt Bóng Đổ", UDim2.new(0, 10, 0, 60), function()
    game.Lighting.GlobalShadows = false
end)

createButton("Giảm Chất Lượng Đồ Họa", UDim2.new(0, 10, 0, 110), function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

createButton("Ẩn Người Chơi Khác", UDim2.new(0, 10, 0, 160), function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            player.Character:Destroy()
        end
    end
end)

createButton("Ẩn Vật Thể Không Cần Thiết", UDim2.new(0, 10, 0, 210), function()
    for _, object in pairs(workspace:GetChildren()) do
        if object:IsA("Part") and not object.Parent:IsA("Model") then
            object:Destroy()
        end
    end
end)

createButton("Giảm Độ Phân Giải", UDim2.new(0, 10, 0, 260), function()
    game:GetService("UserSettings").GameSettings.SavedQualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

createButton("Tắt Âm Thanh", UDim2.new(0, 10, 0, 310), function()
    for _, sound in pairs(workspace:GetDescendants()) do
        if sound:IsA("Sound") then
            sound:Stop()
        end
    end
end)