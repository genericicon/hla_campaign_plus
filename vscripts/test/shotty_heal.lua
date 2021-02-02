require "test/getDifficulty"
local Thigh1SideArmorHits = 0
local Thigh2SideArmorHits = 0
local ArmorArmLeft2Hits = 0
local ArmorArmLeft1Hits = 0 
local ArmorArmRight2Hits = 0
local ArmorArmRight1Hits = 0
local Neckhits = 0
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





function ArmorHits()
  CheckArmorType()
end

function CheckArmorType()
  Player = Entities:GetLocalPlayer()
  ChestArmor = Entities:FindByModelWithin(nil,"models/chest_armor.vmdl",thisEntity:GetAbsOrigin(),72)
  if ChestArmor ~= nil then
    AddEntityOutput(Player, ChestArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","ChestArmorHit", 0, false)
  end
  
  HeadArmor = Entities:FindByModelWithin(nil,"models/pl_head.vmdl",thisEntity:GetAbsOrigin(),72)
  HeadBox = Entities:FindByModelWithin(nil,"models/armor_headhitbox.vmdl",thisEntity:GetAbsOrigin(),72)
  if HeadBox ~= nil then
    AddEntityOutput(Player, HeadBox, "OnTakeDamage", thisEntity, "CallScriptFunction","HeadArmorHit", 0, false)
  end
 
  NeckArmor = Entities:FindByModelWithin(nil,"models/armor_neck.vmdl",thisEntity:GetAbsOrigin(),72)
  if NeckArmor ~= nil then
    AddEntityOutput(Player, NeckArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","NeckArmorHit", 0, false)
  end

  function NeckArmorHit()
    Neckhits = Neckhits + 1
    --print("hit Neck")
    if Neckhits == 15 and NeckArmor ~= nil then
      EntFireByHandle(self,NeckArmor,"Kill")
      SetStagger()
    end
  end

  ArmorArmRight1 = Entities:FindByModelWithin(nil,"models/armor_shd_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if ArmorArmRight1 ~= nil then
    AddEntityOutput(Player, ArmorArmRight1, "OnTakeDamage", thisEntity, "CallScriptFunction","ArmorArmRight1Hit", 0, false)
  end
  function ArmorArmRight1Hit()
    ArmorArmRight1Hits = ArmorArmRight1Hits + 1
    --print("hit Rarmup")
    if ArmorArmRight1Hits == 15 and ArmorArmRight1 ~= nil then
      EntFireByHandle(self,ArmorArmRight1,"Kill")
      SetStagger()
    end
  end

  ArmorArmRight2 = Entities:FindByModelWithin(nil,"models/armor_arm_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if ArmorArmRight2 ~= nil then
    AddEntityOutput(Player, ArmorArmRight2, "OnTakeDamage", thisEntity, "CallScriptFunction","ArmorArmRight2Hit", 0, false)
  end
  function ArmorArmRight2Hit()
    ArmorArmRight2Hits = ArmorArmRight2Hits + 1
    --print("hit Rarmlow")
    if ArmorArmRight2Hits == 15 and ArmorArmRight2 ~= nil then
      EntFireByHandle(self,ArmorArmRight2,"Kill")
      SetStagger()
    end
  end
  ArmorArmLeft1 = Entities:FindByModelWithin(nil,"models/armor_shd_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if ArmorArmLeft1 ~= nil then
    AddEntityOutput(Player, ArmorArmLeft1, "OnTakeDamage", thisEntity, "CallScriptFunction","ArmorArmLeft1Hit", 0, false)
  end
  function ArmorArmLeft1Hit()
    ArmorArmLeft1Hits = ArmorArmLeft1Hits + 1
    --print("hit Larmup")
    if ArmorArmLeft1Hits == 15 and ArmorArmLeft1 ~= nil then
      EntFireByHandle(self,ArmorArmLeft1,"Kill")
      SetStagger()
    end
  end

  ArmorArmLeft2 = Entities:FindByModelWithin(nil,"models/armor_arm_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if ArmorArmLeft2 ~= nil then
    AddEntityOutput(Player, ArmorArmLeft2, "OnTakeDamage", thisEntity, "CallScriptFunction","ArmorArmLeft2hit", 0, false)
  end
  function ArmorArmLeft2hit()
    ArmorArmLeft2Hits = ArmorArmLeft2Hits + 1
    --print("hit larmlow")
    if ArmorArmLeft2Hits == 15 and ArmorArmLeft2 ~= nil then
      EntFireByHandle(self,ArmorArmLeft2,"Kill")
      SetStagger()
    end
  end






  Knee1Armor = Entities:FindByModelWithin(nil,"models/armor_knee_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if Knee1Armor ~= nil then
    AddEntityOutput(Player, Knee1Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Knee1ArmorHit", 0, false)
  end
  Knee2Armor = Entities:FindByModelWithin(nil,"models/armor_knee_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if Knee2Armor ~= nil then
    AddEntityOutput(Player, Knee2Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Knee2ArmorHit", 0, false)
  end
  Thigh1Armor = Entities:FindByModelWithin(nil,"models/armor_leg_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh1Armor ~= nil then
    AddEntityOutput(Player, Thigh1Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh1ArmorHit", 0, false)
  end
  Thigh2Armor = Entities:FindByModelWithin(nil,"models/armor_leg_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh2Armor ~= nil then
    AddEntityOutput(Player, Thigh2Armor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh2ArmorHit", 0, false)
  end
  Thigh1SideArmor = Entities:FindByModelWithin(nil,"models/armor_thigh_r.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh1SideArmor ~= nil then
    AddEntityOutput(Player, Thigh1SideArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh1SideArmorHit", 0, false)
  end
  function Thigh1SideArmorHit()
    Thigh1SideArmorHits = Thigh1SideArmorHits + 1
    --print("hit thighside")
    if Thigh1SideArmorHits == 15 and Thigh1SideArmor ~= nil then
      EntFireByHandle(self,Thigh1SideArmor,"Kill")
      SetStagger()
    end
  end
  Thigh2SideArmor = Entities:FindByModelWithin(nil,"models/armor_thigh_l.vmdl",thisEntity:GetAbsOrigin(),72)
  if Thigh2SideArmor ~= nil then
    AddEntityOutput(Player, Thigh2SideArmor, "OnTakeDamage", thisEntity, "CallScriptFunction","Thigh2SideArmorHit", 0, false)
  end
  function Thigh2SideArmorHit()
    Thigh2SideArmorHits = Thigh2SideArmorHits + 1
    --print("hit thighside")
    if Thigh2SideArmorHits == 15 and Thigh2SideArmor ~= nil then
      EntFireByHandle(self,Thigh2SideArmor,"Kill")
      SetStagger()
    end
  end




end

function ChestArmorHit()
  Chesthits = Chesthits + 1
  --print("hit chest")
  if Chesthits == 15 and ChestArmor ~= nil then
    EntFireByHandle(self,ChestArmor,"Kill")
    SetStagger()
  end
end

function HeadArmorHit()
  if HeadBox ~= nil then
    Headhits = Headhits + 1
    --print("hit head")
    if Headhits == 15 and HeadArmor ~= nil then
      EntFireByHandle(self,HeadArmor,"Skin","3",0)
      EntFireByHandle(self,HeadArmor,"DisableCollision","3",0)
      EntFireByHandle(self,HeadBox,"Kill")
      SetStagger()
    end
  end
end

function Knee1ArmorHit()
  Knee1hits = Knee1hits + 1
  --print("hit knee1")
  if Knee1hits == 15 and Knee1Armor ~= nil then
    EntFireByHandle(self,Knee1Armor,"Kill")

    SetStagger()
  end
end

function Knee2ArmorHit()
  --print("hit knee2")
  Knee2hits = Knee2hits + 1
  if Knee2hits == 15 and Knee2Armor ~= nil then
    EntFireByHandle(self,Knee2Armor,"Kill")
 
    SetStagger()
  end
end
function Thigh1ArmorHit()
 -- print("hit Thigh1")
  Thigh1hits = Thigh1hits + 1
  if Thigh1hits == 15 and Thigh1Armor ~= nil then
    EntFireByHandle(self,Thigh1Armor,"Kill")
 
    SetStagger()
  end
end

function Thigh2ArmorHit()
  --print("hit Thigh2")
  Thigh2hits = Thigh2hits + 1
  if Thigh2hits == 15 and Thigh2Armor ~= nil then
    EntFireByHandle(self,Thigh2Armor,"Kill")
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
  thisEntity:EmitSound("ScriptedSeq.DroneLaserLockBreak")
end






function SpawnHP()
  if i == 1 then                                                              --defaults are from campaign+ may not be only vanilla values
    if Difficulty == 3 then ArGrunt:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 2 then ArGrunt:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 1 then ArGrunt:SetHealth(72)  MaxHealth = 70 i = 2 end --default is 56
    if Difficulty == 0 then ArGrunt:SetHealth(36) MaxHealth = 45 i = 2 end --default is 24
  end 
end