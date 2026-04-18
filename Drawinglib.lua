
local lib = {}
local SynFunctions = {}

function zigzag(X) wait(0.1) return math.acos(math.cos(X*math.pi))/math.pi end
local counter = 0

local getasset = getsynasset or getcustomasset
local net = httpget or http_request or requests

local Camera = game.Workspace.CurrentCamera
local ESP_Active = false

local worldToViewportPoint = Camera.worldToViewportPoint

local Drawing = Drawing




local HeadOffset = Vector3.new(0,.5,0)
local LegOffset = Vector3.new(0,3,0)

local protection = Instance.new("Folder", game.Workspace)
protection.Name = "Kasma#7351"

function boxesp(v, BoxOutline, Box)
    game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health > 0 then

            local vector, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

            local RootPart = v.Character.HumanoidRootPart
            local Head = v.Character.Head
            local RootPosition, Rootvis = worldToViewportPoint(Camera, RootPart.Position)
            local HeadPos = worldToViewportPoint(Camera, Head.Position + HeadOffset)
            local LegPosition =  worldToViewportPoint(Camera, RootPart.Position - LegOffset)

            if onScreen then
                BoxOutline.Size = Vector2.new(1000 / RootPosition.z, HeadPos.Y - LegPosition.Y)
                BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                BoxOutline.Visible = true

                Box.Size = Vector2.new(1000 / RootPosition.z, HeadPos.Y - LegPosition.Y)
                Box.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                Box.Visible = true

                if v.TeamColor == game.Players.LocalPlayer.TeamColor then
                    Box.Color = Color3.new(0,1,0)
                else
                    Box.Color = Color3.new(1,0,0)
                end

            else
                BoxOutline.Visible = false
                Box.Visible = false
            end

        else

            BoxOutline.Visible = false
            Box.Visible = false

        end
    end)
end

local SynFunctions = {}

function SynFunctions:ProtectUI(ui)
    if gethui then
        ui.Parent = gethui()
    else
        ui.Parent = game.CoreGui -- fallback
    end
end

function SynFunctions:UnProtectUI(ui)
    ui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

function lib:Roundify(frame, corner)
    local c = Instance.new("UICorner", frame)
    c.CornerRadius = corner
    return c
end

function rain(v)
    game:GetService("RunService").RenderStepped:Connect(function(deltaTime)

        v.BackgroundColor3 = Color3.fromHSV(zigzag(counter),1,1)
 
        counter = counter + 0.01

        task.wait()
    end)
end

function lib:Rainbowify(item)
    coroutine.wrap(rain)(item)
end

function lib:UnRoundiy(frame)
    if not frame:FindFirstChild("UICorner") then return end
    frame:FindFirstChild("UICorner"):Destroy()
    return
end

function lib:UnlockSynFunctions()
    if gethui then
        return {true, SynFunctions}
    else
        return {false, {}}
    end
end

function lib:HidePlayerUI()
    for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        v.Parent = protection
    end
end

function lib:ShowPlayerUi()
    for _,v in pairs(protection:GetChildren()) do
        v.Parent = game.Players.LocalPlayer.PlayerGui
    end
end

function lib:BoxESP()
    ESP_Active = true

    for _,v in pairs(game.Players:GetPlayers()) do
        local BoxOutline = Drawing.new("Square")
        BoxOutline.Visible = false
        BoxOutline.Color = Color3.new(0,0,0)
        BoxOutline.Thickness = 3
        BoxOutline.Transparency = 1
        BoxOutline.Filled = false

        local Box = Drawing.new("Square")
        Box.Visible = false
        Box.Color = Color3.new(1,1,1)
        Box.Thickness = 1
        Box.Transparency = 1
        Box.Filled = false

        coroutine.wrap(boxesp)(v, BoxOutline, Box)

    end

end

game.Players.PlayerAdded:Connect(function(v)
    if ESP_Active then
        local BoxOutline = Drawing.new("Square")
        BoxOutline.Visible = false
        BoxOutline.Color = Color3.new(0,0,0)
        BoxOutline.Thickness = 3
        BoxOutline.Transparency = 1
        BoxOutline.Filled = false
    
        local Box = Drawing.new("Square")
        Box.Visible = false
        Box.Color = Color3.new(1,1,1)
        Box.Thickness = 1
        Box.Transparency = 1
        Box.Filled = false
    
        coroutine.wrap(boxesp)(v, BoxOutline, Box)
    end
end)



return lib
