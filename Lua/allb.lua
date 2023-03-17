-- kill unit and get greatperson points
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

function YurigaokaGetLilyGreats(playerID, unitID, greatPersonClassID, greatPersonIndividualID)
    local pPlayer = Players[playerID];
    local pPlayerConfig = PlayerConfigurations[playerID];
    if (pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_YURIGAOKA") then
        local iEra = GameInfo.Eras[GameInfo.GreatPersonIndividuals[greatPersonIndividualID].EraType].Hash
        local iGreatPersonBaseCost = GameInfo.Eras[iEra].GreatPersonBaseCost
        if (greatPersonClassID == GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index)then
            local iCost = iGreatPersonBaseCost/3;
            pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index,iCost);
        else
            local iCost = iGreatPersonBaseCost/6;
            pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index,iCost);
        end
    end
end

function GardenRemoveTribe(PlotX, PlotY, eOwner)
    local pPlayer = Players[eOwner]
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local pPlot = Map.GetPlot(PlotX, PlotY)

        if pPlot:IsUnit() then
            for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                if(unit ~= nil) then
                    if unit then
                        print("unit is"..unit:GetOwner())
                        local iPlayerID = unit:GetOwner()
                        local iPlayer = Players[iPlayerID];
                        local iPlayerConfig = PlayerConfigurations[iPlayerID];
                        if (iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA") then return; end
                        local playerCities = iPlayer:GetCities();
                        for i, city in playerCities:Members() do

                            print("city is"..city:GetID())
                            local iCityID = city:GetID()

                            local iNextPlot = ExposedMembers.AL.GetNextPlot(iPlayerID, iCityID)

                            local aPlot = Map.GetPlotByIndex(iNextPlot);

                            if aPlot and aPlot:GetOwner() < 0 then
                                WorldBuilder.CityManager():SetPlotOwner(aPlot, city)
                                local message:string  = Locale.Lookup("LOC_AL_GETBACKPLOT");
                                MessageText = message;
                                Game.AddWorldViewText(0, MessageText, aPlot:GetX(), aPlot:GetY());
                            end
                        end
                    end
                end
            end
        end
    end
end

function KaedeGetBoost (playerID, unitID, greatPersonClassID, greatPersonIndividualID)
    if ExposedMembers.AL.KaedeGovernorHasPomotion(playerID) == true
    and greatPersonClassID == GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index then
        local pPlayer = Players[playerID]
        local pTech = pPlayer:GetTechs();
        local atech = pTech:GetResearchingTech();
        pTech :TriggerBoost(atech)
    end
end

Events.Combat.Add(roseKillBarbarrain);
Events.UnitGreatPersonCreated.Add(YurigaokaGetLilyGreats);
Events.UnitGreatPersonCreated.Add(KaedeGetBoost);
Events.ImprovementRemovedFromMap.Add(GardenRemoveTribe);