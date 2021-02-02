local Soldier
local player
local roundcounter = 65
local GoalActive = false
function Activate()
    --print("shoot")
    thisEntity:SetThink(SHOOT,"SHOOT",0)
    thisEntity:RegisterAnimTagListener( AnimTagListener )
    ChestArmor = Entities:FindByModelWithin(nil,"models/pl_armor_chest.vmdl",thisEntity:GetAbsOrigin(),72)
end

function AnimTagListener( sTagName, nStatus)
    --print (" AnimTag: ", sTagName, "Status: " , 1)
    if sTagName == "Finished_Signal" and nStatus == 1 then Soldier:SetGraphParameterBool("b_firing",false)
    end
    if sTagName == "finished_stagger" and nStatus == 1 then Soldier:SetGraphParameterBool("b_firing",false)
    end

    if sTagName == "Finished_Reload" and nStatus == 1 then Soldier:SetGraphParameterBool("b_firing",false)
    end
end
function SHOOT()
    Soldier = Entities:FindByClassnameNearest("npc_combine_s",thisEntity:GetAbsOrigin(),10)
    if Soldier ~= nil then
        GoalActive = Soldier:NpcNavGoalActive()
        Injured = Soldier:GetGraphParameter("b_injured")
    -- print(GoalActive)
        if GoalActive == true and Injured == false then 
            SoldierFoundEnemy()
        else

        end
    else
        thisEntity:StopThink("SHOOT")
        end
    return .125
end

function SoldierFoundEnemy()
    if roundcounter >= 0 then
       -- print(roundcounter)
        player = Entities:FindByClassnameWithin(nil,"player",thisEntity:GetAbsOrigin(),1024)
        --print(player)
        if player ~= nil then
            local SoldierEyeOrigin = Soldier:EyePosition() 
            local traceTable = 
            {
                startpos = SoldierEyeOrigin;
                endpos = player:EyePosition();
                ent = player;
                ignore = ChestArmor;
            }

            TraceLine(traceTable)
            if traceTable.enthit == player then
                Soldier:SetGraphLookTarget(player:GetCenter())
            -- DebugDrawLine(traceTable.startpos,traceTable.pos,0,255,0,false,1)
            -- DebugDrawLine(traceTable.pos, traceTable.pos + traceTable.normal * 10, 0, 0, 255, false, 1)
            --  print("foundvalidline")
                Soldier:SetGraphParameterBool("b_firing",true)
                --Soldier:SetGraphParameterBool("b_looktarget_can_use_path",false)
                Shooting = Soldier:GetGraphParameter("b_firing")
                if Shooting == true then
                    roundcounter = roundcounter - 1 
                end
            else
            -- DebugDrawLine(traceTable.startpos, traceTable.endpos, 255, 0, 0, false, 1)    
            -- print("linenotvalid")
            end
        end
        
    else 
        EntFireByHandle(thisEntity,thisEntity,"speakresponseconcept", "COMBINESOLDIER_RELOAD")
        Soldier:SetGraphParameterBool("b_reload", true)
        roundcounter = 65 
        Soldier:SetThink(function() return ReloadTimer() end, "reload", 2)
        function ReloadTimer() Soldier:SetGraphParameterBool("b_reload", false) return nil end  
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