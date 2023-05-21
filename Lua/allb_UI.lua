include("PopupDialog");
if ExposedMembers.AL == nil then ExposedMembers.AL = {}; end

function AlPopupMoyuProjectComplete(success,i)
	local popup = PopupDialogInGame:new("UnitCaptured")
	if success == true then
		popup:AddTitle(Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_SUCCESS'))
	else
		popup:AddTitle(Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_FAILED'))
	end
	local message = Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_COMPLETE')
	local effect = Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_'..i..'_NAME')
	local fullmessage = message..'[NEWLINE]'..effect
	popup:AddText(fullmessage)
	popup:AddDefaultButton(Locale.Lookup("LOC_BUILDING_AL_VISUAL_MOYU_BUTTON"),  function() end );
	popup:Open();
end
ExposedMembers.AL.AlPopupMoyuProjectComplete = AlPopupMoyuProjectComplete

function AlPopupMoyuCDComplete(i)
	local popup = PopupDialogInGame:new("UnitCaptured")
	popup:AddTitle(Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_CD_TITLE'))
	local message = Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_CD_TEXT')
	local effect = Locale.Lookup('LOC_BUILDING_AL_VISUAL_MOYU_'..i..'_NAME')
	local fullmessage = message..'[NEWLINE]'..effect
	popup:AddText(fullmessage)
	popup:AddDefaultButton(Locale.Lookup("LOC_BUILDING_AL_VISUAL_MOYU_BUTTON"),  function() end );
	popup:Open();
end
ExposedMembers.AL.AlPopupMoyuCDComplete = AlPopupMoyuCDComplete



local MaxNeunWeltNumber = 10;
local HEX_COLORING_MOVEMENT = UILens.CreateLensLayerHash("Hex_Coloring_Movement");
local HEX_COLORING_ATTACK = UILens.CreateLensLayerHash("Hex_Coloring_Attack");

local m_IsInWBInterfaceMode = false;
local CurrentAction = nil;
local m_bInfoShown = false

function ExecuteScript(name, ...)
	local kParameters = {}
	local i = 1
	kParameters['OnStart'] = 'AlExecuteScript'
	kParameters['Name'] = name
	for _, value in ipairs({...}) do
		kParameters["misc"..i] = value
		i = i + 1
	end
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParameters)
end


function GetAllLilyUnits(playerID)
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    local units = {}
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            table.insert(units,unit:GetID())
        end
    end
    return units
end


function ALRSSelected(playerID, unitID, x, y, hexK, bSelected, bEditable)
	if bSelected then
		local hide,rs,name = AlRsHide(playerID, unitID)
		if hide or rs == nil then
			Controls.AlRareSkillGrid:SetHide(hide)
		else
			local pPlayer = Players[playerID]
			Controls.AlRareSkillGrid:SetHide(hide)

			local disabled, reason,turn = IsAlRsDisabled(playerID, unitID)
			Controls.AlRareSkillButton:SetDisabled(disabled)
			
			local title = Locale.Lookup('LOC_RS_NAME_'..rs,'[ICON_RS_'..rs..']')
			local baseeffect = Locale.Lookup('LOC_RS_EFFECT_'..rs,'[ICON_RS_'..rs..']')
			local effect = Locale.Lookup('LOC_RS_EFFECT_'..name,'[ICON_RS_'..rs..']')
			local message = title..'[NEWLINE]'..baseeffect..effect..Locale.Lookup('LOC_RS_CD','[ICON_RS_'..rs..']',pPlayer:GetProperty(name..'_rs_cd'))
			Controls.AlRareSkillButton:SetToolTipString(message)
			Controls.AlRareSkillImage:SetIcon('ICON_RS_'..rs);

			if disabled then
				message = message..'[NEWLINE]'..reason
				if turn > 0 then
					message = message..turn
				end
				Controls.AlRareSkillButton:SetToolTipString(message)
			end
			Controls.AlRareSkillButton:RegisterCallback(Mouse.eLClick,

			function()
				local pUnit = UnitManager.GetUnit(playerID,unitID)
				ExecuteScript('ALChangeResource',playerID,GameInfo.Resources["RESOURCE_AL_MAGI"].Index,-10)
				if rs == 'Laplace' then
					ExecuteScript('AlRsLaplace',playerID, unitID, x, y)
				end
				if rs == 'LunaticTranser' then
					ExecuteScript('AlRsLunatora',playerID, unitID, x, y)
				end

				ExecuteScript('AlRsTrigger',playerID, unitID)

				local message = Locale.Lookup(pUnit:GetName())..Locale.Lookup("LOC_RS_USE")..Locale.Lookup("LOC_RS_NAME_"..rs)
				ExecuteScript('ALShowPromiseMessage',0, message, pUnit:GetX() ,pUnit:GetY())
				UI.DeselectUnit( pUnit );
				local unitname = string.match(pUnit:GetName(), "(%u+)_GREATNORMAL_NAME")
				
				UI.PlaySound(unitname.."UnitGreatPersonActivated")
				UI.PlaySound(rs)
			end)
		end
	end
end
Events.UnitSelectionChanged.Add(ALRSSelected);
function IsAlRsDisabled(playerID, unitID)
	local pPlayer = Players[playerID]
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
	local rs = nil
	if pName then
		rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
	end
	if pPlayer:GetProperty('rs_cd_'..pName) then
		local cdturn = pPlayer:GetProperty('rs_cd_'..pName)
		local nowturn = Game.GetCurrentGameTurn()
		local RsCooldownTurn = pPlayer:GetProperty(pName..'_rs_cd')
		if nowturn - cdturn < RsCooldownTurn then
			local rsflag = pPlayer:GetProperty('rs_start_'..pName)
			local rscd = pPlayer:GetProperty(pName..'_rs_time')
			if rsflag and rsflag >=1 and rsflag <= rscd then
				local remainturn = rscd - rsflag + 1
				return true,Locale.Lookup('LOC_RS_REMAINING','[ICON_RS_'..rs..']')..remainturn..Locale.Lookup('LOC_RS_COOLING','[ICON_RS_'..rs..']'),RsCooldownTurn - nowturn + cdturn
			else
				return true,Locale.Lookup('LOC_RS_COOLING','[ICON_RS_'..rs..']'),RsCooldownTurn - nowturn + cdturn
			end
		end
	end
	local amount = pPlayer:GetResources():GetResourceAmount(GameInfo.Resources['RESOURCE_AL_MAGI'].Index)
	if amount < 10 then
		return true,Locale.Lookup('LOC_RS_NO_MAGI','[ICON_RS_'..rs..']'),0
		
	end
	return false,nil,0
end

function AlRsHide(playerID, unitID)
	local pPlayer = Players[playerID]
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
	if pName == nil then return true,nil;end
	for row in GameInfo.AL_GreatUnitNames() do
		local name = row.UnitName
		local rs = nil
		if name == pName and row.RareSkill ~= nil then
			rs = row.RareSkill
			return false,rs,name
		end
	end
	return true,nil,nil;
end

function ALLilyInformationSelected(playerID, unitID, x, y, hexK, bSelected, bEditable)
	if bSelected then
		local pPlot = Map.GetPlot(x, y)
		local pUnit = UnitManager.GetUnit(playerID, unitID);

		local hide,combat,cd,breaklevel,breakpoint,cdtime = ALLilyInformationHide(playerID, unitID, x, y)


		if hide then
			Controls.AlLilyInformationGrid:SetHide(hide)
		else
			Controls.AlLilyInformationGrid:SetHide(hide)
			local tooltip = Locale.Lookup('LOC_AL_LILY_INFORMATION_TOOLTIP')
			local tip1 = '[NEWLINE]・'..Locale.Lookup('LOC_AL_LILY_INFORMATION_COMBAT')..combat
			local tip2 = '[NEWLINE]・'..Locale.Lookup('LOC_AL_LILY_INFORMATION_CD')..cd
			local tip3 = '[NEWLINE]・'..Locale.Lookup('LOC_AL_CHARM_BROKEN_'..breaklevel)
			local tip4 = '[NEWLINE]・'..Locale.Lookup('LOC_AL_LILY_INFORMATION_REPAIRPOINT')..breakpoint
			local tip5 = '[NEWLINE]・'..Locale.Lookup('LOC_AL_LILY_INFORMATION_CDTIME')..cdtime
			local message = tooltip..tip1..tip2..tip3..tip4..tip5

			Controls.AlLilyInformationButton:SetToolTipString(message)
			Controls.AlLilyInformationButton:RegisterCallback(Mouse.eLClick,

			function()
				local name = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
				if m_bInfoShown then
					m_bInfoShown = false
					Controls.AlLilyInformationButton:SetSelected(false)
					AlQuitPassInterface(true)
				else
					m_bInfoShown = true
					local rs = GameInfo.AL_GreatUnitNames[name].RareSkill
        			if name and rs == 'Phantasm' then
						UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
						UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
						CurrentAction = 'CHECK_PHANTASM_PLOT'
						Controls.AlLilyInformationButton:SetSelected(true)

						local targetplots = Map.GetNeighborPlots(x, y, 10)
						local selectedPlots = {}
						for i,plot in ipairs(targetplots) do
							if plot:GetProperty('PHANTASM_PLOT') == 1 then
								local iPlotIndex = plot:GetIndex()
								table.insert(selectedPlots, iPlotIndex)
							end
						end
						if #selectedPlots > 0 then
							UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, playerID, selectedPlots)
							UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
						end
					end
				end
			end)
		end
	end
end
Events.UnitSelectionChanged.Add(ALLilyInformationSelected);






function ALLilyInformationHide(playerID, unitID, x, y)
	local pPlayer = Players[playerID]
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
	if pName == nil then return true,-1,-1,-1,-1,-1;end
	local combatproperty = pPlayer:GetProperty(pName..'_neunwelt_combat')
	local cdproperty = pPlayer:GetProperty(pName..'_neunwelt_cd')

	local breakproperty = pPlayer:GetProperty(pName..'_charm_break_level')
	if breakproperty == nil then
		ExecuteScript('ALSetPropertyFlag',playerID,pName..'_charm_break_level',4)
		breakproperty = 4;
	end

	local breakpointproperty = pPlayer:GetProperty(pName..'repair_turn')
	if breakpointproperty == nil then
		ExecuteScript('ALSetPropertyFlag',playerID,pName..'repair_turn',0)
		breakpointproperty = 0;
	end

	local nowcdproperty = pUnit:GetProperty(pName..'_neunwelt_cooldown_turn')
	if nowcdproperty == nil then
		nowcdproperty = 0;
	else
		local nowturn = Game.GetCurrentGameTurn()
		local cdtime = nowturn - nowcdproperty
		if cdtime < 10 then
			nowcdproperty = cdtime
		else
			nowcdproperty = 0
		end
	end
	return false,combatproperty,cdproperty,breakproperty,breakpointproperty,nowcdproperty;
end

function GetNextPlot(iPlayerID, iCityID)
	local pCity = CityManager.GetCity(iPlayerID, iCityID);
	local iPlot = -1;
	if pCity ~= nil and pCity:GetCulture() ~= nil then
		iPlot = pCity:GetCulture():GetNextPlot();
	end
	return iPlot;
end
ExposedMembers.AL.GetNextPlot = GetNextPlot

function HasGovernorPomotion(iPlayerID,governor,number)
	local pPlayer = Players[iPlayerID];
	local pGovernors = pPlayer:GetGovernors();
	if pGovernors:GetGovernor(GameInfo.Governors[governor].Index) == nil then return false; end
	local pGovernor = pGovernors:GetGovernor(GameInfo.Governors[governor].Index);
	if pGovernor:HasPromotion(GameInfo.GovernorPromotions['PROMOTION_'..governor..'_'..number].Hash) then
		return true;
	else
		return false;
	end
end
ExposedMembers.AL.HasGovernorPomotion = HasGovernorPomotion

function GetGovernorTurnsToEstablish(iPlayerID,governor)
	local pPlayer = Players[iPlayerID];
	local pGovernors = pPlayer:GetGovernors();
	if pGovernors:GetGovernor(GameInfo.Governors[governor].Index) == nil then return false; end
	local pGovernor = pGovernors:GetGovernor(GameInfo.Governors[governor].Index);
	local turn = pGovernor:GetTurnsToEstablish()
	return turn;
end
ExposedMembers.AL.GetGovernorTurnsToEstablish = GetGovernorTurnsToEstablish

function GetTourism(playerID)
	local pPlayer = Players[playerID]
	local num = pPlayer:GetStats():GetTourism()
	return num
end
ExposedMembers.AL.GetTourism = GetTourism

function UIPlayersound(string)
	UI.PlaySound(string)
end
ExposedMembers.AL.UIPlayersound = UIPlayersound
function ALPlayerTurnDeactivated(playerID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	if string.match(iPlayerConfig:GetLeaderTypeName(), "(_AL_)") == nil then return; end
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
	UI.PlaySound(name.."PlayerTurnDeactivated")
end

function ALCityBuilt(playerID, cityID, iX, iY)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	if string.match(iPlayerConfig:GetLeaderTypeName(), "(_AL_)") == nil then return; end
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
	UI.PlaySound(name.."CityBuilt")
end

function ALDistrictPillaged(playerID, districtID, cityID, iX, iY, districtType, percentComplete, isPillaged)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	if string.match(iPlayerConfig:GetLeaderTypeName(), "(_AL_)") == nil then return; end
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
	UI.PlaySound(name.."DistrictPillaged")
end

function ALPantheonFounded(playerID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
		UI.PlaySound(name.."PantheonFounded")
end

function ALReligionFounded(playerID, religionID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
		UI.PlaySound(name.."ReligionFounded")
end

function ALGovernorPromoted(playerID, governorID, ePromotion)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	if string.match(iPlayerConfig:GetLeaderTypeName(), "(_AL_)") == nil then return; end
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")
	local govername = string.match(GameInfo.Governors[governorID].Name, "AL_(%u+)")
	if govername then
		local number = string.match(GameInfo.GovernorPromotions[ePromotion].Name, govername.."_(%d+)")
		UI.PlaySound(name.."GovernorPromoted"..govername..number)
	end
end

function ALImprovementAddedToMap(iX, iY, eImprovement, playerID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	if string.match(GameInfo.Improvements[eImprovement].Name, "AL_(%u+)") == nil then return; end
	local iPlayerConfig = PlayerConfigurations[playerID];
	local name = string.match(iPlayerConfig:GetLeaderTypeName(), "LEADER_AL_(%u+)")

	if eImprovement == GameInfo.Improvements['IMPROVEMENT_AL_QUAN'].Index then
		UI.PlaySound(name.."ImprovementAddedToMap")
	end
end

function ALUnitGreatPersonActivated(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
	if unitOwner ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(unitOwner, unitID);
	if string.match(pUnit:GetName(), "(%u+)_NAME") == nil then return; end
	local unitname = string.match(pUnit:GetName(), "(%u+)_NAME")
	UI.PlaySound(unitname.."UnitGreatPersonActivated")
end

function ALGreatSelected( playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if bSelected then
		if pUnit:GetGreatPerson():IsGreatPerson() and pUnit:GetGreatPerson():GetClass() == GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_AL_LILY'].Index then
			local name = string.match(pUnit:GetName(), "(%u+)_NAME")
			UI.PlaySound(name.."GreatSelected")
			ExecuteScript('ALSetPropertyFlag',playerID,'KANBA_GREAT_X',hexI)
			ExecuteScript('ALSetPropertyFlag',playerID,'KANBA_GREAT_Y',hexJ)
		end
	else
		ExecuteScript('ALSetPropertyFlag',playerID,'KANBA_GREAT_X',nil)
		ExecuteScript('ALSetPropertyFlag',playerID,'KANBA_GREAT_Y',nil)
	end
end

function ALUnitSelected( playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if bSelected == false then return; end
	if string.match(pUnit:GetName(), "(%u+)_GREATNORMAL_NAME") == nil then return; end
	local name = string.match(pUnit:GetName(), "(%u+)_GREATNORMAL_NAME")

	if GameInfo.Units[pUnit:GetType()].UnitType ~= GameInfo.Units["UNIT_AL_"..name.."_GREATNORMAL"].UnitType then return; end
	if pUnit:GetProperty(name..'has_ball') == nil or pUnit:GetProperty(name..'has_ball') == 0 then
		UI.PlaySound(name.."GreatSelected")
	elseif pUnit:GetProperty(name..'has_ball') == 1 then
		UI.PlaySound(name.."Fast")
	elseif pUnit:GetProperty(name..'has_ball') > 1 and pUnit:GetProperty(name..'has_ball') < 8 then
		UI.PlaySound(name.."GreatGetBall")
	elseif pUnit:GetProperty(name..'has_ball') == 9 then
		UI.PlaySound(name.."GreatGetBallLast")
	end
end

function ALNekoUnitSelected( playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if bSelected == false then return; end
	if string.match(pUnit:GetName(), "(AL_NEKO)") == nil then return; end
	UI.PlaySound("NEKOGreatSelected")
end

function ALNekoUnitPromoted(playerID,unitID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if string.match(pUnit:GetName(), "(AL_NEKO)") == nil then return; end
	UI.PlaySound("NEKOGreatPromoted")
end

function ALUnitPromoted(playerID,unitID)
	if playerID ~= Game.GetLocalPlayer() then return; end
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if string.match(pUnit:GetName(), "(%u+)_GREATNORMAL_NAME") == nil then return; end
	local name = string.match(pUnit:GetName(), "(%u+)_GREATNORMAL_NAME")
	if name == 'YURI' then return; end
	if GameInfo.Units[pUnit:GetType()].UnitType ~= GameInfo.Units["UNIT_AL_"..name.."_GREATNORMAL"].UnitType then return; end
	UI.PlaySound(name.."GreatPromoted")
end

function ALOhakaRetreat(playerID, unitID)
	local pPlayer = Players[playerID];
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
	if unitname == nil then return;end

	if pPlayer:GetProperty('PROJECT_AL_OHAKA_4_FLAG') == 1 then
		ExecuteScript('ALHealUnits',playerID, unitID ,-30)
	end
	if pPlayer:GetProperty('PROJECT_AL_OHAKA_5_FLAG') == 1 then
		ExecuteScript('ALUnitsRestoreMove',playerID, unitID)
	end
	if pPlayer:GetProperty('PROJECT_AL_OHAKA_6_FLAG') == 1 then
		local characd = pPlayer:GetProperty(unitname..'_neunwelt_cd')
		local cdturn = pUnit:GetProperty(unitname..'_neunwelt_cooldown_turn')
		local nowturn = Game.GetCurrentGameTurn()
		if cdturn == nil then return;end
		local time = nowturn - cdturn
		if time < characd then
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'_neunwelt_cooldown_turn', nowturn - characd)
		end
	end
end
ExposedMembers.AL.ALOhakaRetreat = ALOhakaRetreat

function ALGetTribeIndex(PlotIndex)
	local pPlot = Map.GetPlotByIndex(PlotIndex)
	for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
		if unit and Players[unit:GetOwner()]:IsBarbarian() == true then
			return unit:GetBarbarianTribeIndex();
		end
	end
end
ExposedMembers.AL.ALGetTribeIndex = ALGetTribeIndex



function ALCheckCityBuilding(city,building)
	local buildings = city:GetBuildings();
	if buildings and  buildings:HasBuilding(GameInfo.Buildings['BUILDING_AL_'..building].Index) then
		return true;
	else
		return false;
	end
end

function AlGetALUnitsInCity(city)
	local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(city)
	local units = {}
	for _, iPlotIndex in ipairs(pCityPlots) do
		local pPlot = Map.GetPlotByIndex(iPlotIndex)
		for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
			if unit and string.match(GameInfo.Units[unit:GetType()].UnitType, "(_AL_)") then
				local unitid = unit:GetID()
				table.insert(units, unitid)
			end
		end
	end
	return units;
end

function AlGetALNekoUnitsInCity(PlayerID,cityID)
	local pCity = CityManager.GetCity(PlayerID, cityID)
	local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(pCity)
	local units = {}
	if pCityPlots == nil then return;end
	for _, iPlotIndex in ipairs(pCityPlots) do
		local pPlot = Map.GetPlotByIndex(iPlotIndex)
		for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
			if unit and string.match(GameInfo.Units[unit:GetType()].UnitType, "(NEKO)") then
				local unitid = unit:GetID()
				table.insert(units, unitid)
			end
		end
	end
	return units;
end

function AlCheckGreatUnitInCity(PlayerID,cityID,pName)
	local pCity = CityManager.GetCity(PlayerID, cityID)
	local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(pCity)
	if pCityPlots == nil then return;end
	for _, iPlotIndex in ipairs(pCityPlots) do
		local pPlot = Map.GetPlotByIndex(iPlotIndex)
		for _, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
			if unit and string.match(GameInfo.Units[unit:GetType()].UnitType, pName) then
				return true;
			end
		end
	end
	return false;
end
ExposedMembers.AL.AlCheckGreatUnitInCity = AlCheckGreatUnitInCity

function AlCheckCityHasNeko(PlayerID,cityID)
	local units = AlGetALNekoUnitsInCity(PlayerID,cityID)
	if units == nil then print('AlCheckCityHasNeko:Units is Nil!') return;end
	if #units > 0 then
		local MaxLevel = 0;
		local NekoLevel = 0;
		for _,unitid in ipairs(units) do
			local pUnit = UnitManager.GetUnit(PlayerID, unitid)
			print('AlCheckCityHasNeko:'..PlayerID, unitid)
			local ue = pUnit:GetExperience()
			if ue:HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_NEKO_1'].Index) then
				NekoLevel = NekoLevel + 1
				print('AlCheckCityHasNeko1:NekoLevel is '..NekoLevel)
			end
			if ue:HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_NEKO_3'].Index) then
				NekoLevel = NekoLevel + 1
				print('AlCheckCityHasNeko2:NekoLevel is '..NekoLevel)
			end
		end
		if NekoLevel >= MaxLevel then
			MaxLevel = NekoLevel;
		end
		print('AlCheckCityHasNeko3:NekoLevel is '..MaxLevel)
		return 1,MaxLevel
	else
		return 0,0
	end
end
ExposedMembers.AL.AlCheckCityHasNeko = AlCheckCityHasNeko

function AlNekoUnitsPromote(PlayerID,cityID)
	local pCity = CityManager.GetCity(PlayerID, cityID)
	local units = AlGetALNekoUnitsInCity(PlayerID,cityID)
	for _,unitID in ipairs(units) do
		ExecuteScript('AlNekoUnitsSetPromote',PlayerID,unitID)
		print('AlNekoUnitsPromote: Set!')
	end
end
ExposedMembers.AL.AlNekoUnitsPromote = AlNekoUnitsPromote

function ALOnTurnStartCityUnits(playerID,misc1)
	if IsLilyCivilization(playerID) == false then return;end
	local pPlayer = Players[playerID]

	local playerCities = pPlayer:GetCities();
	print('ALOnTurnStartCityUnits:1');
	for i, city in playerCities:Members() do

		if ALCheckCityBuilding(city,'KOUNAI_ONSEN') then
			local units = AlGetALUnitsInCity(city)
			local heal = -10;
			local i = 1;
			while i <= 4 do
				if pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_'..i..'_FLAG') then
					if pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_'..i..'_FLAG') == 1 then
						heal = heal - 10
					end
				end
				i = i + 1;
			end
			for j,unitid in ipairs(units) do
				ExecuteScript('ALHealUnits',playerID, unitid,heal)
			end
		end

		if ALCheckCityBuilding(city,'OHAKA') or ALCheckCityBuilding(city,'SAKURA') then
			local units = AlGetALUnitsInCity(city)
			for j,unitid in ipairs(units) do
				ExecuteScript('ALUnitsEarnMove',playerID, unitid,2)
			end
		end

	end
	print('ALOnTurnStartCityUnits:2');
end
ExposedMembers.AL.ALOnTurnStartCityUnits = ALOnTurnStartCityUnits
Events.PlayerTurnActivated.Add(ALOnTurnStartCityUnits);

local ALTrainningTable = {}
ALTrainningTable[1] = {name = 'AL_TRAINNING_TAKANOME'}
ALTrainningTable[2] = {name = 'AL_TRAINNING_LUNATIC'}
ALTrainningTable[3] = {name = 'AL_TRAINNING_PHANTOSM'}
ALTrainningTable[4] = {name = 'AL_TRAINNING_TESTAMENT'}
ALTrainningTable[5] = {name = 'AL_TRAINNING_HELIOSPHERE'}
ALTrainningTable[6] = {name = 'AL_TRAINNING_PHASE'}
ALTrainningTable[7] = {name = 'AL_TRAINNING_CHARISMA'}
ALTrainningTable[8] = {name = 'AL_TRAINNING_HAKARIME'}
ALTrainningTable[9] = {name = 'AL_TRAINNING_KOTOWARI'}
ALTrainningTable[10] = {name = 'AL_TRAINNING_SYUKUCHI'}
ALTrainningTable[11] = {name = 'AL_TRAINNING_UBER'}
ALTrainningTable[12] = {name = 'AL_TRAINNING_REGISTER'}

function ALPromiseButtonSetUp()
	local path1 = '/InGame/UnitPanel/StandardActionsStack'
	local path2 = '/InGame/CityPanel/ActionStack'

	local ctrl1 = ContextPtr:LookUpControl(path1)
	local ctrl2 = ContextPtr:LookUpControl(path2)


	if ctrl1 ~= nil then
		Controls.AlPromiseGrid:ChangeParent(ctrl1)
		Controls.AlNeunweltStartGrid:ChangeParent(ctrl1)
		Controls.AlFinishShotGrid:ChangeParent(ctrl1)
		Controls.AlPassGrid:ChangeParent(ctrl1)
		Controls.AlLilyInformationGrid:ChangeParent(ctrl1)
		Controls.AlRareSkillGrid:ChangeParent(ctrl1)
		Controls.AlTeleportGrid:ChangeParent(ctrl1)
	end

	if ctrl2 ~= nil then
		Controls.AlCityInfomation:ChangeParent(ctrl2)
	end
end


function SetCityValuesAL(playerID, cityID)
	if playerID ~= Game.GetLocalPlayer() then
		return
	end
	AlRefreshCityInfomation(playerID, cityID)
end
Events.CitySelectionChanged.Add(SetCityValuesAL)

function AlRefreshCityInfomation()
	if IsAlCityInfomationButtonHide(playerID, cityID) then
		Controls.AlCityInfomation:SetHide(true)
	else
		Controls.AlCityInfomation:SetHide(false)
		
		local disabled, reason = IsAlCityInfomationButtonDisabled(playerID, cityID)
		Controls.AlCityInfomationButton:SetDisabled(disabled)
		
		local tooltip = Locale.Lookup('LOC_AL_INFORMATION_TITLE')
		if disabled then
			Controls.AlCityInfomationButton:SetToolTipString(tooltip .. '[NEWLINE]' .. reason)
		else
			Controls.AlCityInfomationButton:SetToolTipString(tooltip .. '[NEWLINE]' .. reason)
			Controls.AlCityInfomationButton:RegisterCallback(Mouse.eLClick, OnAlCityInfomationButtonClicked)
		end
	
	end
end

function IsAlCityInfomationButtonHide(playerID, cityID)
	local pPlayer = Players[playerID];
	local pCity = CityManager.GetCity(playerID, cityID);
	if ALCheckCityBuilding(pCity,'TRAINING') or ALCheckCityBuilding(pCity,'AREA_DEFENSE') then
		return false;
	else
		return true;
	end
end


function IsAlCityInfomationButtonDisabled(playerID, cityID)
	local pPlayer = Players[playerID];
	local pCity = CityManager.GetCity(playerID, cityID);
	local Districts = pCity:GetDistricts();
	if ALCheckCityBuilding(pCity,'TRAINING') and ALCheckCityBuilding(pCity,'AREA_DEFENSE') == false then
		local garden = Districts:GetDistrict(GameInfo.Districts['DISTRICT_AL_GARDEN'].Index)
		local plot = Map.GetPlot(garden:GetX(),garden:GetY())
		local message = Locale.Lookup('LOC_AL_INFORMATION_TITLE2')
		for i,property in ipairs(ALTrainningTable) do
			if plot:GetProperty(ALTrainningTable[i].name) == 1 then
				message = message..'[NEWLINE]'..'・'..Locale.Lookup('LOC_NAME_ABILITY_'..ALTrainningTable[i].name)
			end
		end
		message = message..'[NEWLINE][COLOR:Red]'..Locale.Lookup('LOC_AL_NO_AREA_DEFENSE')..'[ENDCOLOR]'
		return true, message
	end

	if ALCheckCityBuilding(pCity,'TRAINING') == false and ALCheckCityBuilding(pCity,'AREA_DEFENSE') then
		local message = Locale.Lookup('LOC_AL_INFORMATION_RANGE_CHECK')
		return false, message
	end

	if ALCheckCityBuilding(pCity,'TRAINING') and ALCheckCityBuilding(pCity,'AREA_DEFENSE') then
		local garden = Districts:GetDistrict(GameInfo.Districts['DISTRICT_AL_GARDEN'].Index)
		local plot = Map.GetPlot(garden:GetX(),garden:GetY())
		local message = Locale.Lookup('LOC_AL_INFORMATION_TITLE2')
		for i,property in ipairs(ALTrainningTable) do
			if plot:GetProperty(ALTrainningTable[i].name) == 1 then
				print('IsAlCityInfomationButtonDisabled: GET ABILITY:'..Locale.Lookup('LOC_NAME_ABILITY_'..ALTrainningTable[i].name))
				message = message..'[NEWLINE]'..'・'..Locale.Lookup('LOC_NAME_ABILITY_'..ALTrainningTable[i].name)
			end
		end
		message = message..'[NEWLINE]'..Locale.Lookup('LOC_AL_INFORMATION_RANGE_CHECK')
		return false, message
	end
end

function OnAlCityInfomationButtonClicked()
	local pCity	 = UI.GetHeadSelectedCity();
	local iPlayer = pCity:GetOwner()
	local iCityX = pCity:GetX()
	local iCityY = pCity:GetY()
	local pPlot = Map.GetPlot(iCityX, iCityY)
	if iPlayer ~= Game.GetLocalPlayer() then
		return
	end
	if m_IsInWBInterfaceMode then
		AlQuitPassInterface(true)
	else
		UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
		UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
		m_IsInWBInterfaceMode = true
		CurrentAction = 'CHECK_AREA_DEFENSE'
		Controls.AlCityInfomationButton:SetSelected(true)
		local selectablePlots = AlGetPlotsAreaDefense(pPlot, 20, iPlayer)
		if #selectablePlots > 0 then
			--print("set plot color")
			UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, iPlayer, selectablePlots)

			UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
		end
	end
end

function AlGetPlotsAreaDefense(pPlot,range, iPlayer)
	local pPlayer = Players[iPlayer]
	local AreaDeffenseLevel = pPlayer:GetProperty('AreaDeffenseLevel')
	local selectedPlots = {}
	local DefensePlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), range)
	for _,plot in ipairs(DefensePlots) do
		if plot:GetProperty('area_deffense_flag_'..AreaDeffenseLevel) == 1 then
			local iPlotIndex = plot:GetIndex()
			table.insert(selectedPlots, iPlotIndex)
		end
	end
	return selectedPlots;
end

function ALPromiseGetNameOrderModifier(firstname,secondname,PromiseLevel)
	local nameorder;
	if GameInfo.Modifiers['MOD_AL_PROMISE_'..firstname..'_'..secondname..'_1_1'] then
		nameorder = firstname..'_'..secondname
		return nameorder,firstname,secondname;
	elseif GameInfo.Modifiers['MOD_AL_PROMISE_'..secondname..'_'..firstname..'_1_1'] then
		nameorder = secondname..'_'..firstname
		return nameorder,secondname,firstname;
	else
		return nil;
	end
end

function ALGetNameOrder(playerID, x, y, pUnit)
	local firstname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	local adjPlots = Map.GetAdjacentPlots(x, y)
	local secondnames = {}
	for _, plot in ipairs(adjPlots) do
		for loop, unit in ipairs(Units.GetUnitsInPlot(plot)) do
			if unit and string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
				local maysecondname = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
				table.insert(secondnames, maysecondname)
			end
		end
	end
	return secondnames;
end

function OnAlPromiseButtonClicked(playerID, x, y, pUnit)
	local firstname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");

	local secondnames = ALGetNameOrder(playerID, x, y, pUnit)

	local pPlayer = Players[playerID]

	local secondname = secondnames[1]
	local PromiseLevel = pPlayer:GetProperty('player_promise_level')

	local nameorder,oneName,twoName = ALPromiseGetNameOrderModifier(firstname,secondname,PromiseLevel)
	local cpLevel = 0
		
	if pPlayer:GetProperty(nameorder..'_PROMISE_FLAG') == nil then
		ExecuteScript('ALUnitsEarnMove',playerID,nameorder..'_PROMISE_FLAG',0)
		cpLevel = 0
	else
		cpLevel = pPlayer:GetProperty(nameorder..'_PROMISE_FLAG')
	end

	if nameorder == 'TADUSA_RIRI' and cpLevel == 2 then
		ExecuteScript('ALSetPropertyFlag',playerID,nameorder..'_PROMISE_FLAG',cpLevel + 1)
		ExecuteScript('AlChangePointsTotal',playerID)
		AlPromiseShowMessage(nameorder,x,y,cpLevel + 1,pUnit)
		ExecuteScript('SetPromiseLevelToUnits',playerID,oneName,1)
		ExecuteScript('SetPromiseLevelToUnits',playerID,twoName,1)
		return;
	end
	if nameorder == 'SHENLIN_YUJIA' and cpLevel == 1 then
		ExecuteScript('ALSetPropertyFlag',playerID,nameorder..'_PROMISE_FLAG',cpLevel + 1)
		local cityID = AlGetPlotCityOwner(playerID,x,y)
		ExecuteScript('AlCityAttachModifier',playerID,cityID,'BUFF_AL_PROMISE_SHENLIN_YUJIA_2_1')
		AlPromiseShowMessage(nameorder,x,y,cpLevel + 1,pUnit)
		ExecuteScript('SetPromiseLevelToUnits',playerID,oneName,1)
		ExecuteScript('SetPromiseLevelToUnits',playerID,twoName,1)
		return;
	end
	if cpLevel < PromiseLevel then
		ExecuteScript('SetPromiseLevelToUnits',playerID,oneName,1)
		ExecuteScript('SetPromiseLevelToUnits',playerID,twoName,1)
		AlPromiseSetModifier(pPlayer,playerID,nameorder,cpLevel + 1,pUnit, x, y)
		ExecuteScript('ALChangeResource',playerID,GameInfo.Resources["RESOURCE_AL_MAGI"].Index,-30)
	end
end

function AlPromiseSetModifier(pPlayer,playerID,nameorder,PromiseLevel, pUnit, x, y)
	if pPlayer:GetProperty(nameorder..'_PROMISE_FLAG') ~= nil then
		ExecuteScript('ALAttachModifier',playerID, 'MOD_AL_PROMISE_'..nameorder..'_'..PromiseLevel)
		ExecuteScript('ALSetPropertyFlag',playerID,nameorder..'_PROMISE_FLAG',PromiseLevel)
		AlPromiseShowMessage(nameorder,x,y,PromiseLevel,pUnit)

		if PromiseLevel == 3 then
			ExecuteScript('AlSetNeunweltCombat',playerID,2,oneName,'combat')
			ExecuteScript('AlSetNeunweltCombat',playerID,2,twoName,'combat')
			ExecuteScript('AlSetNeunweltCombat',playerID,-1,oneName,'cd')
			ExecuteScript('AlSetNeunweltCombat',playerID,-1,twoName,'cd')
		end
	end
end

function AlPromiseShowMessage(nameorder,x,y,PromiseLevel,pUnit)
	local promisemessage = Locale.Lookup('LOC_MOD_AL_PROMISE_'..nameorder..'_SUCCESS');
	ExecuteScript('ALShowPromiseMessage',0, promisemessage, x, y)
	UI.PlaySound(nameorder.."PromiseVoice")
	UI.DeselectUnit( pUnit );
	print('AlPromiseSetModifier:'..nameorder..'_PROMISE_FLAG '..PromiseLevel..' SCUCCESS!')
end

function ALPromiseSelected(playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if bSelected then
		print(hexI,hexJ)
		local pPlot = Map.GetPlot(hexI, hexJ)
		local pUnit = UnitManager.GetUnit(playerID, unitID);
		if ALPromiseHide(playerID, unitID, hexI, hexJ) == true then
			Controls.AlPromiseGrid:SetHide(true)
		else
			Controls.AlPromiseGrid:SetHide(false)
			local disabled, reason = IsALPromiseButtonDisabled(playerID, hexI, hexJ, pUnit)
			Controls.AlPromiseButton:SetDisabled(disabled)
			local tooltip = Locale.Lookup('LOC_AL_PROMISE_TOOLTIP')
			if disabled then
				Controls.AlPromiseButton:SetToolTipString(tooltip .. '[NEWLINE][COLOR:Red]' .. reason .. '[ENDCOLOR]')
			else
				--print("not disabled")
				Controls.AlPromiseButton:SetToolTipString(tooltip .. '[NEWLINE]' .. reason )
				Controls.AlPromiseButton:RegisterCallback(Mouse.eLClick, function() OnAlPromiseButtonClicked(playerID, hexI, hexJ, pUnit); end)
			end
		end
	end
end

function IsALPromiseButtonDisabled(playerID, hexI, hexJ, pUnit)
	local firstname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	local secondnames = ALGetNameOrder(playerID, hexI, hexJ, pUnit)
	local pPlayer = Players[playerID]
	local amount = pPlayer:GetResources():GetResourceAmount(GameInfo.Resources['RESOURCE_AL_MAGI'].Index)

	if #secondnames > 1 then
		local toomanymessage = Locale.Lookup("LOC_MOD_AL_PROMISE_TOO_MANY_PERSON");
		return true, toomanymessage;

	elseif #secondnames < 1 then
		local needmessage = Locale.Lookup("LOC_MOD_AL_PROMISE_"..firstname.."_NEEDS");
		return true, needmessage;

	elseif amount < 30 then
		local magimessage = Locale.Lookup("LOC_MOD_AL_PROMISE_NO_MAGI");
		return true, magimessage;

	else
		local secondname = secondnames[1]
		local PromiseLevel = pPlayer:GetProperty('player_promise_level')

		local nameorder,oneName,twoName = ALPromiseGetNameOrderModifier(firstname,secondname,PromiseLevel)

		if nameorder == nil then
			local needmessage = Locale.Lookup("LOC_MOD_AL_PROMISE_"..firstname.."_NEEDS");
			return true, needmessage;
		end

		if pPlayer:GetProperty(nameorder..'_PROMISE_FLAG') == PromiseLevel then
			local promisedmessage = Locale.Lookup("LOC_MOD_AL_PROMISE_HAS_PROMISE");
			return true, promisedmessage;
		end

		local cplevel = 1

		if pPlayer:GetProperty(nameorder..'_PROMISE_FLAG') ~= nil then
			cplevel = pPlayer:GetProperty(nameorder..'_PROMISE_FLAG') + 1
		end

		local promisemessage = Locale.Lookup('LOC_MOD_AL_PROMISE_'..nameorder..'_'..cplevel..'_EFFECT');
		if cplevel == 3 then
			promisemessage = promisemessage..Locale.Lookup('LOC_MOD_AL_PROMISE_LEVEL3');
		end
		return false, promisemessage
	end
end

function ALPromiseHide(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ);
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local district = pPlot:GetDistrictType()
	if string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == nil
	or district == -1
	or AlGetPlotCity(playerID, pPlot) ~= true then
		return true;
	elseif district ~= -1 and GameInfo.Districts[district].DistrictType ~= 'DISTRICT_AL_GARDEN' then
		return true;
	elseif string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == 'YURI' then
		return true;
	end
end

function AlGetPlotCity(playerID, pPlot)
	local cities = Players[playerID]:GetCities()
	for _, city in cities:Members() do
		local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(city)
		for _, iPlotIndex in pairs(pCityPlots) do
			if iPlotIndex == pPlot:GetIndex() and ALCheckCityBuilding(city,'PROMISE') then
				return true;
			end
		end
	end
end

function AlGetPlotCityOwner(playerID, x,y)
	local cities = Players[playerID]:GetCities()
	local pPlot = Map.GetPlot(x,y)
	for _, city in cities:Members() do
		local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(city)
		for _, iPlotIndex in pairs(pCityPlots) do
			if iPlotIndex == pPlot:GetIndex() then
				return city:GetID();
			end
		end
	end
end
ExposedMembers.AL.AlGetPlotCityOwner = AlGetPlotCityOwner

function UnitInArsenal(PlayerID,x,y)
	local cities = Players[PlayerID]:GetCities()
	local pPlot = Map.GetPlot(x,y)

	for _, city in cities:Members() do
		local pCityPlots = Map.GetCityPlots():GetPurchasedPlots(city)
		for _, iPlotIndex in pairs(pCityPlots) do
			if iPlotIndex == pPlot:GetIndex() and ALCheckCityBuilding(city,'ARSENAL') then
				local targetPlots = Map.GetNeighborPlots(x, y, 1)
				for _,plot in ipairs(targetPlots) do
					if plot:GetDistrictType() ~= -1 then
						if GameInfo.Districts[plot:GetDistrictType()].DistrictType == 'DISTRICT_AL_GARDEN' then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end
ExposedMembers.AL.UnitInArsenal = UnitInArsenal


function PromiseInitialize()
    local players = Game.GetPlayers()
	for _,player in ipairs(players) do
		local playerID = player:GetID()
		if IsLilyCivilization(playerID) then
			if player:GetProperty('player_promise_level') == nil then
				ExecuteScript('ALSetPropertyFlag',playerID,'player_promise_level', 1)
				print('SET PROMISE LEVEL FOR PLAYER '..playerID)
			end
		end
	end
end


Events.UnitGreatPersonActivated.Add(ALUnitGreatPersonActivated);
Events.ImprovementAddedToMap.Add(ALImprovementAddedToMap);
Events.GovernorPromoted.Add(ALGovernorPromoted);
Events.CityAddedToMap.Add(ALCityBuilt);
Events.PlayerTurnDeactivated.Add(ALPlayerTurnDeactivated);
Events.DistrictPillaged.Add(ALDistrictPillaged);
Events.PantheonFounded.Add(ALPantheonFounded);
Events.ReligionFounded.Add(ALReligionFounded);
Events.UnitSelectionChanged.Add(ALGreatSelected);
Events.UnitSelectionChanged.Add(ALUnitSelected);
Events.UnitPromoted.Add(ALUnitPromoted);
Events.UnitSelectionChanged.Add(ALNekoUnitSelected);
Events.UnitPromoted.Add(ALNekoUnitPromoted);
Events.LoadGameViewStateDone.Add(ALPromiseButtonSetUp);
Events.UnitSelectionChanged.Add(ALPromiseSelected);
Events.LoadGameViewStateDone.Add(PromiseInitialize)


--————————————NeunweltStart————————————

function ALNeunweltSelected(playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if bSelected then
		ALNeunweltRefresh(playerID, unitID, hexI, hexJ)
	end
end

Events.UnitSelectionChanged.Add(ALNeunweltSelected);

function ALNeunweltRefresh(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ)
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if ALNeunweltHide(playerID, unitID, hexI, hexJ) == true then
		Controls.AlNeunweltStartGrid:SetHide(true)
	else
		Controls.AlNeunweltStartGrid:SetHide(false)
		local disabled, reason = IsALNeunweltDisabled(playerID, pUnit)
		Controls.AlNeunweltStartButton:SetDisabled(disabled)
		local tooltip = Locale.Lookup('LOC_AL_NEUNWELT_TOOLTIP')
		if disabled then
			Controls.AlNeunweltStartButton:SetToolTipString(tooltip .. '[NEWLINE][COLOR:Red]' .. reason .. '[ENDCOLOR]')
		else
			--print("not disabled")
			Controls.AlNeunweltStartButton:SetToolTipString(tooltip .. '[NEWLINE]' .. reason )
			Controls.AlNeunweltStartButton:RegisterCallback(Mouse.eLClick, function() OnAlNeunweltClicked(playerID, hexI, hexJ, pUnit, unitID); end)
		end
	end
end

function ALNeunweltHide(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ);
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local resource = GameInfo.Resources["RESOURCE_AL_NEUNWELT"].Index
	local amount = Players[playerID]:GetResources():GetResourceAmount(resource)

	if string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == nil
	or amount < 1 then
		return true;
	else
		local IsHasBall = pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball')
		if IsHasBall ~= nil then
			if IsHasBall > 0 and IsHasBall < 10 then
				return true;
			end
		end
		if string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == 'YURI' and Players[playerID]:GetProperty('YURI_ALIVE') == nil then
			return true;
		end
	end
	return false;
end

function IsALNeunweltDisabled(playerID, pUnit)
	local pPlayer = Players[playerID]
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	local turn = Game.GetCurrentGameTurn();
	local ballnumber = 0;

	if pUnit:GetProperty(unitname..'_neunwelt_cooldown_turn') then
		local cd = pPlayer:GetProperty(unitname..'_neunwelt_cd')
		if turn - pUnit:GetProperty(unitname..'_neunwelt_cooldown_turn') < cd then
			local cooldownturns = cd - turn + pUnit:GetProperty(unitname..'_neunwelt_cooldown_turn')
			local cooldownmessage = Locale.Lookup("LOC_MOD_AL_UNIT_NEUNWELT_COOLING_DOWN");
			local fullmessage = cooldownmessage..cooldownturns
			return true, fullmessage;
		end
	end

	if pPlayer:GetProperty(unitname..'_charm_break_level') then
		if pPlayer:GetProperty(unitname..'_charm_break_level') <=2 then
			local message = Locale.Lookup("LOC_MOD_AL_UNIT_NEUNWELT_CHARM_BROKEN");
			return true, message;
		end
	end

	local i = 1;
	while i < MaxNeunWeltNumber + 1 do
		local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
		if magisphere.started == 1 then
			ballnumber = ballnumber + 1;
		end
		i = i + 1;
	end

	if ballnumber >= MaxNeunWeltNumber then
		local maxmessage = Locale.Lookup("LOC_MOD_AL_PLAYER_NEUNWELT_MAX");
		return true, maxmessage;
	end
	
	local effectmessage = Locale.Lookup('LOC_MOD_AL_UNIT_NEUNWELT_EFFECT');
	return false, effectmessage
end

function OnAlNeunweltClicked(playerID, hexI, hexJ, pUnit, unitID)
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	if pUnit:GetProperty(unitname..'has_ball') ~= 0
	and pUnit:GetProperty(unitname..'has_ball') ~= nil then return; end
	
	
	local pPlayer = Players[playerID]
	ExecuteScript('ALChangeResource',playerID,GameInfo.Resources["RESOURCE_AL_NEUNWELT"].Index,-1)
	ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'has_ball',1)
	local i = 1
	while i < MaxNeunWeltNumber + 1 do
		local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
		if magisphere.started == 1 then
			i = i + 1;
		else
			local combat = pPlayer:GetProperty(unitname..'_neunwelt_combat')
			print('OnAlNeunweltClicked playerID '..playerID)
			print('OnAlNeunweltClicked i '..i)
			print('OnAlNeunweltClicked combat '..combat)
			print('OnAlNeunweltClicked GetCurrentGameTurn '..Game.GetCurrentGameTurn())
			ExecuteScript('MagiSphereChange',playerID, i, 1, 0, combat, Game.GetCurrentGameTurn())
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, 'ball_number',i)
			break;
		end
	end
	ALNeunweltRefresh(playerID, unitID, hexI, hexJ)
	UI.DeselectUnit( pUnit );
	UI.SelectUnit( pUnit );
end

--————————————PASS————————————
function ALPassSelected(playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if bSelected then
		ALPassRefresh(playerID, unitID, hexI, hexJ)
	end
end

Events.UnitSelectionChanged.Add(ALPassSelected);

function ALTeleportSelected(playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if bSelected then
		local pPlot = Map.GetPlot(hexI, hexJ)
		local pUnit = UnitManager.GetUnit(playerID, unitID);
		if ALTeleportHide(playerID, unitID, hexI, hexJ) == true then
			Controls.AlTeleportGrid:SetHide(true)
		else
			Controls.AlTeleportGrid:SetHide(false)
			
			local message = Locale.Lookup('LOC_AL_TELEPORT_TOOLTIP')
			Controls.AlTeleportButton:SetToolTipString(message)
			Controls.AlTeleportButton:RegisterCallback(Mouse.eLClick, function() OnAlTeleportClicked(playerID, hexI, hexJ, pUnit, unitID); end)
		end
	end
end

Events.UnitSelectionChanged.Add(ALTeleportSelected);

function ALTeleportHide(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ);
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
	if pName then
		if GameInfo.AL_GreatUnitNames[pName].Legion == 'CLASS_AL_GRANEPLE' then
			if HasUnitPromotion(playerID,'PROMOTION_AL_HIMEKA_GREATNORMAL_4_1') then
				local MaxMove = pUnit:GetMaxMoves()
				local move = pUnit:GetMovesRemaining()
				if move == MaxMove then
					local plots = GetAllPlots()
					for _, plotID in ipairs(plots) do
						local pPlot = Map.GetPlotByIndex(plotID)
						if pPlot:GetProperty('TELEPORTING_PLAYER') then
							return true;
						end
					end
					return false;
				end
			end
		end
	end
	return true;
end

function OnAlTeleportClicked(playerID, iX, iY, pUnit, unitID)
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	if m_IsInWBInterfaceMode then
		AlQuitPassInterface(true)
		ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, 'TELEPORTING',nil)
	else
		
		UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
		UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
		m_IsInWBInterfaceMode = true
		CurrentAction = 'WB_SELECT_TELEPORT_PLOT'
		Controls.AlTeleportButton:SetSelected(true)
		local selectablePlots, invalidPlots = AlTeleportGetPlots(playerID)

		if #selectablePlots > 0 then
			UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, playerID, selectablePlots)
			UILens.SetLayerHexesArea(HEX_COLORING_ATTACK, playerID, invalidPlots)

			UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
			UILens.ToggleLayerOn(HEX_COLORING_ATTACK)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, 'TELEPORTING',1)
		else
			local message = Locale.Lookup('LOC_AL_TELEPORT_NO_PLACE');
			ExecuteScript('ALShowPromiseMessage',0, message, iX, iY)
			Controls.AlPassButton:SetSelected(false)
			AlQuitPassInterface(true)
		end
 	end
end

function AlTeleportGetPlots(playerID)
	local selectablePlots,invalidPlots = {},{}
	local playerDistricts = Players[playerID]:GetDistricts();
	for _, district in playerDistricts:Members() do
		if GameInfo.Districts[district:GetType()].DistrictType == 'DISTRICT_AL_STAGE' then
			local targetPlots = Map.GetNeighborPlots(district:GetX(), district:GetY(), 3)
			for _, plot in ipairs(targetPlots) do
				local iPlotIndex = plot:GetIndex()
				local isInvalid = AlCheckTeleportPlot(plot)
				if isInvalid then
					table.insert(invalidPlots,iPlotIndex)
				else
					table.insert(selectablePlots,iPlotIndex)
					ExecuteScript('SetPlotProperty',plot:GetIndex(), 'TELEPORTING_PLAYER', playerID)
				end
			end
		end
	end
	return selectablePlots,invalidPlots;
end

function AlCheckTeleportPlot(plot)
	if plot:IsMountain() or plot:IsWater() or plot:IsCity() or plot:IsUnit() then
		return true
	else
		return false
	end
end

function OnSelectTeleport(plotId, plotEdge, boolDown, rButton)
	if CurrentAction ~= 'WB_SELECT_TELEPORT_PLOT' then 
		return; 
	end

	local unit = nil
	local pPlot = Map.GetPlotByIndex(plotId)
	local playerID = pPlot:GetProperty('TELEPORTING_PLAYER')
	if playerID then
		local pPlayer = Players[playerID]
		local PlayerUnits = pPlayer:GetUnits()
		for i, punit in PlayerUnits:Members() do
			if punit:GetProperty('TELEPORTING') then
				unit = punit
			end
		end
	end

	if not boolDown then
		if rButton then
			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unit:GetID(), 'TELEPORTING',nil)
			return;
		else
			AlQuitPassInterface(true)
			print(playerID, unit:GetID(), pPlot:GetX(), pPlot:GetY())
			ExecuteScript('AlPlaceUnit',playerID, unit:GetID(), pPlot:GetX(), pPlot:GetY())
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unit:GetID(), 'TELEPORTING',nil)
			UI.DeselectUnit( unit );
			UI.SelectUnit( unit );
		end
	end
end

LuaEvents.WorldInput_WBSelectPlot.Add(OnSelectTeleport)

function MagiSphereGetMessageUI(playerID,i)
    local pPlayer = Players[playerID]
    local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
    return magisphere.started, magisphere.pass, magisphere.combat, magisphere.turn;
end

function MagiSphereGetCombatUI(playerID,passnumber,getcombat)
    local pPlayer = Players[playerID]
    local started, pass, combat, turn = MagiSphereGetMessageUI(playerID, passnumber)
    combat = combat + getcombat
    return combat;
end

function ALPassRefresh(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ)
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if ALPassHide(playerID, unitID, hexI, hexJ) == true then
		Controls.AlPassGrid:SetHide(true)
	else
		Controls.AlPassGrid:SetHide(false)
		local passnumber = pUnit:GetProperty('ball_number')
		local started, pass, combat, turn = MagiSphereGetMessageUI(playerID, passnumber)
		local tooltip = Locale.Lookup('LOC_AL_PASS_TOOLTIP')
		local passmessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_PASS_TOOLTIP')
		local combatmessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_COMBAT_TOOLTIP')
		Controls.AlPassButton:SetToolTipString(tooltip..'[NEWLINE]'..passmessage..'[COLOR_RED]'..pass..'[ENDCOLOR]'..'[NEWLINE]'..combatmessage..'[COLOR_RED]'..combat..'[ENDCOLOR]')
		Controls.AlPassButton:RegisterCallback(Mouse.eLClick, function() OnAlPassClicked(playerID, hexI, hexJ, pUnit, unitID); end)
	end
end

function AlOnInputActionTriggered(actionId)
	if actionId == Input.GetActionId("TogglePassBall") then
		local pUnit = UI.GetHeadSelectedUnit();
		local playerID = pUnit:GetOwner()
		local unitID = pUnit:GetID()
		local hexI = pUnit:GetX()
		local hexJ = pUnit:GetY()
		if ALPassHide(playerID, unitID, hexI, hexJ) == true then return;end
		OnAlPassClicked(playerID, hexI, hexJ, pUnit, unitID)
	end
end
Events.InputActionTriggered.Add(AlOnInputActionTriggered)

function ALPassHide(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ);
	local pUnit = UnitManager.GetUnit(playerID, unitID);

	if string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == nil
	or pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball') == nil then
		return true;
	elseif pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball') < 1
	or pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball') > 8 then
		return true;
	elseif string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == 'YURI' and Players[playerID]:GetProperty('YURI_ALIVE') == nil then
		return true;
	end
	return false;
end

function OnAlPassClicked(playerID, iX, iY, pUnit, unitID)
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	if m_IsInWBInterfaceMode then
		AlQuitPassInterface(true)
		ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'is_passing',0)
	else
		
		UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
		UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
		m_IsInWBInterfaceMode = true
		CurrentAction = 'WB_SELECT_PASS_PLOT'
		Controls.AlPassButton:SetSelected(true)
		local selectablePlots, invalidPlots = AlPassGetPlots(iX, iY, 2, playerID)

		if #selectablePlots > 0 then
			UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, playerID, selectablePlots)
			UILens.SetLayerHexesArea(HEX_COLORING_ATTACK, playerID, invalidPlots)

			UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
			UILens.ToggleLayerOn(HEX_COLORING_ATTACK)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'is_passing',1)
		else
			local nomembermessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_WITHOUT_MEMBER');
			ExecuteScript('ALShowPromiseMessage',0, nomembermessage, iX, iY)
			Controls.AlPassButton:SetSelected(false)
			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'is_passing',0)
		end
 	end
end


function AlQuitPassInterface(ifChangeInterfaceMode:boolean)
	if ifChangeInterfaceMode then
		UI.SetInterfaceMode( InterfaceModeTypes.SELECTION )
	end
	UILens.ClearLayerHexes( HEX_COLORING_MOVEMENT );
	UILens.ClearLayerHexes( HEX_COLORING_ATTACK );
	UILens.ToggleLayerOff( HEX_COLORING_MOVEMENT );
	UILens.ToggleLayerOff( HEX_COLORING_ATTACK );
	
	m_IsInWBInterfaceMode = false
	Controls.AlPassButton:SetSelected(false)
	Controls.AlFinishShotButton:SetSelected(false)
	Controls.AlCityInfomationButton:SetSelected(false)
	Controls.AlTeleportButton:SetSelected(false)
	CurrentAction = nil;

	local plots = GetAllPlots()
	for _, plotID in ipairs(plots) do
		ExecuteScript('SetPlotProperty',plotID, 'TELEPORTING_PLAYER', nil)
	end
	print("AlQuitPassInterface")
end

function AlPassGetPlots(iX, iY, range, playerID)
	local turn = Game.GetCurrentGameTurn()
	local selectablePlots = {}
	local invalidPlots = {}
	local AdjPlots = Map.GetNeighborPlots(iX, iY, range)
	for i, AdjPlot in ipairs(AdjPlots) do
		local iPlotIndex = AdjPlot:GetIndex()
		for j, unit in ipairs(Units.GetUnitsInPlot(AdjPlot)) do
			if unit 
			and unit:GetOwner() == playerID
			and string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
				local unitname = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
				if unit:GetProperty(unitname..'has_ball') == nil
				or unit:GetProperty(unitname..'has_ball') < 1 then
					if unit:GetProperty(unitname..'_neunwelt_cooldown_turn') == nil then
						if string.match(unit:GetName(),"(%u+)_GREATNORMAL") ~= 'YURI' or Players[playerID]:GetProperty('YURI_ALIVE') == 1 then
							print(unitname.." HAS BEEN SELECTED WITHOUT CD")
							table.insert(selectablePlots, iPlotIndex)
						end
					else
						local cooldownturn = unit:GetProperty(unitname..'_neunwelt_cooldown_turn')
						local cd = turn - cooldownturn
						local characd = Players[playerID]:GetProperty(unitname..'_neunwelt_cd')
						print("GET UNIT "..unitname.." CD IS "..cd)
						if cd >= characd then
							local pPlayer =Players[playerID]
							if pPlayer:GetProperty(unitname..'_charm_break_level') then
								if pPlayer:GetProperty(unitname..'_charm_break_level') >2 then
									if string.match(unit:GetName(),"(%u+)_GREATNORMAL") ~= 'YURI' or Players[playerID]:GetProperty('YURI_ALIVE') == 1 then
										table.insert(selectablePlots, iPlotIndex)
									else
										table.insert(invalidPlots, iPlotIndex)
									end
								else
									table.insert(invalidPlots, iPlotIndex)
								end
							end
						else
							table.insert(invalidPlots, iPlotIndex)
						end
					end
				else
					table.insert(invalidPlots, iPlotIndex)	
				end
			else
				table.insert(invalidPlots, iPlotIndex)	
			end
		end
	end
	return selectablePlots, invalidPlots;
end

function AlCheckPassPlot(pPlot, playerID)
	local turn = Game.GetCurrentGameTurn()
	for j, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
		if unit 
		and unit:GetOwner() == playerID
		and string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
			local unitname = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
			if unit:GetProperty(unitname..'has_ball') == nil
			or unit:GetProperty(unitname..'has_ball') < 1 then
				if unit:GetProperty(unitname..'_neunwelt_cooldown_turn') == nil then
					return true;
				else
					local cooldownturn = unit:GetProperty(unitname..'_neunwelt_cooldown_turn')
					local characd = Players[playerID]:GetProperty(unitname..'_neunwelt_cd')
					local cd = turn - cooldownturn
					if cd >= characd then
						return true;
					else
						return false;
					end
				end
			else
				return false;
			end
		else
			return false;
		end
	end
end

function AlFindPassingUnit(pPlot,playerID)
	local findplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 5)
	for i, plot in ipairs(findplots) do
		for j, unit in ipairs(Units.GetUnitsInPlot(plot)) do
			if(unit ~= nil) and string.match(unit:GetName(),"(%u+)_GREATNORMAL") and unit:GetOwner() == Game.GetLocalPlayer() then
				if unit:GetProperty(string.match(unit:GetName(),"(%u+)_GREATNORMAL")..'is_passing') == 1 then
					return unit;
				end
			end
		end
	end
end

function OnSelectPass(plotId, plotEdge, boolDown, rButton)
	if CurrentAction ~= 'WB_SELECT_PASS_PLOT' then 
		return; 
	end
	local playerID = -1;
	local pPlot = Map.GetPlotByIndex(plotId)
	local unitID = -1;
	local pUnit = nil;

	for i, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
		if unit and string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
			playerID = unit:GetOwner();
			unitID = unit:GetID()
			pUnit = unit
		end
	end

	local PassingUnit = AlFindPassingUnit(pPlot,playerID)
	local pPlayer = Players[playerID]
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");

	if unitname == nil then
		AlQuitPassInterface(true)
		ExecuteScript('ALSetUnitPropertyFlag',playerID, PassingUnit:GetID(), string.match(PassingUnit:GetName(),"(%u+)_GREATNORMAL")..'is_passing',0)
		return;
	end

	if AlCheckPassPlot(pPlot, playerID) ~= true then

		AlQuitPassInterface(true)
		ExecuteScript('ALSetUnitPropertyFlag',playerID, PassingUnit:GetID(), string.match(PassingUnit:GetName(),"(%u+)_GREATNORMAL")..'is_passing',0)
		return;
	end
	if not boolDown then
		if rButton then

			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, PassingUnit:GetID(), string.match(PassingUnit:GetName(),"(%u+)_GREATNORMAL")..'is_passing',0)
			return;
		else

			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, PassingUnit:GetID(), string.match(PassingUnit:GetName(),"(%u+)_GREATNORMAL")..'is_passing',0)
			local passname = string.match(PassingUnit:GetName(),"(%u+)_GREATNORMAL")
			local passID = PassingUnit:GetID()
			local passnumber = PassingUnit:GetProperty('ball_number')
			local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..passnumber)
			local started, pass, combat, turn = MagiSphereGetMessageUI(playerID, passnumber)
			local nowturn = Game.GetCurrentGameTurn()

			pass = pass + 1;
			local peoplenumber = pass + 1;
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'has_ball', peoplenumber)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, 'ball_number', passnumber)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, passID, passname..'has_ball', 0)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, passID, passname..'_neunwelt_cooldown_turn', nowturn)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, passID, 'ball_number', 0)

			local getcombat = pPlayer:GetProperty(unitname..'_neunwelt_combat')
			local newcombat = MagiSphereGetCombatUI(playerID,passnumber,getcombat)
			ExecuteScript('MagiSphereChange',playerID, passnumber, started, pass, newcombat, turn)
			print("SPHERE NUMBER "..passnumber.." HAS BEEN PASSED FROM "..passname.." TO "..unitname..". IT HAS BEEN PASSED FOR "..peoplenumber.." TIMES")

			print(passname.." COOLDOWN BEGIN AT TURN"..nowturn)

			local passmessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_PASS_SUCCESS');
			local damagemessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_COMBAT_NOW');
			local finalmessage = passmessage..peoplenumber..damagemessage..newcombat
			ExecuteScript('ALShowPromiseMessage',0,finalmessage,pPlot:GetX(),pPlot:GetY())

			UI.DeselectUnit( PassingUnit );
			UI.SelectUnit( pUnit );
			UI.PlaySound("NineWolrdPass")
		end
	end
end

LuaEvents.WorldInput_WBSelectPlot.Add(OnSelectPass)


--————————————FinishShot————————————

function ALFinishShotSelected(playerID, unitID, hexI, hexJ, hexK, bSelected, bEditable)
	if bSelected then
		ALFinishShotRefresh(playerID, unitID, hexI, hexJ)
	end
end

Events.UnitSelectionChanged.Add(ALFinishShotSelected);

function ALFinishShotRefresh(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ)
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	if ALFinishShotHide(playerID, unitID, hexI, hexJ) == true then
		Controls.AlFinishShotGrid:SetHide(true)
	else
		Controls.AlFinishShotGrid:SetHide(false)
		local passnumber = pUnit:GetProperty('ball_number')
		local started, pass, combat, turn = MagiSphereGetMessageUI(playerID, passnumber)
		local tooltip = Locale.Lookup('LOC_AL_FINISHSHOT_TOOLTIP')
		local combatmessage = Locale.Lookup('LOC_MOD_AL_NEUNWELT_COMBAT_TOOLTIP')
		Controls.AlFinishShotButton:SetToolTipString(tooltip..'[NEWLINE]'..combatmessage..'[COLOR_RED]'..combat..'[ENDCOLOR]')
		Controls.AlFinishShotButton:RegisterCallback(Mouse.eLClick, function() OnAlFinishShotClicked(playerID, hexI, hexJ, pUnit, unitID); end)
	end
end

function ALFinishShotHide(playerID, unitID, hexI, hexJ)
	local pPlot = Map.GetPlot(hexI, hexJ);
	local pUnit = UnitManager.GetUnit(playerID, unitID);
	local pPlayer = Players[playerID]

	if string.match(pUnit:GetName(),"(%u+)_GREATNORMAL") == nil
	or pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball') == nil then
		return true;
	elseif pUnit:GetProperty(string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'has_ball') ~= 9
	or pPlayer:GetProperty(playerID..'magi_sphere_'..pUnit:GetProperty('ball_number')).pass ~= 8 then
		return true;
	end
	return false;
end

function OnAlFinishShotClicked(playerID, iX, iY, pUnit, unitID)
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");
	if m_IsInWBInterfaceMode then
		AlQuitPassInterface(true)
		ExecuteScript('ALShowPromiseMessage',playerID, unitID, unitname..'is_shooting',0)
	else
		
		UI.SetInterfaceMode(InterfaceModeTypes.SELECTION)
		UI.SetInterfaceMode(InterfaceModeTypes.WB_SELECT_PLOT)
		m_IsInWBInterfaceMode = true
		Controls.AlFinishShotButton:SetSelected(true)
		CurrentAction = 'WB_SELECT_SHOT_PLOT'
		local selectablePlots, invalidPlots = AlShotGetPlots(iX, iY, 4)

		if #selectablePlots > 0 then
			UILens.SetLayerHexesArea(HEX_COLORING_MOVEMENT, playerID, selectablePlots)
			UILens.SetLayerHexesArea(HEX_COLORING_ATTACK, playerID, invalidPlots)

			UILens.ToggleLayerOn(HEX_COLORING_MOVEMENT)
			UILens.ToggleLayerOn(HEX_COLORING_ATTACK)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, unitID, unitname..'is_shooting',1)
		end
 	end
end

function AlShotGetPlots(iX, iY, range)
	local turn = Game.GetCurrentGameTurn()
	local selectablePlots = {}
	local invalidPlots = {}
	local AdjPlots = Map.GetNeighborPlots(iX, iY, range)
	for i, AdjPlot in ipairs(AdjPlots) do
		local iPlotIndex = AdjPlot:GetIndex()
		table.insert(selectablePlots, iPlotIndex)
	end
	return selectablePlots, invalidPlots;
end

function AlFindShootingUnit(pPlot)
	local findplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 8)
	for i, plot in ipairs(findplots) do
		for j, unit in ipairs(Units.GetUnitsInPlot(plot)) do
			if(unit ~= nil) and string.match(unit:GetName(),"(%u+)_GREATNORMAL") and unit:GetOwner() == Game.GetLocalPlayer() then
				if unit:GetProperty(string.match(unit:GetName(),"(%u+)_GREATNORMAL")..'is_shooting') == 1 then
					return unit;
				end
			end
		end
	end
end

function OnSelectShot(plotId, plotEdge, boolDown, rButton)
	if CurrentAction ~= 'WB_SELECT_SHOT_PLOT' then return; end
	print("OnSelectShot BEGIN")
	local pPlot = Map.GetPlotByIndex(plotId)

	local pUnit = AlFindShootingUnit(pPlot)
	local unitID = pUnit:GetID()
	local playerID = pUnit:GetOwner()
	local pPlayer = Players[playerID]
	local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL");

	if unitname == nil then
		AlQuitPassInterface(true)
		ExecuteScript('ALSetUnitPropertyFlag',playerID, pUnit:GetID(), string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'is_shooting',0)
		return;
	end

	if not boolDown then
		if rButton then
			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, pUnit:GetID(), string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'is_shooting',0)
			return;
		else
			AlQuitPassInterface(true)
			ExecuteScript('ALSetUnitPropertyFlag',playerID, pUnit:GetID(), string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")..'is_shooting',0)
			print("OnSelectShot plotId is"..plotId)
			ExecuteScript('ALFinishShot',playerID, plotId, unitID)
			ALFinishShotRefresh(playerID, unitID, pUnit:GetX(), pUnit:GetY())
			UI.DeselectUnit( pUnit );
			UI.PlaySound(unitname.."FinishShot")
			UI.PlaySound("FinishShot")
		end
	end
end

LuaEvents.WorldInput_WBSelectPlot.Add(OnSelectShot)

function OnUiModChangeAl(intPara, currentInterfaceMode)
	if m_IsInWBInterfaceMode and currentInterfaceMode ~= InterfaceModeTypes.WB_SELECT_PLOT then
		AlQuitPassInterface(false)
 	end
end

Events.InterfaceModeChanged.Add(OnUiModChangeAl)

function AlSetAreaDeffenseFlagGarden(x,y,playerID)
	local city = Cities.GetCityInPlot(x,y)
	local pCityDistricts = city:GetDistricts();
	local pPlayer = Players[playerID]
    for _, pDistrict in pCityDistricts:Members() do
		ExecuteScript('AlSetAreaDeffenseFlagGardenPlots',pDistrict:GetX(),pDistrict:GetY(),playerID)
    end
end
ExposedMembers.AL.AlSetAreaDeffenseFlagGarden = AlSetAreaDeffenseFlagGarden

function AlGetAllianceLevel(playerID,otheriPlayer)
	local pPlayer = Players[playerID];
	local PlayerDiplomacy = pPlayer:GetDiplomacy();
	local allianceLevel = PlayerDiplomacy:GetAllianceLevel(otheriPlayer);
	return allianceLevel;
end
ExposedMembers.AL.AlGetAllianceLevel = AlGetAllianceLevel

function AlCheckMinor (playerID)
	local pPlayer = Players[playerID];
	if pPlayer:IsMinor() == true then
		return true;
	else
		return false;
	end
end
ExposedMembers.AL.AlCheckMinor = AlCheckMinor

function AlGetMagiPerTurn(playerID)
	local pPlayer = Players[playerID]
	local num1 = pPlayer:GetResources():GetResourceAccumulationPerTurn(GameInfo.Resources['RESOURCE_AL_MAGI'].Index)
	local num2 = pPlayer:GetResources():GetBonusResourcePerTurn(GameInfo.Resources['RESOURCE_AL_MAGI'].Index)
	local num = num1 + num2
	print('AlGetMagiPerTurn: num is '..num)
	return num;
end
ExposedMembers.AL.AlGetMagiPerTurn = AlGetMagiPerTurn

function IsLilyCivilization(playerID)
    local pPlayer = Players[playerID]
    local pPlayerConfig = PlayerConfigurations[playerID];

    if pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_AL_YURIGAOKA"
	or pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_AL_KANBA" then 
        return true;
    else
        return false;
    end
end

function GetPromotionNum(playerID,unitID)
	local unit = UnitManager.GetUnit(playerID,unitID)
	local promotionList = unit:GetExperience():GetPromotions();
	local num = 0
	for i, promotion in ipairs(promotionList) do
		if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions[promotion].Index) then
			num = num + 1
		end
	end
	return num;
end
ExposedMembers.AL.GetPromotionNum = GetPromotionNum

function GetLilyPointPerTurn(playerID)
	local pPlayer = Players[playerID];
	local classID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_AL_LILY'].Index;
	if classID then
		local num = pPlayer:GetGreatPeoplePoints():GetPointsPerTurn(classID)
		return num;
	end
end
ExposedMembers.AL.GetLilyPointPerTurn = GetLilyPointPerTurn

function GetLilyUnit(playerID,pName)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if name == pName then
                return unit;
            end
        end
    end
    return nil;
end

function HasUnitPromotion(playerID,Promotion)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits();
    for i, unit in PlayerUnits:Members() do
        local ue = unit:GetExperience()
        if ue:HasPromotion(GameInfo.UnitPromotions[Promotion].Index) then
            return true;
        end
    end
end

function GetAllPlots()
    local plots = {}
    local tContinents = Map.GetContinentsInUse()
    for i, eContinent in ipairs(tContinents) do
        local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
        for _, plotID in ipairs(tContinentPlots) do
            table.insert(plots, plotID)
        end
    end
    return plots
end