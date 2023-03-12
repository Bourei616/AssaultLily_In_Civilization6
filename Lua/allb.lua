-- kill unit and get greatperson points
local m_RoseIndex = GameInfo.Units["UNIT_ROSE"].Index

function roseKillBarbarrain(pCombatResult)

    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]

    local attacker = pCombatResult[CombatResultParameters.ATTACKER]
    local attInfo = attacker[CombatResultParameters.ID]

    local aUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    local dUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

    local aPlayer = Players[attInfo.player]
    local dPlayer = Players[defInfo.player]

    if aUnit ~= nil
    and dUnit ~= nil
	and aPlayer ~= nil
	and dPlayer ~= nil
    and GameInfo.Units[aUnit:GetType()].UnitType == 'UNIT_ROSE'
    and dUnit:IsDelayedDeath() then
        aPlayer:GetGreatPeoplePoints():ChangePointsTotal(5,10);

        local message:string  = Locale.Lookup("LOC_ROSE_GET_GREATPERSON");
        MessageText = message;
        local location = pCombatResult[CombatResultParameters.LOCATION];

        Game.AddWorldViewText(0, MessageText, location.x, location.y);
    end
end

Events.Combat.Add(roseKillBarbarrain);