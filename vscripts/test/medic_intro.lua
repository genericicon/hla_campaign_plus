
function Spawn()
    --print ("starting think")
    thisEntity:SetContextThink(nil, MedicSearchFunc, 0)
  end
  
  function Activate()
    --print("i am a medic")
    combine = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(), 1024)
   
   
    unit1 = combine[1]
    hunit = combine[2]
    healer = unit1
    unit2health = hunit:GetHealth()
   
    unit2maxhealth = hunit:GetMaxHealth()
  end 
    function MedicSearchFunc()
        if healer:IsNull() ~= true then
        healerlocation = healer:GetAbsOrigin()
        end
        bShouldRun = true
        flNavGoalTolerance = 25 
        flMinNpcDist = 40
      
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







    function HealthCheck()

 
        if hunit:IsNull() ~= true  then
        unit2health = hunit:GetHealth()
        end
    end 


    function NPCHealthPriority()
      
         if unit2health ~= nil then
         unit2healthpriority = unit2health/ (unit2maxhealth)
        
         end
    end 
    function MedicChoice()
       
        if unit2healthpriority <.6 and hunit:IsNull() ~= true and healer:IsNull() ~= true then
          critical = hunit:GetAbsOrigin()
          --print(critical)
          flDisttoNPC = (healer:GetAbsOrigin() - critical ):Length()
          hurtunit = hunit
          hurtunitmaxhealth = unit2maxhealth
          MedicRuntoUnit()
        end
    end 