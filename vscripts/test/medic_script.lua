--Last script was an absolute mess, so hopefully this one is a bit better
require "test/getDifficulty"

local UnitsToHeal = {}
local medic
local maxHealth
local currentHealth
local healthpercentage
local healthvaluetablecritical
local bShouldRun
local flNavGoalTolerance
local flDisttoNPC
local flMinNpcDist

function Spawn()
    thisEntity:SetContextThink(nil, MedicGoHeal, 0)
end

function MedicGoHeal()
    GetMedic()
    if medic:IsAlive() == true then 
        GetUnitsToHeal()
    return .1
    else 
    thisEntity:StopThink("MedicGoHeal")
    end
end

function GetMedic()                                                                                     --Finds the Entity that has the medic script (in this case the closest combine soldier)
    medic = Entities:FindByClassnameNearest("npc_combine_s",thisEntity:GetAbsOrigin(),10)
    --print(medic:GetName())
end

function GetUnitsToHeal()   
    UnitsToHeal = Entities:FindAllByClassnameWithin("npc_combine_s",thisEntity:GetAbsOrigin(),1024)     --Finds combine soldiers in the given radius       
    if UnitsToHeal ~= nil then
        for key, val in pairs(UnitsToHeal) do 
            CheckHealthAndPriority(val, key)    
            --print (#UnitsToHeal)
        end
    end
end




function CheckHealthAndPriority(checker, key)                                                            -- Gets Health Percentage and stores info about health within a table if %health is lower than 75%
    maxHealth = checker:GetMaxHealth()                                                                   -- Stores the index of the entity from the UnitsToHeal table in the healthpercentage table
    currentHealth = checker:GetHealth()
    healthpercentage = currentHealth / maxHealth
    if healthpercentage < 1 then
        healthvaluetablecritical = {}
     
        if healthpercentage < .75 then
            table.insert(healthvaluetablecritical, key, healthpercentage)
            --print(healthvaluetablecritical[key])
            CheckWoundedStatus()
        end
    end
end



function CheckWoundedStatus()                                                                           -- Sorts given health percentages in table and finds the lowest value and outputs the index for that value
    if healthvaluetablecritical ~= nil then
        --print("criticaltable")
        local t = healthvaluetablecritical
        local sorted = {}
        for k,v in pairs(t) do 
            table.insert(sorted,{k,v})
        end
        table.sort(sorted,function(a,b) return a[2] < b[2] end)
        for _, v in ipairs(sorted) do
            --print(v[1])
            uni = tonumber(v[1])
            
            --print(uni)
            CriticalUnit = UnitsToHeal[uni]
            --print(CriticalUnit:GetName())
            GoToHeal()
        end
    end
end

    
function GoToHeal()                                                                                     -- Finds Medic's location and forces Medic to run towards the injured unit
    mediclocation = medic:GetAbsOrigin()
    bShouldRun = true
    flNavGoalTolerance = 25
    flMinNpcDist = 60
    if CriticalUnit:IsAlive() == true then
        --print("gocritical")
        MedicNavigate(CriticalUnit:GetAbsOrigin(),CriticalUnit)
    end
   
end

function MedicNavigate(ORIGIN,NPCNAME)                                                                  -- Medic will run to within 100 units of the unit and then begin healing
    flDisttoNPC = (medic:GetAbsOrigin() - ORIGIN):Length()
    if flDisttoNPC ~= nil and flDisttoNPC <= 100 then
        medic:NpcNavClearGoal()
        MedicHeal(NPCNAME)
    else
        medic:NpcForceGoPosition(ORIGIN, bShouldRun, flNavGoalTolerance)
        return .1
    end
end


function MedicHeal(NPCNAME)                                                                             -- Medic heals npc, signals it is healing, healed npc is taken out of injured state if originally injured.
    medic:SetGraphParameterBool("b_signal",true)
    NPCNAME:SetHealth(NPCNAME:GetHealth() + (NPCNAME:GetMaxHealth()-NPCNAME:GetHealth()) *.8)

    NPCNAME:SetGraphParameterBool("b_injured",false)
    medic:EmitSound("healthstation.complete")
    medic:SetThink(function() return SignalEnder(unitmedic) end, "signal", 5)
    function SignalEnder()
        medic:SetGraphParameter("b_signal",false)
        return nil
    end           
end



