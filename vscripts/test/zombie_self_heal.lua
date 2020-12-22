
function Spawn()
    thisEntity:SetContextThink(nil, SelfHeal, 0)
end

function Activate()
  heals = 2
  healdelay = 1
  unit = Entities:FindAllByClassnameWithin("npc_zombie",thisEntity:GetAbsOrigin(), 1)
  if unit[1] ~= nil then
    thisunit = unit[1]
    thisunithealth = thisunit:GetHealth()
    thisunitmaxhealth = 100
  end
end 

function SelfHeal()
  if unit[1] ~= nil and heals ~= 0 then
  HealthCheck()
  else 
    thisunit:EmitSound("campaignplus.hlazombine_medic") 
    thisunit:EmitSound("HealthPen.Fail")
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
  thisunit:EmitSound("campaignplus.hlazombine_stimdose") 
  thisunit:EmitSound("HealthPen.Success01")
  thisunit:SetGraphParameter("b_swat",true)
  thisunit:SetThink(function() return SignalEnder(thisunit) end, "b_swat", 1.5)
  --print("signalling")
      function SignalEnder(thisunit)
   
        thisunit:SetGraphParameter("b_swat",false)
       --print("signal terminated")
      
       return nil
      end 
  
  thisunit:SetHealth(thisunitmaxhealth)
  heals = heals - 1
  healdelay = healdelay + 1
  --print(heals)
    
end

