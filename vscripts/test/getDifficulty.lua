Difficulty = 0 

function Spawn()
    thisEntity:SetContextThink(nil,CheckDifficulty,0)
end

function CheckDifficulty()
    Difficulty = Convars:GetFloat("skill")
end

