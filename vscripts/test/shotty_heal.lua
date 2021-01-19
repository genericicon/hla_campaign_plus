require "test/getDifficulty"

local heals = 2
local healdelay = 1
local i = 1

CheckDifficulty()

function Spawn()
  thisEntity:SetContextThink(nil,UnitSelfHeal, 0)
end

function Activate()
  --print("armored" ..Difficulty)
end

function UnitSelfHeal()

ShGrunt = Entities:FindByClassnameNearest("npc_combine_s",thisEntity:GetAbsOrigin(),0)
SpawnHP()
--print("ShottyGrunt")
  if ShGrunt:IsAlive() == true and heals ~= 0 then
  CheckHP()
    else ShGrunt:EmitSound("HealthPen.Fail")
      thisEntity:StopThink("UnitSelfHeal")
      return nil
    end
      return healdelay 
end   
  
 
function CheckHP()
  CurHealth = ShGrunt:GetHealth()
  PerHealth = CurHealth/MaxHealth
    --print(PerHealth)
    if PerHealth < .55 then
      BeginHeal()
    end
end

function BeginHeal()
  ShGrunt:EmitSound("HealthStation.Start")
  ShGrunt:SetGraphParameter("b_signal",true)
  ShGrunt:SetThink(function() return SignalEnder(ShGrunt) end, "signal", 1.5)
      function SignalEnder(ShGrunt)
        ShGrunt:SetGraphParameterBool("b_signal",false)
        return nil
      end 
  ShGrunt:SetHealth(MaxHealth)
  ShGrunt:SetGraphParameterBool("b_injured",false)
  heals = heals - 1
  healdelay = healdelay + 5
end



function SpawnHP()
  if i == 1 then                                                              --defaults are from campaign+ may not be only vanilla values
    if Difficulty == 3 then ShGrunt:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 2 then ShGrunt:SetHealth(100) MaxHealth = 100 i = 2 end --default is 80
    if Difficulty == 1 then ShGrunt:SetHealth(72)  MaxHealth = 70 i = 2 end --default is 56
    if Difficulty == 0 then ShGrunt:SetHealth(36) MaxHealth = 45 i = 2 end --default is 24
  end 
end