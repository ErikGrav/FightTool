-- Create a frame to hold the text and button

local Character = {}
Character.__index = Character
local characters = {} 
local targets = {} 
local selectedAttacker = {}
local selectedDefender = {}


local frame = CreateFrame("Frame", "CharacterListFrame", UIParent,"BackdropTemplate")
frame:SetSize(600,400)
frame:SetPoint("CENTER", UIParent, "CENTER")
frame:SetBackdrop({
  bgFile = "",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true, tileSize = 16, edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
frame:SetBackdropColor(0, 0, 0, 0.5)
frame:SetBackdropBorderColor(1, 1, 1, 1)

--make main frame movable and handle mouse interaction
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetClampedToScreen(true)


----- GUI ITEMS ----------



-------MAIN TITLE-----


  ----TITLEBAR----------
local titlebar = CreateFrame("Frame", nil, frame, "BackdropTemplate")
titlebar:SetSize(frame:GetWidth(), 20)
titlebar:SetPoint("TOP", 0, 0)
titlebar:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
titlebar:SetBackdropColor(0, 0, 0, 0.8)
titlebar:EnableMouse(true)
titlebar:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        frame:StartMoving()
    end
end)

titlebar:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
        frame:StopMovingOrSizing()
    end
end)
-------------TITLEBAR

  -------title-------
  local title = titlebar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("CENTER", titlebar, "CENTER", 0, 0)
  title:SetText("Gm Fight Tool")
  --------------title

------------------------------------------





-- Create a button to add new characters
local addButton = CreateFrame("Button", "AddCharacterButton", frame, "UIPanelButtonTemplate")
addButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
addButton:SetSize(100, 25)
addButton:SetText("Add Character")
addButton:SetScript("OnClick", function()
  SendChatMessage("adding characters", "SAY")
  table.insert(characters, Character:new("Elf", 100, 10, 10))
  table.insert(characters, Character:new("Worgen", 100, 10, 10))
  table.insert(characters, Character:new("Huntress", 100, 10, 10))
  SendChatMessage("adding targets", "SAY")
  table.insert(targets, Character:new("Gnoll", 100, 10, 10))
  table.insert(targets, Character:new("Skeleton", 100, 10, 10))
  table.insert(targets, Character:new("Ghoul", 100, 10, 10))
  SendChatMessage("alladded", "SAY")
end)


local characterListShow = CreateFrame("Button", "ShowCharacterListButton", frame, "UIPanelButtonTemplate")
characterListShow:SetPoint("BOTTOM", frame, "BOTTOM", 50, 50)
characterListShow:SetSize(150, 25)
characterListShow:SetText("Show Character List")
characterListShow:SetScript("OnClick", function()

  local characterFrame = CreateFrame("Frame", "CharacterFrame", frame,"BackdropTemplate")
  characterFrame:SetSize(180, 300)
  characterFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -20)
  characterFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",})
  characterFrame:SetBackdropColor(0,0,0,0.5)
  addtitlebar(characterFrame,"Character List")
  showCharacterList(characterFrame, characters)

  local actionsFrame = CreateFrame("Frame", "CharacterFrame", frame,"BackdropTemplate")
  actionsFrame:SetSize(180, 300)
  actionsFrame:SetPoint("TOP", frame, "TOP", 5, -20)
  actionsFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",})
  actionsFrame:SetBackdropColor(0,0,0,0.5)
  addtitlebar(actionsFrame,"Actions")
  showActionsList(actionsFrame)

  local targetFrame = CreateFrame("Frame", "targetFrame", frame,"BackdropTemplate")
  targetFrame:SetSize(180, 300)
  targetFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 5, -20)
  targetFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",})
  targetFrame:SetBackdropColor(0,0,0,0.5)
  addtitlebar(targetFrame,"Targets")
  showCharacterList(targetFrame, targets)
end)




----------------FUNCTIONS---------------





--function to load Characters with testdata
-- local function loadCharacters()
------button functions

-- local function CreateButton(name, value)
--     local button = CreateFrame("Button", "MyAddonButton"..value, frame, "UIPanelButtonTemplate")
--     button:SetText(name)
--     button:SetSize(180, 20)
--     button:SetScript("OnClick", function()
--         -- code to handle button click
--     end)
--     return button
-- end




--create the buttons and add it to the frame


function showCharacterList(parentFrame, characters)
  for i, _character in ipairs(characters) do
    local button = CreateFrame("Button", "CharacterButton"..i, parentFrame, "UIPanelButtonTemplate")
    button:SetSize(150, 30)
    button:SetText(_character:getName()) --assuming that the character object has a getName() method
    button:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 5, -20 - (30 * (i-1)))
    button:Show()
  end
end--end--showCharacterList



function showActionsList(parentFrame, actions)
  
    local attackButton = CreateFrame("Button", "ActionButton", parentFrame, "UIPanelButtonTemplate")
    attackButton:SetSize(150, 30)
    attackButton:SetText("Attack") --assuming that the character object has a getName() method
    attackButton:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 5, -20 - 30)
    attackButton:Show()

    attackButton:SetScript("OnClick", function()
      -- code to handle button click
        if(selectedAttacker ~= nil and selectedDefender ~= nil) then 
          selectedDefender:doDamage(selectedAttacker:getAttackPower())
        end
    end)
end--end--showActionsList



---------------------GUI FUNCTIONS


function addtitlebar(parentFrame,bartext)
  ----TITLEBAR----------
  local mytitlebar = CreateFrame("Frame", nil, parentFrame, "BackdropTemplate")
  mytitlebar:SetSize(parentFrame:GetWidth(), 20)
  mytitlebar:SetPoint("TOP", 0, 0)
  mytitlebar:SetBackdrop({
      bgFile = "Interface/Tooltips/UI-Tooltip-Background",
      edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
      tile = true, tileSize = 16, edgeSize = 16,
      insets = { left = 4, right = 4, top = 4, bottom = 4 }
  })
  mytitlebar:SetBackdropColor(0, 0, 0, 0.8)
  -------------TITLEBAR

    -------title-------
    local mytitle = mytitlebar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mytitle:SetPoint("CENTER", mytitlebar, "CENTER", 0, 0)
    mytitle:SetText(bartext)
    --------------title

end--end--addtitlebar



------------Functions Character



  function Character:new(name, health, defence, attackPower)
    local obj = {name = name, health = health, defence = defence, attackPower = attackPower}
    setmetatable(obj, Character)
    return obj
  end

  function Character:getHealth()
    return self.health
  end 

  function Character:setHealth(newHealth)
    self.health = newHealth
  end

  function Character:getName()
    return self.name
  end

  function Character:getDefence()
      return self.defence
  end

  function Character:getAttackPower()
    return self.attackPower
  end

  function Character:doDamage(incomingAttack)
    local dmg = incomingAttack - self.getDefence()
    if(dmg > 0 ) then
      local newHealth = self:getHealth() - dmg
      if(newHealth > 0) then
        self:setHealth(newHealth)
      else
        self:setHealth(0)
      end
    end
  end
