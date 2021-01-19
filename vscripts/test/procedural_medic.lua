
--function Health()

--thisEntity:int GetHealth()


--function MonitorHP()
 -- print ("now checking hp values")
 -- thisEntity:SetContextThink(nil, GruntHealth, 0)
--end

--function GruntHealth()
 -- local HealPriority = 1
 -- local cur_health = thisEntity:GetHealth()
 -- print(cur_health)
 -- print("Health Check")
 --   if (cur_health<=20) then
 --         local HealPriority = 1
 --         print("priority 1")
 --   end
 --   if (cur_health<=65) then
 --     thisEntity:EmitSound("vo.combine.grunt.injured_01")
  --    print("Ouch")
 --   else
  --    print ("I'm fine")
  --  end
 -- return 2
--end






--  Find all grunts on the map, select all of these units and out of them, pick one as a medic
-- Following this get the health of each grunt on the map, and then set them a priority from 1 to 5
-- Highest priority is 1, and then set the medic npc to run to them and "heal" them
-- On a successful heal you hear the health station ping
local combine = nil
local critical = nil 

function Spawn()
  --print ("starting think")
  thisEntity:SetContextThink(nil, MedicSearchFunc, 0)
end

function Activate()
  --print("i am a medic")
  combine = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(), 1024)
  unit1 = combine[1]
  unit2 = combine[2]
  unit3 = combine[3]
  unit4 = combine[4]
  unit5 = combine[5]
  unit6 = combine[6]
  unit1health = unit1:GetHealth()
  unit2health = unit2:GetHealth()
  unit3health = unit3:GetHealth()
  unit4health = unit4:GetHealth()
  unit5health = unit5:GetHealth()
  unit6health = unit6:GetHealth()
  unit1maxhealth = unit1:GetMaxHealth()
  unit2maxhealth = unit2:GetMaxHealth()
  unit3maxhealth = unit3:GetMaxHealth()
  unit4maxhealth = unit4:GetMaxHealth()
  unit5maxhealth = unit5:GetMaxHealth()
  unit6maxhealth = unit6:GetMaxHealth()
  medic = RandomInt(0,5)
  --print(medic)
  if medic == 0 then
   healer = combine[1]
  
  elseif medic == 1 then
     healer = combine[2]
     
  elseif medic == 2 then
     healer = combine[3]
     
  elseif medic == 3 then
     healer = combine[4]
 
  elseif medic ==4 then
     healer = combine[5]
    
  elseif medic ==5 then
    healer = combine[6]
    
  end 
  healer:SetRenderColor(215, 181, 142)
  
end


function MedicSearchFunc()

  --print (unit1, unit2, unit3, unit4, unit5, unit6)

  --print(unit1health, unit2health, unit3health, unit4health, unit5health, unit6health)


  if healer:IsNull() ~= true then
  healerlocation = healer:GetAbsOrigin()
  end
  bShouldRun = true
  flNavGoalTolerance = 60 
  flMinNpcDist = 60

HealthCheck()

 NPCHealthPriority()
  MedicChoice()


  return .1
end



function MedicRuntoUnit()
  if (flDisttoNPC - flMinNpcDist <= 20) then
    healer:NpcNavClearGoal()
    healer:EmitSound("healthstation.complete")
    healer:SetGraphParameter("b_signal",true)






    healer:SetThink(function() return SignalEnder(healer) end, "signal", 3)
       --print("signalling")
  
  

    function SignalEnder(healer)
     healer:SetGraphParameter("b_signal",false)
     --print("signal terminated")
     return nil
    end 

    hurtunit:SetHealth(hurtunitmaxhealth)
    hurtunit:SetGraphParameter("b_injured",false)
  else
  healer:NpcForceGoPosition(critical, bShouldRun, flNavGoalTolerance)
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
  --print (unit1healthpriority, unit2healthpriority, unit3healthpriority, unit4healthpriority, unit5healthpriority, unit6healthpriority)
end


function HealthCheck()

    if unit1:IsNull() ~= true then
      unit1health = unit1:GetHealth()
    end
    if unit2:IsNull() ~= true  then
    unit2health = unit2:GetHealth()
    end


    if unit3:IsNull() ~= true then
    unit3health = unit3:GetHealth()
    end

    if unit4:IsNull() ~= true  then
    unit4health = unit4:GetHealth()
    end


    if unit5:IsNull() ~= true  then
    unit5health = unit5:GetHealth()
    end


    if unit6:IsNull() ~= true  then
    unit6health = unit6:GetHealth()
    end
end

function MedicChoice()
  if (unit1healthpriority <.6) and (unit1:IsNull() ~= true) and healer:IsNull() ~= true then
    critical = unit1:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit1
    hurtunitmaxhealth = unit1maxhealth 
    MedicRuntoUnit()
  end
  if unit2healthpriority <.6 and unit2:IsNull() ~= true and healer:IsNull() ~= true then
    critical = unit2:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit2
    hurtunitmaxhealth = unit2maxhealth
    MedicRuntoUnit()
  end
  if unit3healthpriority <.6 and unit3:IsNull() ~= true and healer:IsNull() ~= true then
    critical = unit3:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit3
    hurtunitmaxhealth = unit3maxhealth
    MedicRuntoUnit()
  end
  if (unit4healthpriority <.6) and (unit4:IsNull() ~= true) and healer:IsNull() ~= true then
    critical = unit4:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit4
    hurtunitmaxhealth = unit4maxhealth
    MedicRuntoUnit()
  end
  if (unit5healthpriority <.6) and (unit5:IsNull() ~= true) and healer:IsNull() ~= true then
    critical = unit5:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit5
    hurtunitmaxhealth = unit5maxhealth
    MedicRuntoUnit()
  end
  if (unit6healthpriority <.6) and (unit6:IsNull() ~= true) and healer:IsNull() ~= true then
    critical = unit6:GetAbsOrigin()
    --print(critical)
    flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
    hurtunit = unit6
    hurtunitmaxhealth = unit6maxhealth
    MedicRuntoUnit()
  end
end



