-- API CALLS

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/not-weuz/Lua/main/bracketv3.lua"))()
local api = loadstring(game:HttpGet("https://raw.githubusercontent.com/not-weuz/xlpapi/main/api.lua"))()

if not isfolder("kocmoc") then makefolder("kocmoc") end
if isfile('kocmoc.txt') == false then (syn and syn.request or http_request)({ Url = "http://127.0.0.1:6463/rpc?v=1",Method = "POST",Headers = {["Content-Type"] = "application/json",["Origin"] = "https://discord.com"},Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER",args = {code = "9vG8UJXuNf"},nonce = game:GetService("HttpService"):GenerateGUID(false)}),writefile('kocmoc.txt', "discord")})end

-- Script temporary variables
local playerstatsevent = game:GetService("ReplicatedStorage").Events.RetrievePlayerStats
local statstable = playerstatsevent:InvokeServer()
local monsterspawners = game:GetService("Workspace").MonsterSpawners
local rarename

-- Script tables

local temptable = {
    version = "2.10.0",
    blackfield = "Ant Field",
    redfields = {},
    bluefields = {},
    whitefields = {},
    shouldiconvertballoonnow = false,
    balloondetected = false,
    puffshroomdetected = false,
    magnitude = 70,
    blacklist = {
        "e_mrFluk2281"
    },
    running = false,
    configname = "",
    tokenpath = game:GetService("Workspace").Collectibles,
    started = {
        vicious = false,
        mondo = false
    },
    detected = {
        vicious = false
    },
    tokensfarm = false,
    converting = false,
    honeystart = 0,
    grib = nil,
    gribpos = CFrame.new(0,0,0),
    honeycurrent = statstable.Totals.Honey,
    dead = false,
    float = false,
    pepsigodmode = false,
    pepsiautodig = false,
    alpha = false,
    beta = false,
    myhiveis = false,
    invis = false,
    sprouts = {
        detected = false,
        coords
    },
    cache = {
        autofarm = false,
        automondo = false,
        vicious = false
    },
    monstertypes = {"Ladybug", "Rhino", "Spider", "Scorpion", "Mantis", "Werewolf"}
}
for i,v in next, temptable.blacklist do if v == api.nickname then game.Players.LocalPlayer:Kick("You're blacklisted! Get clapped!") end end
if temptable.honeystart == 0 then temptable.honeystart = statstable.Totals.Honey end


for i,v in next, game:GetService("Workspace").MonsterSpawners:GetDescendants() do if v.Name == "TimerAttachment" then v.Name = "Attachment" end end
for i,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do if v.Name == "RoseBush" then v.Name = "ScorpionBush" elseif v.Name == "RoseBush2" then v.Name = "ScorpionBush2" end end
for i,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do if v:FindFirstChild("ColorGroup") then if v:FindFirstChild("ColorGroup").Value == "Red" then table.insert(temptable.redfields, v.Name) elseif v:FindFirstChild("ColorGroup").Value == "Blue" then table.insert(temptable.bluefields, v.Name) end else table.insert(temptable.whitefields, v.Name) end end
local flowertable = {}
for _,z in next, game:GetService("Workspace").Flowers:GetChildren() do table.insert(flowertable, z.Position) end
local collectorstable = {}
for _,v in next, getupvalues(require(game:GetService("ReplicatedStorage").Collectors).Exists) do for e,r in next, v do table.insert(collectorstable, e) end end
local fieldstable = {}
for _,v in next, game:GetService("Workspace").FlowerZones:GetChildren() do table.insert(fieldstable, v.Name) end
local toystable = {}
for _,v in next, game:GetService("Workspace").Toys:GetChildren() do table.insert(toystable, v.Name) end
local spawnerstable = {}
for _,v in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do table.insert(spawnerstable, v.Name) end
local accesoriestable = {}
for _,v in next, game:GetService("ReplicatedStorage").Accessories:GetChildren() do if v.Name ~= "UpdateMeter" then table.insert(accesoriestable, v.Name) end end
table.sort(fieldstable)
table.sort(accesoriestable)
table.sort(toystable)
table.sort(spawnerstable)
table.sort(collectorstable)

-- float pad

local floatpad = Instance.new("Part", game:GetService("Workspace"))
floatpad.CanCollide = false
floatpad.Anchored = true
floatpad.Transparency = 1
floatpad.Name = "FloatPad"

-- cococrab

local cocopad = Instance.new("Part", game:GetService("Workspace"))
cocopad.Name = "Coconut Part"
cocopad.Anchored = true
cocopad.Transparency = 1
cocopad.Size = Vector3.new(10, 1, 10)
cocopad.Position = Vector3.new(-307.52117919922, 105.91863250732, 467.86791992188)

-- config

local kocmoc = {
    rares = {},
    priority = {},
    bestfields = {
        red = "Pepper Patch",
        white = "Coconut Field",
        blue = "Stump Field"
    },
    blacklistedfields = {},
    killerkocmoc = {},
    bltokens = {},
    toggles = {
        autofarm = false,
        farmclosestleaf = false,
        farmbubbles = false,
        autodig = false,
        farmrares = false,
        rgbui = false,
        farmflower = false,
        farmfuzzy = false,
        farmcoco = false,
        farmflame = false,
        farmclouds = false,
        killmondo = false,
        killvicious = false,
        loopspeed = false,
        loopjump = false,
        autoquest = false,
        autoboosters = false,
        autodispense = false,
        clock = false,
        freeantpass = false,
        honeystorm = false,
        autodoquest = false,
        disableseperators = false,
        npctoggle = false,
        loopfarmspeed = false,
        mobquests = false,
        traincrab = false,
        avoidmobs = false,
        farmsprouts = false,
        enabletokenblacklisting = false,
        farmunderballoons = false,
        farmsnowflakes = false,
        collectgingerbreads = false,
        collectcrosshairs = false,
        farmpuffshrooms = false,
        tptonpc = false,
        donotfarmtokens = false,
        convertballoons = false
    },
    vars = {
        field = "Ant Field",
        convertat = 100,
        farmspeed = 60,
        prefer = "Tokens",
        walkspeed = 70,
        jumppower = 70,
        npcprefer = "All Quests",
        farmtype = "Walk"
    },
    dispensesettings = {
        blub = false,
        straw = false,
        treat = false,
        coconut = false,
        glue = false,
        rj = false,
        white = false,
        red = false,
        blue = false
    }
}

local defaultkocmoc = kocmoc

-- functions

function statsget() local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() return stats end

function farm(trying)
    if temptable.started.mondo then
        if kocmoc.toggles.loopfarmspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = kocmoc.vars.farmspeed end
        api.humanoid():MoveTo(trying.Position)
        local done = false 
        api.humanoid().MoveToFinished:Connect(function() done=true end)
        repeat task.wait() until done or not IsToken(trying)
    elseif (trying.Position-fieldposition).magnitude < 50 then
        if kocmoc.toggles.loopfarmspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = kocmoc.vars.farmspeed end
        api.humanoid():MoveTo(trying.Position)
        local done = false 
        api.humanoid().MoveToFinished:Connect(function() done=true end)
        repeat task.wait() until done or not IsToken(trying)
    end
end

function disableall()
    if kocmoc.toggles.autofarm and not temptable.converting then
        temptable.cache.autofarm = true
        kocmoc.toggles.autofarm = false
    end
    if kocmoc.toggles.killmondo and not temptable.started.mondo then
        kocmoc.toggles.killmondo = false
        temptable.cache.automondo = true
    end
    if kocmoc.toggles.killvicious and not temptable.started.vicious then
        kocmoc.toggles.killvicious = false
        temptable.cache.vicious = true
    end
end

function enableall()
    if temptable.cache.autofarm then
        kocmoc.toggles.autofarm = true
        temptable.cache.autofarm = false
    end
    if temptable.cache.automondo then
        kocmoc.toggles.killmondo = true
        temptable.cache.automondo = false
    end
    if temptable.cache.vicious then
        kocmoc.toggles.killvicious = true
        temptable.cache.vicious = false
    end
end

function gettoken()
    task.wait()
    for e,r in next, game:GetService("Workspace").Collectibles:GetChildren() do
        itb = false
        if r:FindFirstChildOfClass("Decal") and kocmoc.toggles.enabletokenblacklisting then
            if api.findvalue(kocmoc.bltokens, string.split(r:FindFirstChildOfClass("Decal").Texture, 'rbxassetid://')[2]) then
                itb = true
            end
        end
        if tonumber((r.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and not itb then
            farm(r)
        end
    end
end

function IsToken(token)
    if not token then
        return false
    end
    if not token.Parent then return false end
    if token then
        if token.Name == "C" then
            if token.Orientation.Z ~= 0 then
                return false
            end
            if not token:IsA("Part") then
                return false
            end
        end
        return true
    else
        return false
    end
end

function getprioritytokens()
    task.wait()
    if temptable.running == false then
        for e,r in next, game:GetService("Workspace").Collectibles:GetChildren() do
            if r:FindFirstChildOfClass("Decal") then
                local aaaaaaaa = string.split(r:FindFirstChildOfClass("Decal").Texture, 'rbxassetid://')[2]
                if aaaaaaaa ~= nil and api.findvalue(kocmoc.priority, aaaaaaaa) then
                    if r.Name == game.Players.LocalPlayer.Name and not r:FindFirstChild("got it") or tonumber((r.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and not r:FindFirstChild("got it") then
                        farm(r) local val = Instance.new("IntValue",r) val.Name = "got it" break
                    end
                end
            end
        end
    end
end

function gethiveballoon()
    task.wait()
    result = false
    for i,hive in next, game:GetService("Workspace").Honeycombs:GetChildren() do
        task.wait()
        if hive:FindFirstChild("Owner") and hive:FindFirstChild("SpawnPos") then
            if tostring(hive.Owner.Value) == game.Players.LocalPlayer.Name then
                for e,balloon in next, game:GetService("Workspace").Balloons.HiveBalloons:GetChildren() do
                    task.wait()
                    if balloon:FindFirstChild("BalloonRoot") then
                        if (balloon.BalloonRoot.Position-hive.SpawnPos.Value.Position).magnitude < 15 then
                            result = true
                            break
                        end
                    end
                end
            end
        end
    end
    return result
end

function converthoney()
    task.wait(0)
    if temptable.converting then
        if game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (game:GetService("Players").LocalPlayer.SpawnPos.Value.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 8 then
            api.tween(1, game:GetService("Players").LocalPlayer.SpawnPos.Value * CFrame.fromEulerAnglesXYZ(0, 110, 0))
            task.wait(.9)
            if game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.TextBox.Text ~= "Stop Making Honey" and game.Players.LocalPlayer.PlayerGui.ScreenGui.ActivateButton.BackgroundColor3 ~= Color3.new(201, 39, 28) or (game:GetService("Players").LocalPlayer.SpawnPos.Value.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 8 then game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking") end
            task.wait(.1)
        end
    end
end

function closestleaf()
    for i,v in next, game.Workspace.Flowers:GetChildren() do
        if temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end

function getbubble()
    for i,v in next, game.workspace.Particles:GetChildren() do
        if string.find(v.Name, "Bubble") and temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end

function getballoons()
    for i,v in next, game:GetService("Workspace").Balloons.FieldBalloons:GetChildren() do
        if v:FindFirstChild("BalloonRoot") and v:FindFirstChild("PlayerName") then
            if v:FindFirstChild("PlayerName").Value == game.Players.LocalPlayer.Name then
                if temptable.running == false and tonumber((v.BalloonRoot.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
                    farm(v.BalloonRoot)
                    break
                end
            end
        end
    end
end

function getflower()
    flowerrrr = flowertable[math.random(#flowertable)]
    if tonumber((flowerrrr-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) <= temptable.magnitude/1.4 and tonumber((flowerrrr-fieldposition).magnitude) <= temptable.magnitude/1.4 then 
        if temptable.running == false then 
            if kocmoc.toggles.loopfarmspeed then 
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = kocmoc.vars.farmspeed 
            end 
            api.walkTo(flowerrrr) 
        end 
    end
end

function getcloud()
    for i,v in next, game:GetService("Workspace").Clouds:GetChildren() do
        e = v:FindFirstChild("Plane")
        if e and temptable.running == false and tonumber((e.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(e)
            break
        end
    end
end

function getcoco()
    for i,v in next, game.workspace.Particles:GetChildren() do
        if v.Name == "WarningDisk" and v.BrickColor == BrickColor.new("Lime green") and temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end

function getfuzzy()
    pcall(function()
        for i,v in next, game.workspace.Particles:GetChildren() do
            if v.Name == "DustBunnyInstance" and temptable.running == false and tonumber((v.Plane.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
                if v:FindFirstChild("Plane") then
                    farm(v:FindFirstChild("Plane"))
                    break
                end
            end
        end
    end)
end

function getflame()
    for i,v in next, game.workspace.Particles:GetChildren() do
        if v.Name == "FlamePart" and temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            farm(v)
            break
        end
    end
end

function avoidmob()
    if kocmoc.toggles.avoidmobs then
        for i,v in next, game:GetService("Workspace").Monsters:GetChildren() do
            if v:FindFirstChild("Head") then
                if (v.Head.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 30 then
                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                end
            end
        end
    end
end

function getcrosshairs()
    for i,v in next, game.workspace.Particles:GetChildren() do
        if v.Name == "Crosshair" and temptable.running == false and tonumber((v.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) < temptable.magnitude/1.4 then
            if v ~= nil and v.BrickColor ~= BrickColor.new("Forest green") then farm(v) end
            break
        end
    end
end

function makequests()
    for i,v in next, game:GetService("Workspace").NPCs:GetChildren() do
        if v.Name ~= "Ant Challenge Info" and v.Name ~= "Bubble Bee Man 2" and v.Name ~= "Wind Shrine" and v.Name ~= "Gummy Bear" then if v:FindFirstChild("Platform") then if v.Platform:FindFirstChild("AlertPos") then if v.Platform.AlertPos:FindFirstChild("AlertGui") then if v.Platform.AlertPos.AlertGui:FindFirstChild("ImageLabel") then
            image = v.Platform.AlertPos.AlertGui.ImageLabel
            button = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.ActivateButton.MouseButton1Click
            if image.ImageTransparency == 0 then
                if kocmoc.toggles.tptonpc then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Platform.Position.X, v.Platform.Position.Y+3, v.Platform.Position.Z)
                    task.wait(1)
                else
                    api.tween(2,CFrame.new(v.Platform.Position.X, v.Platform.Position.Y+3, v.Platform.Position.Z))
                    task.wait(3)
                end
                for b,z in next, getconnections(button) do
                    z.Function()
                end
                task.wait(8)
                if image.ImageTransparency == 0 then
                    for b,z in next, getconnections(button) do
                        z.Function()
                    end
                end
            end
        end     
    end end end end end
end

local Config = { WindowName = "🌘  kocmoc | "..temptable.version, Color = Color3.fromRGB(164, 84, 255), Keybind = Enum.KeyCode.Semicolon}
local Window = library:CreateWindow(Config, game:GetService("CoreGui"))

local hometab = Window:CreateTab("Home")
local farmtab = Window:CreateTab("Farming")
local combtab = Window:CreateTab("Combat")
local wayptab = Window:CreateTab("Waypoints")
local misctab = Window:CreateTab("Misc")
local extrtab = Window:CreateTab("Extra")
local setttab = Window:CreateTab("Settings")

local information = hometab:CreateSection("Information")
information:CreateLabel("Thanks you for using our script, "..api.nickname)
information:CreateLabel("Script version: "..temptable.version)
information:CreateLabel("Place version: "..game.PlaceVersion)
information:CreateLabel("⚠️ - Not Safe Function")
information:CreateLabel("⚙ - Configurable Function")
information:CreateLabel("Place version: "..game.PlaceVersion)
information:CreateLabel("Script by weuz_ and mrdevl")
local gainedhoneylabel = information:CreateLabel("Gained Honey: 0")
information:CreateButton("Discord Invite", function() setclipboard("https://discord.gg/9vG8UJXuNf") end)
information:CreateButton("Donation", function() setclipboard("https://qiwi.com/n/W33UZ") end)


local farmo = farmtab:CreateSection("Farming")
local fielddropdown = farmo:CreateDropdown("Field", fieldstable, function(String) kocmoc.vars.field = String end) fielddropdown:SetOption(fieldstable[1])
convertatslider = farmo:CreateSlider("Convert At", 0, 100, 100, false, function(Value) kocmoc.vars.convertat = Value end)
local autofarmtoggle = farmo:CreateToggle("Autofarm ⚙", nil, function(State) kocmoc.toggles.autofarm = State end) autofarmtoggle:CreateKeybind("U", function(Key) end)
farmo:CreateToggle("Autodig", nil, function(State) kocmoc.toggles.autodig = State end)
farmo:CreateToggle("Auto Sprinkler", nil, function(State) kocmoc.toggles.autosprinkler = State end)
farmo:CreateToggle("Farm Bubbles", nil, function(State) kocmoc.toggles.farmbubbles = State end)
farmo:CreateToggle("Farm Flames", nil, function(State) kocmoc.toggles.farmflame = State end)
farmo:CreateToggle("Farm Coconuts", nil, function(State) kocmoc.toggles.farmcoco = State end)
farmo:CreateToggle("Farm Precise Crosshairs", nil, function(State) kocmoc.toggles.collectcrosshairs = State end)
farmo:CreateToggle("Farm Fuzzy Bombs", nil, function(State) kocmoc.toggles.farmfuzzy = State end)
farmo:CreateToggle("Farm Under Balloons", nil, function(State) kocmoc.toggles.farmunderballoons = State end)
farmo:CreateToggle("Farm Under Clouds", nil, function(State) kocmoc.toggles.farmclouds = State end)
--farmo:CreateToggle("Farm Closest Leaves", nil, function(State) kocmoc.toggles.farmclosestleaf = State end)

local farmt = farmtab:CreateSection("Farming")
farmt:CreateToggle("Auto Dispenser ⚙", nil, function(State) kocmoc.toggles.autodispense = State end)
farmt:CreateToggle("Auto Field Boosters ⚙", nil, function(State) kocmoc.toggles.autoboosters = State end)
farmt:CreateToggle("Auto Wealth Clock", nil, function(State) kocmoc.toggles.clock = State end)
farmt:CreateToggle("Auto Gingerbread Bears", nil, function(State) kocmoc.toggles.collectgingerbreads = State end)
farmt:CreateToggle("Auto Free Antpasses", nil, function(State) kocmoc.toggles.freeantpass = State end)
farmt:CreateToggle("Farm Sprouts", nil, function(State) kocmoc.toggles.farmsprouts = State end)
farmt:CreateToggle("Farm Puffshrooms", nil, function(State) kocmoc.toggles.farmpuffshrooms = State end)
farmt:CreateToggle("Farm Snowflakes ⚠️", nil, function(State) kocmoc.toggles.farmsnowflakes = State end)
farmt:CreateToggle("Teleport To Rares ⚠️", nil, function(State) kocmoc.toggles.farmrares = State end)
farmt:CreateToggle("Auto Accept/Confirm Quests ⚙", nil, function(State) kocmoc.toggles.autoquest = State end)
farmt:CreateToggle("Auto Do Quests ⚙", nil, function(State) kocmoc.toggles.autodoquest = State end)
farmt:CreateToggle("Auto Honeystorm", nil, function(State) kocmoc.toggles.honeystorm = State end)


local mobkill = combtab:CreateSection("Combat")
mobkill:CreateToggle("Train Crab", nil, function(State) if State then api.humanoidrootpart().CFrame = CFrame.new(-307.52117919922, 107.91863250732, 467.86791992188) end end)
mobkill:CreateToggle("Kill Mondo", nil, function(State) kocmoc.toggles.killmondo = State end)
mobkill:CreateToggle("Kill Vicious", nil, function(State) kocmoc.toggles.killvicious = State end)
mobkill:CreateToggle("Avoid Mobs", nil, function(State) kocmoc.toggles.avoidmobs = State end)


local wayp = wayptab:CreateSection("Waypoints")
wayp:CreateDropdown("Field Teleports", fieldstable, function(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").FlowerZones:FindFirstChild(Option).CFrame end)
wayp:CreateDropdown("Monster Teleports", spawnerstable, function(Option) d = game:GetService("Workspace").MonsterSpawners:FindFirstChild(Option) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end)
wayp:CreateDropdown("Toys Teleports", toystable, function(Option) d = game:GetService("Workspace").Toys:FindFirstChild(Option).Platform game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(d.Position.X, d.Position.Y+3, d.Position.Z) end)
wayp:CreateButton("Teleport to hive", function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.SpawnPos.Value end)


local miscc = misctab:CreateSection("Misc")
miscc:CreateButton("Ant Challenge Semi-Godmode", function() api.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(1) game.ReplicatedStorage.Events.ToyEvent:FireServer("Ant Challenge") game.Players.LocalPlayer.Character.HumanoidRootPart.Position = Vector3.new(93.4228, 42.3983, 553.128) task.wait(2) game.Players.LocalPlayer.Character.Humanoid.Name = 1 local l = game.Players.LocalPlayer.Character["1"]:Clone() l.Parent = game.Players.LocalPlayer.Character l.Name = "Humanoid" task.wait() game.Players.LocalPlayer.Character["1"]:Destroy() api.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) task.wait(8) api.tween(1, CFrame.new(93.4228, 32.3983, 553.128)) end)
local wstoggle = miscc:CreateToggle("Walk Speed", nil, function(State) kocmoc.toggles.loopspeed = State end) wstoggle:CreateKeybind("K", function(Key) end)
local jptoggle = miscc:CreateToggle("Jump Power", nil, function(State) kocmoc.toggles.loopjump = State end) jptoggle:CreateKeybind("L", function(Key) end)
local misco = misctab:CreateSection("Other")
misco:CreateDropdown("Equip Accesories", accesoriestable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Accessory" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
misco:CreateDropdown("Equip Collectors", collectorstable, function(Option) local ohString1 = "Equip" local ohTable2 = { ["Mute"] = false, ["Type"] = Option, ["Category"] = "Collector" } game:GetService("ReplicatedStorage").Events.ItemPackageEvent:InvokeServer(ohString1, ohTable2) end)
misco:CreateDropdown("Generate Amulet", {"Supreme Star Amulet", "Diamond Star Amulet", "Gold Star Amulet","Silver Star Amulet","Bronze Star Amulet","Moon Amulet"}, function(Option) local A_1 = Option.." Generator" local Event = game:GetService("ReplicatedStorage").Events.ToyEvent Event:FireServer(A_1) end)
misco:CreateButton("Export Stats Table", function() local StatCache = require(game.ReplicatedStorage.ClientStatCache)writefile("Stats_"..api.nickname..".json", StatCache:Encode()) end)
local pepsif = misctab:CreateSection("Pepsi Functions")
pepsif:CreateButton("Enable Pepsi Functions",function()
    Pepsi, dbg = Pepsi, dbg
    if not Pepsi then -- Loser
        loadstring(rawget(rawget(game:GetObjects("rbxassetid://3554165973"), 0x1):GetChildren(), 0x1).ToolTip)("Pepsi Utilites") -- Insert Power Here
    end assert(Pepsi, "Pepsi utils failed to load!") spawn(function()pcall(function()if (true or 2 == shared.devmode) and dbg.attach then pcall(dbg.attach, "pepsiswarm")end end)end)
    pepsif:CreateToggle("Pepsi's Godmode", nil, function(State)
        if temptable.pepsigodmode == false then
            temptable.pepsigodmode = true
            local tool = nil
            if kocmoc.toggles.autodig then
                tool = Pepsi.Tool()
            end
                if tool and autodig and dbg and dbg.sc and dbg.gse and (math.random(3) == 2 or Pepsi.IsMarked(tool, "scoop")) then
                    pcall(function()
                    pcall(dbg.sc, rawget(dbg.gse(tool:FindFirstChild("ClientScriptMouse")), "collectStart"), 11, ((shared.PepsiSwarm.mods.scoop and "GetMouseButtonsPressed") or "IsMouseButtonPressed"))
                    end)
                    if dbg and type(dbg.gse) == "function" then
                        pcall(function()
                            dbg.gse(Pepsi.Tool().ClientScriptMouse).onEquippedLocal(Pepsi.Mouse())
                        end)
                    end
                    Pepsi.Mark(tool, "scoop")
                end
            --end
            task.wait(0.5)
            local cam = Pepsi.GetCam()
            local cf, me = cam.CFrame, Pepsi.Lp
            local c, h = (me.Character or workspace:FindFirstChild(me.Name)), Pepsi.Human()
            h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            local nh = h:Clone()
            Pepsi.Mark(nh, "god")
            me.Character = nil
            nh:SetStateEnabled(15, false)
            nh:SetStateEnabled(1, false)
            nh:SetStateEnabled(0, false)
            nh.Parent = c
            h:Destroy()
            me.Character, cam.CameraSubject = c, nh
            Pepsi.Rs:wait()
            cam.CFrame = cf
            h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            local s = c:FindFirstChild("Animate")
            if s then
                s.Disabled = true
                Pepsi.Rs:wait()
                s.Disabled = false
            end
            delay(2, function()
                if nh then
                    nh.Health = 100
                end
            end)
            if dbg and type(dbg.gse) == "function" then
                pcall(function()
                    dbg.gse(Pepsi.Tool().ClientScriptMouse).onEquippedLocal(Pepsi.Mouse())
                end)
            end
        else
            temptable.pepsigodmode = false
            local me = Pepsi.Lp
            local c, h = (me.Character or workspace:FindFirstChild(me.Name)), Pepsi.Human()
            h:SetStateEnabled(15, true)
            h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
            me.Character = nil
            h:ChangeState(15)
            me.Character = c
            h.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
            Pepsi.Mark(h, "god", false)
            if dbg and type(dbg.gse) == "function" then
                pcall(function() -- I would use securecall, however this game doesnt check that kinda stuff
                    dbg.gse(Pepsi.Tool().ClientScriptMouse).onEquippedLocal(Pepsi.Mouse())
                end)
            end
        end
    end)
end)


local extras = extrtab:CreateSection("Extras")
extras:CreateButton("Hide nickname", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/not-weuz/Lua/main/nicknamespoofer.lua"))()end)
extras:CreateButton("Boost FPS", function()loadstring(game:HttpGet("https://raw.githubusercontent.com/not-weuz/Lua/main/fpsboost.lua"))()end)
extras:CreateButton("Destroy Decals", function()loadstring(game:HttpGet("https://raw.githubusercontent.com/not-weuz/Lua/main/destroydecals.lua"))()end)
extras:CreateTextBox("Glider Speed", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Speed = Value setupvalue(st, st[1]'Glider', glidersTable) end)
extras:CreateTextBox("Glider Float", "", true, function(Value) local StatCache = require(game.ReplicatedStorage.ClientStatCache) local stats = StatCache:Get() stats.EquippedParachute = "Glider" local module = require(game:GetService("ReplicatedStorage").Parachutes) local st = module.GetStat local glidersTable = getupvalues(st) glidersTable[1]["Glider"].Float = Value setupvalue(st, st[1]'Glider', glidersTable) end)
extras:CreateButton("Invisibility", function(State) api.teleport(CFrame.new(0,0,0)) wait(1) if game.Players.LocalPlayer.Character:FindFirstChild('LowerTorso') then Root = game.Players.LocalPlayer.Character.LowerTorso.Root:Clone() game.Players.LocalPlayer.Character.LowerTorso.Root:Destroy() Root.Parent = game.Players.LocalPlayer.Character.LowerTorso api.teleport(game:GetService("Players").LocalPlayer.SpawnPos.Value) end end)
extras:CreateToggle("Float", nil, function(State) temptable.float = State end)


local farmsettings = setttab:CreateSection("Autofarm Settings")
farmsettings:CreateDropdown("Prefer When Autofarming", {"Tokens", "Other"}, function(Option) kocmoc.vars.prefer = Option end, "Tokens")
farmsettings:CreateDropdown("Tokens Collect Mode", {"Walk", "Pathfinding"}, function(Option) kocmoc.vars.farmtype = Option end, "Walk")
farmsettings:CreateTextBox("Autofarming Walkspeed", "Default Value = 60", true, function(Value) kocmoc.vars.farmspeed = Value end)
farmsettings:CreateToggle("^ Loop Speed On Autofarming",nil, function(State) kocmoc.toggles.loopfarmspeed = State end)
farmsettings:CreateToggle("Don't Walk In Field",nil, function(State) kocmoc.toggles.farmflower = State end)
farmsettings:CreateToggle("Convert Hive Balloon",nil, function(State) kocmoc.toggles.convertballoons = State end)
farmsettings:CreateToggle("Don't Farm Tokens",nil, function(State) kocmoc.toggles.donotfarmtokens = State end)
farmsettings:CreateToggle("Enable Token Blacklisting",nil, function(State) kocmoc.toggles.enabletokenblacklisting = State end)
farmsettings:CreateSlider("Walk Speed", 0, 120, 70, false, function(Value) kocmoc.vars.walkspeed = Value end)
farmsettings:CreateSlider("Jump Power", 0, 120, 70, false, function(Value) kocmoc.vars.jumppower = Value end)
local raresettings = setttab:CreateSection("Tokens Settings")
raresettings:CreateTextBox("Asset ID", 'rbxassetid', false, function(Value) rarename = Value end)
raresettings:CreateButton("Add Token To Rares List", function()
    table.insert(kocmoc.rares, rarename)
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Rares List D",true):Destroy()
    raresettings:CreateDropdown("Rares List", kocmoc.rares, function(Option) end)
end)
raresettings:CreateButton("Remove Token From Rares List", function()
    table.remove(kocmoc.rares, api.tablefind(kocmoc.rares, rarename))
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Rares List D",true):Destroy()
    raresettings:CreateDropdown("Rares List", kocmoc.rares, function(Option) end)
end)
raresettings:CreateButton("Add Token To Blacklist", function()
    table.insert(kocmoc.bltokens, rarename)
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Tokens Blacklist D",true):Destroy()
    raresettings:CreateDropdown("Tokens Blacklist", kocmoc.bltokens, function(Option) end)
end)
raresettings:CreateButton("Remove Token From Blacklist", function()
    table.remove(kocmoc.bltokens, api.tablefind(kocmoc.bltokens, rarename))
    game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Tokens Blacklist D",true):Destroy()
    raresettings:CreateDropdown("Tokens Blacklist", kocmoc.bltokens, function(Option) end)
end)
raresettings:CreateDropdown("Tokens Blacklist", kocmoc.bltokens, function(Option) end)
raresettings:CreateDropdown("Rares List", kocmoc.rares, function(Option) end)
local dispsettings = setttab:CreateSection("Auto Dispenser & Auto Boosters Settings")
dispsettings:CreateToggle("Royal Jelly Dispenser", nil, function(State) kocmoc.dispensesettings.rj = not kocmoc.dispensesettings.rj end)
dispsettings:CreateToggle("Blueberry Dispenser", nil,  function(State) kocmoc.dispensesettings.blub = not kocmoc.dispensesettings.blub end)
dispsettings:CreateToggle("Strawberry Dispenser", nil,  function(State) kocmoc.dispensesettings.straw = not kocmoc.dispensesettings.straw end)
dispsettings:CreateToggle("Treat Dispenser", nil,  function(State) kocmoc.dispensesettings.treat = not kocmoc.dispensesettings.treat end)
dispsettings:CreateToggle("Coconut Dispenser", nil,  function(State) kocmoc.dispensesettings.coconut = not kocmoc.dispensesettings.coconut end)
dispsettings:CreateToggle("Glue Dispenser", nil,  function(State) kocmoc.dispensesettings.glue = not kocmoc.dispensesettings.glue end)
dispsettings:CreateToggle("Mountain Top Booster", nil,  function(State) kocmoc.dispensesettings.white = not kocmoc.dispensesettings.white end)
dispsettings:CreateToggle("Blue Field Booster", nil,  function(State) kocmoc.dispensesettings.blue = not kocmoc.dispensesettings.blue end)
dispsettings:CreateToggle("Red Field Booster", nil,  function(State) kocmoc.dispensesettings.red = not kocmoc.dispensesettings.red end)
local guisettings = setttab:CreateSection("GUI Settings")
local uitoggle = guisettings:CreateToggle("UI Toggle", nil, function(State) Window:Toggle(State) end) uitoggle:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key) Config.Keybind = Enum.KeyCode[Key] end) uitoggle:SetState(true)
guisettings:CreateColorpicker("UI Color", function(Color) Window:ChangeColor(Color) end)
local themes = guisettings:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name) if Name == "Default" then Window:SetBackground("2151741365") elseif Name == "Hearts" then Window:SetBackground("6073763717") elseif Name == "Abstract" then Window:SetBackground("6073743871") elseif Name == "Hexagon" then Window:SetBackground("6073628839") elseif Name == "Circles" then Window:SetBackground("6071579801") elseif Name == "Lace With Flowers" then Window:SetBackground("6071575925") elseif Name == "Floral" then Window:SetBackground("5553946656") end end)themes:SetOption("Default")
local kocmocs = setttab:CreateSection("Configs")
kocmocs:CreateTextBox("Config Name", 'ex: stumpconfig', false, function(Value) temptable.configname = Value end)
kocmocs:CreateButton("Load Config", function() kocmoc = game:service'HttpService':JSONDecode(readfile("kocmoc/BSS_"..temptable.configname..".json")) end)
kocmocs:CreateButton("Save Config", function() writefile("kocmoc/BSS_"..temptable.configname..".json",game:service'HttpService':JSONEncode(kocmoc)) end)
kocmocs:CreateButton("Reset Config", function() kocmoc = defaultkocmoc end)
local fieldsettings = setttab:CreateSection("Fields Settings")
fieldsettings:CreateDropdown("Best White Field", temptable.whitefields, function(Option) kocmoc.bestfields.white = Option end)
fieldsettings:CreateDropdown("Best Red Field", temptable.redfields, function(Option) kocmoc.bestfields.red = Option end)
fieldsettings:CreateDropdown("Best Blue Field", temptable.bluefields, function(Option) kocmoc.bestfields.blue = Option end)
fieldsettings:CreateDropdown("Field", fieldstable, function(Option) temptable.blackfield = Option end)
fieldsettings:CreateButton("Add Field To Blacklist", function() table.insert(kocmoc.blacklistedfields, temptable.blackfield) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Blacklisted Fields D",true):Destroy() fieldsettings:CreateDropdown("Blacklisted Fields", kocmoc.blacklistedfields, function(Option) end) end)
fieldsettings:CreateButton("Remove Field From Blacklist", function() table.remove(kocmoc.blacklistedfields, api.tablefind(kocmoc.blacklistedfields, temptable.blackfield)) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Blacklisted Fields D",true):Destroy() fieldsettings:CreateDropdown("Blacklisted Fields", kocmoc.blacklistedfields, function(Option) end) end)
fieldsettings:CreateDropdown("Blacklisted Fields", kocmoc.blacklistedfields, function(Option) end)
local aqs = setttab:CreateSection("Auto Quest Settings")
aqs:CreateDropdown("Do NPC Quests", {'All Quests', 'Bucko Bee', 'Brown Bear', 'Riley Bee', 'Polar Bear'}, function(Option) kocmoc.vars.npcprefer = Option end)
aqs:CreateToggle("Teleport To NPC", nil, function(State) kocmoc.toggles.tptonpc = State end)
aqs:CreateToggle("Do Monster Quests", nil, function(State) kocmoc.toggles.mobquests = State end)
local pts = setttab:CreateSection("Autofarm Priority Tokens")
pts:CreateTextBox("Asset ID", 'rbxassetid', false, function(Value) rarename = Value end)
pts:CreateButton("Add Token To Priority List", function() table.insert(kocmoc.priority, rarename) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Priority List D",true):Destroy() pts:CreateDropdown("Priority List", kocmoc.priority, function(Option) end) end)
pts:CreateButton("Remove Token From Priority List", function() table.remove(kocmoc.priority, api.tablefind(kocmoc.priority, rarename)) game:GetService("CoreGui"):FindFirstChild(_G.windowname).Main:FindFirstChild("Priority List D",true):Destroy() pts:CreateDropdown("Priority List", kocmoc.priority, function(Option) end) end)
pts:CreateDropdown("Priority List", kocmoc.priority, function(Option) end)

-- script

task.spawn(function() while task.wait() do
    if kocmoc.toggles.autofarm then
        temptable.magnitude = 70
        if game.Players.LocalPlayer.Character:FindFirstChild("ProgressLabel",true) then
        local pollenprglbl = game.Players.LocalPlayer.Character:FindFirstChild("ProgressLabel",true)
        maxpollen = tonumber(pollenprglbl.Text:match("%d+$"))
        local pollencount = game.Players.LocalPlayer.CoreStats.Pollen.Value
        pollenpercentage = pollencount/maxpollen*100
        fieldselected = game:GetService("Workspace").FlowerZones[kocmoc.vars.field]
        if kocmoc.toggles.autodoquest and game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests.Content:FindFirstChild("Frame") then
            for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests:GetDescendants() do
                if v.Name == "Description" then
                    if string.match(v.Parent.Parent.TitleBar.Text, kocmoc.vars.npcprefer) or kocmoc.vars.npcprefer == "All Quests" and not string.find(v.Text, "Puffshroom") then
                        pollentypes = {'White Pollen', "Red Pollen", "Blue Pollen", "Blue Flowers", "Red Flowers", "White Flowers"}
                        text = v.Text
                        if api.returnvalue(fieldstable, text) and not string.find(v.Text, "Complete!") and not api.findvalue(kocmoc.blacklistedfields, api.returnvalue(fieldstable, text)) then
                            d = api.returnvalue(fieldstable, text)
                            fieldselected = game:GetService("Workspace").FlowerZones[d]
                            break
                        elseif api.returnvalue(pollentypes, text) and not string.find(v.Text, 'Complete!') then
                            d = api.returnvalue(pollentypes, text)
                            if d == "Blue Flowers" or d == "Blue Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[kocmoc.bestfields.blue]
                                break
                            elseif d == "White Flowers" or d == "White Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[kocmoc.bestfields.white]
                                break
                            elseif d == "Red Flowers" or d == "Red Pollen" then
                                fieldselected = game:GetService("Workspace").FlowerZones[kocmoc.bestfields.red]
                                break
                            end
                        elseif api.returnvalue(temptable.monstertypes, text) and kocmoc.toggles.mobquests and not string.find(text, "Complete!") then
                            goal = api.returnvalue(temptable.monstertypes, text)
                            for e,r in next, game:GetService("Workspace").MonsterSpawners:GetChildren() do
                                if string.match(r.Name, goal) and not r.Attachment.TimerGui.TimerLabel.Visible then
                                    api.tween(1,CFrame.new(r.Position.X, r.Position.Y+10, r.Position.Z))
                                    task.wait(1)
                                    while r.Attachment.TimerGui.TimerLabel.Visible == false and kocmoc.toggles.autofarm and kocmoc.toggles.autodoquest do
                                        task.wait()
                                        didigotmonster = false
                                        igotthatmonster = ""
                                        for index, monster in next, game:GetService("Workspace").Monsters:GetChildren() do
                                            if monster:FindFirstChild("Head") and (monster.Head.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 20 and string.match(r.Name, goal) then
                                                igotthatmonster = monster
                                                didigotmonster = true
                                                break
                                            else
                                                didigotmonster = false
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(r.Position.X, r.Position.Y, r.Position.Z)
                                            end
                                        end
                                        if didigotmonster then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(igotthatmonster.Head.Position.X+20, igotthatmonster.Head.Position.Y, igotthatmonster.Head.Position.Z) end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        else
            fieldselected = game:GetService("Workspace").FlowerZones[kocmoc.vars.field]
        end
        fieldpos = CFrame.new(fieldselected.Position.X, fieldselected.Position.Y+3, fieldselected.Position.Z)
        fieldposition = fieldselected.Position
        if temptable.sprouts.detected and temptable.sprouts.coords and kocmoc.toggles.farmsprouts then
            fieldposition = temptable.sprouts.coords.Position
            fieldpos = temptable.sprouts.coords
        end
        if kocmoc.toggles.farmpuffshrooms then for i,v in next, workspace.Happenings.Puffshrooms:GetChildren() do if v:FindFirstChild("Puffball Stem") then temptable.magnitude = 25 fieldpos = v['Puffball Stem'].CFrame fieldposition = fieldpos.Position break end end end
        if tonumber(pollenpercentage) < tonumber(kocmoc.vars.convertat) then
            if not temptable.tokensfarm then
                api.tween(2, fieldpos)
                task.wait(2)
                temptable.tokensfarm = true
                if kocmoc.toggles.autosprinkler then game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"] = "Sprinkler Builder"}) end
            else
                if kocmoc.toggles.killmondo then
                    while kocmoc.toggles.killmondo and game.Workspace.Monsters:FindFirstChild("Mondo Chick (Lvl 8)") and not temptable.started.vicious do
                        temptable.started.mondo = true
                        while game.Workspace.Monsters:FindFirstChild("Mondo Chick (Lvl 8)") do
                            disableall()
                            game:GetService("Workspace").Map.Ground.HighBlock.CanCollide = false 
                            mondopition = game.Workspace.Monsters["Mondo Chick (Lvl 8)"].Head.Position
                            api.tween(1, CFrame.new(mondopition.x, mondopition.y - 60, mondopition.z))
                            task.wait(1)
                            temptable.float = true
                        end
                        task.wait(.5) game:GetService("Workspace").Map.Ground.HighBlock.CanCollide = true temptable.float = false api.tween(.5, CFrame.new(73.2, 176.35, -167)) task.wait(1)
                        for i = 0, 300 do 
                            task.wait(.25) 
                            gettoken() 
                        end 
                        enableall() 
                        api.tween(2, fieldpos) 
                        temptable.started.mondo = false
                    end
                end
                if (fieldposition-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > temptable.magnitude then
                    api.tween(2, fieldpos)
                    task.wait(2)
                    if kocmoc.toggles.autosprinkler then game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer({["Name"] = "Sprinkler Builder"}) end
                end
                getprioritytokens()
                if kocmoc.toggles.avoidmobs then avoidmob() end
                if kocmoc.vars.prefer == "Other" then
                    if kocmoc.toggles.farmclosestleaf then closestleaf() end
                    if kocmoc.toggles.farmbubbles then getbubble() end
                    if kocmoc.toggles.farmclouds then getcloud() end
                    if kocmoc.toggles.farmcoco then getcoco() end
                    if kocmoc.toggles.farmflame then getflame() end
                    if kocmoc.toggles.farmfuzzy then getfuzzy() end
                    if kocmoc.toggles.farmunderballoons then getballoons() end
                    if kocmoc.toggles.collectcrosshairs then getcrosshairs() end
                end
                if not kocmoc.toggles.donotfarmtokens then gettoken() end
                if kocmoc.vars.prefer == "Tokens" then
                    if kocmoc.toggles.farmclosestleaf then closestleaf() end
                    if kocmoc.toggles.farmbubbles then getbubble() end
                    if kocmoc.toggles.farmclouds then getcloud() end
                    if kocmoc.toggles.farmcoco then getcoco() end
                    if kocmoc.toggles.farmflame then getflame() end
                    if kocmoc.toggles.farmfuzzy then getfuzzy() end
                    if kocmoc.toggles.farmunderballoons then getballoons() end
                    if kocmoc.toggles.collectcrosshairs then getcrosshairs() end
                end
                if not kocmoc.toggles.farmflower then getflower() end
            end
        elseif tonumber(pollenpercentage) >= tonumber(kocmoc.vars.convertat) then
            temptable.tokensfarm = false
            api.tween(2, game:GetService("Players").LocalPlayer.SpawnPos.Value * CFrame.fromEulerAnglesXYZ(0, 110, 0))
            task.wait(2)
            temptable.converting = true
            repeat
                converthoney()
            until game.Players.LocalPlayer.CoreStats.Pollen.Value == 0
            if kocmoc.toggles.convertballoons and gethiveballoon() then
                task.wait(6)
                repeat
                    task.wait()
                    converthoney()
                until gethiveballoon() == false or not kocmoc.toggles.convertballoons
            end
            temptable.converting = false
            task.wait(6)
            if kocmoc.toggles.autoquest then makequests() end
        end
    end
end end end)


task.spawn(function()
    while task.wait(1) do
		if kocmoc.toggles.killvicious and temptable.detected.vicious and temptable.converting == false then
            temptable.started.vicious = true
            disableall()
			local vichumanoid = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
			for i,v in next, game.workspace.Particles:GetChildren() do
				for x in string.gmatch(v.Name, "Vicious") do
					if string.find(v.Name, "Vicious") then
						api.tween(1,CFrame.new(v.Position.x, v.Position.y, v.Position.z)) task.wait(1)
						api.tween(0.5, CFrame.new(v.Position.x, v.Position.y, v.Position.z)) task.wait(.5)
					end
				end
			end
			for i,v in next, game.workspace.Particles:GetChildren() do
				for x in string.gmatch(v.Name, "Vicious") do
                    while kocmoc.toggles.killvicious and temptable.detected.vicious do task.wait() if string.find(v.Name, "Vicious") then
                        for i=1, 4 do temptable.float = true vichumanoid.CFrame = CFrame.new(v.Position.x+10, v.Position.y, v.Position.z) task.wait(.3)
                        end
                    end end
                end
			end
            enableall()
			task.wait(1)
			temptable.float = false
            temptable.started.vicious = false
		end
	end
end)
task.spawn(function() while task.wait(0.001) do
    if kocmoc.toggles.traincrab then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-259, 111.8, 496.4) * CFrame.fromEulerAnglesXYZ(0, 110, 90) temptable.float = true temptable.float = false end
    if kocmoc.toggles.farmrares then for k,v in next, game.workspace.Collectibles:GetChildren() do if v.CFrame.YVector.Y == 1 then if v.Transparency == 0 then decal = v:FindFirstChildOfClass("Decal") for e,r in next, kocmoc.rares do if decal.Texture == r or decal.Texture == "rbxassetid://"..r then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame break end end end end end end
    if kocmoc.toggles.autodig then workspace.NPCs.Onett.Onett["Porcelain Dipper"].ClickEvent:FireServer() if game.Players.LocalPlayer then if game.Players.LocalPlayer.Character then if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("ClickEvent", true) then clickevent = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("ClickEvent", true) or nil end end end if clickevent then clickevent:FireServer() end end end
end end)

game:GetService("Workspace").Particles.Folder2.ChildAdded:Connect(function(child)
    if child.Name == "Sprout" then
        temptable.sprouts.detected = true
        temptable.sprouts.coords = child.CFrame
    end
end)
game:GetService("Workspace").Particles.Folder2.ChildRemoved:Connect(function(child)
    if child.Name == "Sprout" then
        task.wait(30)
        temptable.sprouts.detected = false
        temptable.sprouts.coords = ""
    end
end)
Workspace.Particles.ChildAdded:Connect(function(instance)
    if string.find(instance.Name, "Vicious") then
        temptable.detected.vicious = true
    end
end)
Workspace.Particles.ChildRemoved:Connect(function(instance)
    if string.find(instance.Name, "Vicious") then
        temptable.detected.vicious = false
    end
end)

task.spawn(function() while task.wait(1) do
    temptable.honeycurrent = statsget().Totals.Honey
    if kocmoc.toggles.honeystorm then game.ReplicatedStorage.Events.ToyEvent:FireServer("Honeystorm") end
    if kocmoc.toggles.collectgingerbreads then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Gingerbread House") end
    if kocmoc.toggles.autodispense then
        if kocmoc.dispensesettings.rj then local A_1 = "Free Royal Jelly Dispenser" local Event = game:GetService("ReplicatedStorage").Events.ToyEvent Event:FireServer(A_1) end
        if kocmoc.dispensesettings.blub then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Blueberry Dispenser") end
        if kocmoc.dispensesettings.straw then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Strawberry Dispenser") end
        if kocmoc.dispensesettings.treat then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Treat Dispenser") end
        if kocmoc.dispensesettings.coconut then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Coconut Dispenser") end
        if kocmoc.dispensesettings.glue then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Glue Dispenser") end
    end
    if kocmoc.toggles.autoboosters then 
        if kocmoc.dispensesettings.white then game.ReplicatedStorage.Events.ToyEvent:FireServer("Field Booster") end
        if kocmoc.dispensesettings.red then game.ReplicatedStorage.Events.ToyEvent:FireServer("Red Field Booster") end
        if kocmoc.dispensesettings.blue then game.ReplicatedStorage.Events.ToyEvent:FireServer("Blue Field Booster") end
    end
    if kocmoc.toggles.clock then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Wealth Clock") end
    if kocmoc.toggles.freeantpass then game:GetService("ReplicatedStorage").Events.ToyEvent:FireServer("Free Ant Pass Dispenser") end
    gainedhoneylabel:UpdateText("Gained Honey: "..api.suffixstring(temptable.honeycurrent - temptable.honeystart))
end end)

game:GetService('RunService').Heartbeat:connect(function() 
    if kocmoc.toggles.autoquest then firesignal(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.NPC.ButtonOverlay.MouseButton1Click) end
    if kocmoc.toggles.loopspeed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = kocmoc.vars.walkspeed end
    if kocmoc.toggles.loopjump then game.Players.LocalPlayer.Character.Humanoid.JumpPower = kocmoc.vars.jumppower end
end)

game:GetService('RunService').Heartbeat:connect(function()
    for i,v in next, game.Players.LocalPlayer.PlayerGui.ScreenGui:WaitForChild("MinigameLayer"):GetChildren() do for k,q in next, v:WaitForChild("GuiGrid"):GetDescendants() do if q.Name == "ObjContent" or q.Name == "ObjImage" then q.Visible = true end end end
end)

game:GetService('RunService').Heartbeat:connect(function() 
    if temptable.float then game.Players.LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0 floatpad.CanCollide = true floatpad.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-3.75, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z) task.wait(0)  else floatpad.CanCollide = false end
end)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)task.wait(1)vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

task.spawn(function()while task.wait() do
    if kocmoc.toggles.farmsnowflakes then
        for i,v in next, temptable.tokenpath:GetChildren() do
            if v:FindFirstChildOfClass("Decal") and v:FindFirstChildOfClass("Decal").Texture == "rbxassetid://6087969886" and v.Transparency == 0 then
                api.tween(2, CFrame.new(v.Position.X, v.Position.Y+3, v.Position.Z))
                task.wait(2)
            end
        end
    end
end end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        if kocmoc.toggles.autofarm then
            temptable.dead = true
            kocmoc.toggles.autofarm = false
            temptable.converting = false
            temptable.farmtoken = false
        end
        if temptable.dead then
            task.wait(30)
            temptable.dead = false
            kocmoc.toggles.autofarm = true local player = game.Players.LocalPlayer
            temptable.converting = false
            temptable.tokensfarm = true
        end
    end)
end)

for _,v in next, game.workspace.Collectibles:GetChildren() do
    if string.find(v.Name,"") then
        v:Destroy()
    end
end 

for _, part in next, workspace:FindFirstChild("FieldDecos"):GetDescendants() do if part:IsA("BasePart") then part.CanCollide = false part.Transparency = part.Transparency < 0.5 and 0.5 or part.Transparency task.wait() end end
for _, part in next, workspace:FindFirstChild("Decorations"):GetDescendants() do if part:IsA("BasePart") and (part.Parent.Name == "Bush" or part.Parent.Name == "Blue Flower") then part.CanCollide = false part.Transparency = part.Transparency < 0.5 and 0.5 or part.Transparency task.wait() end end
for i,v in next, workspace.Decorations.Misc:GetDescendants() do if v.Parent.Name == "Mushroom" then v.CanCollide = false v.Transparency = 0.5 end end
