--Last script was an absolute mess, so hopefully this one is a bit better
require "test/getDifficulty"
local UnitsToHeal = {}
local medic
local maxHealth
local currentHealth
local healthpercentage
local healthvaluetablecritical
local bShouldRun
local flNavGoalTolerance
local flDisttoNPC
local flMinNpcDist
local Chesthits = 0
local Headhits = 0
local Knee1hits = 0
local Knee2hits = 0
local Thigh1hits = 0
local Thigh2hits = 0
local StomArmorhits = 0
local Soldier
local player
local roundcounter = 65

function Spawn()
    thisEntity:SetContextThink(nil, MedicGoHeal, 0)
    thisEntity:SetThink(ArmorHits,"ArmorHits",0)
end

function MedicGoHeal()
    GetMedic()
    if medic:IsAlive() == true then 
        GetUnitsToHeal()
    return 4
    else 
    thisEntity:StopThink("MedicGoHeal")
    end
end

function GetMedic()                                                                                     --Finds the Entity that has the medic script (in this case the closest combine soldier)
    medic = Entities:FindByClassnameNearest("npc_combine_s",thisEntity:GetAbsOrigin(),10)
    --print(medic:GetName())
end

function GetUnitsToHeal()   
    UnitsToHeal = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(),512)     --Finds combine soldiers in the given radius       
    if UnitsToHeal ~= nil then
        for key, val in pairs(UnitsToHeal) do 
            CheckHealthAndPriority(val, key)    
            --print (#UnitsToHeal)
        end
    end
end




function CheckHealthAndPriority(checker, key)                                                            -- Gets Health Percentage and stores info about health within a table if %health is lower than 75%
    maxHealth = checker:GetMaxHealth()                                                                   -- Stores the index of the entity from the UnitsToHeal table in the healthpercentage table
    currentHealth = checker:GetHealth()
    healthpercentage = currentHealth / maxHealth
    if healthpercentage < 1 then
        healthvaluetablecritical = {}
     
        if healthpercentage < .75 then
            table.insert(healthvaluetablecritical, key, healthpercentage)
            --print(healthvaluetablecritical[key])
            CheckWoundedStatus()
        end
    end
end



function CheckWoundedStatus()                                                                           -- Sorts given health percentages in table and finds the lowest value and outputs the index for that value
    if healthvaluetablecritical ~= nil then
        --print("criticaltable")
        local t = healthvaluetablecritical
        local sorted = {}
        for k,v in pairs(t) do 
            table.insert(sorted,{k,v})
        end
        table.sort(sorted,function(a,b) return a[2] < b[2] end)
        for _, v in ipairs(sorted) do
           -- print(v[1])
            uni = tonumber(v[1])
            
            --print(uni)
            CriticalUnit = UnitsToHeal[uni]
            --print(CriticalUnit:GetName())
            GoToHeal()
        end
    end
end

    
function GoToHeal()                                                                                     -- Finds Medic's location and forces Medic to run towards the injured unit
    mediclocation = medic:GetAbsOrigin()
    bShouldRun = true
    flNavGoalTolerance = 25
    flMinNpcDist = 60
    if CriticalUnit:IsAlive() == true then
        --print("gocritical")
        MedicNavigate(CriticalUnit:GetAbsOrigin(),CriticalUnit)
    end
   
end

function MedicNavigate(ORIGIN,NPCNAME)                                                                  -- Medic will run to within 100 units of the unit and then begin healing
    flDisttoNPC = (medic:GetAbsOrigin() - ORIGIN):Length()
    if flDisttoNPC ~= nil and flDisttoNPC <= 100 then
        medic:NpcNavClearGoal()
        MedicHeal(NPCNAME)
    else
        medic:NpcForceGoPosition(ORIGIN, bShouldRun, flNavGoalTolerance)
        return .1
    end
end


function MedicHeal(NPCNAME)                                                                             -- Medic heals npc, signals it is healing, healed npc is taken out of injured state if originally injured.
    medic:SetGraphParameterBool("b_signal",true)
    NPCNAME:SetHealth(NPCNAME:GetHealth() + 40)
    OpenPack()
    NPCNAME:SetGraphParameterBool("b_injured",false)
    medic:EmitSound("healthstation.complete")
    medic:SetThink(function() return SignalEnder(unitmedic) end, "signal", 5)
    function SignalEnder()
        medic:SetGraphParameter("b_signal",false)
        return nil
    end           
end

function ArmorHits()
  CheckArmorType()
end

function CheckArmorType()
  Player = Entities:GetLocalPlayer()
  ChestArmor = Entities:FindByModelWithin(nil,"models/pl_armor_chest.vmdl",thisEntity:GetAbsOrigin(),72)
  if ChestArmor ~= nil then
    AddEntityOutput(Player, ChestArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","ChestArmorHit", 0, false)
  end
  
  HeadArmor = Entities:FindByModelWithin(nil,"models/pl_head.vmdl",thisEntity:GetAbsOrigin(),72)
  HeadBox = Entities:FindByModelWithin(nil,"models/armor_headhitbox.vmdl",thisEntity:GetAbsOrigin(),72)
  if HeadBox ~= nil then
    AddEntityOutput(Player, HeadBox, "OnTakeDamage", thisEntity, "CallScriptFunction","HeadArmorHit", 0, false)
  end
 
  Knee1Armor = Entities:FindByModelWithin(nil,"models/pl_armor_knee_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if Knee1Armor ~= nil then
    AddEntityOutput(Player, Knee1Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Knee1ArmorHit", 0, false)
  end
  Knee2Armor = Entities:FindByModelWithin(nil,"models/pl_armor_knee_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if Knee2Armor ~= nil then
    AddEntityOutput(Player, Knee2Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Knee2ArmorHit", 0, false)
  end
  Thigh1Armor = Entities:FindByModelWithin(nil,"models/pl_armor_thigh_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh1Armor ~= nil then
    AddEntityOutput(Player, Thigh1Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh1ArmorHit", 0, false)
  end
  Thigh2Armor = Entities:FindByModelWithin(nil,"models/pl_armor_thigh_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh2Armor ~= nil then
    AddEntityOutput(Player, Thigh2Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh2ArmorHit", 0, false)
  end
  StomArmor = Entities:FindByModelWithin(nil,"models/pl_armor_stom.vmdl",thisEntity:GetAbsOrigin(),72)
  if StomArmor ~= nil then  
    AddEntityOutput(Player, StomArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","StomArmorHit", 0, false)
  end
end

function ChestArmorHit()
  Chesthits = Chesthits + 1
  --print("hit chest")
  if Chesthits == 10 and ChestArmor ~= nil then
    EntFireByHandle(self,ChestArmor,"Skin","3",0)
    EntFireByHandle(self,ChestArmor,"DisableCollision","3",0)
    SetStagger()
  end
end

function HeadArmorHit()
  if HeadBox ~= nil then
    Headhits = Headhits + 1
   -- print("hit head")
    if Headhits == 10 and HeadArmor ~= nil then
      EntFireByHandle(self,HeadArmor,"Skin","3",0)
      EntFireByHandle(self,HeadArmor,"DisableCollision","3",0)
      EntFireByHandle(self,HeadBox,"Kill")
      SetStagger()
    end
  end
end

function Knee1ArmorHit()
  Knee1hits = Knee1hits + 1
 -- print("hit knee1")
  if Knee1hits == 10 and Knee1Armor ~= nil then
    EntFireByHandle(self,Knee1Armor,"Skin","3",0)
    EntFireByHandle(self,Knee1Armor,"DisableCollision","3",0)
    SetStagger()
  end
end

function Knee2ArmorHit()
 -- print("hit knee2")
  Knee2hits = Knee2hits + 1
  if Knee2hits == 10 and Knee2Armor ~= nil then
    EntFireByHandle(self,Knee2Armor,"Skin","3",0)
    EntFireByHandle(self,Knee2Armor,"DisableCollision","3",0)
    SetStagger()
  end
end
function Thigh1ArmorHit()
--  print("hit Thigh1")
  Thigh1hits = Thigh1hits + 1
  if Thigh1hits == 10 and Thigh1Armor ~= nil then
    EntFireByHandle(self,Thigh1Armor,"Skin","3",0,Player)
    EntFireByHandle(self,Thigh1Armor,"DisableCollision","3",0,Player)
    SetStagger()
  end
end

function Thigh2ArmorHit()
  --print("hit Thigh2")
  Thigh2hits = Thigh2hits + 1
  if Thigh2hits == 10 and Thigh2Armor ~= nil then
    EntFireByHandle(self,Thigh2Armor,"Skin","3",0,Player)
    EntFireByHandle(self,Thigh2Armor,"DisableCollision","3",0,Player)
    SetStagger()
  end
end

function StomArmorHit()
 -- print("hit STOM")
  StomArmorhits = StomArmorhits + 1
  if StomArmorhits == 10 and StomArmor ~= nil then
    EntFireByHandle(self,StomArmor,"Skin","3",0,Player)
    EntFireByHandle(self,StomArmor,"DisableCollision","3",0,Player)
    SetStagger()
  end
end

function AddEntityOutput (requestingEntity, outputEntity, outputName, outputTargetEntity, action, parameter, delay, fireOnce)
  parameter = parameter or ""
  delay = delay or 0
  fireOnce = fireOnce or false
  local maxTimesToFire = -1 if (fireOnce) then maxTimesToFire = 1 end
  local target = outputTargetEntity:GetName()

  if target ~= nil then
      local output = outputName ..">".. target ..">".. action ..">".. parameter ..">".. delay ..">".. maxTimesToFire
      EntFireByHandle(requestingEntity, outputEntity, "AddOutput", output)
  end
end






function SetStagger()
  thisEntity:SetGraphParameterEnum("e_stagger",math.random(2,12))
end

function OpenPack()
  Pack = Entities:FindByModelWithin(nil,"models/props_combine/combine_consoles/combine_monitor_medium.vmdl",medic:GetAbsOrigin(),100)
  if Pack ~= nil then
    Pack:SetSequence("open")
    Pack:SetThink(function() return PackClose(pack) end, "close", 5)
    function PackClose()
        Pack:SetSequence("close")
        return nil
    end   
  end
end