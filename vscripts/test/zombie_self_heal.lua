require "test/getDifficulty"

local heals = 2
local healdelay = 1
local i = 1

CheckDifficulty()

function Spawn()
  thisEntity:SetContextThink(nil,UnitSelfHeal, 0)
end

function Activate()
  --print("zombie" ..Difficulty)
end

function UnitSelfHeal()

shzomb = Entities:FindByClassnameNearest("npc_zombie",thisEntity:GetAbsOrigin(),0)
SpawnHP()
--print("ShottyZombie")
  if shzomb:IsAlive() == true and heals ~= 0 then
  CheckHP()
    else shzomb:EmitSound("campaignplus.hlazombine_medic")
      thisEntity:StopThink("HealthPen.Fail")
      return nil
    end
      return healdelay 
end   
  
 
function CheckHP()
  CurHealth = shzomb:GetHealth()
  PerHealth = CurHealth/MaxHealth
    --print(PerHealth)
    if PerHealth < .55 then
      BeginHeal()
    end
end

function BeginHeal()
  shzomb:EmitSound("campaignplus.hlazombine_stimdose")
  shzomb:SetGraphParameter("b_swat",true)
  shzomb:SetThink(function() return SignalEnder(shzomb) end, "b_swat", 1.5)
      function SignalEnder(shzomb)
        shzomb:SetGraphParameterBool("b_swat",false)
        return nil
      end 
  shzomb:SetHealth(MaxHealth)
  heals = heals - 1
  healdelay = healdelay + 5
end



function SpawnHP()
  if i == 1 then                                                              --defaults are from campaign+ may not be only vanilla values
    if Difficulty == 3 then shzomb:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 2 then shzomb:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 1 then shzomb:SetHealth(72)  MaxHealth = 70 i = 2 end --default is 56
    if Difficulty == 0 then shzomb:SetHealth(36) MaxHealth = 45 i = 2 end --default is 24
  end 
end