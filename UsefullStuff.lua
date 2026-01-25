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
    circleRadius = 20,
    circleColor = {r = 1, g = 1, b = 1, a = 0.8},
    lineThickness = 3,
    combatTextEnter = "ENTERING COMBAT!",
    combatTextLeave = "Leaving Combat",
    combatTextFont = "Friz Quadrata TT",
    combatTextSize = 32,
    combatTextX = 0,
    combatTextY = 200,
    disableBlizzardCombatText = true,
    disableBlizzardBagBar = false,
    actionBarsMouseover = {
        MainMenuBar = false,
        MultiBarBottomLeft = false,
        MultiBarBottomRight = false,
        MultiBarRight = false,
        MultiBarLeft = false,
        MultiBar5 = false,
        MultiBar6 = false,
        MultiBar7 = false,
    },
}

-- Initialize settings
local function InitializeSettings()
    if not UsefullStuffDB then
        UsefullStuffDB = {}
    end
    if not UsefullStuffDB.circleRadius then
        UsefullStuffDB.circleRadius = defaults.circleRadius
    end
    if not UsefullStuffDB.circleColor then
        UsefullStuffDB.circleColor = {r = defaults.circleColor.r, g = defaults.circleColor.g, b = defaults.circleColor.b, a = defaults.circleColor.a}
    end
    if not UsefullStuffDB.lineThickness then
        UsefullStuffDB.lineThickness = defaults.lineThickness
    end
    if not UsefullStuffDB.combatTextEnter then
        UsefullStuffDB.combatTextEnter = defaults.combatTextEnter
    end
    if not UsefullStuffDB.combatTextLeave then
        UsefullStuffDB.combatTextLeave = defaults.combatTextLeave
    end
    if not UsefullStuffDB.combatTextFont then
        UsefullStuffDB.combatTextFont = defaults.combatTextFont
    else
        -- Migrate old path-based fonts to names
        local pathToName = {
            ["Fonts\\FRIZQT__.TTF"] = "Friz Quadrata TT",
            ["Fonts\\ARIALN.TTF"] = "Arial Narrow",
            ["Fonts\\skurri.ttf"] = "Skurri",
            ["Fonts\\MORPHEUS.ttf"] = "Morpheus",
        }
        if pathToName[UsefullStuffDB.combatTextFont] then
            UsefullStuffDB.combatTextFont = pathToName[UsefullStuffDB.combatTextFont]
        end
    end
    if not UsefullStuffDB.combatTextSize then
        UsefullStuffDB.combatTextSize = defaults.combatTextSize
    end
    if not UsefullStuffDB.combatTextX then
        UsefullStuffDB.combatTextX = defaults.combatTextX
    end
    if not UsefullStuffDB.combatTextY then
        UsefullStuffDB.combatTextY = defaults.combatTextY
    end
    if UsefullStuffDB.disableBlizzardCombatText == nil then
        UsefullStuffDB.disableBlizzardCombatText = defaults.disableBlizzardCombatText
    end
    if UsefullStuffDB.disableBlizzardBagBar == nil then
        UsefullStuffDB.disableBlizzardBagBar = defaults.disableBlizzardBagBar
    end
    if not UsefullStuffDB.actionBarsMouseover then
        UsefullStuffDB.actionBarsMouseover = {}
    end
    for barName, defaultValue in pairs(defaults.actionBarsMouseover) do
        if UsefullStuffDB.actionBarsMouseover[barName] == nil then
            UsefullStuffDB.actionBarsMouseover[barName] = defaultValue
        end
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
    if UsefullStuffDB.disableBlizzardCombatText then
        SetCVar("enableFloatingCombatText", "0")
    else
        SetCVar("enableFloatingCombatText", "1")
    end
end

-- Function to apply Blizzard bag bar setting
local function ApplyBlizzardBagBarSetting()
    if UsefullStuffDB.disableBlizzardBagBar then
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

-- Action Bar Mouseover functionality
local actionBarFrames = {
    MainMenuBar = "MainMenuBar",
    MultiBarBottomLeft = "MultiBarBottomLeft",
    MultiBarBottomRight = "MultiBarBottomRight",
    MultiBarRight = "MultiBarRight",
    MultiBarLeft = "MultiBarLeft",
    MultiBar5 = "MultiBar5",
    MultiBar6 = "MultiBar6",
    MultiBar7 = "MultiBar7",
}

local actionBarOriginalAlpha = {}

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

        -- Set to transparent
        frame:SetAlpha(0)

        -- Add mouseover scripts
        frame:SetScript("OnEnter", function(self)
            self:SetAlpha(actionBarOriginalAlpha[barName] or 1)
        end)

        frame:SetScript("OnLeave", function(self)
            self:SetAlpha(0)
        end)
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
    end
end

local function ApplyAllActionBarMouseovers()
    for barName, _ in pairs(actionBarFrames) do
        local enable = UsefullStuffDB.actionBarsMouseover[barName]
        ApplyActionBarMouseover(barName, enable)
    end
end

-- Create the main frame for the cursor circle
local circleFrame = CreateFrame("Frame", "UsefullStuff_CursorCircle", UIParent)
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
    local radius = UsefullStuffDB.circleRadius
    local lineThickness = UsefullStuffDB.lineThickness
    local color = UsefullStuffDB.circleColor

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
local combatTextFrame = CreateFrame("Frame", "UsefullStuff_CombatText", UIParent)
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
    combatTextFrame:ClearAllPoints()
    combatTextFrame:SetPoint("CENTER", UIParent, "CENTER", UsefullStuffDB.combatTextX, UsefullStuffDB.combatTextY)

    local fontPath = GetFontPath(UsefullStuffDB.combatTextFont)
    combatText:SetFont(fontPath, UsefullStuffDB.combatTextSize, "OUTLINE")
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
        ShowCombatText(UsefullStuffDB.combatTextEnter)
    elseif event == "PLAYER_REGEN_ENABLED" then
        ShowCombatText(UsefullStuffDB.combatTextLeave)
    end
end)

-- Create settings panel
local function CreateSettingsPanel()
    local panel = CreateFrame("Frame", "UsefullStuffOptionsPanel", UIParent)
    panel.name = "UsefullStuff"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("UsefullStuff Settings")

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
    local tab1 = CreateFrame("Button", "UsefullStuffTab1", panel)
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
    local tab2 = CreateFrame("Button", "UsefullStuffTab2", panel)
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
    local tab3 = CreateFrame("Button", "UsefullStuffTab3", panel)
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
    local tab4 = CreateFrame("Button", "UsefullStuffTab4", panel)
    tab4:SetSize(100, 32)
    tab4:SetPoint("LEFT", tab3, "RIGHT", -15, 0)
    tab4:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab")
    tab4:GetNormalTexture():SetTexCoord(0, 1, 0, 1)

    local tab4Text = tab4:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    tab4Text:SetPoint("CENTER", 0, -2)
    tab4Text:SetText("Action Bars")

    tab4:SetScript("OnClick", function() SelectTab(4) end)
    table.insert(tabs, tab4)

    -- Panel 1: General Settings
    local generalPanel = CreateFrame("Frame", nil, panel)
    generalPanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    generalPanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    table.insert(tabPanels, generalPanel)

    -- Disable Blizzard Bag Bar Checkbox
    local disableBagBarCheckbox = CreateFrame("CheckButton", "UsefullStuffDisableBagBarCheckbox", generalPanel, "UICheckButtonTemplate")
    disableBagBarCheckbox:SetPoint("TOPLEFT", 0, -10)
    disableBagBarCheckbox:SetSize(24, 24)
    disableBagBarCheckbox:SetChecked(UsefullStuffDB.disableBlizzardBagBar)

    local disableBagBarLabel = generalPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    disableBagBarLabel:SetPoint("LEFT", disableBagBarCheckbox, "RIGHT", 5, 0)
    disableBagBarLabel:SetText("Disable Blizzard Bag Bar")

    disableBagBarCheckbox:SetScript("OnClick", function(self)
        UsefullStuffDB.disableBlizzardBagBar = self:GetChecked()
        ApplyBlizzardBagBarSetting()
    end)

    -- Panel 2: Cursor Circle Settings
    local circlePanel = CreateFrame("Frame", nil, panel)
    circlePanel:SetPoint("TOPLEFT", tab1, "BOTTOMLEFT", 5, -10)
    circlePanel:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -10, 10)
    circlePanel:Hide()
    table.insert(tabPanels, circlePanel)

    -- Circle Size Slider
    local sizeSlider = CreateFrame("Slider", "UsefullStuffSizeSlider", circlePanel, "OptionsSliderTemplate")
    sizeSlider:SetPoint("TOPLEFT", 0, -10)
    sizeSlider:SetMinMaxValues(20, 150)
    sizeSlider:SetValue(UsefullStuffDB.circleRadius)
    sizeSlider:SetValueStep(5)
    sizeSlider:SetObeyStepOnDrag(true)
    sizeSlider:SetWidth(200)
    _G[sizeSlider:GetName() .. "Low"]:SetText("20")
    _G[sizeSlider:GetName() .. "High"]:SetText("150")
    _G[sizeSlider:GetName() .. "Text"]:SetText("Circle Size: " .. UsefullStuffDB.circleRadius)
    sizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 5) * 5
        UsefullStuffDB.circleRadius = value
        _G[self:GetName() .. "Text"]:SetText("Circle Size: " .. value)
        BuildCircle()
    end)

    -- Line Thickness Slider
    local thicknessSlider = CreateFrame("Slider", "UsefullStuffThicknessSlider", circlePanel, "OptionsSliderTemplate")
    thicknessSlider:SetPoint("TOPLEFT", sizeSlider, "BOTTOMLEFT", 0, -40)
    thicknessSlider:SetMinMaxValues(1, 5)
    thicknessSlider:SetValue(UsefullStuffDB.lineThickness)
    thicknessSlider:SetValueStep(0.5)
    thicknessSlider:SetObeyStepOnDrag(true)
    thicknessSlider:SetWidth(200)
    _G[thicknessSlider:GetName() .. "Low"]:SetText("1")
    _G[thicknessSlider:GetName() .. "High"]:SetText("5")
    _G[thicknessSlider:GetName() .. "Text"]:SetText("Line Thickness: " .. UsefullStuffDB.lineThickness)
    thicknessSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 0.5) * 0.5
        UsefullStuffDB.lineThickness = value
        _G[self:GetName() .. "Text"]:SetText("Line Thickness: " .. value)
        BuildCircle()
    end)

    -- Color Picker Button
    local colorLabel = circlePanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    colorLabel:SetPoint("TOPLEFT", thicknessSlider, "BOTTOMLEFT", 0, -40)
    colorLabel:SetText("Circle Color:")

    local colorButton = CreateFrame("Button", "UsefullStuffColorButton", circlePanel, "UIPanelButtonTemplate")
    colorButton:SetPoint("TOPLEFT", colorLabel, "BOTTOMLEFT", 0, -8)
    colorButton:SetSize(120, 25)
    colorButton:SetText("Choose Color")
    colorButton:SetScript("OnClick", function()
        local color = UsefullStuffDB.circleColor
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
                UsefullStuffDB.circleColor.r = r
                UsefullStuffDB.circleColor.g = g
                UsefullStuffDB.circleColor.b = b
                UsefullStuffDB.circleColor.a = a
                BuildCircle()
            end,
            opacityFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                local a = ColorPickerFrame:GetColorAlpha()
                UsefullStuffDB.circleColor.r = r
                UsefullStuffDB.circleColor.g = g
                UsefullStuffDB.circleColor.b = b
                UsefullStuffDB.circleColor.a = a
                BuildCircle()
            end,
            cancelFunc = function()
                UsefullStuffDB.circleColor.r = previousColor.r
                UsefullStuffDB.circleColor.g = previousColor.g
                UsefullStuffDB.circleColor.b = previousColor.b
                UsefullStuffDB.circleColor.a = previousColor.a
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

    -- Enter Combat Text
    local enterTextLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    enterTextLabel:SetPoint("TOPLEFT", 0, -10)
    enterTextLabel:SetText("Enter Combat Text:")

    local enterTextBox = CreateFrame("EditBox", "UsefullStuffEnterTextBox", combatPanel, "InputBoxTemplate")
    enterTextBox:SetPoint("TOPLEFT", enterTextLabel, "BOTTOMLEFT", 5, -5)
    enterTextBox:SetSize(200, 20)
    enterTextBox:SetAutoFocus(false)
    enterTextBox:SetText(UsefullStuffDB.combatTextEnter)
    enterTextBox:SetScript("OnEnterPressed", function(self)
        UsefullStuffDB.combatTextEnter = self:GetText()
        self:ClearFocus()
    end)
    enterTextBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefullStuffDB.combatTextEnter)
        self:ClearFocus()
    end)

    -- Leave Combat Text
    local leaveTextLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    leaveTextLabel:SetPoint("TOPLEFT", enterTextBox, "BOTTOMLEFT", -5, -15)
    leaveTextLabel:SetText("Leave Combat Text:")

    local leaveTextBox = CreateFrame("EditBox", "UsefullStuffLeaveTextBox", combatPanel, "InputBoxTemplate")
    leaveTextBox:SetPoint("TOPLEFT", leaveTextLabel, "BOTTOMLEFT", 5, -5)
    leaveTextBox:SetSize(200, 20)
    leaveTextBox:SetAutoFocus(false)
    leaveTextBox:SetText(UsefullStuffDB.combatTextLeave)
    leaveTextBox:SetScript("OnEnterPressed", function(self)
        UsefullStuffDB.combatTextLeave = self:GetText()
        self:ClearFocus()
    end)
    leaveTextBox:SetScript("OnEscapePressed", function(self)
        self:SetText(UsefullStuffDB.combatTextLeave)
        self:ClearFocus()
    end)

    -- Font Size Slider
    local fontSizeSlider = CreateFrame("Slider", "UsefullStuffFontSizeSlider", combatPanel, "OptionsSliderTemplate")
    fontSizeSlider:SetPoint("TOPLEFT", leaveTextBox, "BOTTOMLEFT", -5, -30)
    fontSizeSlider:SetMinMaxValues(12, 72)
    fontSizeSlider:SetValue(UsefullStuffDB.combatTextSize)
    fontSizeSlider:SetValueStep(2)
    fontSizeSlider:SetObeyStepOnDrag(true)
    fontSizeSlider:SetWidth(200)
    _G[fontSizeSlider:GetName() .. "Low"]:SetText("12")
    _G[fontSizeSlider:GetName() .. "High"]:SetText("72")
    _G[fontSizeSlider:GetName() .. "Text"]:SetText("Font Size: " .. UsefullStuffDB.combatTextSize)
    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 2) * 2
        UsefullStuffDB.combatTextSize = value
        _G[self:GetName() .. "Text"]:SetText("Font Size: " .. value)
    end)

    -- Font Dropdown with SharedMedia support
    local fontLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontLabel:SetPoint("TOPLEFT", fontSizeSlider, "BOTTOMLEFT", 0, -40)
    fontLabel:SetText("Font:")

    local fontDropdown = CreateFrame("Frame", "UsefullStuffFontDropdown", combatPanel, "UIDropDownMenuTemplate")
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
                UsefullStuffDB.combatTextFont = fontName
                UIDropDownMenu_SetText(fontDropdown, fontName)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Set initial dropdown text
    UIDropDownMenu_SetText(fontDropdown, UsefullStuffDB.combatTextFont)

    -- Position X Slider
    local posXSlider = CreateFrame("Slider", "UsefullStuffPosXSlider", combatPanel, "OptionsSliderTemplate")
    posXSlider:SetPoint("TOPLEFT", fontDropdown, "BOTTOMLEFT", 15, -30)
    posXSlider:SetMinMaxValues(-500, 500)
    posXSlider:SetValue(UsefullStuffDB.combatTextX)
    posXSlider:SetValueStep(10)
    posXSlider:SetObeyStepOnDrag(true)
    posXSlider:SetWidth(200)
    _G[posXSlider:GetName() .. "Low"]:SetText("-500")
    _G[posXSlider:GetName() .. "High"]:SetText("500")
    _G[posXSlider:GetName() .. "Text"]:SetText("Position X: " .. UsefullStuffDB.combatTextX)
    posXSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefullStuffDB.combatTextX = value
        _G[self:GetName() .. "Text"]:SetText("Position X: " .. value)
    end)

    -- Position Y Slider
    local posYSlider = CreateFrame("Slider", "UsefullStuffPosYSlider", combatPanel, "OptionsSliderTemplate")
    posYSlider:SetPoint("TOPLEFT", posXSlider, "BOTTOMLEFT", 0, -40)
    posYSlider:SetMinMaxValues(-500, 500)
    posYSlider:SetValue(UsefullStuffDB.combatTextY)
    posYSlider:SetValueStep(10)
    posYSlider:SetObeyStepOnDrag(true)
    posYSlider:SetWidth(200)
    _G[posYSlider:GetName() .. "Low"]:SetText("-500")
    _G[posYSlider:GetName() .. "High"]:SetText("500")
    _G[posYSlider:GetName() .. "Text"]:SetText("Position Y: " .. UsefullStuffDB.combatTextY)
    posYSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value / 10) * 10
        UsefullStuffDB.combatTextY = value
        _G[self:GetName() .. "Text"]:SetText("Position Y: " .. value)
    end)

    -- Disable Blizzard Combat Text Checkbox
    local disableBlizzCheckbox = CreateFrame("CheckButton", "UsefullStuffDisableBlizzCheckbox", combatPanel, "UICheckButtonTemplate")
    disableBlizzCheckbox:SetPoint("TOPLEFT", posYSlider, "BOTTOMLEFT", 0, -40)
    disableBlizzCheckbox:SetSize(24, 24)
    disableBlizzCheckbox:SetChecked(UsefullStuffDB.disableBlizzardCombatText)

    local disableBlizzLabel = combatPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    disableBlizzLabel:SetPoint("LEFT", disableBlizzCheckbox, "RIGHT", 5, 0)
    disableBlizzLabel:SetText("Disable Blizzard Combat Text")

    disableBlizzCheckbox:SetScript("OnClick", function(self)
        UsefullStuffDB.disableBlizzardCombatText = self:GetChecked()
        ApplyBlizzardCombatTextSetting()
    end)

    -- Test Combat Text Button
    local testButton = CreateFrame("Button", "UsefullStuffTestButton", combatPanel, "UIPanelButtonTemplate")
    testButton:SetPoint("TOPLEFT", disableBlizzCheckbox, "BOTTOMLEFT", 0, -20)
    testButton:SetSize(200, 25)
    testButton:SetText("Test Combat Text")
    testButton:SetScript("OnClick", function()
        ShowCombatText(UsefullStuffDB.combatTextEnter)
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
        {key = "MainMenuBar", name = "Main Action Bar (Bar 1)"},
        {key = "MultiBarBottomLeft", name = "Bottom Left Bar (Bar 2)"},
        {key = "MultiBarBottomRight", name = "Bottom Right Bar (Bar 3)"},
        {key = "MultiBarRight", name = "Right Bar (Bar 4)"},
        {key = "MultiBarLeft", name = "Right Bar 2 (Bar 5)"},
        {key = "MultiBar5", name = "Bar 6"},
        {key = "MultiBar6", name = "Bar 7"},
        {key = "MultiBar7", name = "Bar 8"},
    }

    local lastCheckbox = abDesc
    for i, barInfo in ipairs(actionBarList) do
        local checkbox = CreateFrame("CheckButton", "UsefullStuffActionBar"..barInfo.key.."Checkbox", actionBarsPanel, "UICheckButtonTemplate")
        if i == 1 then
            checkbox:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -15)
        else
            checkbox:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -5)
        end
        checkbox:SetSize(24, 24)
        checkbox:SetChecked(UsefullStuffDB.actionBarsMouseover[barInfo.key])

        local label = actionBarsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        label:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
        label:SetText(barInfo.name)

        checkbox:SetScript("OnClick", function(self)
            UsefullStuffDB.actionBarsMouseover[barInfo.key] = self:GetChecked()
            ApplyActionBarMouseover(barInfo.key, self:GetChecked())
        end)

        lastCheckbox = checkbox
    end

    -- Select first tab by default
    SelectTab(1)

    -- Register in new settings system
    local category = Settings.RegisterCanvasLayoutCategory(panel, "UsefullStuff")
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
        ApplyAllActionBarMouseovers()
        CreateSettingsPanel()
        print("|cFF00FF00UsefullStuff|r loaded! Right-click for cursor circle. Combat text enabled. Configure in ESC > Options > AddOns > UsefullStuff")
    end
end)
