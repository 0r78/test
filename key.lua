-- gui.lua (Vercel에 올릴 GUI 라이브러리 코드 - 로더가 이걸 loadstring으로 불러옴)

local function CreateKeyGui(onSuccess, onFail)
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KeyGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 320, 0, 180)
    Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.BackgroundTransparency = 1
    Title.Text = "키 인증"
    Title.TextColor3 = Color3.fromRGB(220, 220, 220)
    Title.TextSize = 22
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Frame

    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0.9, 0, 0, 35)
    Input.Position = UDim2.new(0.05, 0, 0.3, 0)
    Input.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    Input.PlaceholderText = "키 입력"
    Input.Text = ""
    Input.ClearTextOnFocus = false
    Input.Font = Enum.Font.Gotham
    Input.TextSize = 18
    Input.Parent = Frame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0.55, 0)
    Button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = "확인"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 18
    Button.Parent = Frame

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0, 30)
    Status.Position = UDim2.new(0.05, 0, 0.78, 0)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(255, 80, 80)
    Status.TextSize = 16
    Status.Font = Enum.Font.Gotham
    Status.TextWrapped = true
    Status.Parent = Frame

    Button.MouseButton1Click:Connect(function()
        local key = Input.Text
        if key == "" then
            Status.Text = "키를 입력하세요"
            return
        end

        Status.Text = "검증 중..."
        Status.TextColor3 = Color3.fromRGB(255, 200, 0)

        onSuccess(key)  -- 로더 쪽으로 키 전달해서 Vercel API 호출하게 함
    end)

    -- 로더 쪽에서 Status 업데이트할 수 있게 함수 노출
    return {
        setStatus = function(text, color)
            Status.Text = text
            Status.TextColor3 = color or Color3.fromRGB(255, 80, 80)
        end,
        destroy = function()
            ScreenGui:Destroy()
        end
    }
end

return CreateKeyGui
