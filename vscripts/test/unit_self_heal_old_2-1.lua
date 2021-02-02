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



