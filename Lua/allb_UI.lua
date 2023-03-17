if ExposedMembers.AL == nil then ExposedMembers.AL = {}; end
ExposedMembers.GameEvents = GameEvents

function GetNextPlot(iPlayerID, iCityID)
	local pCity = CityManager.GetCity(iPlayerID, iCityID);
	local iPlot = -1;
	if pCity ~= nil and pCity:GetCulture() ~= nil then
		iPlot = pCity:GetCulture():GetNextPlot();
        print("iPlot is"..iPlot)
	end
	return iPlot;
end
ExposedMembers.AL.GetNextPlot = GetNextPlot

function KaedeGovernorHasPomotion(iPlayerID)
	local pPlayer = Players[iPlayerID];
	local pGovernors = pPlayer:GetGovernors();
	local pGovernor = pGovernors:GetGovernor(GameInfo.Governors["GOVERNOR_AL_KAEDE"].Index);
	if pGovernor:HasPromotion(GameInfo.GovernorPromotions["GOVERNOR_PROMOTION_AL_KAEDE_5"].Hash) then
		print("success" )
		return true;
	else
		print("false")
		return false;
	end
end
ExposedMembers.AL.KaedeGovernorHasPomotion = KaedeGovernorHasPomotion

-- 百合丘音效

-- complete
function RiriPlayerTurnActivated(playerID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	print("PlayerTurnDeactivated2")
	UI.PlaySound("RiriCityCommandStarted")
end

-- complete
function RiriCityBuilt(playerID, cityID, iX, iY)
	print("CityBuilt")
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	print("CityBuilt")
	UI.PlaySound("RiriCityBuilt")
end



-- complete
function RiriGovernorAppointedYuyu(playerID, governorID, ePromotion)
	print("RiriGovernorAppointedYuyu")
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_1'].Index then return; end
	print("RiriGovernorAppointedYuyu")
	UI.PlaySound("RiriGovernorAppointedYuyu")
end

function RiriDistrictPillaged(playerID, districtID, cityID, iX, iY, districtType, percentComplete, isPillaged)
	print("RiriDistrictPillaged")
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	print("RiriDistrictPillaged")
	UI.PlaySound("RiriDistrictPillaged")
end

-- complete
function RiriGovernorPromotedYuyu2(playerID, governorID, ePromotion)
	print("RiriGovernorPromotedYuyu2")
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_2'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedYuyu2")
end

-- complete
function RiriGovernorPromotedYuyu3(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_3'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedYuyu3")
end

-- complete
function RiriGovernorPromotedYuyu4(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_4'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedYuyu4")
end

-- complete
function RiriGovernorPromotedYuyu5(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_5'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedYuyu5")
end

-- complete
function RiriGovernorPromotedYuyu6(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_YUYU'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_YUYU_6'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedYuyu6")
end

-- complete
function RiriGovernorAppointedKAEDE(playerID, governorID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_1'].Index then return; end
	UI.PlaySound("RiriGovernorAppointedKAEDE")
end

-- complete
function RiriGovernorPromotedKAEDE2(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_2'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedKAEDE2")
end

-- complete
function RiriGovernorPromotedKAEDE3(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_3'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedKAEDE3")
end


-- complete
function RiriGovernorPromotedKAEDE4(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_4'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedKAEDE4")
end

-- complete
function RiriGovernorPromotedKAEDE5(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_5'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedKAEDE5")
end

-- complete
function RiriGovernorPromotedKAEDE6(playerID, governorID, ePromotion)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or governorID ~= GameInfo.Governors['GOVERNOR_AL_KAEDE'].Index 
	or ePromotion ~= GameInfo.GovernorPromotions['GOVERNOR_PROMOTION_AL_KAEDE_6'].Index then return; end
	UI.PlaySound("RiriGovernorPromotedKAEDE6")
end

-- complete
function RiriImprovementAddedToMap(iX, iY, eImprovement, playerID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or eImprovement ~= GameInfo.Improvements['IMPROVEMENT_AL_QUAN'].Index then return; end
	UI.PlaySound("RiriImprovementAddedToMap")
end

-- complete
function FumiUnitGreatPersonActivated(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
	if greatPersonIndividualID ~= GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_AL_LILY_FUMI'].Index then return; end
	UI.PlaySound("FumiUnitGreatPersonActivated")
end

-- complete
function RiriResearchCompleted(playerID, iCivic)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	UI.PlaySound("RiriResearchCompleted")
end

-- complete
function RiriCivicCompleted(playerID, eTech, bCancelled)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	UI.PlaySound("RiriCivicCompleted")
end

function RiriPlayerEraChanged1(playerID, eraID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" 
	or eraID  ~= GameInfo.Eras['ERA_CLASSICAL'].Index then return; end
	UI.PlaySound("RiriPlayerEraChanged1")
end

-- complete
function RiriWonderCompleted(iX, iY, buildingIndex, playerID, cityID, iPercentComplete, iUnknown)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_YURIGAOKA"
	and iPlayerConfig:GetLeaderTypeName() == "LEADER_AL_RIRI" then
		UI.PlaySound("RiriWonderCompleted")
	end
end

-- complete
function FumiGreatUnitAddedToMapRiri(playerID, unitID)
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI"
	or pUnit:GetGreatPerson():GetIndividual() ~= GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_AL_LILY_FUMI'].Index then return; end
	UI.PlaySound("FumiGreatUnitAddedToMapRiri")
end

-- complete
function RiriUnitKilledInCombat(playerID, killedUnitID, iplayerID, unitID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_YURIGAOKA"
	or iPlayerConfig:GetLeaderTypeName() ~= "LEADER_AL_RIRI" then return; end
	UI.PlaySound("RiriUnitKilledInCombat")
end

function RiriPantheonFounded(playerID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_YURIGAOKA"
	and iPlayerConfig:GetLeaderTypeName() == "LEADER_AL_RIRI" then
		UI.PlaySound("RiriPantheonFounded")
	end
end

function RiriReligionFounded(playerID, religionID)
	local iPlayerConfig = PlayerConfigurations[playerID];
	if iPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_YURIGAOKA"
	and iPlayerConfig:GetLeaderTypeName() == "LEADER_AL_RIRI" then
		UI.PlaySound("RiriReligionFounded")
	end
end

function FumiGreatSelected( playerID : number, unitID : number, hexI : number, hexJ : number, hexK : number, bSelected : boolean, bEditable : boolean )
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local iPlayerConfig = PlayerConfigurations[playerID];

	if pUnit:GetGreatPerson():GetIndividual() ~= GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_AL_LILY_FUMI'].Index 
	or bSelected == false then return; end
	UI.PlaySound("FumiGreatSelected")
end
Events.UnitKilledInCombat.Add(RiriUnitKilledInCombat);
Events.UnitAddedToMap.Add(FumiGreatUnitAddedToMapRiri);
Events.WonderCompleted.Add(RiriWonderCompleted);
Events.PlayerEraChanged.Add(RiriPlayerEraChanged1);
Events.UnitGreatPersonActivated.Add(FumiUnitGreatPersonActivated);
Events.ImprovementAddedToMap.Add(RiriImprovementAddedToMap);
Events.GovernorPromoted.Add(RiriGovernorPromotedKAEDE6);
Events.GovernorPromoted.Add(RiriGovernorPromotedKAEDE5);
Events.GovernorPromoted.Add(RiriGovernorPromotedKAEDE4);
Events.CityAddedToMap.Add(RiriCityBuilt);
Events.PlayerTurnDeactivated.Add(RiriPlayerTurnActivated);
Events.DistrictPillaged.Add(RiriDistrictPillaged);

Events.GovernorPromoted.Add(RiriGovernorAppointedYuyu);

Events.GovernorPromoted.Add(RiriGovernorPromotedYuyu2);
Events.GovernorPromoted.Add(RiriGovernorPromotedKAEDE2);

Events.CivicCompleted.Add(RiriCivicCompleted);
Events.ResearchCompleted.Add(RiriResearchCompleted);


Events.GovernorPromoted.Add(RiriGovernorAppointedKAEDE);
Events.GovernorPromoted.Add(RiriGovernorPromotedYuyu3);
Events.GovernorPromoted.Add(RiriGovernorPromotedYuyu4);
Events.GovernorPromoted.Add(RiriGovernorPromotedYuyu5);
Events.GovernorPromoted.Add(RiriGovernorPromotedYuyu6);
Events.GovernorPromoted.Add(RiriGovernorPromotedKAEDE3);

Events.PantheonFounded.Add(RiriPantheonFounded);
Events.ReligionFounded.Add(RiriReligionFounded);

Events.UnitSelectionChanged.Add(FumiGreatSelected);

