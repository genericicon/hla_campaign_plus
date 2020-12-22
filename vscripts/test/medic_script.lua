local combine = nil
local critical = nil
local healdelay = 2

function Spawn()
  --print ("starting think")
  thisEntity:SetContextThink(nil, MedicSearchFunc, 0)
end

function Activate()
  --print("i am a medic")
  unitmed = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(), 1)

  combine = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(), 2048)

if unitmed[1] ~= nil then
    unitmedic = unitmed[1]
    unitmedichealth = unitmedic:GetHealth()
    unitmedicmaxhealth = 125
end

if combine[1] ~= nil then
   unit1 = combine[1]
   unit1health = unit1:GetHealth()
   unit1maxhealth = unit1:GetMaxHealth()
end 
 
if combine[2] ~= nil then
  unit2 = combine[2]
  unit2health = unit2:GetHealth()
  unit2maxhealth = unit2:GetMaxHealth()
end 

if combine[3] ~= nil then
  unit3 = combine[3]
  unit3health = unit3:GetHealth()
  unit3maxhealth = unit3:GetMaxHealth()
  end 

if combine[4] ~= nil then
  unit4 = combine[4]
  unit4health = unit4:GetHealth()
  unit4maxhealth = unit4:GetMaxHealth()
  end 

if combine[5] ~= nil then
  unit5 = combine[5]
  unit5health = unit5:GetHealth()
  unit5maxhealth = unit5:GetMaxHealth()
  end 

if combine[6] ~= nil then
  unit6 = combine[6]
  unit6health = unit6:GetHealth()
  unit6maxhealth = unit6:GetMaxHealth()
  end 

if combine[7] ~= nil then
  unit7 = combine[7]
  unit7health = unit7:GetHealth()
  unit7maxhealth = unit7:GetMaxHealth()
  end 

if combine[8] ~= nil then
  unit8 = combine[8]
  unit8health = unit8:GetHealth()
  unit8maxhealth = unit8:GetMaxHealth()
  end 


end


function MedicSearchFunc()
  bShouldRun = true
  flNavGoalTolerance = 25
  flMinNpcDist = 60
  
  --print ("thinking")


  --print (unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unitmedic)

  --print(unit1health, unit2health, unit3health, unit4health, unit5health, unit6health, unit7health, unit8health, unitmedichealth)
if unitmedic ~= nil then
unitmediclocation = unitmedic:GetAbsOrigin()
end


HealthCheck()
 NPCHealthPriority()
  MedicChoice()


  return healdelay
end


function HealthCheck()
  if unitmedic ~= nil and unitmedic:IsNull() ~= true then
  unitmedichealth = unitmedic:GetHealth()
  end
  if unit1 ~= nil and unit1:IsNull() ~= true then
    unit1health = unit1:GetHealth()
  end
  
  if unit2 ~= nil and unit2:IsNull() ~= true then
  unit2health = unit2:GetHealth()
  end


  if unit3 ~= nil and unit3:IsNull() ~= true then
  unit3health = unit3:GetHealth()
  end

  if unit4 ~= nil and unit4:IsNull() ~= true then
  unit4health = unit4:GetHealth()
  end


  if unit5 ~= nil and unit5:IsNull() ~= true then
  unit5health = unit5:GetHealth()
  end
  if unit6 ~= nil and unit6:IsNull() ~= true then
    unit6health = unit6:GetHealth()
  end

  if unit7 ~= nil and unit7:IsNull() ~= true then
    unit7health = unit7:GetHealth()
  end
  if unit8 ~= nil and unit8:IsNull() ~= true then
    unit8health = unit8:GetHealth()
  end
  

  
end


function NPCHealthPriority()
 if unit1health ~= nil then
        unit1healthpriority = unit1health/ (unit1maxhealth)
       end
        if unit2health ~= nil then
        unit2healthpriority = unit2health/ (unit2maxhealth)
        end
        if unit3health ~= nil then
        unit3healthpriority = unit3health/ (unit3maxhealth)
        end
        if unit4health ~= nil then
        unit4healthpriority = unit4health/ (unit4maxhealth)
        end
        if unit5health ~= nil then
        unit5healthpriority = unit5health/ (unit5maxhealth)
        end
        if unit6health ~= nil then
        unit6healthpriority = unit6health/ (unit6maxhealth)
        end
        if unit7health ~= nil then
          unit7healthpriority = unit7health/ (unit7maxhealth)
        end
        if unit8health ~= nil then
          unit8healthpriority = unit8health/ (unit8maxhealth)
        end
        if unitmedichealth ~= nil then
        unitmedichealthpriority = unitmedichealth/ (unitmedicmaxhealth)
        end
 -- print (unit1healthpriority, unit2healthpriority, unit3healthpriority, unit4healthpriority, unit5healthpriority, unit6healthpriority, unit7healthpriority, unit8healthpriority, unitmedichealthpriority)
end

function MedicChoice()
  if (unit1healthpriority ~=nil and unit1healthpriority <.7) and (unit1 ~= nil and unit1:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit1:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit1
    hurtunitmaxhealth = unit1maxhealth * 1.2
    MedicRuntoUnit()
  end
  if unit2healthpriority ~=nil and unit2healthpriority <.7 and (unit2 ~= nil and unit2:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit2:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit2
    hurtunitmaxhealth = unit2maxhealth * 1.2
    MedicRuntoUnit()
  end
  if unit3healthpriority ~=nil and unit3healthpriority <.7 and (unit3 ~= nil and unit3:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit3:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit3
    hurtunitmaxhealth = unit3maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unit4healthpriority ~=nil and unit4healthpriority <.7) and (unit4 ~= nil and unit4:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit4:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit4
    hurtunitmaxhealth = unit4maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unit5healthpriority ~=nil and unit5healthpriority <.7) and (unit5 ~= nil and unit5:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit5:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit5
    hurtunitmaxhealth = unit5maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unit6healthpriority ~=nil and unit6healthpriority <.7) and (unit6 ~= nil and unit6:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit6:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit6
    hurtunitmaxhealth = unit6maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unit7healthpriority ~=nil and unit7healthpriority <.7) and (unit7 ~= nil and unit7:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit7:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit7
    hurtunitmaxhealth = unit7maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unit8healthpriority ~=nil and unit8healthpriority <.7) and (unit8 ~= nil and unit8:IsNull() ~= true) and unitmedic ~= nil then
    critical = unit8:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unit8
    hurtunitmaxhealth = unit8maxhealth * 1.2
    MedicRuntoUnit()
  end
  if (unitmedichealthpriority ~=nil and unitmedichealthpriority <.7) and (unitmedic ~= nil and unitmedic:IsNull() ~= true ) and unitmedic ~= nil then
    critical = unitmedic:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (unitmedic:GetAbsOrigin() - critical ):Length()
    hurtunit = unitmedic
    hurtunitmaxhealth = unitmedicmaxhealth 
    MedicRuntoUnit()
  end
end

function MedicRuntoUnit()
  if (flDisttoNPC <= 80) then
    unitmedic:NpcNavClearGoal()
    unitmedic:EmitSound("healthstation.complete")
    unitmedic:SetGraphParameter("b_signal",true)
    unitmedic:SetThink(function() return SignalEnder(unitmedic) end, "signal", 3)
      function SignalEnder(unitmedic)
        unitmedic:SetGraphParameter("b_signal",false)
        return nil
      end 
    hurtunit:SetHealth(hurtunitmaxhealth)
    hurtunit:SetGraphParameter("b_injured",false)
    healdelay = healdelay + 2
    
  else
    unitmedic:NpcForceGoPosition(critical, bShouldRun, flNavGoalTolerance)
    return .1
  end 
  
end






