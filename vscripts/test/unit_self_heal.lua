require "test/getDifficulty"

local heals = 2
local healdelay = 1
local i = 1
local Chesthits = 0
local Headhits = 0
local Knee1hits = 0
local Knee2hits = 0
local Thigh1hits = 0
local Thigh2hits = 0
local StomArmorhits = 0
local roundcounter = 0
CheckDifficulty()

function Spawn()
  thisEntity:SetContextThink(nil,UnitSelfHeal, 0)
  thisEntity:SetThink(ArmorHits,"ArmorHits",0)
end

function Activate()
  --print("armored" ..Difficulty)
end

function UnitSelfHeal()
ArGrunt = Entities:FindByClassnameNearest("npc_combine_s",thisEntity:GetAbsOrigin(),10)
SpawnHP()
--print("ArGrunt")
  if ArGrunt:IsAlive() == true and heals ~= 0 then
  CheckHP()
    else ArGrunt:EmitSound("HealthPen.Fail")
      thisEntity:StopThink("UnitSelfHeal")
      return nil
    end
      return healdelay 
end   
  
 
function CheckHP()
  CurHealth = ArGrunt:GetHealth()
  PerHealth = CurHealth/MaxHealth
    --print(PerHealth)
    if PerHealth < .55 then
      BeginHeal()
    end
end

function BeginHeal()
  ArGrunt:EmitSound("HealthStation.Start")
  ArGrunt:SetGraphParameter("b_signal",true)
  ArGrunt:SetThink(function() return SignalEnder(ArGrunt) end, "signal", 1.5)
      function SignalEnder(ArGrunt)
        ArGrunt:SetGraphParameterBool("b_signal",false)
        return nil
      end 
  ArGrunt:SetHealth(MaxHealth)
  ArGrunt:SetGraphParameterBool("b_injured",false)
  heals = heals - 1
  healdelay = healdelay + 5
end



function SpawnHP()
  if i == 1 then                                                             --defaults are from campaign+ may not be vanilla values
    if Difficulty == 3 then ArGrunt:SetHealth(125) MaxHealth = 125 i = 2 end --default is 80
    if Difficulty == 2 then ArGrunt:SetHealth(125) MaxHealth = 125 i = 2 end --default is 80
    if Difficulty == 1 then ArGrunt:SetHealth(72)  MaxHealth = 72 i = 2 end --default is 56
    if Difficulty == 0 then ArGrunt:SetHealth(36) MaxHealth = 36 i = 2 end --default is 24
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
 -- print("hit chest")
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
  --print("hit knee2")
  Knee2hits = Knee2hits + 1
  if Knee2hits == 10 and Knee2Armor ~= nil then
    EntFireByHandle(self,Knee2Armor,"Skin","3",0)
    EntFireByHandle(self,Knee2Armor,"DisableCollision","3",0)
    SetStagger()
  end
end
function Thigh1ArmorHit()
 -- print("hit Thigh1")
  Thigh1hits = Thigh1hits + 1
  if Thigh1hits == 10 and Thigh1Armor ~= nil then
    EntFireByHandle(self,Thigh1Armor,"Skin","3",0,Player)
    EntFireByHandle(self,Thigh1Armor,"DisableCollision","3",0,Player)
    SetStagger()
  end
end

function Thigh2ArmorHit()
 -- print("hit Thigh2")
  Thigh2hits = Thigh2hits + 1
  if Thigh2hits == 10 and Thigh2Armor ~= nil then
    EntFireByHandle(self,Thigh2Armor,"Skin","3",0,Player)
    EntFireByHandle(self,Thigh2Armor,"DisableCollision","3",0,Player)
    SetStagger()
  end
end

function StomArmorHit()
  --print("hit STOM")
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
  thisEntity:EmitSound("Combine.ChargerShieldDown")
end


