function Spawn()
    thisEntity:SetContextThink(nil, SelfHeal, 0)
end

function Activate()
  heals = 2
  healdelay = 2
  unit = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(), 1)
  if unit[1] ~= nil then
    thisunit = unit[1]
    thisunithealth = thisunit:GetHealth()
    thisunitmaxhealth = 125
  end
end 

function SelfHeal()
  if unit[1] ~= nil and heals ~= 0 then
  HealthCheck()
  else thisunit:EmitSound("HealthPen.Fail")
    return nil
  end
    return healdelay
end


function HealthCheck()
  thisunithealth = thisunit:GetHealth()
  if thisunit ~= nil and thisunit:IsNull() ~= true then
    percenthealth = (thisunithealth/thisunitmaxhealth)
    --print(percenthealth)
  end 
  if percenthealth < .55 then
    BeginHeal()
  end
end 

function BeginHeal()

  thisunit:EmitSound("HealthStation.Start")
  thisunit:SetGraphParameter("b_signal",true)
  thisunit:SetThink(function() return SignalEnder(thisunit) end, "signal", 1.5)
  --print("signalling")
      function SignalEnder(thisunit)
   
        thisunit:SetGraphParameter("b_signal",false)
       --print("signal terminated")
      
       return nil
      end 
  
  thisunit:SetHealth(thisunitmaxhealth)
  thisunit:SetGraphParameter("b_injured",false)
  heals = heals - 1
  healdelay = healdelay + 5
  --print(heals)
    
end