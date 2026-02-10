local addonName, addon = ...

-- Get SharedMedia-3.0
local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)

-- Register default WoW fonts with SharedMedia if available
if LSM then
    LSM:Register("font", "Friz Quadrata TT", "Fonts\\FRIZQT__.TTF")
    LSM:Register("font", "Arial Narrow", "Fonts\\ARIALN.TTF")
    LSM:Register("font", "Skurri", "Fonts\\skurri.ttf")
    LSM:Register("font", "Morpheus", "Fonts\\MORPHEUS.ttf")
end

-- Default settings
local defaults = {
    cursorCircleEnabled = true,
    circleRadius = 20,
    circleColor = {r = 1, g = 1, b = 1, a = 0.8},
    lineThickness = 3,
    combatTextEnabled = true,
    combatTextEnter = "ENTERING COMBAT!",
    combatTextLeave = "Leaving Combat",
    combatTextFont = "Friz Quadrata TT",
    combatTextSize = 32,
    combatTextX = 0,
    combatTextY = 200,
    disableBlizzardCombatText = true,
    disableBlizzardBagBar = false,
    actionBarsMouseover = {
        MultiBarBottomLeft = false,
        MultiBarBottomRight = false,
        MultiBarRight = false,
        MultiBarLeft = false,
        MultiBar5 = false,
        MultiBar6 = false,
        MultiBar7 = false,
    },
    combatTimer = {
        enabled = true,
        borderSize = 1,
        font = "Friz Quadrata TT",
        fontSize = 14,
        bgTexture = "Interface\\DialogFrame\\UI-DialogBox-Background",
        borderColor = {r = 1, g = 0, b = 0, a = 1},
        anchorFrame = "AUTO",
        anchorPoint = "TOP",
        anchorRelativePoint = "BOTTOM",
        anchorOffsetX = 0,
        anchorOffsetY = -5,
    },
    autoLogging = {
        dungeonsMythicPlus = false,
        raidMythic = false,
        raidHeroic = false,
        raidNormal = false,
        raidFinder = false,
        arena = false,
        scenarios = false,
    },
    chatFont = {
        enabled = false,
        font = "Friz Quadrata TT",
        fontSize = 14,
    },
    gateway = {
        enabled = true,
        text = "Gateway usable",
        missingText = "Keybind Gateway Control Shard is missing",
        font = "Friz Quadrata TT",
        fontSize = 24,
        x = 0,
        y = 150,
    },
}

-- Initialize settings
local function InitializeSettings()
    if not UsefulStuffDB then
        UsefulStuffDB = {}
    end
    if UsefulStuffDB.cursorCircleEnabled == nil then
        UsefulStuffDB.cursorCircleEnabled = defaults.cursorCircleEnabled
    end
    if not UsefulStuffDB.circleRadius then
        UsefulStuffDB.circleRadius = defaults.circleRadius
    end
    if not UsefulStuffDB.circleColor then
        UsefulStuffDB.circleColor = {r = defaults.circleColor.r, g = defaults.circleColor.g, b = defaults.circleColor.b, a = defaults.circleColor.a}
    end
    if not UsefulStuffDB.lineThickness then
        UsefulStuffDB.lineThickness = defaults.lineThickness
    end
    if UsefulStuffDB.combatTextEnabled == nil then
        UsefulStuffDB.combatTextEnabled = defaults.combatTextEnabled
    end
    if not UsefulStuffDB.combatTextEnter then
        UsefulStuffDB.combatTextEnter = defaults.combatTextEnter
    end
    if not UsefulStuffDB.combatTextLeave then
        UsefulStuffDB.combatTextLeave = defaults.combatTextLeave
    end
    if not UsefulStuffDB.combatTextFont then
        UsefulStuffDB.combatTextFont = defaults.combatTextFont
    else
        -- Migrate old path-based fonts to names
        local pathToName = {
            ["Fonts\\FRIZQT__.TTF"] = "Friz Quadrata TT",
            ["Fonts\\ARIALN.TTF"] = "Arial Narrow",
            ["Fonts\\skurri.ttf"] = "Skurri",
            ["Fonts\\MORPHEUS.ttf"] = "Morpheus",
        }
        if pathToName[UsefulStuffDB.combatTextFont] then
            UsefulStuffDB.combatTextFont = pathToName[UsefulStuffDB.combatTextFont]
        end
    end
    if not UsefulStuffDB.combatTextSize then
        UsefulStuffDB.combatTextSize = defaults.combatTextSize
    end
    if not UsefulStuffDB.combatTextX then
        UsefulStuffDB.combatTextX = defaults.combatTextX
    end
    if not UsefulStuffDB.combatTextY then
        UsefulStuffDB.combatTextY = defaults.combatTextY
    end
    if UsefulStuffDB.disableBlizzardCombatText == nil then
        UsefulStuffDB.disableBlizzardCombatText = defaults.disableBlizzardCombatText
    end
    if UsefulStuffDB.disableBlizzardBagBar == nil then
        UsefulStuffDB.disableBlizzardBagBar = defaults.disableBlizzardBagBar
    end
    if not UsefulStuffDB.actionBarsMouseover then
        UsefulStuffDB.actionBarsMouseover = {}
    end
    for barName, defaultValue in pairs(defaults.actionBarsMouseover) do
        if UsefulStuffDB.actionBarsMouseover[barName] == nil then
            UsefulStuffDB.actionBarsMouseover[barName] = defaultValue
        end
    end
    if not UsefulStuffDB.combatTimer then
        UsefulStuffDB.combatTimer = {}
    end
    if UsefulStuffDB.combatTimer.enabled == nil then
        UsefulStuffDB.combatTimer.enabled = defaults.combatTimer.enabled
    end
    if not UsefulStuffDB.combatTimer.borderSize then
        UsefulStuffDB.combatTimer.borderSize = defaults.combatTimer.borderSize
    end
    if not UsefulStuffDB.combatTimer.font then
        UsefulStuffDB.combatTimer.font = defaults.combatTimer.font
    end
    if not UsefulStuffDB.combatTimer.fontSize then
        UsefulStuffDB.combatTimer.fontSize = defaults.combatTimer.fontSize
    end
    if not UsefulStuffDB.combatTimer.bgTexture then
        UsefulStuffDB.combatTimer.bgTexture = defaults.combatTimer.bgTexture
    end
    if not UsefulStuffDB.combatTimer.borderColor then
        UsefulStuffDB.combatTimer.borderColor = {r = defaults.combatTimer.borderColor.r, g = defaults.combatTimer.borderColor.g, b = defaults.combatTimer.borderColor.b, a = defaults.combatTimer.borderColor.a}
    end
    if not UsefulStuffDB.combatTimer.anchorFrame then
        UsefulStuffDB.combatTimer.anchorFrame = defaults.combatTimer.anchorFrame
    end
    if not UsefulStuffDB.combatTimer.anchorPoint then
        UsefulStuffDB.combatTimer.anchorPoint = defaults.combatTimer.anchorPoint
    end
    if not UsefulStuffDB.combatTimer.anchorRelativePoint then
        UsefulStuffDB.combatTimer.anchorRelativePoint = defaults.combatTimer.anchorRelativePoint
    end
    if not UsefulStuffDB.combatTimer.anchorOffsetX then
        UsefulStuffDB.combatTimer.anchorOffsetX = defaults.combatTimer.anchorOffsetX
    end
    if not UsefulStuffDB.combatTimer.anchorOffsetY then
        UsefulStuffDB.combatTimer.anchorOffsetY = defaults.combatTimer.anchorOffsetY
    end
    if not UsefulStuffDB.autoLogging then
        UsefulStuffDB.autoLogging = {}
    end
    for logType, defaultValue in pairs(defaults.autoLogging) do
        if UsefulStuffDB.autoLogging[logType] == nil then
            UsefulStuffDB.autoLogging[logType] = defaultValue
        end
    end
    if not UsefulStuffDB.chatFont then
        UsefulStuffDB.chatFont = {}
    end
    if UsefulStuffDB.chatFont.enabled == nil then
        UsefulStuffDB.chatFont.enabled = defaults.chatFont.enabled
    end
    if not UsefulStuffDB.chatFont.font then
        UsefulStuffDB.chatFont.font = defaults.chatFont.font
    end
    if not UsefulStuffDB.chatFont.fontSize then
        UsefulStuffDB.chatFont.fontSize = defaults.chatFont.fontSize
    end
    if not UsefulStuffDB.gateway then
        UsefulStuffDB.gateway = {}
    end
    if UsefulStuffDB.gateway.enabled == nil then
        UsefulStuffDB.gateway.enabled = defaults.gateway.enabled
    end
    if not UsefulStuffDB.gateway.text then
        UsefulStuffDB.gateway.text = defaults.gateway.text
    end
    if not UsefulStuffDB.gateway.missingText then
        UsefulStuffDB.gateway.missingText = defaults.gateway.missingText
    end
    if not UsefulStuffDB.gateway.font then
        UsefulStuffDB.gateway.font = defaults.gateway.font
    end
    if not UsefulStuffDB.gateway.fontSize then
        UsefulStuffDB.gateway.fontSize = defaults.gateway.fontSize
    end
    if not UsefulStuffDB.gateway.x then
        UsefulStuffDB.gateway.x = defaults.gateway.x
    end
    if not UsefulStuffDB.gateway.y then
        UsefulStuffDB.gateway.y = defaults.gateway.y
    end
end

-- Function to get font path from font name
local function GetFontPath(fontName)
    if LSM then
        -- Try to fetch from SharedMedia
        local success, path = pcall(LSM.Fetch, LSM, "font", fontName)
        if success and path then
            return path
        end
    end

    -- Fallback to default fonts
    local defaultFonts = {
        ["Friz Quadrata TT"] = "Fonts\\FRIZQT__.TTF",
        ["Arial Narrow"] = "Fonts\\ARIALN.TTF",
        ["Skurri"] = "Fonts\\skurri.ttf",
        ["Morpheus"] = "Fonts\\MORPHEUS.ttf",
    }

    return defaultFonts[fontName] or "Fonts\\FRIZQT__.TTF"
end

-- Function to apply Blizzard combat text setting
local function ApplyBlizzardCombatTextSetting()
    if UsefulStuffDB.disableBlizzardCombatText then
        SetCVar("enableFloatingCombatText", "0")
    else
        SetCVar("enableFloatingCombatText", "1")
    end
end

-- Function to apply Blizzard bag bar setting
local function ApplyBlizzardBagBarSetting()
    if UsefulStuffDB.disableBlizzardBagBar then
        -- Hide the bag bar
        if BagsBar then
            BagsBar:Hide()
            BagsBar:SetAlpha(0)
        end
        if MicroButtonAndBagsBar then
            if MicroButtonAndBagsBar.BagBar then
                MicroButtonAndBagsBar.BagBar:Hide()
                MicroButtonAndBagsBar.BagBar:SetAlpha(0)
            end
        end
        -- Also try to hide individual bag buttons
        for i = 0, 4 do
            local bagButton = _G["CharacterBag"..i.."Slot"]
            if bagButton then
                bagButton:Hide()
            end
        end
        if MainMenuBarBackpackButton then
            MainMenuBarBackpackButton:Hide()
        end
    else
        -- Show the bag bar
        if BagsBar then
            BagsBar:Show()
            BagsBar:SetAlpha(1)
        end
        if MicroButtonAndBagsBar then
            if MicroButtonAndBagsBar.BagBar then
                MicroButtonAndBagsBar.BagBar:Show()
                MicroButtonAndBagsBar.BagBar:SetAlpha(1)
            end
        end
        -- Also show individual bag buttons
        for i = 0, 4 do
            local bagButton = _G["CharacterBag"..i.."Slot"]
            if bagButton then
                bagButton:Show()
            end
        end
        if MainMenuBarBackpackButton then
            MainMenuBarBackpackButton:Show()
        end
    end
end

-- Helper: apply font face to all FontStrings in a frame tree (keeps original sizes)
local function ApplyFontToFrame(frame, fontPath)
    if not frame then return end
    local regions = {frame:GetRegions()}
    for _, region in ipairs(regions) do
        if region and region.GetObjectType and region:GetObjectType() == "FontString" then
            local _, currentSize, currentFlags = region:GetFont()
            if currentSize then
                region:SetFont(fontPath, currentSize, currentFlags)
            end
        end
    end
    local children = {frame:GetChildren()}
    for _, child in ipairs(children) do
        ApplyFontToFrame(child, fontPath)
    end
end

-- Function to apply chat font setting
local function ApplyChatFont()
    if not UsefulStuffDB.chatFont.enabled then
        return
    end
    local fontPath = GetFontPath(UsefulStuffDB.chatFont.font)
    local fontSize = UsefulStuffDB.chatFont.fontSize

    -- Chat frames (use selected font size)
    for i = 1, NUM_CHAT_WINDOWS do
        local chatFrame = _G["ChatFrame" .. i]
        if chatFrame then
            local _, oldSize, flags = chatFrame:GetFont()
            chatFrame:SetFont(fontPath, fontSize, flags)
        end
    end

    -- Objective Tracker
    if ObjectiveTrackerFrame then
        ApplyFontToFrame(ObjectiveTrackerFrame, fontPath)
    end
end

-- Setup hooks so font reapplies when frames update dynamically
local chatFontHooksInstalled = false
local function SetupChatFontHooks()
    if chatFontHooksInstalled then return end
    chatFontHooksInstalled = true

    -- Hook objective tracker updates
    if ObjectiveTrackerFrame and ObjectiveTrackerFrame.Update then
        hooksecurefunc(ObjectiveTrackerFrame, "Update", function()
            if UsefulStuffDB.chatFont.enabled then
                ApplyFontToFrame(ObjectiveTrackerFrame, GetFontPath(UsefulStuffDB.chatFont.font))
            end
        end)
    end
end

-- Action Bar Mouseover functionality
local actionBarFrames = {
    MultiBarBottomLeft = "MultiBarBottomLeft",
    MultiBarBottomRight = "MultiBarBottomRight",
    MultiBarRight = "MultiBarRight",
    MultiBarLeft = "MultiBarLeft",
    MultiBar5 = "MultiBar5",
    MultiBar6 = "MultiBar6",
    MultiBar7 = "MultiBar7",
}

local actionBarOriginalAlpha = {}
local actionBarHoverStates = {}

local function ShowActionBar(barName)
    local frameName = actionBarFrames[barName]
    local frame = _G[frameName]
    if frame then
        frame:SetAlpha(actionBarOriginalAlpha[barName] or 1)
    end
end

local function HideActionBar(barName)
    local frameName = actionBarFrames[barName]
    local frame = _G[frameName]
    if frame then
        frame:SetAlpha(0)
    end
end

local function ApplyActionBarMouseover(barName, enable)
    local frameName = actionBarFrames[barName]
    local frame = _G[frameName]

    if not frame then
        return
    end

    if enable then
        -- Store original alpha if not already stored
        if not actionBarOriginalAlpha[barName] then
            actionBarOriginalAlpha[barName] = frame:GetAlpha()
        end

        -- Initialize hover state
        actionBarHoverStates[barName] = false

        -- Set to transparent
        frame:SetAlpha(0)

        -- Add mouseover scripts to the bar frame
        frame:SetScript("OnEnter", function(self)
            actionBarHoverStates[barName] = true
            ShowActionBar(barName)
        end)

        frame:SetScript("OnLeave", function(self)
            actionBarHoverStates[barName] = false
            C_Timer.After(0.1, function()
                if not actionBarHoverStates[barName] then
                    HideActionBar(barName)
                end
            end)
        end)

        -- Also add mouseover to all buttons on the bar
        for i = 1, 12 do
            local button = _G[frameName .. "Button" .. i]
            if button then
                button:HookScript("OnEnter", function(self)
                    actionBarHoverStates[barName] = true
                    ShowActionBar(barName)
                end)
                button:HookScript("OnLeave", function(self)
                    actionBarHoverStates[barName] = false
                    C_Timer.After(0.1, function()
                        if not actionBarHoverStates[barName] then
                            HideActionBar(barName)
                        end
                    end)
                end)
            end
        end
    else
        -- Remove mouseover scripts
        frame:SetScript("OnEnter", nil)
        frame:SetScript("OnLeave", nil)

        -- Restore original alpha
        if actionBarOriginalAlpha[barName] then
            frame:SetAlpha(actionBarOriginalAlpha[barName])
        else
            frame:SetAlpha(1)
        end

        actionBarHoverStates[barName] = nil
    end
end

local function ApplyAllActionBarMouseovers()
    for barName, _ in pairs(actionBarFrames) do
        local enable = UsefulStuffDB.actionBarsMouseover[barName]
        ApplyActionBarMouseover(barName, enable)
    end
end

-- Create the main frame for the cursor circle
local circleFrame = CreateFrame("Frame", "UsefulStuff_CursorCircle", UIParent)
circleFrame:SetFrameStrata("TOOLTIP")
circleFrame:Hide()

local circleLines = {}

-- Build or rebuild the circle based on current settings
local function BuildCircle()
    -- Clear existing lines
    for _, line in ipairs(circleLines) do
        line:Hide()
        line:SetParent(nil)
    end
    wipe(circleLines)

    local numSegments = 32
    local radius = UsefulStuffDB.circleRadius
    local lineThickness = UsefulStuffDB.lineThickness
    local color = UsefulStuffDB.circleColor

    circleFrame:SetSize(radius * 2, radius * 2)

    for i = 1, numSegments do
        local angle1 = (i - 1) * (2 * math.pi / numSegments)
        local angle2 = i * (2 * math.pi / numSegments)

        local line = circleFrame:CreateTexture(nil, "OVERLAY")
        line:SetTexture("Interface\\Buttons\\WHITE8X8")
        line:SetVertexColor(color.r, color.g, color.b, color.a)

        local x1 = math.cos(angle1) * radius
        local y1 = math.sin(angle1) * radius
        local x2 = math.cos(angle2) * radius
        local y2 = math.sin(angle2) * radius

        local dx = x2 - x1
        local dy = y2 - y1
        local length = math.sqrt(dx * dx + dy * dy)

        line:SetSize(length, lineThickness)
        line:SetPoint("CENTER", circleFrame, "CENTER", (x1 + x2) / 2, (y1 + y2) / 2)

        local angle = math.atan2(dy, dx)
        line:SetRotation(angle)

        table.insert(circleLines, line)
    end
end

-- Track mouse button state
local isRightMouseDown = false

-- Update circle position to follow cursor
circleFrame:SetScript("OnUpdate", function(self)
    if isRightMouseDown then
        local x, y = GetCursorPosition()
        local scale = UIParent:GetEffectiveScale()
        self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / scale, y / scale)
    end
end)

-- Mouse button detection
local function CheckMouseButton()
    if not UsefulStuffDB or not UsefulStuffDB.cursorCircleEnabled then
        if isRightMouseDown then
            isRightMouseDown = false
            circleFrame:Hide()
        end
        return
    end
    if IsMouseButtonDown("RightButton") then
        if not isRightMouseDown then
            isRightMouseDown = true
            circleFrame:Show()
        end
    else
        if isRightMouseDown then
            isRightMouseDown = false
            circleFrame:Hide()
        end
    end
end

-- Continuous checking for mouse button state
local checkFrame = CreateFrame("Frame")
checkFrame:SetScript("OnUpdate", function(self, elapsed)
    CheckMouseButton()
end)

-- Combat Text Frame
local combatTextFrame = CreateFrame("Frame", "UsefulStuff_CombatText", UIParent)
combatTextFrame:SetSize(400, 100)
combatTextFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
combatTextFrame:SetFrameStrata("HIGH")
combatTextFrame:Hide()

local combatText = combatTextFrame:CreateFontString(nil, "OVERLAY")
combatText:SetPoint("CENTER")
combatText:SetJustifyH("CENTER")

-- Animation for combat text
local animGroup = combatTextFrame:CreateAnimationGroup()
local translate = animGroup:CreateAnimation("Translation")
translate:SetOffset(0, 100)
translate:SetDuration(1.5)
translate:SetSmoothing("OUT")

local alpha = animGroup:CreateAnimation("Alpha")
alpha:SetFromAlpha(1)
alpha:SetToAlpha(0)
alpha:SetDuration(1.5)
alpha:SetSmoothing("OUT")

animGroup:SetScript("OnFinished", function()
    combatTextFrame:Hide()
end)

-- Function to show combat text
local function ShowCombatText(text)
    if not UsefulStuffDB.combatTextEnabled then return end
    combatTextFrame:ClearAllPoints()
    combatTextFrame:SetPoint("CENTER", UIParent, "CENTER", UsefulStuffDB.combatTextX, UsefulStuffDB.combatTextY)

    local fontPath = GetFontPath(UsefulStuffDB.combatTextFont)
    combatText:SetFont(fontPath, UsefulStuffDB.combatTextSize, "OUTLINE")
    combatText:SetText(text)

    combatTextFrame:SetAlpha(1)
    combatTextFrame:Show()

    animGroup:Stop()
    animGroup:Play()
end

-- Combat events
local combatEventFrame = CreateFrame("Frame")
combatEventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
combatEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
combatEventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        ShowCombatText(UsefulStuffDB.combatTextEnter)
    elseif event == "PLAYER_REGEN_ENABLED" then
        ShowCombatText(UsefulStuffDB.combatTextLeave)
    end
end)

-- Combat Timer
local combatTimerFrame = CreateFrame("Frame", "UsefulStuff_CombatTimer", UIParent, "BackdropTemplate")
combatTimerFrame:SetSize(80, 30)
combatTimerFrame:SetFrameStrata("MEDIUM")
combatTimerFrame:Hide()

local combatTimerText = combatTimerFrame:CreateFontString(nil, "OVERLAY")
combatTimerText:SetPoint("CENTER")
combatTimerText:SetJustifyH("CENTER")

local combatStartTime = 0
local combatTimerUpdateFrame = CreateFrame("Frame")

-- Function to find and anchor to player unit frame
local function AnchorCombatTimer()
    combatTimerFrame:ClearAllPoints()

    local settings = UsefulStuffDB.combatTimer
    local frameName = settings.anchorFrame
    local targetFrame = nil

    -- Auto detection
    if frameName == "AUTO" then
        -- Try common unit frame addons in order
        local autoFrames = {
            "ElvUF_Player",
            "oUF_Unhalted_Player",
            "UnhaltedPlayer",
            "SUFUnitplayer",
            "PlayerFrame"
        }

        for _, name in ipairs(autoFrames) do
            local frame = _G[name]
            if frame and frame:IsShown() then
                targetFrame = frame
                break
            end
        end

        -- Fallback to PlayerFrame if nothing found
        if not targetFrame and PlayerFrame then
            targetFrame = PlayerFrame
        end
    else
        -- Try to find the specified frame
        targetFrame = _G[frameName]
    end

    -- Anchor to found frame or fallback to center
    if targetFrame then
        combatTimerFrame:SetPoint(
            settings.anchorPoint,
            targetFrame,
            settings.anchorRelativePoint,
            settings.anchorOffsetX,
            settings.anchorOffsetY
        )
    else
        -- Fallback: center of screen
        combatTimerFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
    end
end

-- Function to update combat timer appearance
local function UpdateCombatTimerAppearance()
    local settings = UsefulStuffDB.combatTimer

    -- Update backdrop
    combatTimerFrame:SetBackdrop({
        bgFile = settings.bgTexture,
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        tileSize = 0,
        edgeSize = settings.borderSize,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    combatTimerFrame:SetBackdropColor(0, 0, 0, 0.7)

    local borderColor = settings.borderColor
    combatTimerFrame:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)

    -- Update font
    local fontPath = GetFontPath(settings.font)
    combatTimerText:SetFont(fontPath, settings.fontSize, "OUTLINE")
end

-- Function to show/hide combat timer
local function SetCombatTimerVisible(visible)
    if not UsefulStuffDB.combatTimer.enabled then
        combatTimerFrame:Hide()
        return
    end

    if visible then
        AnchorCombatTimer()
        UpdateCombatTimerAppearance()
        combatTimerFrame:Show()
    else
        combatTimerFrame:Hide()
    end
end

-- Update timer display
combatTimerUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
    if combatTimerFrame:IsShown() then
        local elapsedTime = GetTime() - combatStartTime
        local minutes = math.floor(elapsedTime / 60)
        local seconds = math.floor(elapsedTime % 60)
        combatTimerText:SetText(string.format("%d:%02d", minutes, seconds))
    end
end)

-- Hook into combat events for timer
combatEventFrame:HookScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        combatStartTime = GetTime()
        SetCombatTimerVisible(true)
    elseif event == "PLAYER_REGEN_ENABLED" then
        SetCombatTimerVisible(false)
    end
end)

-- Auto Combat Logging
local isLoggingActive = false
local currentInstanceType = nil

local function StartCombatLogging()
    if not isLoggingActive then
        SetCVar("advancedCombatLogging", "1")
        LoggingCombat(true)
        isLoggingActive = true
        print("|cFF00FF00UsefulStuff:|r Combat logging started")
    end
end

local function StopCombatLogging()
    if isLoggingActive then
        LoggingCombat(false)
        isLoggingActive = false
        print("|cFF00FF00UsefulStuff:|r Combat logging stopped")
    end
end

local function ShouldLogCurrentContent()
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, lfgDungeonID = GetInstanceInfo()

    if not instanceType or instanceType == "none" then
        return false
    end

    local settings = UsefulStuffDB.autoLogging

    -- Mythic+ Dungeons (Challenge Mode)
    if instanceType == "party" and C_ChallengeMode.IsChallengeModeActive() then
        return settings.dungeonsMythicPlus
    end

    -- Raids
    if instanceType == "raid" then
        -- 16 = Mythic, 15 = Heroic, 14 = Normal, 17 = LFR
        if difficultyID == 16 then
            return settings.raidMythic
        elseif difficultyID == 15 then
            return settings.raidHeroic
        elseif difficultyID == 14 then
            return settings.raidNormal
        elseif difficultyID == 17 then
            return settings.raidFinder
        end
    end

    -- Arena
    if instanceType == "arena" then
        return settings.arena
    end

    -- Scenarios
    if instanceType == "scenario" then
        return settings.scenarios
    end

    return false
end

local function CheckAndUpdateLogging()
    if ShouldLogCurrentContent() then
        StartCombatLogging()
        currentInstanceType = select(2, GetInstanceInfo())
    else
        if currentInstanceType then
            StopCombatLogging()
            currentInstanceType = nil
        end
    end
end

-- Auto Logging Event Handler
local autoLoggingFrame = CreateFrame("Frame")
autoLoggingFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
autoLoggingFrame:RegisterEvent("CHALLENGE_MODE_START")
autoLoggingFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
autoLoggingFrame:RegisterEvent("ENCOUNTER_START")
autoLoggingFrame:RegisterEvent("ENCOUNTER_END")
autoLoggingFrame:SetScript("OnEvent", function(self, event)
    CheckAndUpdateLogging()
end)

-- Gateway Control Shard Detection
local GATEWAY_SPELL_ID = 188152
local gatewayActionId = nil

local gatewayFrame = CreateFrame("Frame", "UsefulStuff_GatewayText", UIParent)
gatewayFrame:SetSize(400, 50)
gatewayFrame:SetFrameStrata("HIGH")
gatewayFrame:Hide()

local gatewayText = gatewayFrame:CreateFontString(nil, "OVERLAY")
gatewayText:SetPoint("CENTER")
gatewayText:SetJustifyH("CENTER")

local function GetGatewayActionId()
    for i = 1, 200 do
        local actionType, id = GetActionInfo(i)
        if id == GATEWAY_SPELL_ID then
            gatewayActionId = i
            return
        end
    end
    gatewayActionId = nil
end

local function UpdateGatewayDisplay()
    if not UsefulStuffDB or not UsefulStuffDB.gateway.enabled then
        gatewayFrame:Hide()
        return
    end

    local settings = UsefulStuffDB.gateway
    local fontPath = GetFontPath(settings.font)
    gatewayText:SetFont(fontPath, settings.fontSize, "OUTLINE")

    gatewayFrame:ClearAllPoints()
    gatewayFrame:SetPoint("CENTER", UIParent, "CENTER", settings.x, settings.y)

    if gatewayActionId == nil then
        gatewayText:SetText(settings.missingText)
        gatewayText:SetTextColor(1, 0.3, 0.3, 1)
        gatewayFrame:Show()
    elseif IsUsableAction(gatewayActionId) then
        gatewayText:SetText(settings.text)
        gatewayText:SetTextColor(0, 1, 0, 1)
        gatewayFrame:Show()
    else
        gatewayFrame:Hide()
    end
end

local gatewayEventFrame = CreateFrame("Frame")
gatewayEventFrame:RegisterEvent("ACTIONBAR_UPDATE_USABLE")
gatewayEventFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
gatewayEventFrame:SetScript("OnEvent", function(self, event)
    if event == "ACTIONBAR_SLOT_CHANGED" then
        GetGatewayActionId()
    end
    UpdateGatewayDisplay()
end)

local function InitGateway()
    GetGatewayActionId()
    UpdateGatewayDisplay()
end

-- Create settings panel
local function CreateSettingsPanel()
    local panel = CreateFrame("Frame", "UsefulStuffOptionsPanel", UIParent)
    panel.name = "UsefulStuff"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("UsefulStuff Settings")

    -- Tab System
    local tabs = {}
    local tabPanels = {}

    local function SelectTab(id)
        for i, tab in ipairs(tabs) do
            if i == id then
                tab:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
                tabPanels[i]:Show()
            else
                tab:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
                tabPanels[i]:Hide()
            end
        end
    end

    -- Tab 1: General
    local tab1 = CreateFrame("Button", "UsefulStuffTab1", panel)
    tab1:SetSize(100, 32)
    tab1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 5, -8)
    tab1:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
    tab1:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab1Text = tab1:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab1Text:SetPoint("CENTER", 0, -2)
    tab1Text:SetText("General")

    tab1:SetScript("OnClick", function() SelectTab(1) end)
    table.insert(tabs, tab1)

    -- Tab 2: Cursor Circle
    local tab2 = CreateFrame("Button", "UsefulStuffTab2", panel)
    tab2:SetSize(100, 32)
    tab2:SetPoint("LEFT", tab1, "RIGHT", -15, 0)
    tab2:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab2:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab2Text = tab2:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab2Text:SetPoint("CENTER", 0, -2)
    tab2Text:SetText("Cursor Circle")

    tab2:SetScript("OnClick", function() SelectTab(2) end)
    table.insert(tabs, tab2)

    -- Tab 3: Combat Text
    local tab3 = CreateFrame("Button", "UsefulStuffTab3", panel)
    tab3:SetSize(100, 32)
    tab3:SetPoint("LEFT", tab2, "RIGHT", -15, 0)
    tab3:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab3:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab3Text = tab3:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab3Text:SetPoint("CENTER", 0, -2)
    tab3Text:SetText("Combat Text")

    tab3:SetScript("OnClick", function() SelectTab(3) end)
    table.insert(tabs, tab3)

    -- Tab 4: Action Bars
    local tab4 = CreateFrame("Button", "UsefulStuffTab4", panel)
    tab4:SetSize(100, 32)
    tab4:SetPoint("LEFT", tab3, "RIGHT", -15, 0)
    tab4:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab4:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab4Text = tab4:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab4Text:SetPoint("CENTER", 0, -2)
    tab4Text:SetText("Action Bars")

    tab4:SetScript("OnClick", function() SelectTab(4) end)
    table.insert(tabs, tab4)

    -- Tab 5: Combat Timer
    local tab5 = CreateFrame("Button", "UsefulStuffTab5", panel)
    tab5:SetSize(100, 32)
    tab5:SetPoint("LEFT", tab4, "RIGHT", -15, 0)
    tab5:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab5:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab5Text = tab5:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab5Text:SetPoint("CENTER", 0, -2)
    tab5Text:SetText("Combat Timer")

    tab5:SetScript("OnClick", function() SelectTab(5) end)
    table.insert(tabs, tab5)

    -- Tab 6: Auto Logging
    local tab6 = CreateFrame("Button", "UsefulStuffTab6", panel)
    tab6:SetSize(100, 32)
    tab6:SetPoint("LEFT", tab5, "RIGHT", -15, 0)
    tab6:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab6:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab6Text = tab6:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab6Text:SetPoint("CENTER", 0, -2)
    tab6Text:SetText("Auto Logging")

    tab6:SetScript("OnClick", function() SelectTab(6) end)
    table.insert(tabs, tab6)

    -- Tab 7: Gateway
    local tab7 = CreateFrame("Button", "UsefulStuffTab7", panel)
    tab7:SetSize(100, 32)
    tab7:SetPoint("LEFT", tab6, "RIGHT", -15, 0)
    tab7:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab7:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab7Text = tab7:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab7Text:SetPoint("CENTER", 0, -2)
    tab7Text:SetText("Gateway")

    tab7:SetScript("OnClick", function() SelectTab(7) end)
    table.insert(tabs, tab7)

    -- Panel 1: General Settings
    local generalPanel = CreateFrame("Frame", nil, panel)
    generalPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    generalPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    table.insert(tabPanels, generalPanel)

    -- Disable Blizzard Bag Bar Checkbox
    local disableBagBarCheckbox = CreateFrame("CheckButton", "UsefulStuffDisableBagBarCheckbox", generalPanel, "UICheckButtonTemplate")
    disableBagBarCheckbox:SetPoint("TOPLEFT", 0, -10)
    disableBagBarCheckbox:SetSize(24, 24)
    disableBagBarCheckbox:SetChecked(UsefulStuffDB.disableBlizzardBagBar)

    local disableBagBarLabel = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    disableBagBarLabel:SetPoint("LEFT", disableBagBarCheckbox, "RIGHT", 5, 0)
    disableBagBarLabel:SetText("Disable Blizzard Bag Bar")

    disableBagBarCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.disableBlizzardBagBar = self:GetChecked()
        ApplyBlizzardBagBarSetting()
    end)

    -- Chat Font Section
    local chatFontTitle = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    chatFontTitle:SetPoint("TOPLEFT", disableBagBarCheckbox, "BOTTOMLEFT", 0, -25)
    chatFontTitle:SetText("Chat Font")

    local chatFontDesc = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    chatFontDesc:SetPoint("TOPLEFT", chatFontTitle, "BOTTOMLEFT", 0, -5)
    chatFontDesc:SetText("Override the default Blizzard chat font")

    -- Enable Chat Font Checkbox
    local enableChatFontCheckbox = CreateFrame("CheckButton", "UsefulStuffEnableChatFontCheckbox", generalPanel, "UICheckButtonTemplate")
    enableChatFontCheckbox:SetPoint("TOPLEFT", chatFontDesc, "BOTTOMLEFT", 0, -10)
    enableChatFontCheckbox:SetSize(24, 24)
    enableChatFontCheckbox:SetChecked(UsefulStuffDB.chatFont.enabled)

    local enableChatFontLabel = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enableChatFontLabel:SetPoint("LEFT", enableChatFontCheckbox, "RIGHT", 5, 0)
    enableChatFontLabel:SetText("Enable Custom Chat Font")

    enableChatFontCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.chatFont.enabled = self:GetChecked()
        ApplyChatFont()
    end)

    -- Chat Font Dropdown
    local chatFontLabel = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    chatFontLabel:SetPoint("TOPLEFT", enableChatFontCheckbox, "BOTTOMLEFT", 0, -15)
    chatFontLabel:SetText("Font:")

    local chatFontDropdown = CreateFrame("Frame", "UsefulStuffChatFontDropdown", generalPanel, "UIDropDownMenuTemplate")
    chatFontDropdown:SetPoint("TOPLEFT", chatFontLabel, "BOTTOMLEFT", -15, -5)

    UIDropDownMenu_SetWidth(chatFontDropdown, 150)
    UIDropDownMenu_Initialize(chatFontDropdown, function(self, level)
        local fonts = {}
        if LSM then
            for _, fontName in pairs(LSM:List("font")) do
                table.insert(fonts, fontName)
            end
            table.sort(fonts)
        else
            fonts = {"Friz Quadrata TT", "Arial Narrow", "Skurri", "Morpheus"}
        end

        for i, fontName in ipairs(fonts) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = fontName
            info.func = function()
                UsefulStuffDB.chatFont.font = fontName
                UIDropDownMenu_SetText(chatFontDropdown, fontName)
                ApplyChatFont()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    UIDropDownMenu_SetText(chatFontDropdown, UsefulStuffDB.chatFont.font)

    -- Chat Font Size Slider
    local chatFontSizeSlider = CreateFrame("Slider", "UsefulStuffChatFontSizeSlider", generalPanel, "OptionsSliderTemplate")
    chatFontSizeSlider:SetPoint("TOPLEFT", chatFontDropdown, "BOTTOMLEFT", 15, -30)
    chatFontSizeSlider:SetMinMaxValues(8, 32)
    chatFontSizeSlider:SetValue(UsefulStuffDB.chatFont.fontSize)
    chatFontSizeSlider:SetValueStep(1)
    chatFontSizeSlider:SetObeyStepOnDrag(true)
    chatFontSizeSlider:SetWidth(200)
    _G[chatFontSizeSlider:GetName() .. "Low"]:SetText("8")
    _G[chatFontSizeSlider:GetName() .. "High"]:SetText("32")
    _G[chatFontSizeSlider:GetName() .. "Text"]:SetText("Font Size: " .. UsefulStuffDB.chatFont.fontSize)
    chatFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        UsefulStuffDB.chatFont.fontSize = value
        _G[self:GetName() .. "Text"]:SetText("Font Size: " .. value)
        ApplyChatFont()
    end)

    -- Panel 2: Cursor Circle Settings
    local circlePanel = CreateFrame("Frame", nil, panel)
    circlePanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    circlePanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    circlePanel:Hide()
    table.insert(tabPanels, circlePanel)

    -- Enable Cursor Circle Checkbox
    local enableCircleCheckbox = CreateFrame("CheckButton", "UsefulStuffEnableCircleCheckbox", circlePanel, "UICheckButtonTemplate")
    enableCircleCheckbox:SetPoint("TOPLEFT", 0, -10)
    enableCircleCheckbox:SetSize(24, 24)
    enableCircleCheckbox:SetChecked(UsefulStuffDB.cursorCircleEnabled)

    local enableCircleLabel = circlePanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enableCircleLabel:SetPoint("LEFT", enableCircleCheckbox, "RIGHT", 5, 0)
    enableCircleLabel:SetText("Enable Cursor Circle")

    enableCircleCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.cursorCircleEnabled = self:GetChecked()
    end)

    -- Circle Size Slider
    local sizeSlider = CreateFrame("Slider", "UsefulStuffSizeSlider", circlePanel, "OptionsSliderTemplate")
    sizeSlider:SetPoint("TOPLEFT", enableCircleCheckbox, "BOTTOMLEFT", 0, -30)
    sizeSlider:SetMinMaxValues(20, 150)
    sizeSlider:SetValue(UsefulStuffDB.circleRadius)
    sizeSlider:SetValueStep(5)
    sizeSlider:SetObeyStepOnDrag(true)
    sizeSlider:SetWidth(200)
    _G[sizeSlider:GetName() .. "Low"]:SetText("20")
    _G[sizeSlider:GetName() .. "High"]:SetText("150")
    _G[sizeSlider:GetName() .. "Text"]:SetText("Circle Size: " .. UsefulStuffDB.circleRadius)
    sizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 5) * 5
        UsefulStuffDB.circleRadius = value
        _G[self:GetName() .. "Text"]:SetText("Circle Size: " .. value)
        BuildCircle()
    end)

    -- Line Thickness Slider
    local thicknessSlider = CreateFrame("Slider", "UsefulStuffThicknessSlider", circlePanel, "OptionsSliderTemplate")
    thicknessSlider:SetPoint("TOPLEFT", sizeSlider, "BOTTOMLEFT", 0, -40)
    thicknessSlider:SetMinMaxValues(1, 5)
    thicknessSlider:SetValue(UsefulStuffDB.lineThickness)
    thicknessSlider:SetValueStep(0.5)
    thicknessSlider:SetObeyStepOnDrag(true)
    thicknessSlider:SetWidth(200)
    _G[thicknessSlider:GetName() .. "Low"]:SetText("1")
    _G[thicknessSlider:GetName() .. "High"]:SetText("5")
    _G[thicknessSlider:GetName() .. "Text"]:SetText("Line Thickness: " .. UsefulStuffDB.lineThickness)
    thicknessSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 0.5) * 0.5
        UsefulStuffDB.lineThickness = value
        _G[self:GetName() .. "Text"]:SetText("Line Thickness: " .. value)
        BuildCircle()
    end)

    -- Color Picker Button
    local colorLabel = circlePanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    colorLabel:SetPoint("TOPLEFT", thicknessSlider, "BOTTOMLEFT", 0, -40)
    colorLabel:SetText("Circle Color:")

    local colorButton = CreateFrame("Button", "UsefulStuffColorButton", circlePanel, "UIPanelButtonTemplate")
    colorButton:SetPoint("TOPLEFT", colorLabel, "BOTTOMLEFT", 0, -8)
    colorButton:SetSize(120, 25)
    colorButton:SetText("Choose Color")
    colorButton:SetScript("OnClick", function()
        local color = UsefulStuffDB.circleColor
        local previousColor = {
            r = color.r,
            g = color.g,
            b = color.b,
            a = color.a
        }

        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame:GetColorAlpha()
                UsefulStuffDB.circleColor.r = r
                UsefulStuffDB.circleColor.g = g
                UsefulStuffDB.circleColor.b = b
                UsefulStuffDB.circleColor.a = a
                BuildCircle()
            end,
            opacityFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame:GetColorAlpha()
                UsefulStuffDB.circleColor.r = r
                UsefulStuffDB.circleColor.g = g
                UsefulStuffDB.circleColor.b = b
                UsefulStuffDB.circleColor.a = a
                BuildCircle()
            end,
            cancelFunc = function()
                UsefulStuffDB.circleColor.r = previousColor.r
                UsefulStuffDB.circleColor.g = previousColor.g
                UsefulStuffDB.circleColor.b = previousColor.b
                UsefulStuffDB.circleColor.a = previousColor.a
                BuildCircle()
            end,
            hasOpacity = true,
            opacity = color.a,
            r = color.r,
            g = color.g,
            b = color.b,
        })
    end)

    -- Panel 2: Combat Text Settings
    local combatPanel = CreateFrame("Frame", nil, panel)
    combatPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    combatPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    combatPanel:Hide()
    table.insert(tabPanels, combatPanel)

    -- Enable Combat Text Checkbox
    local enableCombatTextCheckbox = CreateFrame("CheckButton", "UsefulStuffEnableCombatTextCheckbox", combatPanel, "UICheckButtonTemplate")
    enableCombatTextCheckbox:SetPoint("TOPLEFT", 0, -10)
    enableCombatTextCheckbox:SetSize(24, 24)
    enableCombatTextCheckbox:SetChecked(UsefulStuffDB.combatTextEnabled)

    local enableCombatTextLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enableCombatTextLabel:SetPoint("LEFT", enableCombatTextCheckbox, "RIGHT", 5, 0)
    enableCombatTextLabel:SetText("Enable Combat Text")

    enableCombatTextCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.combatTextEnabled = self:GetChecked()
    end)

    -- Enter Combat Text
    local enterTextLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enterTextLabel:SetPoint("TOPLEFT", enableCombatTextCheckbox, "BOTTOMLEFT", 0, -15)
    enterTextLabel:SetText("Enter Combat Text:")

    local enterTextBox = CreateFrame("EditBox", "UsefulStuffEnterTextBox", combatPanel, "InputBoxTemplate")
    enterTextBox:SetPoint("TOPLEFT", enterTextLabel, "BOTTOMLEFT", 5, -5)
    enterTextBox:SetSize(200, 20)
    enterTextBox:SetAutoFocus(false)
    enterTextBox:SetText(UsefulStuffDB.combatTextEnter)
    enterTextBox:SetScript("OnEnterPressed", function(self)
        UsefulStuffDB.combatTextEnter = self:GetText()
        self:ClearFocus()
    end)
    enterTextBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefulStuffDB.combatTextEnter)
        self:ClearFocus()
    end)

    -- Leave Combat Text
    local leaveTextLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    leaveTextLabel:SetPoint("TOPLEFT", enterTextBox, "BOTTOMLEFT", -5, -15)
    leaveTextLabel:SetText("Leave Combat Text:")

    local leaveTextBox = CreateFrame("EditBox", "UsefulStuffLeaveTextBox", combatPanel, "InputBoxTemplate")
    leaveTextBox:SetPoint("TOPLEFT", leaveTextLabel, "BOTTOMLEFT", 5, -5)
    leaveTextBox:SetSize(200, 20)
    leaveTextBox:SetAutoFocus(false)
    leaveTextBox:SetText(UsefulStuffDB.combatTextLeave)
    leaveTextBox:SetScript("OnEnterPressed", function(self)
        UsefulStuffDB.combatTextLeave = self:GetText()
        self:ClearFocus()
    end)
    leaveTextBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefulStuffDB.combatTextLeave)
        self:ClearFocus()
    end)

    -- Font Size Slider
    local fontSizeSlider = CreateFrame("Slider", "UsefulStuffFontSizeSlider", combatPanel, "OptionsSliderTemplate")
    fontSizeSlider:SetPoint("TOPLEFT", leaveTextBox, "BOTTOMLEFT", -5, -30)
    fontSizeSlider:SetMinMaxValues(12, 72)
    fontSizeSlider:SetValue(UsefulStuffDB.combatTextSize)
    fontSizeSlider:SetValueStep(2)
    fontSizeSlider:SetObeyStepOnDrag(true)
    fontSizeSlider:SetWidth(200)
    _G[fontSizeSlider:GetName() .. "Low"]:SetText("12")
    _G[fontSizeSlider:GetName() .. "High"]:SetText("72")
    _G[fontSizeSlider:GetName() .. "Text"]:SetText("Font Size: " .. UsefulStuffDB.combatTextSize)
    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 2) * 2
        UsefulStuffDB.combatTextSize = value
        _G[self:GetName() .. "Text"]:SetText("Font Size: " .. value)
    end)

    -- Font Dropdown with SharedMedia support
    local fontLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontLabel:SetPoint("TOPLEFT", fontSizeSlider, "BOTTOMLEFT", 0, -40)
    fontLabel:SetText("Font:")

    local fontDropdown = CreateFrame("Frame", "UsefulStuffFontDropdown", combatPanel, "UIDropDownMenuTemplate")
    fontDropdown:SetPoint("TOPLEFT", fontLabel, "BOTTOMLEFT", -15, -5)

    local function GetFontList()
        if LSM then
            local fonts = {}
            for _, fontName in pairs(LSM:List("font")) do
                table.insert(fonts, fontName)
            end
            table.sort(fonts)
            return fonts
        else
            return {
                "Friz Quadrata TT",
                "Arial Narrow",
                "Skurri",
                "Morpheus",
            }
        end
    end

    UIDropDownMenu_SetWidth(fontDropdown, 150)
    UIDropDownMenu_Initialize(fontDropdown, function(self, level)
        local fonts = GetFontList()
        for i, fontName in ipairs(fonts) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = fontName
            info.func = function()
                UsefulStuffDB.combatTextFont = fontName
                UIDropDownMenu_SetText(fontDropdown, fontName)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Set initial dropdown text
    UIDropDownMenu_SetText(fontDropdown, UsefulStuffDB.combatTextFont)

    -- Position X Slider
    local posXSlider = CreateFrame("Slider", "UsefulStuffPosXSlider", combatPanel, "OptionsSliderTemplate")
    posXSlider:SetPoint("TOPLEFT", fontDropdown, "BOTTOMLEFT", 15, -30)
    posXSlider:SetMinMaxValues(-500, 500)
    posXSlider:SetValue(UsefulStuffDB.combatTextX)
    posXSlider:SetValueStep(10)
    posXSlider:SetObeyStepOnDrag(true)
    posXSlider:SetWidth(200)
    _G[posXSlider:GetName() .. "Low"]:SetText("-500")
    _G[posXSlider:GetName() .. "High"]:SetText("500")
    _G[posXSlider:GetName() .. "Text"]:SetText("Position X: " .. UsefulStuffDB.combatTextX)
    posXSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefulStuffDB.combatTextX = value
        _G[self:GetName() .. "Text"]:SetText("Position X: " .. value)
    end)

    -- Position Y Slider
    local posYSlider = CreateFrame("Slider", "UsefulStuffPosYSlider", combatPanel, "OptionsSliderTemplate")
    posYSlider:SetPoint("TOPLEFT", posXSlider, "BOTTOMLEFT", 0, -40)
    posYSlider:SetMinMaxValues(-500, 500)
    posYSlider:SetValue(UsefulStuffDB.combatTextY)
    posYSlider:SetValueStep(10)
    posYSlider:SetObeyStepOnDrag(true)
    posYSlider:SetWidth(200)
    _G[posYSlider:GetName() .. "Low"]:SetText("-500")
    _G[posYSlider:GetName() .. "High"]:SetText("500")
    _G[posYSlider:GetName() .. "Text"]:SetText("Position Y: " .. UsefulStuffDB.combatTextY)
    posYSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefulStuffDB.combatTextY = value
        _G[self:GetName() .. "Text"]:SetText("Position Y: " .. value)
    end)

    -- Disable Blizzard Combat Text Checkbox
    local disableBlizzCheckbox = CreateFrame("CheckButton", "UsefulStuffDisableBlizzCheckbox", combatPanel, "UICheckButtonTemplate")
    disableBlizzCheckbox:SetPoint("TOPLEFT", posYSlider, "BOTTOMLEFT", 0, -40)
    disableBlizzCheckbox:SetSize(24, 24)
    disableBlizzCheckbox:SetChecked(UsefulStuffDB.disableBlizzardCombatText)

    local disableBlizzLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    disableBlizzLabel:SetPoint("LEFT", disableBlizzCheckbox, "RIGHT", 5, 0)
    disableBlizzLabel:SetText("Disable Blizzard Combat Text")

    disableBlizzCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.disableBlizzardCombatText = self:GetChecked()
        ApplyBlizzardCombatTextSetting()
    end)

    -- Test Combat Text Button
    local testButton = CreateFrame("Button", "UsefulStuffTestButton", combatPanel, "UIPanelButtonTemplate")
    testButton:SetPoint("TOPLEFT", disableBlizzCheckbox, "BOTTOMLEFT", 0, -20)
    testButton:SetSize(200, 25)
    testButton:SetText("Test Combat Text")
    testButton:SetScript("OnClick", function()
        ShowCombatText(UsefulStuffDB.combatTextEnter)
    end)

    -- Panel 4: Action Bars Settings
    local actionBarsPanel = CreateFrame("Frame", nil, panel)
    actionBarsPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    actionBarsPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    actionBarsPanel:Hide()
    table.insert(tabPanels, actionBarsPanel)

    local abTitle = actionBarsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    abTitle:SetPoint("TOPLEFT", 0, 0)
    abTitle:SetText("Show on Mouseover")

    local abDesc = actionBarsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    abDesc:SetPoint("TOPLEFT", abTitle, "BOTTOMLEFT", 0, -5)
    abDesc:SetText("Hide action bars until you hover over them with your mouse")

    -- Define action bars with friendly names
    local actionBarList = {
        {key = "MultiBarBottomLeft", name = "Bar 2"},
        {key = "MultiBarBottomRight", name = "Bar 3"},
        {key = "MultiBarRight", name = "Bar 4"},
        {key = "MultiBarLeft", name = "Bar 5"},
        {key = "MultiBar5", name = "Bar 6"},
        {key = "MultiBar6", name = "Bar 7"},
        {key = "MultiBar7", name = "Bar 8"},
    }

    local lastCheckbox = abDesc
    for i, barInfo in ipairs(actionBarList) do
        local checkbox = CreateFrame("CheckButton", "UsefulStuffActionBar"..barInfo.key.."Checkbox", actionBarsPanel, "UICheckButtonTemplate")
        if i == 1 then
            checkbox:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -15)
        else
            checkbox:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -5)
        end
        checkbox:SetSize(24, 24)
        checkbox:SetChecked(UsefulStuffDB.actionBarsMouseover[barInfo.key])

        local label = actionBarsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        label:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
        label:SetText(barInfo.name)

        checkbox:SetScript("OnClick", function(self)
            UsefulStuffDB.actionBarsMouseover[barInfo.key] = self:GetChecked()
            ApplyActionBarMouseover(barInfo.key, self:GetChecked())
        end)

        lastCheckbox = checkbox
    end

    -- Panel 5: Combat Timer Settings
    local combatTimerPanel = CreateFrame("Frame", nil, panel)
    combatTimerPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    combatTimerPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    combatTimerPanel:Hide()
    table.insert(tabPanels, combatTimerPanel)

    local ctTitle = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    ctTitle:SetPoint("TOPLEFT", 0, 0)
    ctTitle:SetText("Combat Timer")

    local ctDesc = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    ctDesc:SetPoint("TOPLEFT", ctTitle, "BOTTOMLEFT", 0, -5)
    ctDesc:SetText("Shows a timer during combat. Auto-anchors to PlayerFrame, SUF, or ElvUI")

    -- Enable Combat Timer Checkbox
    local enableCTCheckbox = CreateFrame("CheckButton", "UsefulStuffEnableCTCheckbox", combatTimerPanel, "UICheckButtonTemplate")
    enableCTCheckbox:SetPoint("TOPLEFT", ctDesc, "BOTTOMLEFT", 0, -15)
    enableCTCheckbox:SetSize(24, 24)
    enableCTCheckbox:SetChecked(UsefulStuffDB.combatTimer.enabled)

    local enableCTLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enableCTLabel:SetPoint("LEFT", enableCTCheckbox, "RIGHT", 5, 0)
    enableCTLabel:SetText("Enable Combat Timer")

    enableCTCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.combatTimer.enabled = self:GetChecked()
    end)

    -- Border Size Slider
    local borderSizeSlider = CreateFrame("Slider", "UsefulStuffCTBorderSizeSlider", combatTimerPanel, "OptionsSliderTemplate")
    borderSizeSlider:SetPoint("TOPLEFT", enableCTCheckbox, "BOTTOMLEFT", 0, -30)
    borderSizeSlider:SetMinMaxValues(1, 5)
    borderSizeSlider:SetValue(UsefulStuffDB.combatTimer.borderSize)
    borderSizeSlider:SetValueStep(1)
    borderSizeSlider:SetObeyStepOnDrag(true)
    borderSizeSlider:SetWidth(200)
    _G[borderSizeSlider:GetName() .. "Low"]:SetText("1")
    _G[borderSizeSlider:GetName() .. "High"]:SetText("5")
    _G[borderSizeSlider:GetName() .. "Text"]:SetText("Border Size: " .. UsefulStuffDB.combatTimer.borderSize)
    borderSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        UsefulStuffDB.combatTimer.borderSize = value
        _G[self:GetName() .. "Text"]:SetText("Border Size: " .. value)
        UpdateCombatTimerAppearance()
    end)

    -- Font Size Slider
    local ctFontSizeSlider = CreateFrame("Slider", "UsefulStuffCTFontSizeSlider", combatTimerPanel, "OptionsSliderTemplate")
    ctFontSizeSlider:SetPoint("TOPLEFT", borderSizeSlider, "BOTTOMLEFT", 0, -40)
    ctFontSizeSlider:SetMinMaxValues(10, 32)
    ctFontSizeSlider:SetValue(UsefulStuffDB.combatTimer.fontSize)
    ctFontSizeSlider:SetValueStep(2)
    ctFontSizeSlider:SetObeyStepOnDrag(true)
    ctFontSizeSlider:SetWidth(200)
    _G[ctFontSizeSlider:GetName() .. "Low"]:SetText("10")
    _G[ctFontSizeSlider:GetName() .. "High"]:SetText("32")
    _G[ctFontSizeSlider:GetName() .. "Text"]:SetText("Font Size: " .. UsefulStuffDB.combatTimer.fontSize)
    ctFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 2) * 2
        UsefulStuffDB.combatTimer.fontSize = value
        _G[self:GetName() .. "Text"]:SetText("Font Size: " .. value)
        UpdateCombatTimerAppearance()
    end)

    -- Font Dropdown
    local ctFontLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctFontLabel:SetPoint("TOPLEFT", ctFontSizeSlider, "BOTTOMLEFT", 0, -40)
    ctFontLabel:SetText("Font:")

    local ctFontDropdown = CreateFrame("Frame", "UsefulStuffCTFontDropdown", combatTimerPanel, "UIDropDownMenuTemplate")
    ctFontDropdown:SetPoint("TOPLEFT", ctFontLabel, "BOTTOMLEFT", -15, -5)

    UIDropDownMenu_SetWidth(ctFontDropdown, 150)
    UIDropDownMenu_Initialize(ctFontDropdown, function(self, level)
        local fonts = {}
        if LSM then
            for _, fontName in pairs(LSM:List("font")) do
                table.insert(fonts, fontName)
            end
            table.sort(fonts)
        else
            fonts = {"Friz Quadrata TT", "Arial Narrow", "Skurri", "Morpheus"}
        end

        for i, fontName in ipairs(fonts) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = fontName
            info.func = function()
                UsefulStuffDB.combatTimer.font = fontName
                UIDropDownMenu_SetText(ctFontDropdown, fontName)
                UpdateCombatTimerAppearance()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    UIDropDownMenu_SetText(ctFontDropdown, UsefulStuffDB.combatTimer.font)

    -- Background Texture Dropdown
    local ctBgLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctBgLabel:SetPoint("TOPLEFT", ctFontDropdown, "BOTTOMLEFT", 15, -30)
    ctBgLabel:SetText("Background Texture:")

    local ctBgDropdown = CreateFrame("Frame", "UsefulStuffCTBgDropdown", combatTimerPanel, "UIDropDownMenuTemplate")
    ctBgDropdown:SetPoint("TOPLEFT", ctBgLabel, "BOTTOMLEFT", -15, -5)

    local bgTextures = {
        {name = "Dialog Box", path = "Interface\\DialogFrame\\UI-DialogBox-Background"},
        {name = "Tooltip", path = "Interface\\Tooltips\\UI-Tooltip-Background"},
        {name = "Solid Black", path = "Interface\\Buttons\\WHITE8X8"},
        {name = "Chat Background", path = "Interface\\ChatFrame\\ChatFrameBackground"},
    }

    UIDropDownMenu_SetWidth(ctBgDropdown, 150)
    UIDropDownMenu_Initialize(ctBgDropdown, function(self, level)
        for i, texture in ipairs(bgTextures) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = texture.name
            info.func = function()
                UsefulStuffDB.combatTimer.bgTexture = texture.path
                UIDropDownMenu_SetText(ctBgDropdown, texture.name)
                UpdateCombatTimerAppearance()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Set initial dropdown text
    local currentTextureName = "Dialog Box"
    for i, texture in ipairs(bgTextures) do
        if texture.path == UsefulStuffDB.combatTimer.bgTexture then
            currentTextureName = texture.name
            break
        end
    end
    UIDropDownMenu_SetText(ctBgDropdown, currentTextureName)

    -- Anchor Frame Name Input
    local ctFrameLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctFrameLabel:SetPoint("TOPLEFT", ctBgDropdown, "BOTTOMLEFT", 15, -30)
    ctFrameLabel:SetText("Anchor To Frame:")

    local ctFrameHint = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    ctFrameHint:SetPoint("TOPLEFT", ctFrameLabel, "BOTTOMLEFT", 0, -2)
    ctFrameHint:SetText("(Use AUTO for auto-detect, or frame name like PlayerFrame, ElvUF_Player, etc.)")
    ctFrameHint:SetTextColor(0.7, 0.7, 0.7, 1)

    local ctFrameInput = CreateFrame("EditBox", "UsefulStuffCTFrameInput", combatTimerPanel, "InputBoxTemplate")
    ctFrameInput:SetPoint("TOPLEFT", ctFrameHint, "BOTTOMLEFT", 5, -5)
    ctFrameInput:SetSize(250, 20)
    ctFrameInput:SetAutoFocus(false)
    ctFrameInput:SetText(UsefulStuffDB.combatTimer.anchorFrame)
    ctFrameInput:SetScript("OnEnterPressed", function(self)
        UsefulStuffDB.combatTimer.anchorFrame = self:GetText()
        self:ClearFocus()
        AnchorCombatTimer()
    end)
    ctFrameInput:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefulStuffDB.combatTimer.anchorFrame)
        self:ClearFocus()
    end)

    -- Anchor Point Dropdown
    local ctPointLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctPointLabel:SetPoint("TOPLEFT", ctFrameInput, "BOTTOMLEFT", -5, -20)
    ctPointLabel:SetText("Anchor Point:")

    local ctPointDropdown = CreateFrame("Frame", "UsefulStuffCTPointDropdown", combatTimerPanel, "UIDropDownMenuTemplate")
    ctPointDropdown:SetPoint("TOPLEFT", ctPointLabel, "BOTTOMLEFT", -15, -5)

    local anchorPoints = {"TOP", "BOTTOM", "LEFT", "RIGHT", "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER"}

    UIDropDownMenu_SetWidth(ctPointDropdown, 120)
    UIDropDownMenu_Initialize(ctPointDropdown, function(self, level)
        for i, point in ipairs(anchorPoints) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = point
            info.func = function()
                UsefulStuffDB.combatTimer.anchorPoint = point
                UIDropDownMenu_SetText(ctPointDropdown, point)
                AnchorCombatTimer()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)
    UIDropDownMenu_SetText(ctPointDropdown, UsefulStuffDB.combatTimer.anchorPoint)

    -- Relative Point Dropdown
    local ctRelPointLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctRelPointLabel:SetPoint("LEFT", ctPointDropdown, "RIGHT", 10, 2)
    ctRelPointLabel:SetText("To:")

    local ctRelPointDropdown = CreateFrame("Frame", "UsefulStuffCTRelPointDropdown", combatTimerPanel, "UIDropDownMenuTemplate")
    ctRelPointDropdown:SetPoint("LEFT", ctRelPointLabel, "RIGHT", -10, -2)

    UIDropDownMenu_SetWidth(ctRelPointDropdown, 120)
    UIDropDownMenu_Initialize(ctRelPointDropdown, function(self, level)
        for i, point in ipairs(anchorPoints) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = point
            info.func = function()
                UsefulStuffDB.combatTimer.anchorRelativePoint = point
                UIDropDownMenu_SetText(ctRelPointDropdown, point)
                AnchorCombatTimer()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)
    UIDropDownMenu_SetText(ctRelPointDropdown, UsefulStuffDB.combatTimer.anchorRelativePoint)

    -- Offset X Input
    local ctOffsetXLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctOffsetXLabel:SetPoint("TOPLEFT", ctPointDropdown, "BOTTOMLEFT", 15, -20)
    ctOffsetXLabel:SetText("Offset X:")

    local ctOffsetXInput = CreateFrame("EditBox", "UsefulStuffCTOffsetXInput", combatTimerPanel, "InputBoxTemplate")
    ctOffsetXInput:SetPoint("LEFT", ctOffsetXLabel, "RIGHT", 10, 0)
    ctOffsetXInput:SetSize(60, 20)
    ctOffsetXInput:SetAutoFocus(false)
    ctOffsetXInput:SetText(tostring(UsefulStuffDB.combatTimer.anchorOffsetX))
    ctOffsetXInput:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText()) or 0
        UsefulStuffDB.combatTimer.anchorOffsetX = value
        self:ClearFocus()
        AnchorCombatTimer()
    end)
    ctOffsetXInput:SetScript("OnEscapePressed", function(self)
        self:SetText(tostring(UsefulStuffDB.combatTimer.anchorOffsetX))
        self:ClearFocus()
    end)

    -- Offset Y Input
    local ctOffsetYLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctOffsetYLabel:SetPoint("LEFT", ctOffsetXInput, "RIGHT", 20, 0)
    ctOffsetYLabel:SetText("Y:")

    local ctOffsetYInput = CreateFrame("EditBox", "UsefulStuffCTOffsetYInput", combatTimerPanel, "InputBoxTemplate")
    ctOffsetYInput:SetPoint("LEFT", ctOffsetYLabel, "RIGHT", 10, 0)
    ctOffsetYInput:SetSize(60, 20)
    ctOffsetYInput:SetAutoFocus(false)
    ctOffsetYInput:SetText(tostring(UsefulStuffDB.combatTimer.anchorOffsetY))
    ctOffsetYInput:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText()) or 0
        UsefulStuffDB.combatTimer.anchorOffsetY = value
        self:ClearFocus()
        AnchorCombatTimer()
    end)
    ctOffsetYInput:SetScript("OnEscapePressed", function(self)
        self:SetText(tostring(UsefulStuffDB.combatTimer.anchorOffsetY))
        self:ClearFocus()
    end)

    -- Border Color Picker
    local ctBorderColorLabel = combatTimerPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ctBorderColorLabel:SetPoint("TOPLEFT", ctOffsetXLabel, "BOTTOMLEFT", -15, -25)
    ctBorderColorLabel:SetText("Border Color:")

    local ctBorderColorButton = CreateFrame("Button", "UsefulStuffCTBorderColorButton", combatTimerPanel, "UIPanelButtonTemplate")
    ctBorderColorButton:SetPoint("TOPLEFT", ctBorderColorLabel, "BOTTOMLEFT", 0, -8)
    ctBorderColorButton:SetSize(120, 25)
    ctBorderColorButton:SetText("Choose Color")
    ctBorderColorButton:SetScript("OnClick", function()
        local color = UsefulStuffDB.combatTimer.borderColor
        local previousColor = {
            r = color.r,
            g = color.g,
            b = color.b,
            a = color.a
        }

        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame:GetColorAlpha()
                UsefulStuffDB.combatTimer.borderColor.r = r
                UsefulStuffDB.combatTimer.borderColor.g = g
                UsefulStuffDB.combatTimer.borderColor.b = b
                UsefulStuffDB.combatTimer.borderColor.a = a
                UpdateCombatTimerAppearance()
            end,
            opacityFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame:GetColorAlpha()
                UsefulStuffDB.combatTimer.borderColor.r = r
                UsefulStuffDB.combatTimer.borderColor.g = g
                UsefulStuffDB.combatTimer.borderColor.b = b
                UsefulStuffDB.combatTimer.borderColor.a = a
                UpdateCombatTimerAppearance()
            end,
            cancelFunc = function()
                UsefulStuffDB.combatTimer.borderColor.r = previousColor.r
                UsefulStuffDB.combatTimer.borderColor.g = previousColor.g
                UsefulStuffDB.combatTimer.borderColor.b = previousColor.b
                UsefulStuffDB.combatTimer.borderColor.a = previousColor.a
                UpdateCombatTimerAppearance()
            end,
            hasOpacity = true,
            opacity = color.a,
            r = color.r,
            g = color.g,
            b = color.b,
        })
    end)

    -- Panel 6: Auto Logging Settings
    local autoLoggingPanel = CreateFrame("Frame", nil, panel)
    autoLoggingPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    autoLoggingPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    autoLoggingPanel:Hide()
    table.insert(tabPanels, autoLoggingPanel)

    local autoLoggingTitle = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    autoLoggingTitle:SetPoint("TOPLEFT", 0, 0)
    autoLoggingTitle:SetText("Automatic Combat Logging")

    local autoLoggingDesc = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    autoLoggingDesc:SetPoint("TOPLEFT", autoLoggingTitle, "BOTTOMLEFT", 0, -8)
    autoLoggingDesc:SetText("Automatically start/stop advanced combat logging when entering/leaving content types:")

    -- Mythic+ Dungeons Checkbox
    local dungeonsMPlusCheckbox = CreateFrame("CheckButton", "UsefulStuffDungeonsMPlusCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    dungeonsMPlusCheckbox:SetPoint("TOPLEFT", autoLoggingDesc, "BOTTOMLEFT", 0, -15)
    dungeonsMPlusCheckbox:SetSize(24, 24)
    dungeonsMPlusCheckbox:SetChecked(UsefulStuffDB.autoLogging.dungeonsMythicPlus)

    local dungeonsMPlusLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    dungeonsMPlusLabel:SetPoint("LEFT", dungeonsMPlusCheckbox, "RIGHT", 5, 0)
    dungeonsMPlusLabel:SetText("Mythic+ Dungeons")

    dungeonsMPlusCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.dungeonsMythicPlus = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Raid: Mythic Checkbox
    local raidMythicCheckbox = CreateFrame("CheckButton", "UsefulStuffRaidMythicCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    raidMythicCheckbox:SetPoint("TOPLEFT", dungeonsMPlusCheckbox, "BOTTOMLEFT", 0, -8)
    raidMythicCheckbox:SetSize(24, 24)
    raidMythicCheckbox:SetChecked(UsefulStuffDB.autoLogging.raidMythic)

    local raidMythicLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    raidMythicLabel:SetPoint("LEFT", raidMythicCheckbox, "RIGHT", 5, 0)
    raidMythicLabel:SetText("Raid: Mythic")

    raidMythicCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.raidMythic = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Raid: Heroic Checkbox
    local raidHeroicCheckbox = CreateFrame("CheckButton", "UsefulStuffRaidHeroicCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    raidHeroicCheckbox:SetPoint("TOPLEFT", raidMythicCheckbox, "BOTTOMLEFT", 0, -8)
    raidHeroicCheckbox:SetSize(24, 24)
    raidHeroicCheckbox:SetChecked(UsefulStuffDB.autoLogging.raidHeroic)

    local raidHeroicLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    raidHeroicLabel:SetPoint("LEFT", raidHeroicCheckbox, "RIGHT", 5, 0)
    raidHeroicLabel:SetText("Raid: Heroic")

    raidHeroicCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.raidHeroic = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Raid: Normal Checkbox
    local raidNormalCheckbox = CreateFrame("CheckButton", "UsefulStuffRaidNormalCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    raidNormalCheckbox:SetPoint("TOPLEFT", raidHeroicCheckbox, "BOTTOMLEFT", 0, -8)
    raidNormalCheckbox:SetSize(24, 24)
    raidNormalCheckbox:SetChecked(UsefulStuffDB.autoLogging.raidNormal)

    local raidNormalLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    raidNormalLabel:SetPoint("LEFT", raidNormalCheckbox, "RIGHT", 5, 0)
    raidNormalLabel:SetText("Raid: Normal")

    raidNormalCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.raidNormal = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Raid: Finder Checkbox
    local raidFinderCheckbox = CreateFrame("CheckButton", "UsefulStuffRaidFinderCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    raidFinderCheckbox:SetPoint("TOPLEFT", raidNormalCheckbox, "BOTTOMLEFT", 0, -8)
    raidFinderCheckbox:SetSize(24, 24)
    raidFinderCheckbox:SetChecked(UsefulStuffDB.autoLogging.raidFinder)

    local raidFinderLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    raidFinderLabel:SetPoint("LEFT", raidFinderCheckbox, "RIGHT", 5, 0)
    raidFinderLabel:SetText("Raid: Finder")

    raidFinderCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.raidFinder = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Arena Checkbox
    local arenaCheckbox = CreateFrame("CheckButton", "UsefulStuffArenaCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    arenaCheckbox:SetPoint("TOPLEFT", raidFinderCheckbox, "BOTTOMLEFT", 0, -8)
    arenaCheckbox:SetSize(24, 24)
    arenaCheckbox:SetChecked(UsefulStuffDB.autoLogging.arena)

    local arenaLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    arenaLabel:SetPoint("LEFT", arenaCheckbox, "RIGHT", 5, 0)
    arenaLabel:SetText("Arena")

    arenaCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.arena = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Scenarios Checkbox
    local scenariosCheckbox = CreateFrame("CheckButton", "UsefulStuffScenariosCheckbox", autoLoggingPanel, "UICheckButtonTemplate")
    scenariosCheckbox:SetPoint("TOPLEFT", arenaCheckbox, "BOTTOMLEFT", 0, -8)
    scenariosCheckbox:SetSize(24, 24)
    scenariosCheckbox:SetChecked(UsefulStuffDB.autoLogging.scenarios)

    local scenariosLabel = autoLoggingPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    scenariosLabel:SetPoint("LEFT", scenariosCheckbox, "RIGHT", 5, 0)
    scenariosLabel:SetText("Scenarios")

    scenariosCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.autoLogging.scenarios = self:GetChecked()
        CheckAndUpdateLogging()
    end)

    -- Panel 7: Gateway Settings
    local gatewayPanel = CreateFrame("Frame", nil, panel)
    gatewayPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    gatewayPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    gatewayPanel:Hide()
    table.insert(tabPanels, gatewayPanel)

    local gwTitle = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    gwTitle:SetPoint("TOPLEFT", 0, 0)
    gwTitle:SetText("Gateway Control Shard")

    local gwDesc = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    gwDesc:SetPoint("TOPLEFT", gwTitle, "BOTTOMLEFT", 0, -5)
    gwDesc:SetText("Shows a notification when Gateway Control Shard (spell 188152) is usable")

    -- Enable Gateway Checkbox
    local enableGWCheckbox = CreateFrame("CheckButton", "UsefulStuffEnableGWCheckbox", gatewayPanel, "UICheckButtonTemplate")
    enableGWCheckbox:SetPoint("TOPLEFT", gwDesc, "BOTTOMLEFT", 0, -15)
    enableGWCheckbox:SetSize(24, 24)
    enableGWCheckbox:SetChecked(UsefulStuffDB.gateway.enabled)

    local enableGWLabel = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enableGWLabel:SetPoint("LEFT", enableGWCheckbox, "RIGHT", 5, 0)
    enableGWLabel:SetText("Enable Gateway Notification")

    enableGWCheckbox:SetScript("OnClick", function(self)
        UsefulStuffDB.gateway.enabled = self:GetChecked()
        UpdateGatewayDisplay()
    end)

    -- Gateway Usable Text
    local gwTextLabel = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    gwTextLabel:SetPoint("TOPLEFT", enableGWCheckbox, "BOTTOMLEFT", 0, -15)
    gwTextLabel:SetText("Usable Text:")

    local gwTextBox = CreateFrame("EditBox", "UsefulStuffGWTextBox", gatewayPanel, "InputBoxTemplate")
    gwTextBox:SetPoint("TOPLEFT", gwTextLabel, "BOTTOMLEFT", 5, -5)
    gwTextBox:SetSize(200, 20)
    gwTextBox:SetAutoFocus(false)
    gwTextBox:SetText(UsefulStuffDB.gateway.text)
    gwTextBox:SetScript("OnEnterPressed", function(self)
        UsefulStuffDB.gateway.text = self:GetText()
        self:ClearFocus()
        UpdateGatewayDisplay()
    end)
    gwTextBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefulStuffDB.gateway.text)
        self:ClearFocus()
    end)

    -- Gateway Missing Text
    local gwMissingLabel = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    gwMissingLabel:SetPoint("TOPLEFT", gwTextBox, "BOTTOMLEFT", -5, -15)
    gwMissingLabel:SetText("Missing Text:")

    local gwMissingBox = CreateFrame("EditBox", "UsefulStuffGWMissingBox", gatewayPanel, "InputBoxTemplate")
    gwMissingBox:SetPoint("TOPLEFT", gwMissingLabel, "BOTTOMLEFT", 5, -5)
    gwMissingBox:SetSize(200, 20)
    gwMissingBox:SetAutoFocus(false)
    gwMissingBox:SetText(UsefulStuffDB.gateway.missingText)
    gwMissingBox:SetScript("OnEnterPressed", function(self)
        UsefulStuffDB.gateway.missingText = self:GetText()
        self:ClearFocus()
        UpdateGatewayDisplay()
    end)
    gwMissingBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefulStuffDB.gateway.missingText)
        self:ClearFocus()
    end)

    -- Font Dropdown
    local gwFontLabel = gatewayPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    gwFontLabel:SetPoint("TOPLEFT", gwMissingBox, "BOTTOMLEFT", -5, -15)
    gwFontLabel:SetText("Font:")

    local gwFontDropdown = CreateFrame("Frame", "UsefulStuffGWFontDropdown", gatewayPanel, "UIDropDownMenuTemplate")
    gwFontDropdown:SetPoint("TOPLEFT", gwFontLabel, "BOTTOMLEFT", -15, -5)

    UIDropDownMenu_SetWidth(gwFontDropdown, 150)
    UIDropDownMenu_Initialize(gwFontDropdown, function(self, level)
        local fonts = {}
        if LSM then
            for _, fontName in pairs(LSM:List("font")) do
                table.insert(fonts, fontName)
            end
            table.sort(fonts)
        else
            fonts = {"Friz Quadrata TT", "Arial Narrow", "Skurri", "Morpheus"}
        end

        for i, fontName in ipairs(fonts) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = fontName
            info.func = function()
                UsefulStuffDB.gateway.font = fontName
                UIDropDownMenu_SetText(gwFontDropdown, fontName)
                UpdateGatewayDisplay()
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    UIDropDownMenu_SetText(gwFontDropdown, UsefulStuffDB.gateway.font)

    -- Font Size Slider
    local gwFontSizeSlider = CreateFrame("Slider", "UsefulStuffGWFontSizeSlider", gatewayPanel, "OptionsSliderTemplate")
    gwFontSizeSlider:SetPoint("TOPLEFT", gwFontDropdown, "BOTTOMLEFT", 15, -30)
    gwFontSizeSlider:SetMinMaxValues(12, 72)
    gwFontSizeSlider:SetValue(UsefulStuffDB.gateway.fontSize)
    gwFontSizeSlider:SetValueStep(2)
    gwFontSizeSlider:SetObeyStepOnDrag(true)
    gwFontSizeSlider:SetWidth(200)
    _G[gwFontSizeSlider:GetName() .. "Low"]:SetText("12")
    _G[gwFontSizeSlider:GetName() .. "High"]:SetText("72")
    _G[gwFontSizeSlider:GetName() .. "Text"]:SetText("Font Size: " .. UsefulStuffDB.gateway.fontSize)
    gwFontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 2) * 2
        UsefulStuffDB.gateway.fontSize = value
        _G[self:GetName() .. "Text"]:SetText("Font Size: " .. value)
        UpdateGatewayDisplay()
    end)

    -- Position X Slider
    local gwPosXSlider = CreateFrame("Slider", "UsefulStuffGWPosXSlider", gatewayPanel, "OptionsSliderTemplate")
    gwPosXSlider:SetPoint("TOPLEFT", gwFontSizeSlider, "BOTTOMLEFT", 0, -40)
    gwPosXSlider:SetMinMaxValues(-500, 500)
    gwPosXSlider:SetValue(UsefulStuffDB.gateway.x)
    gwPosXSlider:SetValueStep(10)
    gwPosXSlider:SetObeyStepOnDrag(true)
    gwPosXSlider:SetWidth(200)
    _G[gwPosXSlider:GetName() .. "Low"]:SetText("-500")
    _G[gwPosXSlider:GetName() .. "High"]:SetText("500")
    _G[gwPosXSlider:GetName() .. "Text"]:SetText("Position X: " .. UsefulStuffDB.gateway.x)
    gwPosXSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefulStuffDB.gateway.x = value
        _G[self:GetName() .. "Text"]:SetText("Position X: " .. value)
        UpdateGatewayDisplay()
    end)

    -- Position Y Slider
    local gwPosYSlider = CreateFrame("Slider", "UsefulStuffGWPosYSlider", gatewayPanel, "OptionsSliderTemplate")
    gwPosYSlider:SetPoint("TOPLEFT", gwPosXSlider, "BOTTOMLEFT", 0, -40)
    gwPosYSlider:SetMinMaxValues(-500, 500)
    gwPosYSlider:SetValue(UsefulStuffDB.gateway.y)
    gwPosYSlider:SetValueStep(10)
    gwPosYSlider:SetObeyStepOnDrag(true)
    gwPosYSlider:SetWidth(200)
    _G[gwPosYSlider:GetName() .. "Low"]:SetText("-500")
    _G[gwPosYSlider:GetName() .. "High"]:SetText("500")
    _G[gwPosYSlider:GetName() .. "Text"]:SetText("Position Y: " .. UsefulStuffDB.gateway.y)
    gwPosYSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefulStuffDB.gateway.y = value
        _G[self:GetName() .. "Text"]:SetText("Position Y: " .. value)
        UpdateGatewayDisplay()
    end)

    -- Select first tab by default
    SelectTab(1)

    -- Register in new settings system
    local category = Settings.RegisterCanvasLayoutCategory(panel, "UsefulStuff")
    Settings.RegisterAddOnCategory(category)
end

-- Initialize addon
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        InitializeSettings()
        BuildCircle()
        ApplyBlizzardCombatTextSetting()
        ApplyBlizzardBagBarSetting()
        ApplyChatFont()
        SetupChatFontHooks()
        ApplyAllActionBarMouseovers()
        AnchorCombatTimer()
        UpdateCombatTimerAppearance()
        InitGateway()
        CreateSettingsPanel()
        print("|cFF00FF00UsefulStuff|r loaded! Configure in ESC > Options > AddOns > UsefulStuff")
    end
end)
