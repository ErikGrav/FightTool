-- Create a frame to hold the text and button

local Character = {}
Character.__index = Character
local characters = {} 
local targets = {} 
local selectedAttacker = {}
local selectedDefender = {}
local diceValue = 10




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
  -- SendChatMessage("adding characters", "SAY")
  table.insert(characters, Character:new("Elf", 50, 5, 10, true, false))
  table.insert(characters, Character:new("Worgen", 50, 5, 10, false, false))
  table.insert(characters, Character:new("Huntress", 50, 5, 10, false, false))
  selectedAttacker = characters[1]
  -- SendChatMessage("adding targets", "SAY")
  table.insert(targets, Character:new("Gnoll", 40, 3, 6,true, false))
  table.insert(targets, Character:new("Skeleton", 40, 3, 6, false, false))
  table.insert(targets, Character:new("Ghoul", 40, 3, 6, false, false))
  selectedDefender = targets[1]
  -- SendChatMessage("alladded", "SAY")
end)


local addButton = CreateFrame("Button", "AddCharacterButton", frame, "UIPanelButtonTemplate")
addButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 100)
addButton:SetSize(100, 25)
addButton:SetText("Add showselected")
addButton:SetScript("OnClick", function()
  SendChatMessage("attacker:" .. selectedAttacker:getName() , "SAY")
  SendChatMessage("Defender:" .. selectedDefender:getName() , "SAY")
  
  
end)
-- SendChatMessage("adding targets", "SAY")

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
  showCharacterList(characterFrame, characters, true, "CharacterButton")
 
  
  local targetFrame = CreateFrame("Frame", "TargetFrame", frame,"BackdropTemplate")
  targetFrame:SetSize(180, 300)
  targetFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 5, -20)
  targetFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",})
  targetFrame:SetBackdropColor(0,0,0,0.5)
  addtitlebar(targetFrame,"Targets")
  showCharacterList(targetFrame, targets, false, "CharacterButton")

   
  local actionsFrame = CreateFrame("Frame", "ActionsFrame", frame,"BackdropTemplate")
  actionsFrame:SetSize(180, 300)
  actionsFrame:SetPoint("TOP", frame, "TOP", 5, -20)
  actionsFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",})
  actionsFrame:SetBackdropColor(0,0,0,0.5)
  addtitlebar(actionsFrame,"Actions")
  showActionsList(actionsFrame, characterFrame, targetFrame)
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
        
        
        function findCharacterByName(name)
          for i, character in ipairs(characters) do
            if character:getName() == name then
              return character
            end
          end
          return nil
        end
        
        
        function setSelectedAttacker(_newCharacter, isCharacter)

          local newAttacker = _newCharacter
          local oldAttacker = selectedAttacker

          
           if selectedAttacker == nil  then 
            oldAttacker = selectedAttacker:getName()
          end
          

          if isCharacter == true then
            
            for i, char in ipairs(characters) do
              if char:getName() == newAttacker:getName() then
                char:setAttacker()
                selectedAttacker = char;
              end
              if oldAttacker ~= nil then
                if char:getName() == oldAttacker:getName() then
                  char:setAttacker(false)
                end
              end
            end
          else     
            -- SendChatMessage("defneder", "SAY")
            for i, char in ipairs(targets) do
              if char:getName() == newAttacker:getName() then
                char:setAttacker()
                selectedAttacker = char;
              end
              if oldAttacker ~= nil then
                if char:getName() == oldAttacker:getName() then
                  char:setAttacker(false)
                end
              end
            end
          end
          SendChatMessage("selectedattacker: " .. selectedAttacker:getName(), "SAY")
        end
         
        

        function setSelectedDefender(_newDefender, isCharacter)
          local newDefender = _newDefender:getName()
          local oldDefender= selectedDefender:getName();

          if not next(selectedDefender) == nil then
            oldDefender = selectedDefender:getName()
          end

          if isCharacter == true then
            
            for i, char in ipairs(characters) do
              if char:getName() == newDefender then
                char:setDefender()
                selectedDefender = char;
              end
              if char:getName() == oldDefender then
                char:clearDefender()
              end

            end
          else     
            -- SendChatMessage("defneder", "SAY")
            for i, char in ipairs(targets) do
              if char:getName() == newDefender then
                char:setDefender()
                selectedDefender = char;
              end
              if char:getName() == oldDefender then
                char:setDefender(false)
              end
            end
          end
          SendChatMessage("selectedDefender: " .. selectedDefender:getName(), "SAY")
        end
      
        



        --create the buttons and add it to the frame
      
        function showCharacterList(parentFrame, _characters, isCharacter, buttonType)
          -- SendChatMessage("showCharacterList whatframe? ? :".. parentFrame:GetName() , "SAY")
          for i, _character in ipairs(_characters) do
            local button = CreateFrame("CheckButton", buttonType..i, parentFrame, "UIPanelButtonTemplate")
            button:SetSize(150, 30)
            button:SetText(_character:getName() .. "[" .. _character:getHealth() .. "]") --assuming that the character object has a getName() method
            button:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 5, -20 - (30 * (i-1)))
            button:SetScript("OnClick", function()
              if(isCharacter == true) then
                setSelectedAttacker(_character, isCharacter)
              end
              if(isCharacter == false) then
                setSelectedDefender(_character, isCharacter)
              end
            end)

            if _character:getAttacker() or _character:getDefender() then
              button:SetChecked(true)
            else
              --button:SetChecked(false)
            end
            
            
            button:Show()
            -- SendChatMessage( parentFrame:GetName() .. button:GetName(), "SAY")
          end
        end
        
        function showActionsList(actionsFrame, characterFrame, targetFrame, actions)
          -- SendChatMessage("showActionsList whatframe? ? :".. actionsFrame:GetName() , "SAY")
          
          local attackButton = CreateFrame("Button", "ActionButton", actionsFrame, "UIPanelButtonTemplate")
          attackButton:SetSize(150, 30)
          attackButton:SetText("Attack") --assuming that the character object has a getName() method
          attackButton:SetPoint("TOPLEFT", actionsFrame, "TOPLEFT", 5, -20 - 30)
          attackButton:Show()
          
          attackButton:SetScript("OnClick", function()
            -- code to handle button click
            if(selectedAttacker ~= nil and selectedDefender ~= nil) then 
              
              local atackName = selectedAttacker:getName()
              local defName = selectedDefender:getName()
              
              -- SendChatMessage("attacker: " .. selectedAttacker:getName() .. " hits " .. selectedDefender:getName() , "SAY")
   
              doDamage(characterFrame, targetFrame)
            end
          end)
        end--end--showActionsList
        
        
        function doDamage(characterFrame, targetFrame)
          
          -- SendChatMessage("incomingAttack:" .. selectedAttacker:getAttackPower() .. " incomingDefence:" .. selectedDefender:getDefence(), "SAY")
          local randomRoll = math.random(1, diceValue)
          local attackDmg = selectedAttacker:getAttackPower() + randomRoll
          local dmg = attackDmg - selectedDefender:getDefence()
          SendChatMessage("attacker rolled: " .. randomRoll .. " + basedmg: " .. selectedAttacker:getAttackPower() .. "dealing " .. dmg .. " dmg." , "SAY")
          
          updateCharacterHealthByName(selectedDefender:getName(), false, dmg)
          updateSelectedDefender(selectedDefender:getName(), false, characterFrame, targetFrame)
        
        end
              
              
        function updateSelectedDefender(name, isCharacter, characterFrame, targetFrame)
          SendChatMessage("updateSelectedDefender name? :".. name , "SAY")
        

          if isCharacter == true then
            for i, char in ipairs(characters) do
              if char:getName() == name then
                
                selectedAttacker = char
                -- SendChatMessage("SelectedAttacker updated??? :" , "SAY")
               
                break
              end
            end
            refreshButtons(characters, characterFrame,isCharacter)
          else
            for i, char in ipairs(targets) do
              if char:getName() == name then
                selectedDefender = char
                -- SendChatMessage("selectedDefender nupdated???", "SAY")
               
  
                break
              end
            end
            refreshButtons(targets,targetFrame, isCharacter)
          end
          -- SendChatMessage("selectedAttacker new?? :" .. selectedAttacker:getName() .. " - " .. selectedAttacker:getHealth(), "SAY")
          -- SendChatMessage("selectedDefender new?? :" .. selectedDefender:getName() .. " - " .. selectedDefender:getHealth(), "SAY")
        end
              
              
              
              
        function updateCharacterHealthByName(name, isCharacter, dmg)
          if isCharacter == true then
            
            for i, char in ipairs(characters) do
              if char:getName() == name then
                local currentHealth = char:getHealth()
                local newHealth = currentHealth - dmg
                if newHealth < 0 then
                  char:setHealth(0)
                else
                  char:setHealth(newHealth)
                end
                -- SendChatMessage("new HP? :" .. char:getHealth(), "SAY")
                break
              end
            end
          else     
            -- SendChatMessage("defneder", "SAY")
            for i, char in ipairs(targets) do
              if char:getName() == name then
                -- SendChatMessage("found name:" .. char:getName() .. "== ".. name  , "SAY")
                local currentHealth = char:getHealth()
                local newHealth = currentHealth - dmg
                -- SendChatMessage("new health:" .. newHealth, "SAY")
                
                if newHealth < 0 then
                  char:setHealth(0)
                  SendChatMessage(char:getName() .."is down ", "SAY")
                else
                  char:setHealth(newHealth)
                end
                
                -- SendChatMessage("new HP? :" .. char:getHealth(), "SAY")
                break
              end
            end
          end
        end
              

          
          
          
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


        function refreshButtons(_targets, parentFrame, isCharacter)

          local buttonName = "CharacterButton"

          -- SendChatMessage("frame?" .. parentFrame:GetName(), "SAY")


          if parentFrame then
            for i = 1, parentFrame:GetNumChildren() do
              local child = select(i, parentFrame:GetChildren())
              if child and child:GetObjectType() == "CheckButton" then
                child:Hide()
              end
            end
          end

          for i, _character in ipairs(_targets) do
            -- SendChatMessage("Button?" .. parentFrame:GetName()..buttonName .. i, "SAY")

            local button = _G[parentFrame:GetName()..buttonName .. i] -- get the button by its name

            SendChatMessage("characters? " , "SAY")

            if not button then -- if the button doesn't exist, create it
              button = CreateFrame("CheckButton", "CharacterButton" .. i, parentFrame, "UIPanelButtonTemplate")
              button:SetSize(150, 30)
              button:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 5, -20 - (30 * (i-1)))
              button:SetScript("OnClick", function()
                if(isCharacter == true) then
                  selectedAttacker = _character
                 
                end
                if(isCharacter == false) then
                  selectedDefender = _character
                  

                end
                SendChatMessage("checked? ", "SAY")
              end)
            else
              button:Hide() -- hide the old button
            end
            SendChatMessage("stops here? ", "SAY")
      
            local isAttacker _character.getAttacker()
            local isDefender _character.getDefender()

            if(isAttacker == "true") then
              button:SetChecked(true)
              SendChatMessage("is attacker", "SAY")
            else
               button:SetChecked(false)
               SendChatMessage("not attacker", "SAY")
            end

            if(isDefender == "true") then
              button:SetChecked(true)
              SendChatMessage("is defender", "SAY")
         
            else
               button:SetChecked(false)
               SendChatMessage("not defender", "SAY")
            end

            button:SetText(_character:getName() .. "[" .. _character:getHealth() .. "]") -- update the text
            button:Show() -- make sure the button is visible
          end
          for i = #_targets + 1, #_G do -- hide any remaining buttons
            local button = _G[parentFrame..buttonName .. i]
            if button then
              button:Hide()
            end
          end
        end
          
          
          
          ------------Functions Character
          
          
          
        function Character:new(name, health, defence, attackPower, attacker, defender)
          local obj = {name = name, health = health, defence = defence, attackPower = attackPower, attacker = attacker, defender = defender}
          setmetatable(obj, Character)
          return obj
        end
        
        function Character:setAttacker()
          if self.defender == true then
            self:clearDefender()
          end
          self.setAttacker(true)
     
        end

        function Character:setAttacker(value)
          self.attacker = value
        end

        function Character:setDefender()
          if self.attacker == true then
            self:setAttacker(false)
          end
          self:setDefender(true)
     
        end

        function Character:setDefender(value)
          self.defender = value
 
        end

        function Character:getDefender()
          return self.defender
        end

        function Character:getAttacker()
          return self.attacker
        end

        -- function Character:getRole()

        --   if self.defender == true then
        --     return "defender"
        --   end
        --   if self.attacker == true then
        --     return"attacker"
        --   end

        --   return "nothing"
        -- end
        
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


          
        
                  