

-- Taken from Epic's Github https://github.com/PeterSHollander/glorious_gloves/blob/master/scripts/vscripts/a1_intro_world_transition_fix.lua
-- Edited so it would work properly for me at least



function Activate ()

    --print("Replacing problematic level change with addon map command...")

    local problem = Entities:FindByName(nil, "*command_change_level*")
    UTIL_Remove(problem)
    --print("problem killed")
    local relay = Entities:FindByName(nil, "*relay_button_press*")
   -- print(relay)
    AddEntityOutput(relay, "OnTrigger", thisEntity, "CallScriptFunction", "ChangeLevel", "40","1")

    --print("Done.")

end



function ChangeLevel ()
    print("removed")
    SendToConsole("addon_play a1_intro_world_2")
    
end

function AddEntityOutput (outputEntity, outputName, outputTarget, action, parameter, delay, fireOnce)
    
    parameter = parameter or ""
    delay = delay or 0
    fireOnce = fireOnce or false
    
    local maxTimesToFire = -1 if fireOnce then maxTimesToFire = 1 end

    local target
    if type(outputTarget) == "string" then
        target = outputTarget
    else
        target = outputTarget:GetName()
        if target == "" then
            target = UniqueString()
            outputTarget:SetEntityName(target)
        end
    end
    
    local output = outputName ..">".. target ..">".. action ..">".. parameter ..">".. delay ..">".. maxTimesToFire
    EntFireByHandle(outputEntity, outputEntity, "AddOutput", output)

end