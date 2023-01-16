-- Create a frame to hold the text and button

local Character = {}
Character.__index = Character
local characters = {} 
local selectedAttacker = Character
local selectedDefender = Character


local frame = CreateFrame("Frame", "CharacterListFrame", UIParent)
frame:SetSize(600,400)
frame:SetPoint("CENTER", UIParent, "CENTER")



-- for i, mob in ipairs(characters) do
--     local button = CreateButton(mob:getName() , i)
--     button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5 - (20 * (i-1)))
--     button:Show()
-- end




-- Create a button to add new characters
local addButton = CreateFrame("Button", "AddCharacterButton", frame, "UIPanelButtonTemplate")
addButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
addButton:SetSize(100, 25)
addButton:SetText("Add Character")


local characterListShow = CreateFrame("Button", "ShowCharacterListButton", frame, "UIPanelButtonTemplate")
characterListShow:SetPoint("BOTTOM", frame, "BOTTOM", 50, 50)
characterListShow:SetSize(150, 25)
characterListShow:SetText("Show Character List")


characterListShow:SetScript("OnClick", function()
    showCharacterList()
end)

----------------FUNCTIONS---------------
addButton:SetScript("OnClick", function()
    table.insert(characters, Character:new("Elf", 100, 10, 10))
    table.insert(characters, Character:new("Ghoul1", 100, 10, 10))
    table.insert(characters, Character:new("Ghoul1", 100, 10, 10))
end)




--function to load Characters with testdata
-- local function loadCharacters()
   
-- end

------button functions

local function CreateButton(name, value)
    local button = CreateFrame("Button", "MyAddonButton"..value, frame, "UIPanelButtonTemplate")
    button:SetText(name)
    button:SetSize(180, 20)
    button:SetScript("OnClick", function()
        -- code to handle button click
    end)
    return button
end




--create the buttons and add it to the frame


function showCharacterList()
  -- show the frame
  -- create the frame
  local frame = CreateFrame("Frame", "MyAddonButtonList", UIParent)
  frame:SetSize(300, 300)
  frame:SetPoint("CENTER")
  -- create the buttons
  for i, _Character in ipairs(characters) do
      local button = CreateButton(_Character:getName(), i)
      button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5 - (20 * (i-1)))
      button:Show()
  end
  frame:Show()
end



------------Functions Character

function Character:new(name, health, defence, attackPower)
    local obj = {name = name, health = health, defence = defence, attackPower = attackPower}
    setmetatable(obj, Character)
    return obj
  end
  
  function Character:getHealth()
    return self.health
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
