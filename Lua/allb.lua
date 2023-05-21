local mapSizeType = GameInfo.Maps[Map.GetMapSize()].MapSizeType
local gameDifficultyType = GameInfo.Difficulties[PlayerConfigurations[0]:GetHandicapTypeID()].DifficultyType
local MaxNeunWeltNumber = 10;

if ExposedMembers.AL == nil then ExposedMembers.AL = {}; end

local ExposedTable = {}

local NestMapSize = {
    MAPSIZE_DUEL = 3,
    MAPSIZE_TINY = 3,
    MAPSIZE_SMALL = 4,
    MAPSIZE_STANDARD = 4,
    MAPSIZE_LARGE = 4,
    MAPSIZE_HUGE = 5,
}

local NestDifficulty = {
    DIFFICULTY_SETTLER = 1,
    DIFFICULTY_CHIEFTAIN = 1,
    DIFFICULTY_WARLORD = 1,
    DIFFICULTY_PRINCE = 2,
    DIFFICULTY_KING = 2,
    DIFFICULTY_EMPEROR = 3,
    DIFFICULTY_IMMORTAL = 3,
    DIFFICULTY_DEITY = 4,
}

local MaxNestNumber = NestMapSize[mapSizeType] * NestDifficulty[gameDifficultyType] or 4;
local MaxCaveNumberGigant = 3;
local MaxCaveNumberUltra = 5;
local DefaultAreaDeffenseRange = 2;
local DefaultDistrictAreaDeffenseRange = 1;
local DefaultAreaDeffenseLevel = 1;
local Project1AreaDeffenseRange = 1;

local NestPhase1 = 15
local NestPhase2 = 20
local NestPhase3 = 25
local NestPhase4 = 30

local AreaDeffensePercent = 0.99

local MaxSuperNestNum = 2

local HugeEra = 1

local DefaultTranningEXP = 4
local DefaultTranningEXPLV2 = 4
local DefaultTranningEXPLV3 = 4

local EraRateParamater = 0.025*NestDifficulty[gameDifficultyType]
local EraNumberParamater = 0.5*NestDifficulty[gameDifficultyType]
local DestroyedNestParamater = 0.005

local NaturalNestPercent = 0.97
local HugeNestPercent = 0.05

local NestEnovyRange = 4
local NestFavorabilityRange = 5

local DefaultMaxNeunweltDamage = 75

local YuriCycle = 9

function IsLilyCivilization(playerID)
    local pPlayer = Players[playerID]
    local pPlayerConfig = PlayerConfigurations[playerID];
    if pPlayerConfig == nil then return false;end
    if pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_AL_YURIGAOKA"
    or pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_AL_KANBA" then 
        return true;
    else
        return false;
    end
end

function AlGetGreatUnits(unitOwner,unitID,greatPersonClassID,greatPersonIndividualID)
    local individual = GameInfo.GreatPersonIndividuals[greatPersonIndividualID].GreatPersonIndividualType
    local pPlayer = Players[unitOwner]
    local name = string.match(individual, "AL_LILY_(%u+)")
    if name == nil then return;end

    if name == 'RIRI' then
        local pPlayerConfig = PlayerConfigurations[unitOwner];
        local LeaderName = string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)")
        for _,player in ipairs(Game.GetPlayers()) do
            local iPlayer = player:GetID();
            if iPlayer ~= unitOwner and player:IsMajor() then
                player:AttachModifierByID('MOD_AL_GP_RIRI_ACTION_CHARISMA_'..LeaderName)
                print('Player '..iPlayer..'Get Charisma Modifier to '..LeaderName)
            end
        end
    end

    local capital = pPlayer:GetCities():GetCapitalCity()
    if capital == nil then return;end
    local unittype = 'UNIT_AL_'..name..'_GREATNORMAL'
    if pPlayer:GetProperty(name..'_greatnormal_flag') == nil then
        UnitManager.InitUnitValidAdjacentHex(unitOwner, unittype, capital:GetX(), capital:GetY(), 1)
        pPlayer:SetProperty(name..'_greatnormal_flag',1)
        RefreshCharmBreakLevel(unitOwner)
        print('AlGetGreatUnits:Get Unit '..name)
    else
        print('AlGetGreatUnits:Repeat Get Unit '..name)
        return;
    end

    local capital = pPlayer:GetCities():GetCapitalCity()
    if name == 'SHENLIN' or name == 'YUJIA' then
        if capital:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index) == false then
            capital:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index)
        end
    end
end
Events.UnitGreatPersonActivated.Add(AlGetGreatUnits);

function CountCharmBreakLevelTrigger(pCombatResult)

    local aUnit,dUnit,aPlayer,dPlayer,location = GetInfoFromCombat(pCombatResult)
    if aUnit == nil or dUnit == nil then return;end
    if string.match(aUnit:GetName(),"(%u+)_GREATNORMAL") then
        local name = string.match(aUnit:GetName(),"(%u+)_GREATNORMAL")
        local PlayerID = aPlayer:GetID()
        CountCharmBreakLevel(name,PlayerID,aUnit:GetID(),location.x,location.y)
    end

    if string.match(dUnit:GetName(),"(%u+)_GREATNORMAL") then
        local name = string.match(dUnit:GetName(),"(%u+)_GREATNORMAL")
        local PlayerID = dPlayer:GetID()
        CountCharmBreakLevel(name,PlayerID,dUnit:GetID(),location.x,location.y)
    end
end
Events.Combat.Add(CountCharmBreakLevelTrigger);

function TakaneProtectKanaho(pCombatResult)
    local aUnit,dUnit,aPlayer,dPlayer,location = GetInfoFromCombat(pCombatResult)
    if aUnit == nil or dUnit == nil then return;end
    local pName = string.match(dUnit:GetName(),"(%u+)_GREATNORMAL")
    if pName and pName == 'KANAHO' then
        local kanaho = dUnit
        local pPlot = Map.GetPlot(location.x,location.y)
        local NearTakane,FlagNearTakane = NearTakane(pPlot)
        if FlagNearTakane then
            local takane = GetLilyUnit(dPlayer:GetID(),'TAKANE')
            if takane and takane:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_2_1'].Index) then
                local defender = pCombatResult[CombatResultParameters.DEFENDER]
                local damage = defender[CombatResultParameters.DAMAGE_TO]
                local hp = 99 - takane:GetDamage()
                if damage < hp and damage >0 then
                    takane:ChangeDamage(damage)
                    kanaho:ChangeDamage(-1*damage)
                elseif damage >= hp and hp>0 then
                    takane:ChangeDamage(hp)
                    kanaho:ChangeDamage(-1*damage)
                end
            end
        end
    end
end
Events.Combat.Add(TakaneProtectKanaho);



function GetInfoFromCombat(pCombatResult)
    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]

    local attacker = pCombatResult[CombatResultParameters.ATTACKER]
    local attInfo = attacker[CombatResultParameters.ID]

    local aUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    local dUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

    local aPlayer = Players[attInfo.player]
    local dPlayer = Players[defInfo.player]
    local location = pCombatResult[CombatResultParameters.LOCATION];
    return aUnit,dUnit,aPlayer,dPlayer,location
end

function KillYuriTrigger(pCombatResult)
    local aUnit,dUnit,aPlayer,dPlayer,location = GetInfoFromCombat(pCombatResult)
    if aUnit == nil or dUnit == nil then return;end

    if string.match(aUnit:GetName(),"(%u+)_GREATNORMAL") and string.match(dUnit:GetName(),"UNIT_AL_HUGE_(%u+)") then
        if string.match(aUnit:GetName(),"(%u+)_GREATNORMAL") == 'YURI' 
        and string.match(dUnit:GetName(),"UNIT_AL_HUGE_(%u+)") == 'YURI' 
        and aPlayer:GetProperty('FIGHT_YURI_HUGE') == nil 
        and dPlayer:GetID() == 63 
        and aPlayer:GetProperty('YURI_ALIVE') == nil 
        and dUnit:GetProperty('YURI_HUGE_OWNER') == aPlayer:GetID() then

            if aUnit then
                UnitManager.Kill(aUnit)
            end

            AlYuriPopup(playerID,14)
            aPlayer:SetProperty('YURI_DIED',0)
            ExposedMembers.AL.UIPlayersound('YURI_DIED')
            aPlayer:SetProperty('YURI_greatnormal_flag',0)

            if dUnit and dUnit:IsDelayedDeath()==false then
                UnitManager.Kill(dUnit)
            end
            
            
        end
    end
end
Events.Combat.Add(KillYuriTrigger);

function CountCharmBreakLevel(name,PlayerID,unitID,x,y)
    local pPlot = GetCapitalPlot(PlayerID)
    local breaklevel = GetCharmBreakLevel(PlayerID,name)
    local pUnit = UnitManager.GetUnit(PlayerID, unitID)
    local damageParamater = pUnit:GetDamage()/300
    local rand = Game.GetRandNum(100,'NO WHY')/100
    local percent = rand + damageParamater
    print('CountCharmBreakLevel:'..rand,damageParamater)
    if percent >= 0.95 then
        print('CountCharmBreakLevel:BREAK!')
        SetCharmBreakLevel(PlayerID,name,breaklevel-1)
        Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_CHARM_BROKEN")..Locale.Lookup("LOC_AL_CHARM_BROKEN_"..breaklevel-1), x, y)
    end
end

function YurigaokaGetLilyGreats(playerID, unitID, greatPersonClassID, greatPersonIndividualID)
    local pPlayer = Players[playerID];
    local pPlayerConfig = PlayerConfigurations[playerID];
    if (pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_AL_YURIGAOKA") then
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

function KanbaGetGreatPoint(playerID)
    if IsLilyCivilization(playerID) and IsLeader(playerID,'KANAHO') then
        local pPlayer = Players[playerID];
        local classID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_AL_LILY'].Index;
        if classID then
            local num = ExposedMembers.AL.GetLilyPointPerTurn(playerID)
            if num and num>0 then
                pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_MUSICIAN"].Index,num);
                pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_WRITER"].Index,num);
                pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_ARTIST"].Index,num);
            end
        end
    end
end
Events.PlayerTurnActivated.Add(KanbaGetGreatPoint);
function AlChangePointsTotal(playerID)
    local pPlayer = Players[playerID];
    local era = Game.GetEras():GetCurrentEra()
    local iGreatPersonBaseCost = GameInfo.Eras[era].GreatPersonBaseCost
    local iCost = iGreatPersonBaseCost;
    pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index,iCost);
end
ExposedTable['AlChangePointsTotal'] = AlChangePointsTotal

function RiriGetGardenYield(playerID,misc1)
    local pPlayer = Players[playerID];
    local pPlayerConfig = PlayerConfigurations[playerID];
    if pPlayerConfig:GetLeaderTypeName() ~= 'LEADER_AL_RIRI' then return;end
    
    if pPlayer:GetProperty('RIRI_ALLIANCE_NUM') == nil then
        pPlayer:SetProperty('RIRI_ALLIANCE_NUM',0)
    end

    local nownum = 0;
    local pastnum = pPlayer:GetProperty('RIRI_ALLIANCE_NUM')

    
    for _,player in ipairs(Game.GetPlayers()) do
        local iPlayer = player:GetID();
        if iPlayer ~= playerID and player:IsMajor() then
            local PlayerDiplomacy = pPlayer:GetDiplomacy();
            local allianceLevel = 0;
            if PlayerDiplomacy:HasAllied(iPlayer) then
                allianceLevel = ExposedMembers.AL.AlGetAllianceLevel(playerID,iPlayer)
            end
            nownum = nownum + allianceLevel;
        end
    end

    if nownum > pastnum then
        pPlayer:SetProperty('RIRI_ALLIANCE_NUM',nownum)
        local i = nownum - pastnum
        local j = 1
        while j <= i do
            pPlayer:AttachModifierByID('MOD_RIRI_GARDEN_YIELD_BONUS')
            print('RiriGetGardenYield:Attach!')
            j = j + 1
        end
    end
    
end
Events.PlayerTurnActivated.Add(RiriGetGardenYield);

function RiriSetCapitalProperty(playerID,misc1)
    
    local pPlayer = Players[playerID];
    local pPlayerConfig = PlayerConfigurations[playerID];
    if pPlayerConfig:GetLeaderTypeName() ~= 'LEADER_AL_RIRI' then return;end
    local capital = pPlayer:GetCities():GetCapitalCity()
    if capital then
        local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())
        if CheckRIRIAllMember(playerID) ~= true then
            pPlot:SetProperty('RIRI_CAPITAL',1)
        elseif CheckRIRIAllMember(playerID) then
            pPlot:SetProperty('RIRI_CAPITAL',nil)
        end
    end
    
end
Events.PlayerTurnActivated.Add(RiriSetCapitalProperty);

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
                        if not IsLilyCivilization(iPlayerID) then return; end
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
    if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_KAEDE',5)
    and greatPersonClassID == GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index then
        local pPlayer = Players[playerID]
        local pTech = pPlayer:GetTechs();
        local atech = pTech:GetResearchingTech();
        pTech :TriggerBoost(atech)
        print("KaedeGetBoost")
    end
end

function ALUnitKilledInCombat(pCombatResult)
    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]

    local attacker = pCombatResult[CombatResultParameters.ATTACKER]
    local attInfo = attacker[CombatResultParameters.ID]

    local aUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    local dUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

    if aUnit == nil or dUnit == nil then return; end

    if string.match(aUnit:GetName(),"(%u+)_GREATNORMAL") == nil
    and string.match(dUnit:GetName(),"(%u+)_GREATNORMAL") ~= nil then
        if defInfo.player ~= Game.GetLocalPlayer()
        or dUnit:GetDamage()  ~= 99 then  return; end
        local dunitname = string.match(dUnit:GetName(), "(%u+)_GREATNORMAL")
        ExposedMembers.AL.UIPlayersound(dunitname..'GreatDefeated')
        ExposedMembers.AL.ALOhakaRetreat(defInfo.player, defInfo.id)
    end

    if string.match(aUnit:GetName(),"(%u+)_GREATNORMAL") ~= nil
    and string.match(dUnit:GetName(),"(%u+)_GREATNORMAL") == nil then 
        if attInfo.player ~= Game.GetLocalPlayer()
        or aUnit:GetDamage()  ~= 99 then  return; end
        local aunitname = string.match(aUnit:GetName(), "(%u+)_GREATNORMAL")
        ExposedMembers.AL.UIPlayersound(aunitname..'GreatDefeated')
        ExposedMembers.AL.ALOhakaRetreat(attInfo.player, attInfo.id)
    end
end


function ALPlaceHugeNest(TribeTypeIndex,PlotIndex)
    local SaveNestPlayer = Players[0]
    local era = Game.GetEras():GetCurrentEra()
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    local GlobalNestNumber = SaveNestPlayer:GetProperty('GlobalNestNumber')
    if GlobalNestNumber == nil then GlobalNestNumber = 0; end
    if GlobalNestNumber >= MaxNumber then return; end
    if PlotIndex and TribeTypeIndex then
        local i = 1
        while i < MaxNumber + 1 do
            local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
            if nest and nest.exist == 0 then
                
                local pPlot = Map.GetPlotByIndex(PlotIndex)
                local pBarbManager = Game.GetBarbarianManager()
                local iTribeNumber = pBarbManager:CreateTribeOfType(TribeTypeIndex, PlotIndex)
                SaveNestPlayer:SetProperty('al_nest_'..i, {
                    exist = 1,
                    points = 0,
                    number = i,
                    x = pPlot:GetX(),
                    y = pPlot:GetY(),
                    type = GameInfo.BarbarianTribes[TribeTypeIndex].TribeType,
                    cavenumber = 0,
                    caves = {},
                    level = 1,
                    index = iTribeNumber,
                })
                SaveNestPlayer:SetProperty('GlobalNestNumber',GlobalNestNumber + 1) 
                local newnest = SaveNestPlayer:GetProperty('al_nest_'..i)
                print("————GOT NEST "..newnest.number.." TYPE IS "..newnest.type.." AT POSITION X: "..newnest.x.." Y: "..newnest.y.."————")

                if newnest.type ~= 'TRIBE_AL_NEST_SUPER' then
                    local pAllPlayerIDs : table = PlayerManager.GetAliveIDs();	
                    for k, iPlayerID in ipairs(pAllPlayerIDs) do
                        local notification = GameInfo.Notifications["NOTIFICATION_AL_NEST_CREATED"]
                        NotificationManager.SendNotification(iPlayerID, notification.NotificationType, notification.Message, notification.Summary, newnest.x, newnest.y);
                    end
                end
                break
            end
            i = i + 1
        end
    end
end

function ALPlaceHugeCave(PlotIndex,nestnumber)
    local SaveNestPlayer = Players[0]
    if PlotIndex then
    local nest = SaveNestPlayer:GetProperty('al_nest_'..nestnumber)
            if nest and nest.exist == 1 then
                local pPlot = Map.GetPlotByIndex(PlotIndex)
                local pBarbManager = Game.GetBarbarianManager()
                local random = Game.GetRandNum(100,'NO WHY')/100
                print(random)
                if nest.cavenumber < MaxCaveNumberGigant + 1 then
                    if random < 0.65 then
                        pBarbManager:CreateTribeOfType(GameInfo.BarbarianTribes['TRIBE_AL_CAVE_LARGE'].Index, PlotIndex)
                    end

                    if random >= 0.65 and random < 0.95 then
                        pBarbManager:CreateTribeOfType(GameInfo.BarbarianTribes['TRIBE_AL_CAVE_GIGANT'].Index, PlotIndex)
                    end

                    if random >= 0.95 then
                        pBarbManager:CreateTribeOfType(GameInfo.BarbarianTribes['TRIBE_AL_CAVE_ULTRA'].Index, PlotIndex)
                    end
                end
                local gotcave = {x = pPlot:GetX(), y = pPlot:GetY()}
                local nextturn = nest.points - NestPhase3
                local nestx = nest.x
                local nesty = nest.y
                local nesttype = nest.type
                local nestcave = nest.cavenumber + 1
                local nestcaves = nest.caves
                local nestlevel = nest.level
                local nestindex = nest.index
                table.insert(nestcaves, gotcave)
                SaveNestPlayer:SetProperty('al_nest_'..nestnumber, {
                    exist = 1,
                    points = nextturn,
                    number = nestnumber,
                    x = nestx,
                    y = nesty,
                    type = nesttype,
                    cavenumber = nestcave,
                    caves = nestcaves,
                    level = nestlevel,
                    index = nestindex,
                })
                local newnest = SaveNestPlayer:GetProperty('al_nest_'..nestnumber)
                print("————NEST NUMBER"..newnest.number.."BUY CAVE AT POSITION X: "..pPlot:GetX().." Y "..pPlot:GetY().." NOW IT HAS "..newnest.points.. " POINTS————")
                local pAllPlayerIDs : table = PlayerManager.GetAliveIDs();	
                for k, iPlayerID in ipairs(pAllPlayerIDs) do
                    local notification = GameInfo.Notifications["NOTIFICATION_AL_CAVE_CREATED"]
                    NotificationManager.SendNotification(iPlayerID, notification.NotificationType, notification.Message, notification.Summary, newnest.x, newnest.y);
                end
            end
    end
end

function AlPlotNearbyUnitCheck(pPlot,isCheck)
    local targetplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 3)
    for _,plot in ipairs(targetplots) do
        if plot:IsUnit() then
            for loop, unit in ipairs(Units.GetUnitsInPlot(plot)) do
                if GameInfo.Units[unit:GetType()].UnitType == 'UNIT_AL_HUGE_GIGANT_SUPER' then
                    if isCheck == true then
                        return true;
                    elseif isCheck == false then
                        UnitManager.Kill(unit)
                    end
                end
            end
        end
    end
    return false;
end

function GetNestPlots()
    local plotindex = {}
    local tContinents = Map.GetContinentsInUse()
    for i, eContinent in ipairs(tContinents) do
        local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
        for _, plot in ipairs(tContinentPlots) do
            local pPlot = Map.GetPlotByIndex(plot)
            
            if (pPlot ~= nil) and (pPlot:IsWater() == false) and (pPlot:IsMountain() == false) and AlPlotNearbyUnitCheck(pPlot,true) == true
            and (pPlot:GetImprovementType() == -1) and (pPlot:GetUnitCount() ==  0) and (pPlot:IsFreshWater() == true) and (pPlot:GetOwner() == -1) then
                if pPlot:GetProperty('area_deffense_flag_1') then
                    local random = Game.GetRandNum(100,'NO WHY')/100
                    if pPlot:GetProperty('area_deffense_flag_1') == 1 then
                        if random > AreaDeffensePercent then
                            table.insert(plotindex, pPlot)
                        else
                        end
                    end
                else
                    table.insert(plotindex, pPlot)
                end
            end
        end
    end
    return plotindex
end

function GetNaturalNestPlots()
    local plotindex = {}
    local tContinents = Map.GetContinentsInUse()
    for i, eContinent in ipairs(tContinents) do
        local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
        for _, plot in ipairs(tContinentPlots) do
            local pPlot = Map.GetPlotByIndex(plot)
            
            if (pPlot ~= nil) and (pPlot:IsWater() == false) and (pPlot:IsMountain() == false)
            and (pPlot:GetImprovementType() == -1) and (pPlot:GetUnitCount() ==  0) and (pPlot:IsFreshWater() == true) and (pPlot:GetOwner() == -1) then
                if pPlot:GetProperty('area_deffense_flag_1') then
                    local random = Game.GetRandNum(100,'NO WHY')/100
                    if pPlot:GetProperty('area_deffense_flag_1') == 1 then
                        if random > AreaDeffensePercent then
                            table.insert(plotindex, pPlot)
                        else
                        end
                    end
                else
                    table.insert(plotindex, pPlot)
                end
            end
        end
    end
    return plotindex
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

function YuriGetHuge(playerID)
    local pPlayer = Players[playerID]
    local capital = pPlayer:GetCities():GetCapitalCity()
    local plots = {}
    local range = 1
    while #plots < 1 do
        local tplots = Map.GetNeighborPlots(capital:GetX(), capital:GetY(), range)
        for _,plot in ipairs(tplots) do
            if (plot ~= nil) and (plot:IsWater() == false) and (plot:IsMountain() == false)
            and (plot:GetUnitCount() ==  0) and (plot:IsCity() ==  false) then
                table.insert(plots,plot)
            end
        end
        range = range + 1
    end
    local randNumPlotIndex = Game.GetRandNum(#plots,'ALLB:Get Nest Position') + 1
    local iPlot = plots[randNumPlotIndex]
    local sUnitType = GameInfo.Units['UNIT_AL_HUGE_YURI'].Index
    Players[63]:GetUnits():Create(sUnitType, iPlot:GetX(), iPlot:GetY())

    local Yurihuge = nil
    for loop, unit in ipairs(Units.GetUnitsInPlot(iPlot)) do
        if string.match(unit:GetName(),"UNIT_AL_HUGE_(%u+)") == 'YURI' then
            Yurihuge = unit;
            break
        end
    end
    Yurihuge:SetProperty('YURI_HUGE_OWNER',playerID)
end

function ALSelectSuperNestPosition(playerID)
    
    if playerID ~= 0 or Players[0]:GetProperty('SUPER_NEST_FLAG') == 1 then return;end

    local era = Game.GetEras():GetCurrentEra()
    if era < HugeEra then return;end
    local rand = Game.GetRandNum(100,'NO WHY')/100
    local plotindex = {}
	local tContinents = Map.GetContinentsInUse()
    for j, eContinent in ipairs(tContinents) do
	    local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
	    for _, plot in ipairs(tContinentPlots) do
		    local pPlot = Map.GetPlotByIndex(plot)
            
		    if (pPlot ~= nil) and (pPlot:IsWater() == false) and (pPlot:IsMountain() == false)
            and (pPlot:GetImprovementType() == -1) and (pPlot:GetUnitCount() ==  0) then

                if pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_SNOW'].Index
                or pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_SNOW_HILLS'].Index
                or pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_SNOW_MOUNTAIN'].Index
                or pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_TUNDRA'].Index
                or pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_TUNDRA_HILLS'].Index
                or pPlot:GetTerrainType() == GameInfo.Terrains['TERRAIN_TUNDRA_MOUNTAIN'].Index then
                    table.insert(plotindex, pPlot)
                end
		    end
	    end
    end
    local indexes = {}
    while #indexes +1 <= MaxSuperNestNum do
        local randPlotIndex = Game.GetRandNum(#plotindex,'ALLB:Get Nest Position') + 1
        if AlCheckTable(indexes,randPlotIndex) == false then
            table.insert(indexes,randPlotIndex)
        end
        print('ALSelectSuperNestPosition: Insert Plot:'..randPlotIndex)
    end
    local TribeIndex = GameInfo.BarbarianTribes['TRIBE_AL_NEST_SUPER'].Index 
    for _,index in ipairs(indexes) do
        ALPlaceHugeNest(TribeIndex,plotindex[index]:GetIndex())
    end
    Players[0]:SetProperty('SUPER_NEST_FLAG',1)
    
end
Events.PlayerTurnDeactivated.Add(ALSelectSuperNestPosition)

function ALBuyHuge(label,tribeID)
    local SaveNestPlayer = Players[0]
    local nest = SaveNestPlayer:GetProperty('al_nest_'..tribeID)
    if nest.exist ~= 1 then return; end
    local EraType = GameInfo.Eras[Game.GetEras():GetCurrentEra()].EraType
    local EraTypeName = string.match(EraType,"ERA_(%u+)")
    if EraTypeName ~= 'ANCIENT' then
        EraTypeName = 'ANCIENT'
    end
    local iPlotIndex = Map.GetPlot(nest.x,nest.y):GetIndex();
    local pBarbManager = Game.GetBarbarianManager()

    if nest.type ~= 'TRIBE_AL_NEST_SUPER' then
        pBarbManager:CreateTribeUnits(nest.index, 'CLASS_AL_HUGE'..label, 1, iPlotIndex, 3)
    else
        pBarbManager:CreateTribeUnits(nest.index, 'CLASS_AL_HUGE_SUPER_'..label, 1, iPlotIndex, 3)
    end

    local nextturn = nest.points
    if label == 'GIGANT' then
        nextturn = nextturn - NestPhase1
    end
    if label == 'ULTRA' then
        nextturn = nextturn - NestPhase2
    end
    local nowcaves = nest.caves
    local nestx = nest.x
    local nesty = nest.y
    local nesttype = nest.type
    local nestlevel = nest.level
    local nowcavenumber = nest.cavenumber
    local nestindex = nest.index
    SaveNestPlayer:SetProperty('al_nest_'..tribeID, {
        exist = 1,
        points = nextturn,
        number = tribeID,
        x = nestx,
        y = nesty,
        type = nesttype,
        cavenumber = nowcavenumber,
        caves = nowcaves,
        level = nestlevel,
        index = nestindex,
    })
    local newnest = SaveNestPlayer:GetProperty('al_nest_'..tribeID)
    print("——————NEST: "..newnest.number.." BUY A "..label.." UNIT. NOW IT HAS "..newnest.points.." POINTS——————")
end

function ALSelectCavePosition(playerID,TribeNumber)
    if playerID ~= 0 then return; end
    local SaveNestPlayer = Players[0]
    local nest = SaveNestPlayer:GetProperty('al_nest_'..TribeNumber)
    if nest.cavenumber >= MaxCaveNumberGigant + 1 then return; end
    if nest.x and nest.y then
        local targetplots = Map.GetNeighborPlots(nest.x, nest.y, 9)
        local CityAdjPlots = {}

        while #CityAdjPlots < 1 do
            local range = 2;
            for k, adjPlot in ipairs(targetplots) do
                if (adjPlot ~= nil) and (adjPlot:IsCity() == false) and (adjPlot:IsWater() == false) and (adjPlot:IsMountain() == false)
                and (adjPlot:GetImprovementType() == -1) and (adjPlot:GetDistrictType() == -1) and (adjPlot:GetUnitCount() ==  0) then
                    if AlCheckCaveValid(adjPlot,range) then
                        print('ALSelectCavePosition: Insert plot'..adjPlot:GetIndex())
                        table.insert(CityAdjPlots,adjPlot)
                    end
                end
            end
            range = range + 2
        end
        print('ALSelectCavePosition: SELECTED '..#CityAdjPlots..' PLOTS')
        local randPlotIndex = Game.GetRandNum(#CityAdjPlots,'ALLB:Get Cave Position') + 1
        ALPlaceHugeCave(CityAdjPlots[randPlotIndex]:GetIndex(),TribeNumber)
    end
end

function AlCheckCaveValid(adjPlot,range)
    local possiblePlots = Map.GetNeighborPlots(adjPlot:GetX(), adjPlot:GetY(), range)
    for j, CaveAdjPlot in ipairs(possiblePlots) do
        if CaveAdjPlot:IsCity() == true then
            if adjPlot:GetProperty('area_deffense_flag_1') then
                local random = Game.GetRandNum(100,'NO WHY')/100
                if adjPlot:GetProperty('area_deffense_flag_1') == 1 then
                    if random > AreaDeffensePercent then
                        return true;
                    else
                    end
                end
            else
                return true;
            end
        end
    end
end

function ALRefreshNest(PlotX, PlotY, eOwner)
    local SaveNestPlayer = Players[0]
    local i = 1
    local era = Game.GetEras():GetCurrentEra()
    local GlobalNestNumber = SaveNestPlayer:GetProperty('GlobalNestNumber')
    if GlobalNestNumber == nil then GlobalNestNumber = 0; end
    if era == nil then
        era = 0
    end
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    while i < MaxNumber + 1 do
        local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
        if nest and nest.exist == 1 and nest.x == PlotX and nest.y == PlotY  then
            SaveNestPlayer:SetProperty('al_nest_'..i, {
                exist = 0,
                points = 0,
                number = i,
                x = nil,
                y = nil,
                type = nil,
                cavenumber = 0,
                caves = {},
                level = 0,
                index = nil,
            })
            SaveNestPlayer:SetProperty('GlobalNestNumber',GlobalNestNumber - 1) 
            local newnest = SaveNestPlayer:GetProperty('al_nest_'..i)
            print("——————NEST "..i.."AT POSITION X:"..PlotX.." Y: "..PlotY.."HAS BEEN DESTROYED——————")
            AlBreakHugeTribe(PlotX,PlotY,'NEST')
            Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_BREAK_NEST"), PlotX, PlotY);
            local GlobalDestroyedNum = Players[0]:GetProperty('Global_Destroyed_Num')
            GlobalDestroyedNum = GlobalDestroyedNum + 1
            Players[0]:SetProperty('Global_Destroyed_Num', GlobalDestroyedNum)
            break
        end
        i = i + 1
    end
end

function AlBreakHugeTribe(x,y,TribeType)
    local pPlot = Map.GetPlot(x, y)
    if pPlot:IsUnit() then
        for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
            if unit then
                local pPlayer = Players[unit:GetOwner()]
                if TribeType == 'NEST' then
                    if pPlayer:GetProperty('POLICY_AL_SEITOKAI_4_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestEnovyRange,2,'Minor')
                    end
                    if pPlayer:GetProperty('POLICY_AL_FUUKI_6_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestFavorabilityRange,2,'Major')
                        pPlayer:GetDiplomacy():ChangeFavor(100);
                    end
                    if pPlayer:GetProperty('POLICY_AL_FUUKI_8_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestEnovyRange,2,'Minor')
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestFavorabilityRange,2,'Major')
                        pPlayer:GetDiplomacy():ChangeFavor(100);
                    end
                    break
                elseif TribeType == 'CAVE' then
                    if pPlayer:GetProperty('POLICY_AL_SEITOKAI_4_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestEnovyRange,1,'Minor')
                    end
                    if pPlayer:GetProperty('POLICY_AL_FUUKI_6_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestFavorabilityRange,1,'Major')
                        pPlayer:GetDiplomacy():ChangeFavor(50);
                    end
                    if pPlayer:GetProperty('POLICY_AL_FUUKI_8_FLAG') == 1 then
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestEnovyRange,1,'Minor')
                        AlGetBonusFromHuge(unit:GetOwner(),pPlot:GetIndex(),NestFavorabilityRange,1,'Major')
                        pPlayer:GetDiplomacy():ChangeFavor(50);
                    end
                    break
                end
            end
        end
    end
end


function AlGetBonusFromHuge(PlayerID,iPlot,range,num,label)
    local pPlayer = Players[PlayerID]
    local pPlot = Map.GetPlotByIndex(iPlot)
    local targetplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), range)
    print('AlGetBonusFromHuge: START! RANGE is '..range..' LABEL is '..label)

    for _,plot in ipairs(targetplots) do
        if plot:IsCity() then
            local pCity = CityManager.GetCityAt(plot:GetX(), plot:GetY())

            if label == 'Minor' or label == 'Both' then
                if ExposedMembers.AL.AlCheckMinor(pCity:GetOwner()) then
                    local i = 1
                    while i <= num do
                        pPlayer:GetInfluence():GiveFreeTokenToPlayer(pCity:GetOwner());
                        print('AlGetBonusFromHuge: Get Envoy at '..pCity:GetOwner())
                        Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_GET_ENVOY"), pCity:GetX(), pCity:GetY());
                        i=i+1
                    end
                end
            end

            if label == 'Major' or label == 'Both' then
                local iCityOwner = pCity:GetOwner()
                local CityOwner = Players[iCityOwner]
                local pPlayerConfig = PlayerConfigurations[PlayerID];
                if iCityOwner ~= PlayerID then
                    if string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)") == nil then return;end
                    local LeaderName = string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)")
                    if CityOwner:IsMajor() then
                        local i = 1
                        while i <= num do
                            CityOwner:AttachModifierByID('MODIFIER_AL_KILL_HUGE_WELCOM_'..LeaderName)
                            print('AlGetBonusFromHuge: Get Favorability at '..pCity:GetOwner())
                            Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_GET_FAVORABILITY"), pCity:GetX(), pCity:GetY());
                            i=i+1
                        end
                    end
                end
            end

        end
    end
end


function ALRefreshCave(PlotX, PlotY, eOwner)
    local SaveNestPlayer = Players[0]
    local i = 1
    local era = Game.GetEras():GetCurrentEra()
    if era == nil then
        era = 0
    end
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    while i < MaxNumber + 1 do
        local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
        if nest and nest.exist == 1 and nest.caves ~= nil then
            local gotcaves = nest.caves
            for k, cave in ipairs(nest.caves) do
                if cave.x == PlotX and cave.y == PlotY then
                    local nowcaves = nest.caves
                    table.remove(nowcaves,k)
                    local nowcavenumber = nest.cavenumber - 1
                    local nextturn = nest.points
                    local nestx = nest.x
                    local nesty = nest.y
                    local nesttype = nest.type
                    local nestlevel = nest.level
                    local nestindex = nest.index
                    SaveNestPlayer:SetProperty('al_nest_'..i, {
                        exist = 1,
                        points = nextturn,
                        number = i,
                        x = nestx,
                        y = nesty,
                        type = nesttype,
                        cavenumber = nowcavenumber,
                        level = nestlevel,
                        caves = nowcaves,
                        index = nestindex,
                    })
                    print("——————CAVE BELONGS TO NEST "..i.." AT X:"..PlotX.." Y:"..PlotY.."HAS BEEN DESTROYED——————")
                    AlBreakHugeTribe(PlotX,PlotY,'CAVE')
                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_BREAK_CAVE"), PlotX, PlotY);
                    break
                end
            end
        end
        i = i + 1
    end
end


function RefreshUnitAdded(playerID,unitID)
    if IsLilyCivilization(playerID) == false then return;end
    RefreshCharmBreakLevel(playerID)
    AlCitySetNekoBuilding(playerID)
    AlSetShenlinBuilding(playerID)
    SetPromiseLevelToUnits(playerID,nil,0)
    KanbaLilyReligion(playerID,unitID)
end
Events.UnitAddedToMap.Add(RefreshUnitAdded);

function KanbaLilyReligion(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local pPlayer = Players[playerID]
    if GameInfo.Units[pUnit:GetType()].UnitType == 'UNIT_AL_KANBALILY' then
        local religiontype = pPlayer:GetReligion():GetReligionInMajorityOfCities() 
        if religiontype and ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',1) then
            local ur = pUnit:GetReligion()
            ur:SetReligionType(religiontype)
            ur:ChangeReligiousStrength(100)
            ur:ChangeSpreadCharges(3)
        end
    end
end

function ALHealUnits(playerID, unitid ,hp)
    local pUnit = UnitManager.GetUnit(playerID, unitid);
    pUnit:ChangeDamage(hp);
end
ExposedTable['ALHealUnits'] = ALHealUnits


function ALUnitsEarnMove(playerID, unitid ,extramove)
    local pUnit = UnitManager.GetUnit(playerID, unitid);
    UnitManager.ChangeMovesRemaining(pUnit,extramove)
end
ExposedTable['ALUnitsEarnMove'] = ALUnitsEarnMove

function ALUnitsRestoreMove(playerID, unitid)
    local pUnit = UnitManager.GetUnit(playerID, unitid);
    UnitManager.RestoreUnitAttacks(pUnit);
    UnitManager.RestoreMovement(pUnit);
    UnitManager.RestoreMovementToFormation(pUnit);
    print("ALUnitsRestoreMove")
end
ExposedTable['ALUnitsRestoreMove'] = ALUnitsRestoreMove

function ALShowPromiseMessage(boolean, message, x ,y)
    Game.AddWorldViewText(boolean, message, x, y);
end
ExposedTable['ALShowPromiseMessage'] = ALShowPromiseMessage

function ALAttachModifier(playerID,modifierfix)
    local pPlayer = Players[playerID]
    local ModifierTable = {}
    local i = 1;
    
    while i < 99 do
        if GameInfo.Modifiers[modifierfix..'_'..i] then
            table.insert(ModifierTable,modifierfix..'_'..i)
            print('ALAttachModifier: modifierfix is '..modifierfix..'_'..i)
        else
            break;
        end
        i = i + 1
    end

    for j,modifier in ipairs(ModifierTable) do
        pPlayer:AttachModifierByID(modifier)
    end
end
ExposedTable['ALAttachModifier'] = ALAttachModifier

function ALSetPropertyFlag(playerID,property,propertycontext)
    local pPlayer = Players[playerID]
    pPlayer:SetProperty(property,propertycontext);
end
ExposedTable['ALSetPropertyFlag'] = ALSetPropertyFlag

function ALSetUnitPropertyFlag(playerID,unitID,property,propertycontext)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    pUnit:SetProperty(property,propertycontext);
end
ExposedTable['ALSetUnitPropertyFlag'] = ALSetUnitPropertyFlag

function ALChangeResource(playerID,resourceindex,amount)
    local pPlayer = Players[playerID]
    local playerResources = pPlayer:GetResources();
    playerResources:ChangeResourceAmount(resourceindex, amount);
end
ExposedTable['ALChangeResource'] = ALChangeResource


Events.ImprovementRemovedFromMap.Add(ALRefreshNest);
Events.ImprovementRemovedFromMap.Add(ALRefreshCave);
Events.ImprovementRemovedFromMap.Add(GardenRemoveTribe);
Events.Combat.Add(ALUnitKilledInCombat);

Events.UnitGreatPersonCreated.Add(YurigaokaGetLilyGreats);
Events.UnitGreatPersonCreated.Add(KaedeGetBoost);

function ALGetUniqueGreat (playerID, governorID, ePromotion)
    if IsLilyCivilization(playerID) then
        local pPlayer = Players[playerID]
        if string.match(GameInfo.Governors[governorID].Name, "AL_(%u+)") == nil then return; end
        local govername = string.match(GameInfo.Governors[governorID].Name, "AL_(%u+)")
        local capital = pPlayer:GetCities():GetCapitalCity()
        if pPlayer:GetProperty(govername..'_greatnormal_flag') == nil then
            if GameInfo.Units['UNIT_AL_'..govername..'_GREATNORMAL'] then
                UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_'..govername..'_GREATNORMAL', capital:GetX(), capital:GetY(), 1)
                pPlayer:SetProperty(govername..'_greatnormal_flag',1)
                print('AlGetGreatUnits:Get Unit '..govername)
            end
        end
    end
end
Events.GovernorPromoted.Add(ALGetUniqueGreat);

function HimekaGetModifiers (playerID, governorID, ePromotion)
    if IsLilyCivilization(playerID) then
        local pPlayer = Players[playerID]
        if string.match(GameInfo.Governors[governorID].Name, "AL_(%u+)") == nil then return; end
        local govername = string.match(GameInfo.Governors[governorID].Name, "AL_(%u+)")
        if govername ~= 'HIMEKA' then return; end
        local capital = pPlayer:GetCities():GetCapitalCity()
        local numberT = string.match(GameInfo.GovernorPromotions[ePromotion].Name, govername.."_(%d+)")
        local number = tonumber(numberT)
        if number == 1 then
            local property = {cityID = nil,cityPlayer = nil,cityType = nil,Turns = -1,Level = number}
            pPlayer:SetProperty('GOV_HIMEKA_PROPERTY',property);
            print('HimekaGetModifiers:姬歌状态更新：等级为'..number)
        elseif number > 1 then
            local property = pPlayer:GetProperty('GOV_HIMEKA_PROPERTY');
            property.Level = number
            pPlayer:SetProperty('GOV_HIMEKA_PROPERTY',property);
            print('HimekaGetModifiers:姬歌状态更新：等级为'..number)
        end
    end
end
Events.GovernorPromoted.Add(HimekaGetModifiers);

function HimekaPropmotions(playerID)
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    local property = pPlayer:GetProperty('GOV_HIMEKA_PROPERTY')
    if property then
        local PlayerUnits = pPlayer:GetUnits()
        local city = CityManager.GetCity(property.cityPlayer, property.cityID);
        local turn = property.Turns
        local cPlayer = Players[property.cityPlayer]
        local capital = pPlayer:GetCities():GetCapitalCity()
        local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())
        for row in GameInfo.AL_CityStateModifiers() do
            pPlot:SetProperty('PROPERTY_HIMEKA_'..row.ModifierId,nil)
        end
        if turn >= 0 then
            turn = turn + 1;
            property.Turns = turn
            pPlayer:SetProperty('GOV_HIMEKA_PROPERTY',property);
            print('HimekaGetModifiers:姬歌状态更新：回合为'..turn)
            if turn > ExposedMembers.AL.GetGovernorTurnsToEstablish(playerID,'GOVERNOR_AL_HIMEKA') then
                property.Turns = -1
                print('HimekaGetModifiers:姬歌状态更新：任职时效果触发')
                pPlayer:SetProperty('GOV_HIMEKA_PROPERTY',property);
                if property.cityType == 'STATE' then
                    if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',2) then
                        pPlayer:GetInfluence():GiveFreeTokenToPlayer(property.cityPlayer);
                        Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_2_AFTER"), city:GetX(), city:GetY());
                    end
                    if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',4) then
                        
                        for i, unit in PlayerUnits:Members() do
                            if GameInfo.Units[unit:GetType()].UnitType == 'UNIT_AL_KANBALILY' then
                                local religiontype = pPlayer:GetReligion():GetReligionInMajorityOfCities() 
                                if religiontype then
                                    local ur = unit:GetReligion()
                                    ur:SetReligionType(religiontype)
                                    ur:ChangeSpreadCharges(1)
                                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_4_AFTER"), unit:GetX(), unit:GetY());
                                end
                            end
                        end
                    end
                elseif property.cityType == 'ABROAD' then
                    if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',3) then
                        cPlayer:AttachModifierByID('MOD_GOVERNOR_AL_HIMEKA_3_2')
                        Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_3_AFTER"), city:GetX(), city:GetY());
                    end
                    if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',5) then
                        for i, unit in PlayerUnits:Members() do
                            if GameInfo.Units[unit:GetType()].UnitType == 'UNIT_AL_KANBALILY' then
                                local religiontype = pPlayer:GetReligion():GetReligionInMajorityOfCities() 
                                if religiontype then
                                    local ur = unit:GetReligion()
                                    ur:SetReligionType(religiontype)
                                    ur:ChangeSpreadCharges(1)
                                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_5_AFTER"), unit:GetX(), unit:GetY());
                                end
                            end
                        end
                    end
                end
                if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',6) then
                    local religiontype = pPlayer:GetReligion():GetReligionInMajorityOfCities()
                    local pCityReligion = city:GetReligion();
                    if pCityReligion:GetMajorityReligion() == religiontype then
                        for i, unit in PlayerUnits:Members() do
                            if GameInfo.Units[unit:GetType()].UnitType == 'UNIT_AL_KANBALILY' then
                                local ur = unit:GetReligion()
                                ur:SetReligionType(religiontype)
                                ur:ChangeSpreadCharges(2)
                                Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_6_AFTER"), unit:GetX(), unit:GetY());
                            end
                        end
                    end
                end
                return;
            end
            if property.cityType == 'STATE' then
                if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',2) then
                    local token = cPlayer:GetInfluence():GetTokensReceived(playerID)
                    local era = Game.GetEras():GetCurrentEra() + 1
                    local amount = token*era
                    pPlayer:GetReligion():ChangeFaithBalance(amount);
                    pPlayer:GetCulture():ChangeCurrentCulturalProgress(amount);
                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_2_BEFORE",amount), city:GetX(), city:GetY());
                end
                if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',4) then
                    local capital = pPlayer:GetCities():GetCapitalCity()
                    local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())
                    local cityname = string.match(PlayerConfigurations[property.cityPlayer]:GetCivilizationTypeName(), "CIVILIZATION_(%u+)")
                    for row in GameInfo.AL_CityStateModifiers() do
                        if cityname == string.match(row.ModifierId,"MINOR_CIV_(%u+)") then
                            pPlot:SetProperty('PROPERTY_HIMEKA_'..row.ModifierId,1)
                            print('HimekaGetModifiers:获得城邦效果'..row.ModifierId)
                            Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_4_BEFORE"), city:GetX(), city:GetY());
                        end
                    end
                end
            elseif property.cityType == 'ABROAD' then
                if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',3) then
                    local pop = city:GetPopulation()
                    local era = Game.GetEras():GetCurrentEra() + 1
                    local amount = pop*era
                    pPlayer:GetTechs():ChangeCurrentResearchProgress(amount);
                    pPlayer:GetTreasury():ChangeGoldBalance(amount);
                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_3_BEFORE",amount), city:GetX(), city:GetY());
                end
                if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',5) then
                    local pop = city:GetPopulation()
                    for row in GameInfo.GreatPersonClasses() do
                        pPlayer:GetGreatPeoplePoints():ChangePointsTotal(row.Index,pop);
                    end
                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_5_BEFORE",pop), city:GetX(), city:GetY());
                end
            end
            if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_HIMEKA',6) then
                local religiontype = pPlayer:GetReligion():GetReligionInMajorityOfCities() 
                if religiontype then
                    city:GetReligion():AddReligiousPressure(0, religiontype, 50, playerID);
                    Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HIMEKA_GOVSKILL_6_BEFORE"), city:GetX(), city:GetY());
                end
            end
        end
    end
end
Events.PlayerTurnActivated.Add(HimekaPropmotions);

function HimekaAssign(cityPlayer, cityID, playerID, eGovernor)
    if IsLilyCivilization(playerID) == false or eGovernor ~= GameInfo.Governors['GOVERNOR_AL_HIMEKA'].Index then return;end
    local pPlayer = Players[playerID]
    local property = pPlayer:GetProperty('GOV_HIMEKA_PROPERTY');
    local cityType = nil
    if ExposedMembers.AL.AlCheckMinor(cityPlayer) then
        cityType = 'STATE'
    elseif Players[cityPlayer]:IsMajor() and cityPlayer ~= playerID then
        cityType = 'ABROAD'
    elseif cityPlayer == playerID then
        cityType = 'SELF'
    end
    property.cityType = cityType
    property.cityID = cityID
    property.cityPlayer = cityPlayer
    property.Turns = 0
    pPlayer:SetProperty('GOV_HIMEKA_PROPERTY',property);
    print('HimekaAssign:姬歌状态更新：就职城市为'..property.cityType)
end
Events.GovernorAssigned.Add(HimekaAssign);

function NestInitialize()
    
    local SaveNestPlayer = Players[0]
    local i = 1
    local era = Game.GetEras():GetCurrentEra()
    if era == nil then
        era = 0
    end
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    while i < MaxNumber + 1 do
        local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
        if nest == nil then
            SaveNestPlayer:SetProperty('al_nest_'..i, {
                exist = 0,
                points = 0,
                number = i,
                x = nil,
                y = nil,
                type = nil,
                cavenumber = 0,
                caves = {},
                level = 0,
                index = nil,
            })
            local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
            print("——————ALREADY SET NEST "..nest.number.."——————")
        end
        i = i + 1
    end
    if SaveNestPlayer:GetProperty('Global_Destroyed_Num') == nil then
        SaveNestPlayer:SetProperty('Global_Destroyed_Num',0)
    end
end
Events.LoadGameViewStateDone.Add(NestInitialize)
Events.PlayerTurnDeactivated.Add(NestInitialize)

function ResetNeunweltResource(playerID)
    if not IsLilyCivilization(playerID) then
        local pPlayer = Players[playerID]
        local playerResources = pPlayer:GetResources();
        local resource = GameInfo.Resources['RESOURCE_AL_NEUNWELT'].Index
        local amount = playerResources:GetResourceAmount(resource)
        if amount <= 0 then 
            return;
        elseif amount >0 then
            playerResources:ChangeResourceAmount(resource, amount*-1);
        end
    end
    
end
Events.PlayerTurnDeactivated.Add(ResetNeunweltResource);

function ALNestGetTurn(PlayerID)
    
    if PlayerID ~= 0 then return; end
    local SaveNestPlayer = Players[0]
    local i = 1
    local era = Game.GetEras():GetCurrentEra()
    if era == nil then
        era = 0
    end
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    while i < MaxNumber + 1 do
        local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
        if nest and nest.exist == 1 then
            local point = nest.level
            local nextturn = nest.points + point
            local nestx = nest.x
            local nesty = nest.y
            local nesttype = nest.type
            local nestcave = nest.cavenumber
            local nestcaves = nest.caves
            local nestindex = nest.index
            SaveNestPlayer:SetProperty('al_nest_'..i,{
                exist = 1,
                points = nextturn,
                number = i,
                x = nestx,
                y = nesty,
                type = nesttype,
                cavenumber = nestcave,
                caves = nestcaves,
                level = point,
                index = nestindex,
            })
            local newnest = SaveNestPlayer:GetProperty('al_nest_'..i)
        end
        i = i + 1
    end
end
Events.PlayerTurnDeactivated.Add(ALNestGetTurn);

function ALSelectNestPosition(playerID)
    if playerID ~= 0 then return; end
    local SaveNestPlayer = Players[playerID]
    local era = Game.GetEras():GetCurrentEra()
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    local GlobalNestNumber = SaveNestPlayer:GetProperty('GlobalNestNumber')
    if GlobalNestNumber == nil then GlobalNestNumber = 0; end
    if GlobalNestNumber >= MaxNumber or era<HugeEra then return;end
    local GlobalDestroyedNum = Players[0]:GetProperty('Global_Destroyed_Num')
    local NaturalPercent = NaturalNestPercent - era * EraRateParamater + DestroyedNestParamater * GlobalDestroyedNum
    local rand = Game.GetRandNum(100,'NO WHY')/100
    local plotindex = {}
    print('ALSelectNestPosition:NaturalPercent is '..NaturalPercent..' and rand is '..rand)
    if rand < HugeNestPercent then 
        plotindex = GetNestPlots()
    end
    if rand > NaturalPercent then 
        plotindex = GetNaturalNestPlots()
    end
    print('ALSelectNestPosition: Get '..#plotindex..' plots')
    local randPlotIndex = Game.GetRandNum(#plotindex,'ALLB:Get Nest Position') + 1
    local rand1 = Game.GetRandNum(100,'NO WHY')/100
    if rand1 < 0.5 and #plotindex > 0 then
        local TribeIndex = GameInfo.BarbarianTribes['TRIBE_AL_NEST_GIGANT'].Index
        ALPlaceHugeNest(TribeIndex,plotindex[randPlotIndex]:GetIndex())
        AlPlotNearbyUnitCheck(plotindex[randPlotIndex],false)
    end
    if rand1 >= 0.5 and rand1 < 1 and #plotindex > 0 then
        local TribeIndex = GameInfo.BarbarianTribes['TRIBE_AL_NEST_GIGANT_SEA'].Index
        ALPlaceHugeNest(TribeIndex,plotindex[randPlotIndex]:GetIndex())
        AlPlotNearbyUnitCheck(plotindex[randPlotIndex],false)
    end
    
end
Events.PlayerTurnDeactivated.Add(ALSelectNestPosition);

function ALNestBuyItems(playerID)
    if playerID ~= 0 then return; end
    
    local era = Game.GetEras():GetCurrentEra()
    local MaxNumber = MaxNestNumber + EraNumberParamater*era
    local SaveNestPlayer = Players[0]
    local i = 1
    while i <= MaxNumber do
        
        local nest = SaveNestPlayer:GetProperty('al_nest_'..i)
        local rand = Game.GetRandNum(100,'NO WHY')/100
        if nest.exist == 1 and nest.points >= NestPhase1 then
            if nest.points >= NestPhase1 and nest.points < NestPhase2 then
                if rand < 0.02 then
                    print("NEST "..i.." BEGIN TO BUY GIGANT")
                    ALBuyHuge('GIGANT',i)
                end
            end
            if nest.points >= NestPhase2 and nest.points < NestPhase3 then
                if rand < 0.02 then
                    print("NEST "..i.." BEGIN TO BUY GIGANT")
                    ALBuyHuge('GIGANT',i)
                end
                if rand >= 0.02 and rand < 0.04 and string.match(nest.type,"NEST_(%u+)") ~= 'GIGANT' then
                    print("NEST "..i.." BEGIN TO BUY ULTRA")
                    ALBuyHuge('ULTRA',i)
                end
            end
            if nest.points >= NestPhase3 and nest.points < NestPhase4 then
                if rand < 0.02 then
                    print("NEST "..i.." BEGIN TO BUY GIGANT")
                    ALBuyHuge('GIGANT',i)
                end
                if rand >= 0.02 and rand < 0.04 and string.match(nest.type,"NEST_(%u+)") ~= 'GIGANT' then
                    print("NEST "..i.." BEGIN TO BUY ULTRA")
                    ALBuyHuge('ULTRA',i)
                end
                if rand >= 0.04 and rand < 0.1 then
                    if nest.cavenumber >= MaxCaveNumberGigant + 1 then return; end
                    print("NEST "..i.." BEGIN TO BUY CAVE")
                    ALSelectCavePosition(playerID,i)
                end
            end
            if nest.points >= nest.level*NestPhase4 then
                local uprand = Game.GetRandNum(100,'NO WHY')/100
                if uprand < 0.75 then
                    print("NEST "..i.." BEGIN TO UPDATE")
                    local nowcaves = nest.caves
                    local nowcavenumber = nest.cavenumber
                    local nextturn = nest.points - NestPhase4
                    local nestx = nest.x
                    local nesty = nest.y
                    local nesttype = nest.type
                    local nestlevel = nest.level + 1
                    local nestindex = nest.index
                    SaveNestPlayer:SetProperty('al_nest_'..i, {
                        exist = 1,
                        points = nextturn,
                        number = i,
                        x = nestx,
                        y = nesty,
                        type = nesttype,
                        cavenumber = nowcavenumber,
                        caves = nowcaves,
                        level = nestlevel,
                        index = nestindex,})
                    local pAllPlayerIDs : table = PlayerManager.GetAliveIDs();	
                    for k, iPlayerID in ipairs(pAllPlayerIDs) do
                        local notification = GameInfo.Notifications["NOTIFICATION_AL_NEST_UPDATE"]
                        NotificationManager.SendNotification(iPlayerID, notification.NotificationType, notification.Message, notification.Summary, nest.x, nest.y);
                    end
                end
                if uprand >= 0.25 and string.match(nest.type,"NEST_(%u+)") == 'GIGANT' then
                    print("NEST "..i.." BEGIN TO BUY ULTRA")
                    ALBuyHuge('ULTRA',i)
                end
            end
        end
        i = i + 1
    end
    
end
Events.PlayerTurnDeactivated.Add(ALNestBuyItems);

function MagiSphereInitialize()
    local players = Game.GetPlayers()
	for _,pPlayer in ipairs(players) do
		local i = 1;
        local playerid = pPlayer:GetID()
        while i < MaxNeunWeltNumber + 1 do
            pPlayer:SetProperty(playerid..'magi_sphere_'..i,{
                started = 0,
                pass = 0,
                combat = 0,
                turn =nil,
            });
            i = i + 1
        end
	end
end
Events.LoadGameViewStateDone.Add(MagiSphereInitialize)

function MagiSphereGetMessage(playerID,i)
    local pPlayer = Players[playerID]
    local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
    return magisphere.started, magisphere.pass, magisphere.combat, magisphere.turn;
end
ExposedTable['MagiSphereGetMessage'] = MagiSphereGetMessage

function MagiSphereChange(playerID, i, istarted, ipass, icombat, iturn)
    local pPlayer = Players[playerID]
    local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
    pPlayer:SetProperty(playerID..'magi_sphere_'..i,{
        started = istarted,
        pass = ipass,
        combat = icombat,
        turn = iturn,
    })
    local newmagisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
    print('MagiSphereChange'..newmagisphere.started)
    print('MagiSphereChange'..newmagisphere.pass)
    print('MagiSphereChange'..newmagisphere.combat)
    print("MS CHANGED! MS NUMBER"..i.." NOW HAS STARTED "..newmagisphere.started.." pass "..newmagisphere.pass.." combat "..newmagisphere.combat)
end
ExposedTable['MagiSphereChange'] = MagiSphereChange

function MagiSphereDead(playerID)
    local pPlayer = Players[playerID]
    local i = 1;
    local nowturn = Game.GetCurrentGameTurn()
    
    while i < MaxNeunWeltNumber + 1 do
        local magisphere = pPlayer:GetProperty(playerID..'magi_sphere_'..i)
        if magisphere.turn and nowturn - magisphere.turn >= 10 then
            
            local PlayerUnits = pPlayer:GetUnits()
            for j,unit in PlayerUnits:Members() do
                if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
                    if unit:GetProperty(string.match(unit:GetName(),"(%u+)_GREATNORMAL")..'has_ball')
                    and unit:GetProperty('ball_number') == i then
                        unit:SetProperty(string.match(unit:GetName(),"(%u+)_GREATNORMAL")..'has_ball',0)
                        unit:SetProperty('ball_number',0)
                        print("MagiSphereReset")
                        local x = unit:GetX()
                        local y = unit:GetY()
                        local message = Locale.Lookup('LOC_MOD_AL_NEUNWELT_PASS_FAILED');
                        Game.AddWorldViewText(1, message, x, y);
                    end
                end
            end
            MagiSphereChange(playerID, i, 0, 0, 0, nil)
        end
        i = i + 1
    end
    
end

Events.PlayerTurnDeactivated.Add(MagiSphereDead);




function AlCheckAtWar(playerID, targetplayerID)
    local pPlayer = Players[playerID]
    local PD = pPlayer:GetDiplomacy()
    if PD:IsAtWarWith(targetplayerID) then
        return true;
    else
        return false;
    end
end
ExposedTable['AlCheckAtWar'] = AlCheckAtWar


function ALFinishShot(playerID, plotId, unitID)
    print("FinishShot Begin")
    local pPlayer = Players[playerID]
    local pPlot = Map.GetPlotByIndex(plotId)
    local pUnit = UnitManager.GetUnit(playerID, unitID);
    local unitname = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    print("FinishShot at "..pPlot:GetX().." and "..pPlot:GetY())

    local passnumber = pUnit:GetProperty('ball_number')

    local started,pass,combat,turn = MagiSphereGetMessage(playerID, passnumber)

    local targetplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 2)
    for i, plot in ipairs(targetplots) do
        for j, unit in ipairs(Units.GetUnitsInPlot(plot)) do
            if unit then
                local iPlayer = Players[unit:GetOwner()]
                local damage = FinishShotDamage(pPlayer, pPlot, unit,combat)
                if iPlayer:IsBarbarian() then
                    
                    if string.match(unit:GetName(),"UNIT_AL_HUGE_(%u+)") then
                        if string.match(unit:GetName(),"UNIT_AL_HUGE_(%u+)") == 'YURI' and pPlayer:GetProperty('YURI_ALIVE') == nil and unit:GetProperty('YURI_HUGE_OWNER') == playerID then
                            if pPlayer:GetProperty('FIGHT_YURI_HUGE')== 1 then
                                local owner = unit:GetProperty('YURI_HUGE_OWNER')
                                local yuriPlayer = Players[owner]
                                if yuriPlayer:GetProperty('YURI_DIED') or yuriPlayer:GetProperty('YURI_ALIVE') then return;end
                                yuriPlayer:SetProperty('YURI_ALIVE',1)
                                AlYuriPopup(owner,18)
                                ExposedMembers.AL.UIPlayersound('YURI_END2')
                                UnitManager.Kill(unit)

                                print('Finishi shot 击杀结梨胡歌！')
                            else
                                damage= 50
                                unit:ChangeDamage(damage);
                                YuriHugeDamageChanged(unit:GetOwner(),unit:GetID(),50,100)
                            end
                        else
                            unit:ChangeDamage(damage*1.25);
                        end
                    else
                        unit:ChangeDamage(damage*1.25);
                    end
                elseif iPlayer:IsBarbarian() == false and AlCheckAtWar(playerID, unit:GetOwner()) == true then
                    unit:ChangeDamage(damage);
                end
            end
        end
    end
    MagiSphereChange(playerID,passnumber,0,0,0,nil)
    ALSetUnitPropertyFlag(playerID, unitID, unitname..'has_ball', 0)
    ALSetUnitPropertyFlag(playerID, unitID, 'ball_number', 0)
    local nowturn = Game.GetCurrentGameTurn()

    ALSetUnitPropertyFlag(playerID, unitID, unitname..'_neunwelt_cooldown_turn', nowturn)

    local message  = Locale.Lookup("LOC_AL_NEUNWELT_BOMB");
    local finalmessage = message..combat
    Game.AddWorldViewText(0, finalmessage, pPlot:GetX(), pPlot:GetY());
end
ExposedTable['ALFinishShot'] = ALFinishShot

function YuriHugeDamageChanged(PlayerID,UnitID,newDamage,prevDamage)
    local pUnit = UnitManager.GetUnit(PlayerID, UnitID);
    if pUnit == nil then return;end
    if string.match(pUnit:GetName(),"UNIT_AL_HUGE_(%u+)") then
        if string.match(pUnit:GetName(),"UNIT_AL_HUGE_(%u+)") == 'YURI' and pUnit:GetProperty('YURI_HUGE_OWNER') then
            local pPlayer = Players[pUnit:GetProperty('YURI_HUGE_OWNER')]
            if newDamage >= 50 and newDamage ~= 100 and pPlayer:GetProperty('FIGHT_YURI_HUGE')== nil then
                pPlayer:SetProperty('FIGHT_YURI_HUGE',1)
                AlYuriPopup(pPlayer:GetID(),17)
                ExposedMembers.AL.UIPlayersound('YURI_MIDDLE3')
            end
        end
    end
end
Events.UnitDamageChanged.Add(YuriHugeDamageChanged);

function KanahoDamageChanged(PlayerID,UnitID,newDamage,prevDamage)
    if IsLilyCivilization(PlayerID) then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID);
        if pUnit then
            local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
            if pName and pName == 'KANAHO' then
                if prevDamage > newDamage then
                    local pPlot = Map.GetPlot(pUnit:GetX(),pUnit:GetY())
                    local NearTakane,FlagNearTakane = NearTakane(pPlot)
                    if FlagNearTakane then
                        local takane = GetLilyUnit(PlayerID,'TAKANE')
                        if takane and takane:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_2_2'].Index) then
                            local heal = prevDamage - newDamage
                            heal = heal * 0.5
                            takane:ChangeDamage(-1*heal)
                        end
                    end
                end
            end
        end
    end
end
Events.UnitDamageChanged.Add(KanahoDamageChanged);

function UnitDeadWithMagiSphere(playerID, unitID)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    local i = 1

    if pUnit == nil then return;end
    if pUnit:GetOwner() == playerID and pUnit:GetProperty('ball_number') then
        local ballnumber = pUnit:GetProperty('ball_number')
        while i <= MaxNeunWeltNumber do
            if ballnumber == i then
                MagiSphereChange(playerID,ballnumber,0,0,0,nil)
                local message = Locale.Lookup('LOC_MOD_AL_NEUNWELT_PASS_FAILED');
                local city = pPlayer:GetCities():GetCapitalCity()
                Game.AddWorldViewText(1, message, city:GetX(), city:GetY());
                break;
            end
            i = i+1
        end
    end
end
Events.UnitRemovedFromMap.Add(UnitDeadWithMagiSphere)

function YurihugeDie(playerID, unitID)
    local iPlayer = Players[playerID]
    if iPlayer:IsBarbarian() then
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        if pUnit == nil then return;end
        if pUnit:GetProperty('YURI_HUGE_OWNER') then
            local owner = pUnit:GetProperty('YURI_HUGE_OWNER')
            local pPlayer = Players[owner]
            if pPlayer:GetProperty('YURI_DIED') or pPlayer:GetProperty('YURI_ALIVE') then return;end
            pPlayer:SetProperty('YURI_ALIVE',1)
            AlYuriPopup(owner,18)
            ExposedMembers.AL.UIPlayersound('YURI_END2')
        end
    end
end

Events.UnitRemovedFromMap.Add(YurihugeDie)

function NeunweltCombatInitialize()
    local players = Game.GetPlayers()
	for _,pPlayer in ipairs(players) do
        if IsLilyCivilization(pPlayer:GetID()) then
            local i = 1;
            local playerid = pPlayer:GetID()
            for row in GameInfo.AL_GreatUnitNames() do
                local name = row.UnitName
                local combat = row.NeunweltCombat
                local cd = row.NeunweltCD
                local combatproperty = pPlayer:GetProperty(name..'_neunwelt_combat')
                local cdproperty = pPlayer:GetProperty(name..'_neunwelt_cd')

                local rscdproperty = pPlayer:GetProperty(name..'_rs_cd')
                local rstimeproperty = pPlayer:GetProperty(name..'_rs_time')
                local rscd = 15
                local rstime = row.RareSkillCD
                if combatproperty == nil then
                    AlSetNeunweltCombat(playerid,combat,name,'combat')
                end
                if cdproperty == nil then
                    AlSetNeunweltCombat(playerid,cd,name,'cd')
                end
                if rscdproperty == nil then
                    AlSetNeunweltCombat(playerid,rscd,name,'cd',1)
                end
                if rstimeproperty == nil and rstime then
                    AlSetNeunweltCombat(playerid,rstime,name,'time',1)
                end
            end
        end
	end
end
Events.LoadGameViewStateDone.Add(NeunweltCombatInitialize)

function MagiSphereGetCombat(playerID,passnumber,getcombat)
    local pPlayer = Players[playerID]
    local started, pass, combat, turn = MagiSphereGetMessage(playerID, passnumber)
    combat = combat + getcombat
    return combat;
end
ExposedTable['MagiSphereGetCombat'] = MagiSphereGetCombat

function FinishShotDamage(pPlayer, pPlot, unit,combat)
    local unitcombat = unit:GetCombat()
    local dif = combat - unitcombat
    local damage = 0;
    local rand = Game.GetRandNum(13,'NO WHY') + 24
    local finalDamage = rand * math.pow(1.04, dif)
    if finalDamage <= 50 then
        finalDamage = 50
    end
    return finalDamage;
end

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

function AlTrainningBuildingGetProperty(iPlayerID : number, iCityID : number, eBuildingIndex : number, iPlotIndex : number, bOriginalConstruction : boolean)
    if bOriginalConstruction ~= true then return;end
    local pPlot = Map.GetPlotByIndex(iPlotIndex)
    local pPlayer = Players[iPlayerID]

    if eBuildingIndex == GameInfo.Buildings['BUILDING_AL_TRAINING'].Index then
        local TrainningPlots = pPlayer:GetProperty('TranningPlots')
        local TrainningLevel = pPlayer:GetProperty('TranningLevel')
        table.insert(TrainningPlots, iPlotIndex)
        pPlayer:SetProperty('TranningPlots',TrainningPlots)
        AlTranningSetProperty(pPlayer,pPlot,TrainningLevel)
    end

    if eBuildingIndex == GameInfo.Buildings['BUILDING_AL_AREA_DEFENSE'].Index then
        local city = CityManager.GetCity(iPlayerID, iCityID);
        local DeffensePlots = pPlayer:GetProperty('DeffensePlots')
        local cityplotindex = Map.GetPlotIndex(city:GetX(), city:GetY())
        AlSetAreaDeffenseFlag(iCityID,iPlayerID,1)
        table.insert(DeffensePlots, cityplotindex)
        pPlayer:SetProperty('DeffensePlots',DeffensePlots)
        if pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_2_FLAG') == 1 then
            AlSetAreaDeffenseFlag(iCityID,iPlayerID,2)
        end
    end
end
GameEvents.BuildingConstructed.Add(AlTrainningBuildingGetProperty)

function AlSetAreaDeffenseFlagDistricts(playerID, cityID, orderType, unitType, canceled)
	local pPlayer = Players[playerID]
	if pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_2_FLAG') == 1 and orderType == 2 then
        local city = CityManager.GetCity(playerID, cityID);
        ExposedMembers.AL.AlSetAreaDeffenseFlagGarden(city:GetX(),city:GetY(),playerID)
    end
    if orderType == 2 and GameInfo.Districts[unitType].DistrictType == "DISTRICT_AL_MOYU" and pPlayer:GetProperty('YURIGAOKA_GET_MOYU') ~= 1 then
        local individual = GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_AL_LILY_MOYU'].Hash;	
	    local class = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Hash;
	    local era = GameInfo.Eras["ERA_CLASSICAL"].Hash;
	    local cost = 0;		--出场费
        Game.GetGreatPeople():GrantPerson(individual, class, era, cost, playerID, false);
        pPlayer:SetProperty('YURIGAOKA_GET_MOYU',1)
    end
end
Events.CityProductionCompleted.Add(AlSetAreaDeffenseFlagDistricts)

function AlSetAreaDeffenseFlag(iCityID,iPlayerID,switch)
    local pPlayer = Players[iPlayerID]
    local AreaDeffenseLevel = pPlayer:GetProperty('AreaDeffenseLevel')
    local city = CityManager.GetCity(iPlayerID, iCityID);
    if switch == 1 then
        local defplots = Map.GetNeighborPlots(city:GetX(), city:GetY(), pPlayer:GetProperty('AreaDeffenseRange'))
        for _,plot in ipairs(defplots) do
            
            local i = 1;
            while i <=5 do
                if AreaDeffenseLevel >= i then
                    if plot:GetProperty('area_deffense_flag_'..i) ~= 1 then
                        plot:SetProperty('area_deffense_flag_'..i,1)
                    end
                end
                i=i+1
            end
        end
    end
    if switch == 2 then
        ExposedMembers.AL.AlSetAreaDeffenseFlagGarden(city:GetX(),city:GetY(),iPlayerID)
    end
end

function AlSetAreaDeffenseFlagGardenPlots(x,y,playerID)
    local pPlayer = Players[playerID]
    print('AlSetAreaDeffenseFlagGardenPlots: x is '..x..' and y is '..y)
    if pPlayer:GetProperty('DistrictAreaDeffenseRange') == nil then
        pPlayer:SetProperty('DistrictAreaDeffenseRange',DefaultDistrictAreaDeffenseRange)
    end
    local DistrictAreaDeffenseRange = pPlayer:GetProperty('DistrictAreaDeffenseRange')
    local defplots = Map.GetNeighborPlots(x, y, DistrictAreaDeffenseRange)
    local AreaDeffenseLevel = pPlayer:GetProperty('AreaDeffenseLevel')
    for _,plot in ipairs(defplots) do

        local i = 1;
        while i <=5 do
            if AreaDeffenseLevel >= i then
                if plot:GetProperty('area_deffense_flag_'..i) ~= 1 then
                    plot:SetProperty('area_deffense_flag_'..i,1)
                end
            end
            i=i+1
        end
    end
end
ExposedTable['AlSetAreaDeffenseFlagGardenPlots'] = AlSetAreaDeffenseFlagGardenPlots

function AlTranningSetProperty(pPlayer,pPlot,number)
    local hadProperties = {}
    local properties = {}

    for k,property in ipairs(ALTrainningTable) do
        if pPlot:GetProperty(property.name) == 1 then
            print("AlTranningSetProperty: This Plot have property:"..property.name)
            table.insert(hadProperties,property.name)
        end
    end

    local i = 1;
    while i <= number do
        local randPropertyNum = Game.GetRandNum(#ALTrainningTable,'ALLB:Get ALTrainningTable') + 1
        if AlCheckTable(hadProperties,ALTrainningTable[randPropertyNum].name) == false then
            table.insert(properties,ALTrainningTable[randPropertyNum].name)
            i=i+1;
        end
    end

    for j,gotproperty in ipairs(properties) do
        pPlot:SetProperty(gotproperty,1)
        print("AlTrainningBuildingGetProperty Set Property:"..gotproperty..":"..pPlot:GetProperty(gotproperty).." at "..pPlot:GetX().." and "..pPlot:GetY())
    end
end

function AlCheckTable(table,property)
    for i,item in ipairs(table) do
        print("AlCheckTable: item "..i..":"..item)
        print("AlCheckTable: property "..i..":"..property)
        if item == property then
            print("AlCheckTable: table has been got the property:"..property)
            return true;
        end
    end
    return false;
end

function AlTrainningInitialize()
    local players = Game.GetPlayers()
	for _,pPlayer in ipairs(players) do
		if pPlayer:GetProperty('TranningPlots') == nil then
            local TranningPlots = {}
            pPlayer:SetProperty('TranningPlots', TranningPlots)
        end
        if pPlayer:GetProperty('DeffensePlots') == nil then
            local DeffensePlots = {}
            pPlayer:SetProperty('DeffensePlots', DeffensePlots)
        end
        if pPlayer:GetProperty('TranningEXP') == nil then
            pPlayer:SetProperty('TranningEXP', DefaultTranningEXP)
        end
        if pPlayer:GetProperty('TranningLevel') == nil then
            pPlayer:SetProperty('TranningLevel', 1)
        end
        if pPlayer:GetProperty('TranningRange') == nil then
            pPlayer:SetProperty('TranningRange', 1)
        end
        if pPlayer:GetProperty('AreaDeffenseRange') == nil then
            pPlayer:SetProperty('AreaDeffenseRange', DefaultAreaDeffenseRange)
        end
        if pPlayer:GetProperty('AreaDeffenseLevel') == nil then
            pPlayer:SetProperty('AreaDeffenseLevel', DefaultAreaDeffenseLevel)
        end
	end
end
Events.LoadGameViewStateDone.Add(AlTrainningInitialize)

function AlEarnXp(playerID)
    
    local pPlayer = Players[playerID]
    local TrainningPlots = pPlayer:GetProperty('TranningPlots')
    if TrainningPlots == nil or #TrainningPlots == 0 then return; end
    
    local maiID = {}

    for i,iPlotIndex in ipairs(TrainningPlots) do
        local pPlot = Map.GetPlotByIndex(iPlotIndex)
        local xpplots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), pPlayer:GetProperty('TranningRange'))
        for j,iPlot in ipairs(xpplots) do
            for k, unit in ipairs(Units.GetUnitsInPlot(iPlot)) do
                if unit and string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
                    if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MAI_GREATNORMAL_2_2'].Index) == false then
                        unit:GetExperience():ChangeExperience(pPlayer:GetProperty('TranningEXP'))

                        local message = Locale.Lookup('LOC_MOD_AL_TRAINNING_EFFECT');
                        
                        Game.AddWorldViewText(0, message..pPlayer:GetProperty('TranningEXP'), unit:GetX(), unit:GetY());
                    elseif unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MAI_GREATNORMAL_2_2'].Index) then
                        table.insert(maiID,unit:GetID())
                    end
                end
            end
        end
    end
    local PlayerUnits = pPlayer:GetUnits()
    for l, sunit in PlayerUnits:Members() do
        if sunit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MAI_GREATNORMAL_2_2'].Index) then
            local switch = false

            if maiID ~= nil then
                if #maiID > 0 then
                    for m,id in ipairs(maiID) do
                        if id == sunit:GetID() then
                            switch = true
                        end
                    end
                end
            end

            if switch == false then
                sunit:GetExperience():ChangeExperience(pPlayer:GetProperty('TranningEXP')/2)
            end
        end
    end
end
Events.PlayerTurnDeactivated.Add(AlEarnXp);

function AlEarnXpFromTourism(playerID)
    if IsLilyCivilization(playerID) and IsLeader(playerID,'KANAHO') then
        if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_TAKANE',5) then
            local tourism = ExposedMembers.AL.GetTourism(playerID)
            local pPlayer = Players[playerID]
            local PlayerUnits = pPlayer:GetUnits()
            for _, unit in PlayerUnits:Members() do
                unit:GetExperience():ChangeExperience(tourism/10)
            end
        end
    end
end
Events.PlayerTurnDeactivated.Add(AlEarnXpFromTourism);
local ALMoyuProjectTable = {}
ALMoyuProjectTable[1] = {name = 'BUILDING_AL_VISUAL_MOYU_1'}
ALMoyuProjectTable[2] = {name = 'BUILDING_AL_VISUAL_MOYU_2'}
ALMoyuProjectTable[3] = {name = 'BUILDING_AL_VISUAL_MOYU_3'}
ALMoyuProjectTable[4] = {name = 'BUILDING_AL_VISUAL_MOYU_4'}
ALMoyuProjectTable[5] = {name = 'BUILDING_AL_VISUAL_MOYU_5'}
ALMoyuProjectTable[6] = {name = 'BUILDING_AL_VISUAL_MOYU_6'}
ALMoyuProjectTable[7] = {name = 'BUILDING_AL_VISUAL_MOYU_7'}
ALMoyuProjectTable[8] = {name = 'BUILDING_AL_VISUAL_MOYU_8'}
ALMoyuProjectTable[9] = {name = 'BUILDING_AL_VISUAL_MOYU_9'}
function AlProjectEffects(playerID:number, cityID:number, projectIndex, buildingIndex:number, locX:number, locY:number, bCanceled:boolean)
    local pPlayer = Players[playerID]
    if projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_EXP_1'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_EXP_3'].Index then
        local exp = pPlayer:GetProperty('TranningEXP')
        pPlayer:SetProperty('TranningEXP', exp + DefaultTranningEXPLV2)
        return;
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_EXP_2'].Index then
        local exp = pPlayer:GetProperty('TranningEXP')
        local range = pPlayer:GetProperty('TranningRange')
        pPlayer:SetProperty('TranningEXP', exp + DefaultTranningEXPLV3)
        pPlayer:SetProperty('TranningRange', range + 1)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_ABL_1'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_ABL_2'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_TRANNING_ABL_3'].Index then

        local abl = pPlayer:GetProperty('TranningLevel')
        pPlayer:SetProperty('TranningLevel', abl + 1)
        local TrainningPlots = pPlayer:GetProperty('TranningPlots')
        for i,iPlotIndex in ipairs(TrainningPlots) do
            local pPlot = Map.GetPlotByIndex(iPlotIndex)
            AlTranningSetProperty(pPlayer,pPlot,1)
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_1'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_3'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_5'].Index then
        AlSetNeunweltCombat(playerID,1,nil,'combat')
        AlSetNeunweltCombat(playerID,-1,nil,'cd')
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_2'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_4'].Index then
        AlSetNeunweltCombat(playerID,1.5,nil,'combat')
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_ARSENAL_6'].Index then
        AlSetNeunweltCombat(playerID,2,nil,'combat')
        AlSetNeunweltCombat(playerID,-2,nil,'cd')
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_PROMISE_1'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_PROMISE_2'].Index
    or projectIndex == GameInfo.Projects['PROJECT_AL_PROMISE_3'].Index then
        local promiselevel = pPlayer:GetProperty('player_promise_level')
        pPlayer:SetProperty('player_promise_level', promiselevel + 1)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_1'].Index then
        pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_FUTURE'].Index)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_2'].Index then
        pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_RENAISSANCE'].Index)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_3'].Index then
        pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_INDUSTRIAL'].Index)
    end
    

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_4'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_OHAKA_4_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_OHAKA_4_FLAG', 1)
            pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_MODERN'].Index)
            print("AlProjectEffects: Set PROJECT_AL_OHAKA_4_FLAG To "..pPlayer:GetProperty('PROJECT_AL_OHAKA_4_FLAG'))
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_5'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_OHAKA_5_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_OHAKA_5_FLAG', 1)
            pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_ATOMIC'].Index)
            print("AlProjectEffects: Set PROJECT_AL_OHAKA_5_FLAG To "..pPlayer:GetProperty('PROJECT_AL_OHAKA_5_FLAG'))
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_OHAKA_6'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_OHAKA_6_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_OHAKA_6_FLAG', 1)
            pPlayer:GetCulture():TriggerBoost(GameInfo.Civics['CIVIC_AL_INFORMATION'].Index)
            print("AlProjectEffects: Set PROJECT_AL_OHAKA_6_FLAG To "..pPlayer:GetProperty('PROJECT_AL_OHAKA_6_FLAG'))
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_AREA_DEFFENSE_1'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_1_FLAG')
        if flag == nil then
            local AreaDeffenseRange = pPlayer:GetProperty('AreaDeffenseRange')
            pPlayer:SetProperty('AreaDeffenseRange',AreaDeffenseRange+Project1AreaDeffenseRange)
            AlAreaDeffenseLevelUp(playerID,true,false,1)
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_AREA_DEFFENSE_2'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_2_FLAG')
        if flag == nil then
            AlAreaDeffenseLevelUp(playerID,true,true,2)
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_AREA_DEFFENSE_3'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_3_FLAG')
        if flag == nil then
            AlAreaDeffenseLevelUp(playerID,true,true,3)
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_AREA_DEFFENSE_4'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_AREA_DEFFENSE_4_FLAG')
        if flag == nil then
            AlAreaDeffenseLevelUp(playerID,true,true,4)
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_KOUNAI_ONSEN_1'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_1_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_KOUNAI_ONSEN_1_FLAG',1)
            print('AlProjectEffects:PROJECT_AL_KOUNAI_ONSEN_1_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_KOUNAI_ONSEN_2'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_2_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_KOUNAI_ONSEN_2_FLAG',1)
            print('AlProjectEffects:PROJECT_AL_KOUNAI_ONSEN_2_FLAG')
        end
    end
    
    if projectIndex == GameInfo.Projects['PROJECT_AL_KOUNAI_ONSEN_3'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_3_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_KOUNAI_ONSEN_3_FLAG',1)
            print('AlProjectEffects:PROJECT_AL_KOUNAI_ONSEN_3_FLAG')
        end
    end
    
    if projectIndex == GameInfo.Projects['PROJECT_AL_KOUNAI_ONSEN_4'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_KOUNAI_ONSEN_4_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_KOUNAI_ONSEN_4_FLAG',1)
            print('AlProjectEffects:PROJECT_AL_KOUNAI_ONSEN_4_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_COLLECTION'].Index then
        local players = Game.GetPlayers()
        local num = 0
        local targetplayers = {}
	    for _,player in ipairs(players) do
            if player:GetID() == pPlayer:GetID() then
                table.insert(targetplayers,player:GetID())
            end
            if player:GetInfluence():GetSuzerain() and player:GetInfluence():GetSuzerain() == pPlayer:GetID() then
                table.insert(targetplayers,player:GetID())
            end
            if pPlayer:GetDiplomacy():HasAllied(player:GetID()) then
                table.insert(targetplayers,player:GetID())
            end
        end
        if #targetplayers >0 then
            for _,iPlayer in ipairs(targetplayers) do
                print('神庭展示会：获取玩家:'..iPlayer)
                local dplayer = Players[iPlayer]
                local playerCities = dplayer:GetCities()
                for _,city in playerCities:Members() do
                    local pop = city:GetPopulation()
                    num = num + pop
                end
            end
            local era = Game.GetEras():GetCurrentEra()
            local eraParam = era + 1
            local boost = 1 + num/(10*eraParam)
            local i = 1
            while i <= boost do
                pPlayer:AttachModifierByID('MOD_AL_KANBA_COLLECTION_BOOST')
                i = i + 1
            end
        end

        local PlayerUnits = pPlayer:GetUnits()
        for i, unit in PlayerUnits:Members() do
            if GameInfo.Units[unit:GetType()].UnitType == 'UNIT_AL_KANBALILY' then
                local unitAbilities = unit:GetAbility(); 
                if unitAbilities:GetAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE') and unitAbilities:GetAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE') ==0 then
                    unitAbilities:ChangeAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE', 1);
                end
            end
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_SEITOKAI_1'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_SEITOKAI_1_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_SEITOKAI_1_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_1'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_2'].Index)
            print('AlProjectEffects:PROJECT_AL_SEITOKAI_1_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_SEITOKAI_2'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_SEITOKAI_2_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_SEITOKAI_2_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_3'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_4'].Index)
            print('AlProjectEffects:PROJECT_AL_SEITOKAI_2_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_SEITOKAI_3'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_SEITOKAI_3_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_SEITOKAI_3_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_5'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_6'].Index)
            print('AlProjectEffects:PROJECT_AL_SEITOKAI_3_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_SEITOKAI_4'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_SEITOKAI_4_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_SEITOKAI_4_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_7'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_SEITOKAI_8'].Index)
            pPlayer:AttachModifierByID('MOD_AL_BAN_SEITOKAI_6')
            pPlayer:AttachModifierByID('MOD_AL_BAN_FUUKI_2')
            print('AlProjectEffects:PROJECT_AL_SEITOKAI_4_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_FUUKI_1'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_FUUKI_1_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_FUUKI_1_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_1'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_2'].Index)
            print('AlProjectEffects:PROJECT_AL_FUUKI_1_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_FUUKI_2'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_FUUKI_2_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_FUUKI_2_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_3'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_4'].Index)
            print('AlProjectEffects:PROJECT_AL_FUUKI_2_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_FUUKI_3'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_FUUKI_3_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_FUUKI_3_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_5'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_6'].Index)
            print('AlProjectEffects:PROJECT_AL_FUUKI_3_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_FUUKI_4'].Index then
        local flag = pPlayer:GetProperty('PROJECT_AL_FUUKI_4_FLAG')
        if flag == nil then
            pPlayer:SetProperty('PROJECT_AL_FUUKI_4_FLAG',1)
            local pPlayerCulture = pPlayer:GetCulture()
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_7'].Index)
            pPlayerCulture:UnlockPolicy(GameInfo.Policies['POLICY_AL_FUUKI_8'].Index)
            pPlayer:AttachModifierByID('MOD_AL_BAN_SEITOKAI_4')
            pPlayer:AttachModifierByID('MOD_AL_BAN_FUUKI_6')
            print('AlProjectEffects:PROJECT_AL_FUUKI_4_FLAG')
        end
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_MOYU_RANDOM'].Index then
        pPlayer:SetProperty('MOYU_PROJECT_CD',20)
        local capital = pPlayer:GetCities():GetCapitalCity()
        local buildingIndex = GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU'].Index
        if capital:GetBuildings():HasBuilding(buildingIndex) == true then
            capital:GetBuildings():RemoveBuilding(buildingIndex)
        end
        local randIndex = Game.GetRandNum(#ALMoyuProjectTable,'ALLB:Get Nest Position') + 1
        print('PROJECT_AL_MOYU_RANDOM:Get Random '..randIndex)
        pPlayer:SetProperty('MOYU_BUFF_CD',20)
        local success = true
        if randIndex >=1 and randIndex <=7 then
            local buffbuildingIndex = GameInfo.Buildings[ALMoyuProjectTable[randIndex].name].Index
            capital:GetBuildQueue():CreateBuilding(buffbuildingIndex)
            if randIndex == 6 or randIndex == 7 then
                success = false
            end
        elseif randIndex == 8 then
            local cities = pPlayer:GetCities()
            for _,city in cities:Members() do
                city:GetBuildQueue():FinishProgress()
            end
            local buffbuildingIndex = GameInfo.Buildings[ALMoyuProjectTable[randIndex].name].Index
            capital:GetBuildQueue():CreateBuilding(buffbuildingIndex)
        elseif randIndex == 9 then
            local playerTechs = pPlayer:GetTechs();
            if (playerTechs:GetResearchingTech() ~= -1) then
                playerTechs:ChangeCurrentResearchProgress(playerTechs:GetResearchCost(playerTechs:GetResearchingTech()) - playerTechs:GetResearchProgress());
            end
            local buffbuildingIndex = GameInfo.Buildings[ALMoyuProjectTable[randIndex].name].Index
            capital:GetBuildQueue():CreateBuilding(buffbuildingIndex)
        end
        ExposedMembers.AL.AlPopupMoyuProjectComplete(success,randIndex)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_TADUSA_NEKO'].Index then
        ExposedMembers.AL.AlNekoUnitsPromote(playerID, cityID)
    end

    if projectIndex == GameInfo.Projects['PROJECT_AL_HITOTSUYANAGI'].Index then
        local targetunit = {}
        for row in GameInfo.AL_GreatUnitNames() do
            if row.Legion == 'CLASS_AL_RADGRID' then
                if HasLilyUnit(playerID,row.UnitName) == false and pPlayer:GetProperty(row.UnitName..'_greatnormal_flag') ~= 1 then
                    if row.UnitName ~= 'RIRI' and row.UnitName ~= 'YUYU' and row.UnitName ~= 'KAEDE' and row.UnitName ~= 'YURI' then
                        table.insert(targetunit,row.UnitName)
                    end
                end
            end
        end
        local randUnit = Game.GetRandNum(#targetunit,'ALLB:Get Nest Position') + 1
        local name = targetunit[randUnit]
        local capital = pPlayer:GetCities():GetCapitalCity()
        if name then
            UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_'..name..'_GREATNORMAL', capital:GetX(), capital:GetY(), 1)
            pPlayer:SetProperty(name..'_greatnormal_flag',1)
        end
    end
end

function HasLilyUnit(playerID,name)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local lname = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if lname == name then
                return true;
            end
        end
    end
    return false;
end
Events.CityProjectCompletedNarrative.Add( AlProjectEffects );

function AlAreaDeffenseLevelUp(iPlayerID,switch1,switch2,level)
    local pPlayer = Players[iPlayerID]
    pPlayer:SetProperty('PROJECT_AL_AREA_DEFFENSE_'..level..'_FLAG', 1)
    local AreaDeffenseLevel = pPlayer:GetProperty('AreaDeffenseLevel')
    pPlayer:SetProperty('AreaDeffenseLevel',AreaDeffenseLevel+1)
    local DeffensePlots = pPlayer:GetProperty('DeffensePlots')
    for _,index in ipairs(DeffensePlots) do
        local pPlot = Map.GetPlotByIndex(index)
        local city = Cities.GetCityInPlot(pPlot:GetX(),pPlot:GetY())
        if switch1 == true then
            AlSetAreaDeffenseFlag(city:GetID(),iPlayerID,1)
        end
        if switch2 == true then
            AlSetAreaDeffenseFlag(city:GetID(),iPlayerID,2)
        end
        
    end
end

function AlSetNeunweltCombat(playerID,num,name,context,rs)
    local pPlayer = Players[playerID]
    local pattern = nil
    if rs == nil then
        pattern = '_neunwelt_'
    else
        pattern = '_rs_'
    end
    if name == nil then
        for row in GameInfo.AL_GreatUnitNames() do
            local combat = pPlayer:GetProperty(row.UnitName..pattern..context)
            if combat == nil then
                combat = 0
            end
            if combat then
                local newcombat = combat + num
                pPlayer:SetProperty(row.UnitName..pattern..context,newcombat)

                local unit = GetLilyUnit(playerID,row.UnitName)
                if unit and context == 'combat' then
                    local oldcombat = unit:GetProperty('NEUNWELT_COMBAT')
                    unit:SetProperty('NEUNWELT_COMBAT',newcombat)
                    if oldcombat then
                        if oldcombat ~= newcombat then
                            print('AlSetNeunweltCombat:'..row.UnitName..'的CHARM输出从'..oldcombat..'调整至'..newcombat)
                        end
                    end
                end
                
                if context == 'combat' then
                    RefreshCapitalFlags(playerID,newcombat,row.UnitName)
                end
                if newcombat ~= combat and combat ~= 0 then
                    print('AlSetNeunweltCombat:'..row.UnitName..'的'..pattern..context..'从'..combat..'调整至'..newcombat)
                end
            end
        end
    elseif name then
        local combat = pPlayer:GetProperty(name..pattern..context)
        if combat == nil then
            combat = 0
        end
        if combat then
            local newcombat = combat + num
            pPlayer:SetProperty(name..pattern..context,newcombat)

            local unit = GetLilyUnit(playerID,name)
            if unit and context == 'combat' then
                local oldcombat = unit:GetProperty('NEUNWELT_COMBAT')
                unit:SetProperty('NEUNWELT_COMBAT',newcombat)
                if oldcombat then
                    if oldcombat ~= newcombat then
                        print('AlSetNeunweltCombat:'..name..'的CHARM输出从'..oldcombat..'调整至'..newcombat)
                    end
                end
            end

            if context == 'combat' then
                RefreshCapitalFlags(playerID,newcombat,name)
            end
            if newcombat ~= combat and combat ~= 0 then
                print('AlSetNeunweltCombat:'..name..'的'..pattern..context..'从'..combat..'调整至'..newcombat)
            end
        end
    end
end
ExposedTable['AlSetNeunweltCombat'] = AlSetNeunweltCombat


function RefreshCapitalFlags(playerID,combat,name)
    local pPlayer = Players[playerID]
    local PlayerCities = pPlayer:GetCities()
    if PlayerCities == nil then return;end
    local capital = pPlayer:GetCities():GetCapitalCity()
    if capital == nil then return;end
    if capital:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_CHARM'].Index) == false then
        capital:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_CHARM'].Index)
    end
    local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())
    local i = 1
    while i <=40 do
        if i ~= combat then
            pPlot:SetProperty(name..'_neunwelt_combat_'..i,0)
        elseif i == combat then
            pPlot:SetProperty(name..'_neunwelt_combat_'..i,1)
        end
        i = i + 1
    end
end



function AlOnPolicyChanged(playerID:number, policyID:number, bEnacted:boolean)
    local pPlayer = Players[playerID]
    local policyInfo = GameInfo.Policies[policyID]

    if policyInfo.PolicyType == 'POLICY_AL_SEITOKAI_3' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_3_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_3_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_SEITOKAI_4' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_4_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_4_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_SEITOKAI_6' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_6_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_6_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_SEITOKAI_7' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_7_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_7_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_SEITOKAI_8' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_8_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_SEITOKAI_8_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_FUUKI_2' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_FUUKI_2_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_FUUKI_2_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_FUUKI_5' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_FUUKI_5_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_FUUKI_5_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_FUUKI_6' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_FUUKI_6_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_FUUKI_6_FLAG',0)
        end
    end

    if policyInfo.PolicyType == 'POLICY_AL_FUUKI_8' then
        if bEnacted then
            pPlayer:SetProperty('POLICY_AL_FUUKI_8_FLAG',1)
        else
            pPlayer:SetProperty('POLICY_AL_FUUKI_8_FLAG',0)
        end
    end
end

GameEvents.PolicyChanged.Add(AlOnPolicyChanged)

function AlResetNeunweltCombat(playerID,misc1)
    if IsLilyCivilization(playerID) == false then return;end
    
    AlSetNeunweltCombat(playerID,0,nil,'combat')
    AlSetNeunweltCombat(playerID,0,nil,'cd')
    RefreshMoyuBuffBuilding(playerID)
    RefreshCharmBreakLevel(playerID)
    AlCitySetNekoBuilding(playerID)
    SetPromiseLevelToUnits(playerID,nil,0)
    local pPlayer = Players[playerID]
    if pPlayer:GetProperty('POLICY_AL_SEITOKAI_3_FLAG') == 1 then
        if pPlayer:GetProperty('HAVE_POLICY_AL_SEITOKAI_3_FLAG') == 1 then return;end
        AlSetNeunweltCombat(playerID,2,nil,'combat')
        AlSetNeunweltCombat(playerID,-1,nil,'cd')
        pPlayer:SetProperty('HAVE_POLICY_AL_SEITOKAI_3_FLAG',1)
    elseif pPlayer:GetProperty('POLICY_AL_SEITOKAI_3_FLAG') == 0 then
        if pPlayer:GetProperty('HAVE_POLICY_AL_SEITOKAI_3_FLAG') ~= 1 then return;end
        AlSetNeunweltCombat(playerID,-2,nil,'combat')
        AlSetNeunweltCombat(playerID,1,nil,'cd')
        pPlayer:SetProperty('HAVE_POLICY_AL_SEITOKAI_3_FLAG',0)
    else
        return;
    end
end

Events.PlayerTurnActivated.Add(AlResetNeunweltCombat);

function CheckRIRIAllMember(playerID)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    local member = 0
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if name == 'RIRI' or name =='YUYU' or name =='KAEDE' or name =='FUMI' or name =='MAI' or name =='TADUSA' or name =='SHENLIN' or name =='YUJIA' or name =='MILIAM' then
                member = member + 1
            end
        end
    end
    if member == 9 then
        if pPlayer:GetProperty('RADGRID_FULL_MEMBER') == nil then
            print('CheckRIRIAllMember:一柳队全员到齐！')
        end
        return true
    else
        return false
    end
end

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

function YuriSetPromotion(playerID,j)
    local yuri = GetLilyUnit(playerID,'YURI')
    local promotionString = nil
    if j == 1 then
        promotionString = '_1_1'
    elseif j == 2 then
        promotionString = '_1_2'
    elseif j == 3 then
        promotionString = '_2_1'
    elseif j == 4 then
        promotionString = '_2_2'
    elseif j == 5 then
        promotionString = '_3_1'
    elseif j == 6 then
        promotionString = '_3_2'
    elseif j == 7 then
        promotionString = '_4_1'
    elseif j == 8 then
        promotionString = '_5_1'
    elseif j == 9 then
        promotionString = '_6_1'
    end
    ExposedMembers.AL.UIPlayersound('YuriPromoted'..j)
    local pID = GameInfo.UnitPromotions['PROMOTION_AL_YURI_GREATNORMAL'..promotionString].Index

    local UE = yuri:GetExperience()
    if UE:HasPromotion(pID) == false then
        UE:SetPromotion(pID)
        AlYuriPopup(playerID,j + 2)
    end
end
function AlYuriPopup(playerID,i)
    print('AlYuriPopup: 开始事件'..i)
    ReportingEvents.Send("EVENT_POPUP_REQUEST", { ForPlayer = playerID, EventKey = "ALLB_YURI_EVENT_"..i });
end

function AlGetYuri(playerID)
    
    local pPlayer = Players[playerID]
    if CheckRIRIAllMember(playerID) == false then return;end
    if CheckRIRIAllMember(playerID) and pPlayer:GetProperty('RADGRID_FULL_MEMBER')== nil then
        pPlayer:SetProperty('RADGRID_FULL_MEMBER',0)
        return;
    end
    if pPlayer:GetProperty('RADGRID_FULL_MEMBER') then
        if pPlayer:GetProperty('RADGRID_FULL_MEMBER') <= YuriCycle*2 then
            local fullturn = pPlayer:GetProperty('RADGRID_FULL_MEMBER')
            pPlayer:SetProperty('RADGRID_FULL_MEMBER',fullturn + 1)
            print('AlGetYuri:距离获取一柳结梨单位剩余回合：'..YuriCycle*2-fullturn)
            return;
        end
    end

    if pPlayer:GetProperty('YURI_BEFORE_GET_FLAG')== nil then
        pPlayer:SetProperty('YURI_BEFORE_GET_FLAG',0)
        AlYuriPopup(playerID,1)
    end
    if pPlayer:GetProperty('YURI_BEFORE_GET_FLAG')<YuriCycle then
        local GetFlag = pPlayer:GetProperty('YURI_BEFORE_GET_FLAG')
        pPlayer:SetProperty('YURI_BEFORE_GET_FLAG',GetFlag + 1)
    end
    if pPlayer:GetProperty('YURI_BEFORE_GET_FLAG')>=YuriCycle and pPlayer:GetProperty('YURI_GET_FLAG') == nil then
        local unittype = 'UNIT_AL_YURI_GREATNORMAL'
        local capital = pPlayer:GetCities():GetCapitalCity()
        UnitManager.InitUnitValidAdjacentHex(playerID, unittype, capital:GetX(), capital:GetY(), 1)
        AlYuriPopup(playerID,2)
        pPlayer:SetProperty('YURI_GET_FLAG',1)
        pPlayer:SetProperty('YURI_greatnormal_flag',1)
    end

    if pPlayer:GetProperty('YURI_GET_FLAG') == 1 then
        if pPlayer:GetProperty('YURI_TURN') == nil then
            pPlayer:SetProperty('YURI_TURN',0)
        end
        local yuriturn = pPlayer:GetProperty('YURI_TURN')
        pPlayer:SetProperty('YURI_TURN',yuriturn + 1)
        local i = YuriCycle
        local j = 1
        while j <= 11 do
            if j <= 9 and pPlayer:GetProperty('YURI_PROMOTION_'..j) == nil then
                if pPlayer:GetProperty('YURI_TURN') >= i * j then
                    YuriSetPromotion(playerID,j)
                    pPlayer:SetProperty('YURI_PROMOTION_'..j,1)
                end
            end
            if j == 10 and pPlayer:GetProperty('YURI_PROMOTION_'..j) == nil then
                if pPlayer:GetProperty('YURI_TURN') >= i * j then
                    AlYuriPopup(playerID,12)
                    pPlayer:SetProperty('YURI_PROMOTION_'..j,1)
                    ExposedMembers.AL.UIPlayersound('YURI_MIDDLE')
                end
            end
            if j == 11 and pPlayer:GetProperty('YURI_PROMOTION_'..j) == nil then
                if pPlayer:GetProperty('YURI_TURN') >= i * j then
                    YuriGetHuge(playerID)
                    AlYuriPopup(playerID,13)
                    pPlayer:SetProperty('YURI_PROMOTION_'..j,1)
                end
            end
            j = j + 1
        end
        if pPlayer:GetProperty('YURI_DIED') then
            if pPlayer:GetProperty('YURI_DIED') >=0 and pPlayer:GetProperty('YURI_DIED') < YuriCycle then
                local diedturn = pPlayer:GetProperty('YURI_DIED')
                pPlayer:SetProperty('YURI_DIED',diedturn + 1)
            end
            if pPlayer:GetProperty('YURI_DIED') >=YuriCycle and pPlayer:GetProperty('YURI_DIED') < 2*YuriCycle then
                local diedturn = pPlayer:GetProperty('YURI_DIED')
                pPlayer:SetProperty('YURI_DIED',diedturn + 1)
                if pPlayer:GetProperty('YURI_MESSAGE') == nil then
                    AlYuriPopup(playerID,15)
                    pPlayer:SetProperty('YURI_MESSAGE',1)
                    ExposedMembers.AL.UIPlayersound('YURI_MIDDLE2')
                end
            end
            if pPlayer:GetProperty('YURI_DIED') ==2 * YuriCycle and pPlayer:GetProperty('YURI_DIED_MODIFIER') == nil then
                AlYuriPopup(playerID,16)
                pPlayer:AttachModifierByID('MOD_AL_YURI_DIED_1')
                pPlayer:AttachModifierByID('MOD_AL_YURI_DIED_2')
                pPlayer:SetProperty('YURI_DIED_MODIFIER',1)
                
                ExposedMembers.AL.UIPlayersound('YURI_END1')
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(AlGetYuri);

function SetPromiseLevelToUnits(playerID,pName,level)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            if pName == nil then
                if unit:GetProperty('PROMISE_LEVEL') == nil then
                    unit:SetProperty('PROMISE_LEVEL',0)
                end
            end
            local name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if name == pName then
                if unit:GetProperty('PROMISE_LEVEL') == nil then
                    unit:SetProperty('PROMISE_LEVEL',0)
                end
                local PromiseLevel = unit:GetProperty('PROMISE_LEVEL')
                local NewLevel = PromiseLevel + level
                unit:SetProperty('PROMISE_LEVEL',NewLevel)
                if NewLevel ~= PromiseLevel then
                    print('SetPromiseLevelToUnits: Set PromiseLevel to '..NewLevel..' for '..pName)
                end
            end
        end
    end
end
ExposedTable['SetPromiseLevelToUnits'] = SetPromiseLevelToUnits

function RefreshCharmBreakLevel(playerID)
    local pPlayer = Players[playerID]
    local pPlot = GetCapitalPlot(playerID)
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if pPlot:GetProperty(pName..'_charm_break_level_1') == nil then
                if pPlayer:GetProperty(pName..'_charm_break_level') == nil then
                    SetCharmBreakLevel(playerID,pName,4)
                else
                    local breakLevel = pPlayer:GetProperty(pName..'_charm_break_level')
                    SetCharmBreakLevel(playerID,pName,breakLevel)
                end
            end
            local x = unit:GetX()
            local y = unit:GetY()
            if ExposedMembers.AL.UnitInArsenal(playerID,x,y) then
                RepairCharmBreakLevel(playerID,pName,breakLevel,x,y,1)
            end

            local targetplots = Map.GetNeighborPlots(unit:GetX(), unit:GetY(), 1)
            for _,plot in ipairs(targetplots) do
                if plot:IsUnit() then
                    for _, munit in ipairs(Units.GetUnitsInPlot(plot)) do
                        if munit then
                            local mName = string.match(munit:GetName(),"(%u+)_GREATNORMAL")
                            if mName then
                                if mName == 'MILIAM' and GreatUnitsHasPromotion(playerID,'PROMOTION_AL_MILIAM_GREATNORMAL_2_1') then
                                    RepairCharmBreakLevel(playerID,pName,breakLevel,x,y,1)
                                end
                                if mName == 'MOYU' and GreatUnitsHasPromotion(playerID,'PROMOTION_AL_MOYU_GREATNORMAL_1_2') then
                                    RepairCharmBreakLevel(playerID,pName,breakLevel,x,y,1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function RepairCharmBreakLevel(playerID,pName,breakLevel,x,y,rPoint)
    local pPlot = GetCapitalPlot(playerID)
    local pPlayer = Players[playerID]
    local breaklevel = GetCharmBreakLevel(playerID,pName)
    if pPlayer:GetProperty(pName..'repair_turn') == nil then
        pPlayer:SetProperty(pName..'repair_turn',1)
    else
        local point = pPlayer:GetProperty(pName..'repair_turn')
        if breaklevel < 4 then
            pPlayer:SetProperty(pName..'repair_turn',point + rPoint)
        end

        if point >= 3 then
            if breaklevel < 4 then
                SetCharmBreakLevel(playerID,pName,breaklevel + 1)
                pPlayer:SetProperty(pName..'repair_turn',point - 3)
                Game.AddWorldViewText(1, Locale.Lookup('LOC_MOD_AL_CHARM_REPAIR'), x, y);
            end
        end
    end
end

function SetCharmBreakLevel(playerID,name,level)
    local pPlot = GetCapitalPlot(playerID)
    local pPlayer = Players[playerID]
    local num1 = 1
    if pPlayer:GetProperty(name..'_charm_break_level') == nil then
        pPlayer:SetProperty(name..'_charm_break_level',4)
    end
    local breaklevel = pPlayer:GetProperty(name..'_charm_break_level')
    while num1 <= 4 do
        if num1 ~= level then
            pPlot:SetProperty(name..'_charm_break_level_'..num1,0)
        end
        if num1 == level then
            if pPlot:GetProperty(name..'_charm_break_level_'..num1) ~= 1 or pPlayer:GetProperty(name..'_charm_break_level') ~= num1 then
                pPlayer:SetProperty(name..'_charm_break_level',num1)
                pPlot:SetProperty(name..'_charm_break_level_'..num1,1)
                if level < breaklevel then
                    pPlayer:SetProperty(name..'repair_turn',0)
                end
                if num1 ~= breaklevel then 
                    print('SetCharmBreakLevel: Set '..name..'charm_break_level to '..num1)
                end
            end
        end
        num1 = num1 + 1
    end
end
ExposedTable['SetCharmBreakLevel'] = SetCharmBreakLevel

function GetCharmBreakLevel(playerID,name)
    local pPlot = GetCapitalPlot(playerID)
    local num1 = 1
    while num1 <= 4 do
        if pPlot:GetProperty(name..'_charm_break_level_'..num1) == 1 then
            return num1;
        end
        num1 = num1 + 1
    end
end

function GetCapitalPlot(playerID)
    local pPlayer = Players[playerID]
    local capital = pPlayer:GetCities():GetCapitalCity()
    if capital == nil then return;end
    local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())
    return pPlot;
end

function AlGetMagiFromPolicy(playerID,misc1)
    
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    if pPlayer:GetProperty('POLICY_AL_SEITOKAI_8_FLAG') == 1
    or pPlayer:GetProperty('POLICY_AL_FUUKI_2_FLAG') == 1 then
        local num = ExposedMembers.AL.AlGetMagiPerTurn(playerID)
        pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_AL_LILY"].Index,num)
    end
    
end
Events.PlayerTurnActivated.Add(AlGetMagiFromPolicy);

function AlGardenYieldFromGreat(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
    local pPlayer = Players[unitOwner]
    if GameInfo.GreatPersonClasses[greatPersonClassID].GreatPersonClassType == 'GREAT_PERSON_CLASS_AL_LILY' then
        if pPlayer:GetProperty('POLICY_AL_SEITOKAI_6_FLAG') == 1 
        or pPlayer:GetProperty('POLICY_AL_SEITOKAI_8_FLAG') == 1  then
            pPlayer:AttachModifierByID('MOD_POLICY_AL_SEITOKAI_6_3')
        end
    end
end

Events.UnitGreatPersonActivated.Add(AlGardenYieldFromGreat);

function KanbaStageYieldFromGreat(unitOwner, unitID, greatPersonClassID, greatPersonIndividualID)
    if GameInfo.GreatPersonClasses[greatPersonClassID].GreatPersonClassType == 'GREAT_PERSON_CLASS_AL_LILY' then
        local pPlayer = Players[unitOwner]
        local unit = UnitManager.GetUnit(unitOwner, unitID)
        local iCity = ExposedMembers.AL.AlGetPlotCityOwner(unitOwner,pPlayer:GetProperty('KANBA_GREAT_X'),pPlayer:GetProperty('KANBA_GREAT_Y'))
        local city = CityManager.GetCity(unitOwner, iCity)
        local districtIndex = GameInfo.Districts['DISTRICT_AL_STAGE'].Index
        local pCityDistricts = city:GetDistricts();
        if pCityDistricts:HasDistrict(districtIndex) then
            local pDistrict = pCityDistricts:GetDistrict(districtIndex, unitOwner);
            local pPlot = Map.GetPlot(pDistrict:GetX(),pDistrict:GetY())
            local num = pPlot:GetProperty('KANBA_GREAT')
            if num == nil then
                num = 0
            end
            num = num + 1
            print('KanbaStageYieldFromGreat:设置伟人PROPERTY:'..num)
            pPlot:SetProperty('KANBA_GREAT',num)
        end
    end
end

Events.UnitGreatPersonActivated.Add(KanbaStageYieldFromGreat);


function AlKillHugeTourism(pCombatResult)

    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]

    local attacker = pCombatResult[CombatResultParameters.ATTACKER]
    local attInfo = attacker[CombatResultParameters.ID]

    local aUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    local dUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

    local aPlayer = Players[attInfo.player]
    local dPlayer = Players[defInfo.player]
    if dUnit == nil then return;end

    if string.match(GameInfo.Units[dUnit:GetType()].UnitType, "(UNIT_AL_HUGE)") == nil then return; end
    if aPlayer:GetProperty('POLICY_AL_SEITOKAI_7_FLAG') ~= 1 then return; end

    if dUnit:IsDelayedDeath() then
        aPlayer:AttachModifierByID('MOD_POLICY_AL_SEITOKAI_7_1')
        print('AlKillHugeTourism: Attach!')
    end
end

Events.Combat.Add(AlKillHugeTourism);

function AlSetGarrisonFlag(playerID)
    
    local pPlayer = Players[playerID]
    if pPlayer:GetProperty('POLICY_AL_FUUKI_5_FLAG') ~= 1 then return;end
    local Cities = pPlayer:GetCities()
    for i, city in Cities:Members() do
        local pPlot = Map.GetPlot(city:GetX(),city:GetY())
        if pPlot:IsUnit() then
            for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                if string.match(unit:GetName(),"(%u+)_GREATNORMAL") and unit:GetFortifyTurns() >= 1 then

                        Game.AddWorldViewText(1, Locale.Lookup('LOC_MOD_AL_GARRISON_START'), unit:GetX(), unit:GetY());
                    pPlot:SetProperty('LILY_UNIT_GARRISON',1);
                    break
                else
                    pPlot:SetProperty('LILY_UNIT_GARRISON',0)
                end
            end
        else
            pPlot:SetProperty('LILY_UNIT_GARRISON',0)
        end
    end
    
end
Events.PlayerTurnDeactivated.Add(AlSetGarrisonFlag);


function AlMoyuProjectSetFlag(playerID,misc1)
    
    local pPlayer = Players[playerID]
    local pPlayerConfig = PlayerConfigurations[playerID];
    if pPlayerConfig:GetCivilizationTypeName() ~= 'CIVILIZATION_AL_YURIGAOKA' then return;end
    local capital = pPlayer:GetCities():GetCapitalCity()
    if capital == nil then return;end
    local buildingIndex = GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU'].Index
    local districtIndex = GameInfo.Districts['DISTRICT_AL_MOYU'].Index
    if capital:GetDistricts():HasDistrict(districtIndex) == false then return;end

    if pPlayer:GetProperty('MOYU_PROJECT_CD') == nil then
        pPlayer:SetProperty('MOYU_PROJECT_CD',0)
        pPlayer:SetProperty('MOYU_BUFF_CD',-1)
    end

    if pPlayer:GetProperty('MOYU_PROJECT_CD') > 0 then
        local cd = pPlayer:GetProperty('MOYU_PROJECT_CD')
        pPlayer:SetProperty('MOYU_PROJECT_CD',cd - 1)
        pPlayer:SetProperty('MOYU_BUFF_CD',cd - 1)
    end

    if pPlayer:GetProperty('MOYU_PROJECT_CD') == 0 then
        if capital:GetBuildings():HasBuilding(buildingIndex) == false then
            capital:GetBuildQueue():CreateBuilding(buildingIndex)
        end
        pPlayer:SetProperty('MOYU_PROJECT_CD',-1)
    end

    if pPlayer:GetProperty('MOYU_BUFF_CD') == 0 then
        local i = 1
        while i <= #ALMoyuProjectTable do
            local buffbuildingIndex = GameInfo.Buildings[ALMoyuProjectTable[i].name].Index
            if capital:GetBuildings():HasBuilding(buffbuildingIndex) == true then
                capital:GetBuildings():RemoveBuilding(buffbuildingIndex)
                ExposedMembers.AL.AlPopupMoyuCDComplete(i)
            end
            i = i + 1;
        end
        pPlayer:SetProperty('MOYU_BUFF_CD',-1)
    end
    
end
Events.PlayerTurnActivated.Add(AlMoyuProjectSetFlag);

function AlCitySetNekoBuilding(playerID)
    local pPlayer = Players[playerID]
    local Cities = pPlayer:GetCities();
    for _, city in Cities:Members() do
        local CityID = city:GetID()
        local Nswitch,Nlevel =ExposedMembers.AL.AlCheckCityHasNeko(playerID, CityID)
        if Nswitch == 1 then
            if Nlevel >= 0 and city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO'].Index) == false then
                city:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO'].Index)
            end
            if Nlevel >= 1 and city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_1'].Index) == false then
                city:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_1'].Index)
            end
            if Nlevel >= 2 and city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_2'].Index) == false then
                city:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_2'].Index)
            end
        elseif Nswitch == 0 then
            if city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO'].Index) then
                city:GetBuildings():RemoveBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO'].Index)
            end
            if city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_1'].Index) then
                city:GetBuildings():RemoveBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_1'].Index)
            end
            if city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_2'].Index) then
                city:GetBuildings():RemoveBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_TADUSA_NEKO_2'].Index)
            end
        end
    end
end

function RefreshMoyuBuffBuilding(playerID)
    local pPlayer = Players[playerID]
    local Cities = pPlayer:GetCities();
    for _, city in Cities:Members() do
        local CityID = city:GetID()
        local pPlot = Map.GetPlot(city:GetX(),city:GetY())
        if ExposedMembers.AL.AlCheckGreatUnitInCity(playerID,CityID,'MOYU') == true then
            if city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU_BUFF'].Index) == false then
                city:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU_BUFF'].Index)
                print('RefreshMoyuBuffBuilding:Set CITY HAS MOYU at '..city:GetX(),city:GetY())
                pPlot:SetProperty('CITY_HAS_MOYU',1)
            end
        end
        if ExposedMembers.AL.AlCheckGreatUnitInCity(playerID,CityID,'MOYU') == false then
            if city:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU_BUFF'].Index) then
                city:GetBuildings():RemoveBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_MOYU_BUFF'].Index)
                pPlot:SetProperty('CITY_HAS_MOYU',0)
            end
        end

        if ExposedMembers.AL.AlCheckGreatUnitInCity(playerID,CityID,'MILIAM') == true then
            pPlot:SetProperty('CITY_HAS_MILIAM',1)
            if GreatUnitsHasPromotion(playerID,'PROMOTION_AL_MILIAM_GREATNORMAL_4_1') then
                pPlot:SetProperty('CITY_HAS_MILIAM_4',1)
            end
        end
        if ExposedMembers.AL.AlCheckGreatUnitInCity(playerID,CityID,'MILIAM') == false then
            pPlot:SetProperty('CITY_HAS_MILIAM',0)
            pPlot:SetProperty('CITY_HAS_MILIAM_4',0)
        end
    end
end

function GreatUnitsHasPromotion(playerID,Promotion)
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits();
    for i, unit in PlayerUnits:Members() do
        local ue = unit:GetExperience()
        if ue:HasPromotion(GameInfo.UnitPromotions[Promotion].Index) then
            return true;
        end
    end
end

function AlCityGetNekoBuilding(playerID,unitID,iX,iY)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    if pUnit == nil then return;end
    if string.match(GameInfo.Units[pUnit:GetType()].UnitType, "(NEKO)") == nil then return;end
    AlCitySetNekoBuilding(playerID)
end
Events.UnitMoveComplete.Add(AlCityGetNekoBuilding);

function AlMoyuMoveTrigger(playerID,unitID,iX,iY)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    if pUnit then
        if string.match(GameInfo.Units[pUnit:GetType()].UnitType, "(MOYU)") == nil then return;end
        RefreshMoyuBuffBuilding(playerID)
    end
end
Events.UnitMoveComplete.Add(AlMoyuMoveTrigger);

function AlSetShenlinBuilding(playerID)
    
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits();
    if pPlayer:GetProperty('SHENLIN_greatnormal_flag') ~= 1 then return;end
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if pName == 'SHENLIN' or pName == 'YUJIA' then
                local capital = pPlayer:GetCities():GetCapitalCity()
                if capital:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index) == false then
                    capital:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index)
                    AlSetShenlinProperty(playerID,unit:GetID())
                    AlSetShenlinPromotionProperty(playerID,unit:GetID())
                else
                    AlSetShenlinProperty(playerID,unit:GetID())
                    AlSetShenlinPromotionProperty(playerID,unit:GetID())
                end
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(AlSetShenlinBuilding);

function AlSetShenlinProperty(playerID,unitID)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    if pUnit == nil or pUnit:GetDamage() == nil then return;end
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    if pName ~= 'SHENLIN' and pName ~= 'YUJIA' then return;end
    local capital = pPlayer:GetCities():GetCapitalCity()

    if capital:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index) == false then
        capital:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index)
    end

    local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())

    local damage = 100 - pUnit:GetDamage()
    if damage >= 66 then
        if pPlot:GetProperty(pName..'_PROPERTY_HIGH_HP') ~= 1 then
            pPlot:SetProperty(pName..'_PROPERTY_HIGH_HP',1)
            print('AlSetShenlinProperty:'..pName..' HIGH_HP')
        end
        pPlot:SetProperty(pName..'_PROPERTY_MED_HP',0)
        pPlot:SetProperty(pName..'_PROPERTY_LOW_HP',0)
    elseif damage >= 33 and damage < 66 then
        pPlot:SetProperty(pName..'_PROPERTY_HIGH_HP',0)
        if pPlot:GetProperty(pName..'_PROPERTY_MED_HP') ~= 1 then
            pPlot:SetProperty(pName..'_PROPERTY_MED_HP',1)
            print('AlSetShenlinProperty:'..pName..' Med_HP')
        end
        pPlot:SetProperty(pName..'_PROPERTY_LOW_HP',0)
    elseif damage < 33 then
        pPlot:SetProperty(pName..'_PROPERTY_HIGH_HP',0)
        pPlot:SetProperty(pName..'_PROPERTY_MED_HP',0)
        if pPlot:GetProperty(pName..'_PROPERTY_LOW_HP') ~= 1 then
            pPlot:SetProperty(pName..'_PROPERTY_LOW_HP',1)
            print('AlSetShenlinProperty:'..pName..' Low_HP')
        end
    end
end
Events.UnitDamageChanged.Add(AlSetShenlinProperty);

function AlSetShenlinPromotionProperty(playerID : number, unitID : number)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    if pUnit == nil then return;end
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    if pName ~= 'SHENLIN' and pName ~= 'YUJIA' then return;end
    local capital = pPlayer:GetCities():GetCapitalCity()

    if capital:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index) == false then
        capital:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_AL_VISUAL_SHENLIN'].Index)
    end

    local pPlot = Map.GetPlot(capital:GetX(),capital:GetY())

    local ue = pUnit:GetExperience()
    local i = 1
    while i <= 4 do
        local j = 1
        while j <= 2 do
            local Promotion = GameInfo.UnitPromotions['PROMOTION_AL_'..pName..'_GREATNORMAL_'..i..'_'..j]
            if Promotion then
                Promotion = Promotion.Index
                if ue:HasPromotion(GameInfo.UnitPromotions[Promotion].Index) then
                    if pPlot:GetProperty(pName..'_PROPERTY_PROMOTION_'..i..'_'..j) ~= 1 then
                        pPlot:SetProperty(pName..'_PROPERTY_PROMOTION_'..i..'_'..j,1)
                        print('AlSetShenlinPromotionProperty: SetProperty: '..pName..'_PROPERTY_PROMOTION_'..i..'_'..j)
                    end
                else
                    pPlot:SetProperty(pName..'_PROPERTY_PROMOTION_'..i..'_'..j,0)
                end
            end
            j = j + 1
        end
        i = i +1
    end
end
Events.UnitPromoted.Add(AlSetShenlinPromotionProperty);

function AlLeaderGetGreat(playerID,TechID)
    local pPlayerConfig = PlayerConfigurations[playerID];
    local pPlayer = Players[playerID]
    if pPlayer:IsMajor() == false then return;end
    if string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)") == nil or TechID ~= GameInfo.Technologies['TECH_AL_MEDIEVAL'].Index then return;end

    local capital = pPlayer:GetCities():GetCapitalCity()
    local LeaderName = string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)")
    if pPlayer:GetProperty(LeaderName..'_greatnormal_flag') == nil and GameInfo.Units['UNIT_AL_'..LeaderName..'_GREATNORMAL'] then
        UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_'..LeaderName..'_GREATNORMAL', capital:GetX(), capital:GetY(), 1)
        pPlayer:SetProperty(LeaderName..'_greatnormal_flag',1)
        print('AlGetGreatUnits:Get Unit '..LeaderName)      
    end
end
Events.ResearchCompleted.Add(AlLeaderGetGreat);

function AlUnitPromotion(playerID : number, unitID : number)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local UnitName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    if UnitName == nil then return;end
    local i = 1;
    while i <= 4 do
        local j = 1
        while j <= 2 do
            if i == 1 then
                if pPlayer:GetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG') == nil 
                and pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j].Index) then
                    AlSetNeunweltCombat(playerID,-1,UnitName,'cd',1)
                    pPlayer:SetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG',1)
                end
            end

            if i == 2 then
                if pPlayer:GetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG') == nil 
                and pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j].Index) then
                    AlSetNeunweltCombat(playerID,1,UnitName,'combat')
                    pPlayer:SetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG',1)
                end
            end
            if i == 4 and j == 1 then
                if pPlayer:GetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG') == nil 
                and pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j].Index) then
                    AlSetNeunweltCombat(playerID,2,UnitName,'combat')
                    AlSetNeunweltCombat(playerID,-1,UnitName,'cd')
                    pPlayer:SetProperty('PROMOTION_AL_'..UnitName..'_GREATNORMAL_'..i..'_'..j..'_FLAG',1)
                end
            end
            j = j + 1
        end
        i = i + 1
    end

    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TADUSA_GREATNORMAL_1_2'].Index) 
    and pPlayer:GetProperty('TAZUSA_NEKO_FLAG') == nil then
        local capital = pPlayer:GetCities():GetCapitalCity()
        UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_NEKO', capital:GetX(), capital:GetY(), 1)
        pPlayer:SetProperty('TAZUSA_NEKO_FLAG',1)
        AlCitySetNekoBuilding(playerID)
    end

    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MAI_GREATNORMAL_1_2'].Index) 
    and pPlayer:GetProperty('MAI_NEKO_FLAG') == nil then
        local capital = pPlayer:GetCities():GetCapitalCity()
        UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_NEKO', capital:GetX(), capital:GetY(), 1)
        pPlayer:SetProperty('MAI_NEKO_FLAG',1)
        AlCitySetNekoBuilding(playerID)
    end

    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_YUJIA_GREATNORMAL_2_1'].Index) 
    and pPlayer:GetProperty('YUJIA_NEKO_FLAG') == nil then
        local capital = pPlayer:GetCities():GetCapitalCity()
        UnitManager.InitUnitValidAdjacentHex(playerID, 'UNIT_AL_NEKO', capital:GetX(), capital:GetY(), 1)
        pPlayer:SetProperty('YUJIA_NEKO_FLAG',1)
        AlCitySetNekoBuilding(playerID)
    end
    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MOYU_GREATNORMAL_2_1'].Index)
    or pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MOYU_GREATNORMAL_3_1'].Index) then
        RefreshMoyuBuffBuilding(playerID)
    end
    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MOYU_GREATNORMAL_1_2'].Index)
    and pPlayer:GetProperty('MOYU_1_2_FLAG') ~= 1 then
        AlSetNeunweltCombat(playerID,2,nil,'combat')
        pPlayer:SetProperty('MOYU_1_2_FLAG',1)
    end
    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MOYU_GREATNORMAL_2_2'].Index)
    and pPlayer:GetProperty('MOYU_2_2_FLAG') ~= 1 then
        AlSetNeunweltCombat(playerID,-1,nil,'cd')
        pPlayer:SetProperty('MOYU_2_2_FLAG',1)
    end
    if pUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_MOYU_GREATNORMAL_3_2'].Index)
    and pPlayer:GetProperty('MOYU_3_2_FLAG') ~= 1 then
        local playerCities = pPlayer:GetCities();
        if pPlayer:GetProperty('DistrictAreaDeffenseRange') == nil then
            pPlayer:SetProperty('DistrictAreaDeffenseRange',DefaultDistrictAreaDeffenseRange)
        end
        local DistrictAreaDeffenseRange = pPlayer:GetProperty('DistrictAreaDeffenseRange')
        pPlayer:SetProperty('DistrictAreaDeffenseRange',DistrictAreaDeffenseRange + 1)
        for _, city in playerCities:Members() do
            AlSetAreaDeffenseFlag(city:GetID(),playerID,2)
        end
        pPlayer:SetProperty('MOYU_3_2_FLAG',1)
    end
    
end
Events.UnitPromoted.Add(AlUnitPromotion);

function AlNekoUnitsSetPromote(PlayerID,unitID)
    local pUnit = UnitManager.GetUnit(PlayerID,unitID)
    local UE = pUnit:GetExperience()
    local i = 1
    while i <= 5 do
        local PromotionID = GameInfo.UnitPromotions['PROMOTION_AL_NEKO_'..i].Index
        if UE:HasPromotion(PromotionID) == false then
            UE:SetPromotion(PromotionID)
            print('AlNekoUnitsSetPromote: Set PROMOTION_AL_NEKO_'..i)
            break;
        end
        i = i + 1
    end
    AlCitySetNekoBuilding(PlayerID)
end
ExposedTable['AlNekoUnitsSetPromote'] = AlNekoUnitsSetPromote

function YujiaCritical(pCombatResult)
    local attacker = pCombatResult[CombatResultParameters.ATTACKER];
    local attInfo = attacker[CombatResultParameters.ID]
    local pAttUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    if pAttUnit == nil then return;end
    if string.match(pAttUnit:GetName(),"(%u+)_GREATNORMAL") ~= 'YUJIA' 
    or pAttUnit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_YUJIA_GREATNORMAL_3_2'].Index) == false then return;end
    
    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]

    if attInfo.type ~= ComponentType.UNIT or defInfo.type ~= ComponentType.UNIT then return;end
    
    local randNum = Game.GetRandNum(100,'NO WHY')/100
    if randNum <= 0.5 then
        local location = pCombatResult[CombatResultParameters.LOCATION];
        local damage = defender[CombatResultParameters.DAMAGE_TO]*0.25
        local pDefUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)
        pDefUnit:ChangeDamage(damage)
        Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_YUJIA_CRITICAL"), location.x, location.y)
        print('YujiaCritical: Success!')
    else
        print('YujiaCritical: Failed!')
    end
end

Events.Combat.Add(YujiaCritical)



function AlCityAttachModifier(playerID,cityID,ModifierType)
    local pCity = CityManager.GetCity(playerID, cityID);
    pCity:AttachModifierByID(ModifierType)
    print('AlCityAttachModifier: Attach Modifier '..ModifierType..' At City '..cityID)
end
ExposedTable['AlCityAttachModifier'] = AlCityAttachModifier

function AlRsLaplace(playerID, unitID, x, y)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    local units = AlGetNeighborLily(playerID,x, y,2)
    for _,row in ipairs(units) do
        local unit = UnitManager.GetUnit(row.playerID,row.unitID)
        local iPlayer = Players[unit:GetOwner()]
        local name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
        local cdturn = unit:GetProperty(name..'_neunwelt_cooldown_turn')
        if cdturn then
            ALSetUnitPropertyFlag(row.playerID, row.unitID, name..'_neunwelt_cooldown_turn', nil)
        end
        local rsturn = iPlayer:GetProperty('rs_cd_'..name)
        if rsturn and pName == 'RIRI' then
            iPlayer:SetProperty('rs_cd_'..name,rsturn-5)
        end
        if unit:GetProperty('PTDFlag'..name) and unit:GetProperty('PTDFlag'..name) >= 1 then
            local unitAbilities = unit:GetAbility();
            local DebuffAbility = GameInfo.UnitAbilities['ABL_AL_RS_DEBUFF_'..name].UnitAbilityType
            local count = unitAbilities:GetAbilityCount(DebuffAbility);
            if count >= 1 then
                unitAbilities:ChangeAbilityCount(DebuffAbility, -1);
                unit:SetProperty('PTDFlag'..name,nil)
                Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HEAL_PT_DEBUFF"), unit:GetX(), unit:GetY())
            end
        end
    end
    
end
ExposedTable['AlRsLaplace'] = AlRsLaplace

function AlRsPhantasm(playerID)
    local pPlayer = Players[playerID]
    if IsLilyCivilization(playerID) == false then return;end
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        local name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
        if name and GameInfo.AL_GreatUnitNames[name].RareSkill == 'Phantasm' then
            local rs = GameInfo.AL_GreatUnitNames[name].RareSkill
            if unit:GetProperty(rs) == 1 then
                local x,y= unit:GetX(),unit:GetY()
                local targetplots = Map.GetNeighborPlots(x, y, 2)
                local number = pPlayer:GetProperty(name..'RsPlotNumber')
                if pPlayer:GetProperty(name..'RsPlotNumber') == nil then
                    pPlayer:SetProperty(name..'RsPlotNumber',6)
                    number = 6
                end
                for i = #targetplots,2,-1 do
                    local j = Game.GetRandNum(i)
                    targetplots[i],targetplots[j] = targetplots[j],targetplots[i]
                end
                local finalplots = {}
                for i = 1,number do
                    finalplots[i] = targetplots[i]
                end

                local rsplots = pPlayer:GetProperty(name..'RsPlots')
                if rsplots == nil then
                    rsplots = {}
                end

                if #rsplots >0 then
                    for i,plotID in ipairs(rsplots) do
                        local plot = Map.GetPlotByIndex(plotID)
                        plot:SetProperty('PHANTASM_PLOT',nil)
                    end
                    rsplots = {}
                end

                for i,plot in ipairs(finalplots) do

                    print('记录单元格'..plot:GetX(),plot:GetY())
                    table.insert(rsplots,plot:GetIndex())

                    plot:SetProperty('PHANTASM_PLOT',1)
                end
                pPlayer:SetProperty(name..'RsPlots',rsplots)
            end
        end
    end
    if pPlayer:GetProperty('PHANTASM_MODIFIER') == nil then
        pPlayer:AttachModifierByID('MOD_AL_PHANTASM_PLAYER')
        pPlayer:SetProperty('PHANTASM_MODIFIER',1)
    end
end
ExposedTable['AlRsPhantasm'] = AlRsPhantasm

function AlRsPhantasmTrigger(playerID,unitID,iX,iY)
    
    if IsLilyCivilization(playerID) == false then return;end
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    if pName then
        local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
        if rs == 'Phantasm' and pUnit:GetProperty(rs) == 1 then
            AlRsPhantasm(playerID)
        end
    end
    
end

Events.PlayerTurnActivated.Add(AlRsPhantasm);
Events.UnitMoveComplete.Add(AlRsPhantasmTrigger);

function AlRsLunatora(playerID, unitID, x, y)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    local targetPlots = Map.GetNeighborPlots(x, y, 2)
    for _,plot in ipairs(targetPlots) do
        for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
            if AlCheckAtWar(playerID,unit:GetOwner()) then
                local damage = BattleSimulation(playerID, unitID,unit:GetOwner(),unit:GetID())
                unit:ChangeDamage(damage)
            end
        end
    end
end
ExposedTable['AlRsLunatora'] = AlRsLunatora

function BattleSimulation(playerID,unitID,eplayerID,eunitID)
    local pUnit,eUnit = UnitManager.GetUnit(playerID,unitID),UnitManager.GetUnit(eplayerID,eunitID)
    local pCombat,eCombat = pUnit:GetCombat(),eUnit:GetCombat()
    local dif = pCombat - eCombat
    local rand = Game.GetRandNum(13,'NO WHY') + 24
    local finalDamage = rand * math.pow(1.04, dif)
    return finalDamage;
end

function AlGetNeighborLily(playerID,x,y,range)
    local pPlayer = Players[playerID]
    local units = {}
    local targetPlots = Map.GetNeighborPlots(x, y, range)
    for _,plot in ipairs(targetPlots) do
        for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
            local Name = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if Name then
                if unit:GetOwner() ~= playerID then
                    if AlCheckAtWar(playerID,unit:GetOwner()) == false then
                        local row = {playerID = unit:GetOwner(),unitID = unit:GetID(),pName = Name}
                        table.insert(units,row)
                    end
                else
                    local row = {playerID = unit:GetOwner(),unitID = unit:GetID(),pName = Name}
                    table.insert(units,row)
                end
            end
        end
    end
    return units;
end

function AlCheckCharmRs(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    if pName then
        local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
        if rs == 'Register' then
            return true,rs;
        else
            return false,rs;
        end
    end
end

function AlRsTrigger(playerID, unitID)
    local pPlayer = Players[playerID]
    local pUnit = UnitManager.GetUnit(playerID,unitID)
    local pName = string.match(pUnit:GetName(),"(%u+)_GREATNORMAL")
    local pPlot = Map.GetPlot(pUnit:GetX(),pUnit:GetY())
    local unitAbilities = pUnit:GetAbility();
    local RsAbility = GameInfo.UnitAbilities['ABL_AL_RS_'..pName].UnitAbilityType
    local count = unitAbilities:GetAbilityCount(RsAbility);
    local nowturn = Game.GetCurrentGameTurn()
    if count == nil or count < 1 then
        unitAbilities:ChangeAbilityCount(RsAbility, 1);
    end
    pPlayer:SetProperty('rs_start_'..pName,1)
    pPlayer:SetProperty('rs_cd_'..pName,nowturn)
    local IsSetCharm,rs = AlCheckCharmRs(playerID, unitID)
    pUnit:SetProperty(rs,1)
    if IsSetCharm then
        SetCharmFromRs(playerID)
    end
    if pName then
        local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
        if rs == 'Phantasm' then
            AlRsPhantasm(playerID)
        end
        if rs == 'ShrunkenLand' then
            ALUnitsRestoreMove(playerID, unitID)
        end
        if rs == 'PhaseTranscendence' then
            ALUnitsRestoreMove(playerID, unitID)
            local PTFlag = pUnit:GetProperty('PTFlag')
            if PTFlag == nil then
                pUnit:SetProperty('PTFlag',1)
                AlSetNeunweltCombat(playerID,15,pName,'combat')
                if pName == 'MILIAM' then
                    AlSetNeunweltCombat(playerID,5,pName,'combat')
                end
            end
        end
        if pName == 'MOYU' then
            local units = AlGetNeighborLily(playerID,pUnit:GetX(), pUnit:GetY(),2)
            for _,row in ipairs(units) do
                local unit = UnitManager.GetUnit(row.playerID,row.unitID)
                local name = row.pName
                SetCharmBreakLevel(playerID,name,4)
                Game.AddWorldViewText(1, Locale.Lookup('LOC_MOD_AL_CHARM_REPAIR_MOYU'), unit:GetX(), unit:GetX());
            end
        end
    end
    SetRSPlotProperty(playerID)
end
ExposedTable['AlRsTrigger'] = AlRsTrigger

function SetRSPlotProperty(playerID)
    
    if IsLilyCivilization(playerID) == false then return;end
    local plots = GetAllPlots()
    for _, plotID in ipairs(plots) do
        local pPlot = Map.GetPlotByIndex(plotID)
        for _,unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
            local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            if pName then
                local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
                if unit:GetProperty(rs) == 1 and pPlot:GetProperty('USING_RS')~=1 then
                    print('位于'..pPlot:GetX(),pPlot:GetY()..'的单元格获得USING_RS属性')
                    pPlot:SetProperty('USING_RS',1)
                end
            end
        end
        if pPlot:GetProperty('USING_RS') == 1 then
            if pPlot:IsUnit() then
                for _,unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                    local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                    if pName then
                        local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
                        if unit:GetProperty(rs) ==nil or unit:GetProperty(rs) ~=1 then
                            pPlot:SetProperty('USING_RS',nil)
                        end
                    end
                end
            else
                pPlot:SetProperty('USING_RS',nil)
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(SetRSPlotProperty);
Events.UnitMoveComplete.Add(SetRSPlotProperty);

function AlRsCounter(playerID)
    
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            local rs = nil
            if pName then
                rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
            end
            if pPlayer:GetProperty('rs_start_'..pName) then
                local rsflag = pPlayer:GetProperty('rs_start_'..pName)
                local rstime = pPlayer:GetProperty(pName..'_rs_time')
                if rsflag >= rstime then
                    print(pName..'的效果结束！')
                    local text = Locale.Lookup("LOC_RS_OVER_TOOLTIP",'[ICON_RS_'..rs..']')
                    Game.AddWorldViewText(0, text, unit:GetX(),unit:GetY());
                    pPlayer:SetProperty('rs_start_'..pName,-1)
                    local unitAbilities = unit:GetAbility();
                    local RsAbility = GameInfo.UnitAbilities['ABL_AL_RS_'..pName].UnitAbilityType
                    unitAbilities:ChangeAbilityCount(RsAbility, -1);

                    local IsSetCharm,rs = AlCheckCharmRs(playerID, unit:GetID())
                    unit:SetProperty(rs,nil)

                    if pName then
                        if rs == 'ShrunkenLand' then
                            unit:SetProperty('ATTACK_FLAG',nil)
                            unit:SetProperty('ATTACK_NUMBER',nil)
                            unit:SetProperty('ATTACK_KILL',nil)
                        end
                        if unit:GetProperty('RS_CHARM_OUTPUT') == 1 then
                            unit:SetProperty('RS_CHARM_OUTPUT',nil)
                            AlSetNeunweltCombat(unit:GetOwner(),-5,name,'combat')
                        end
                        if rs == 'PhaseTranscendence' then
                            local PTFlag = unit:GetProperty('PTFlag')
                            if PTFlag == 1 then
                                unit:SetProperty('PTFlag',nil)
                                UnitManager.ChangeMovesRemaining(unit,-99)
                                AlSetNeunweltCombat(playerID,-15,pName,'combat')
                                if pName == 'MILIAM' then
                                    AlSetNeunweltCombat(playerID,-5,pName,'combat')
                                end
                                local PTDFlag = unit:GetProperty('PTDFlag'..pName)
                                if PTDFlag == nil then
                                    unit:SetProperty('PTDFlag'..pName,1)
                                end
                            end
                        end
                    end

                end
                local rsflag = pPlayer:GetProperty('rs_start_'..pName)
                if rsflag >=1 then
                    rsflag = rsflag + 1
                    pPlayer:SetProperty('rs_start_'..pName,rsflag)
                    local text = Locale.Lookup("LOC_RS_REMANING_TOOLTIP",'[ICON_RS_'..rs..']',rsflag-1,rstime-rsflag+1)
                    Game.AddWorldViewText(0, text, unit:GetX(),unit:GetY());
                    print(pName..'的效果发动'..rsflag..'回合，剩余'..rstime-rsflag..'回合。')
                end
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(AlRsCounter);

function PhaseTranscendenceDebuffCounter(playerID)
    
    if IsLilyCivilization(playerID) == false then return;end
    local pPlayer = Players[playerID]
    local PlayerUnits = pPlayer:GetUnits()
    for i, unit in PlayerUnits:Members() do
        if string.match(unit:GetName(),"(%u+)_GREATNORMAL") then
            local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
            local rs = GameInfo.AL_GreatUnitNames[pName].RareSkill
            if pName and rs == 'PhaseTranscendence' then
                local PTDFlag = unit:GetProperty('PTDFlag'..pName)
                if PTDFlag and PTDFlag >= 1 then
                    local unitAbilities = unit:GetAbility();
                    local DebuffAbility = GameInfo.UnitAbilities['ABL_AL_RS_DEBUFF_'..pName].UnitAbilityType
                    local count = unitAbilities:GetAbilityCount(DebuffAbility);
                    if PTDFlag < 3 then
                        if PTDFlag == 1 and pName ~= 'MILIAM' then
                            SetCharmBreakLevel(playerID,pName,1)
                        end
                        unit:SetProperty('PTDFlag'..pName,PTDFlag+1)
                        UnitManager.ChangeMovesRemaining(unit,-99)
                        if count~= 1 then
                            unitAbilities:ChangeAbilityCount(DebuffAbility, 1);
                        end
                    elseif PTDFlag == 3 then
                        if count == 1 then
                            unitAbilities:ChangeAbilityCount(DebuffAbility, -1);
                            unit:SetProperty('PTDFlag'..pName,nil)
                        end
                    end
                end
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(PhaseTranscendenceDebuffCounter);

function SetCharmFromRs(playerID)
    
    if IsLilyCivilization(playerID) == false then return;end
    local units = GetAllLilyUnits(playerID)
    for _,unitID in ipairs(units) do
        local unit = UnitManager.GetUnit(playerID,unitID)
        local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
        local modifiers = GetCharmModifiers(unit:GetX(), unit:GetY(), playerID)
        local GotModifiers = unit:GetProperty('GotModifiers')
        if GotModifiers == nil then
            GotModifiers = {}
        end
        for _,row in ipairs(modifiers) do
            if IsLilyClass(playerID,unitID,row.tag) then
                if unit:GetProperty(row.name..'_modifier') ~= 1 then
                    if row.pattern == nil then
                        AlSetNeunweltCombat(playerID,row.amount,pName,row.context)
                    elseif row.pattern == 1 then
                        AlSetNeunweltCombat(playerID,row.amount,pName,row.context,1)
                    end
                    if IsUnactivitedModifier(row.name,GotModifiers) then
                        table.insert(GotModifiers,row)
                        unit:SetProperty(row.name..'_modifier',1)
                    end
                end
            end
        end
        unit:SetProperty('GotModifiers',GotModifiers)

        local pPlot = Map.GetPlot(unit:GetX(),unit:GetY())
        if pPlot:GetProperty('PHANTASM_PLOT') == 1 and unit:GetProperty('PHANTASM_BUFF') == nil then
            unit:SetProperty('PHANTASM_BUFF',1)
            AlSetNeunweltCombat(playerID,4,pName,'combat')
        end
    end
    RemoveCharmFromRs(playerID)
    
end
Events.PlayerTurnActivated.Add(SetCharmFromRs);
Events.UnitMoveComplete.Add(SetCharmFromRs);

function RemoveCharmFromRs(playerID)
    local units = GetAllLilyUnits(playerID)
    for _,unitID in ipairs(units) do
        local unit = UnitManager.GetUnit(playerID,unitID)
        local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
        local modifiers = GetCharmModifiers(unit:GetX(), unit:GetY(), playerID)
        local GotModifiers = unit:GetProperty('GotModifiers')
        if GotModifiers then
            for k, v in pairs(GotModifiers) do
                if IsUnactivitedModifier(v.name,modifiers) then
                    if v.pattern == nil then
                        AlSetNeunweltCombat(playerID,-v.amount,pName,v.context)
                    elseif v.pattern == 1 then
                        AlSetNeunweltCombat(playerID,-v.amount,pName,v.context,1)
                    end
                    unit:SetProperty(v.name..'_modifier',0)
                    GotModifiers[k] = nil
                end
            end
            unit:SetProperty('GotModifiers',GotModifiers)
        end

        local pPlot = Map.GetPlot(unit:GetX(),unit:GetY())
        if pPlot:GetProperty('PHANTASM_PLOT') == nil and unit:GetProperty('PHANTASM_BUFF') == 1 then
            unit:SetProperty('PHANTASM_BUFF',nil)
            AlSetNeunweltCombat(playerID,-4,pName,'combat')
        end
    end
end

function IsUnactivitedModifier(name,modifiers)
    for _,row in ipairs(modifiers) do
        if row.name == name then
            return false
        end
    end
    return true;
end

function TableHasMember(table,member)
    for i,element in ipairs(table) do
        if element == member then
            return true
        end
    end
    return false;
end

function GetCharmModifiers(x,y,playerID)
    local targetPlots = Map.GetNeighborPlots(x, y, 2)
    local modifiers = {}
    for _,plot in ipairs(targetPlots) do
        for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
            if unit:GetOwner() == playerID then
                local IsSetCharm,rs = AlCheckCharmRs(playerID, unit:GetID()) 
                if IsSetCharm and unit:GetProperty(rs) == 1 then
                    local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                    if rs == 'Register' then
                        local row = {name = rs..pName,amount = 2,pattern = nil,context = 'combat',tag = 'ALL'}
                        table.insert(modifiers,row)
                    end
                    if pName == 'KAEDE' then
                        local row = {name = rs..pName..'unique',amount = 2,pattern = nil,context = 'combat',tag = 'BZ'}
                        table.insert(modifiers,row)
                    end
                end
            end
        end
    end
    return modifiers
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

function CheckRsUsing(playerID,pName)
    local pPlayer = Players[playerID]
    if pPlayer:GetProperty('rs_start_'..pName) then
        local rsflag = pPlayer:GetProperty('rs_start_'..pName)
        if rsflag >= 0 then
            return true
        end
    end
    return false
end

function AlLunaticDamage(playerID)
    
    if IsLilyCivilization(playerID) == false then  return;end
    local pPlayer = Players[playerID]
    local damage = true
    for row in GameInfo.AL_GreatUnitNames() do
        if row.RareSkill == 'LunaticTranser' then
            if CheckRsUsing(playerID,row.UnitName) then
                local unit = GetLilyUnit(playerID,row.UnitName)
                print('AlLunaticDamage:找到梦结单位')
                if unit:GetDamage() <= 80 then
                    local targetPlots = Map.GetNeighborPlots(unit:GetX(), unit:GetY(), 1)
                    for _,plot in ipairs(targetPlots) do
                        for _,aunit in ipairs(Units.GetUnitsInPlot(plot)) do
                            if aunit then
                                if string.match(aunit:GetName(),"(%u+)_GREATNORMAL") then
                                    local pName = string.match(aunit:GetName(),"(%u+)_GREATNORMAL")
                                    if GameInfo.AL_GreatUnitNames[pName].RareSkill == 'Laplace' then
                                        print('AlLunaticDamage:找到魅力感召单位')
                                        damage = false
                                    end
                                end
                            end
                        end
                    end
                    if damage == true then
                        unit:ChangeDamage(20)
                    end
                end
            end
        end
    end
    
end
Events.PlayerTurnActivated.Add(AlLunaticDamage);

function CheckHasAbility(playerID,unitID,Ability)
    local unit = UnitManager.GetUnit(playerID,unitID)
    local unitAbilities = unit:GetAbility();
    local AbilityName = GameInfo.UnitAbilities[Ability].UnitAbilityType
    local count = unitAbilities:GetAbilityCount(AbilityName);
    if count and count ~= 0 then
        return true;
    else
        return false
    end
end

function IsLilyClass(playerID,unitID,Class)
    local Ability = 'ABILITY_AL_LILY_'..Class
    if Class == 'ALL' then
        return true
    elseif CheckHasAbility(playerID,unitID,Ability)then
        return true;
    else
        return false
    end
end

function ShrunkenLandGetAtkNums(pCombatResult)
    local aUnit,dUnit,aPlayer,dPlayer,location = GetInfoFromCombat(pCombatResult)
    if IsLilyCivilization(aPlayer:GetID()) == false then return;end
    if aUnit == nil then return;end
    local name = string.match(aUnit:GetName(),"(%u+)_GREATNORMAL")
    if name == nil then return;end
    local rs = GameInfo.AL_GreatUnitNames[name].RareSkill 

    if name and rs == 'ShrunkenLand' then
        local AtkNum = aUnit:GetProperty('ATTACK_NUMBER')
        if AtkNum == nil and aUnit:GetProperty(rs) == 1 then
            AtkNum = 2
            aUnit:SetProperty('ATTACK_NUMBER',AtkNum)
            print(name..'获得AtkNum'..AtkNum)
        elseif AtkNum and aUnit:GetProperty(rs) == 1 then
            aUnit:SetProperty('ATTACK_NUMBER',AtkNum + 2)
            print(name..'获得AtkNum+2，先前为'..AtkNum)
        end
    end
    if name == 'MAI' then 
        if aUnit:GetProperty(rs) == 1 then
            if dUnit and dUnit:IsDelayedDeath() then
                local kill = aUnit:GetProperty('ATTACK_KILL')
                if kill == nil then
                    kill = 1
                    aUnit:SetProperty('ATTACK_KILL',kill)
                elseif kill and kill>0 and kill < 2 then
                    aUnit:SetProperty('ATTACK_KILL',kill + 1)
                elseif kill and kill == 2 then
                    ALUnitsRestoreMove(aUnit:GetOwner(), aUnit:GetID())
                    aUnit:SetProperty('ATTACK_KILL',nil)
                end
            end
        end
    end
end
Events.Combat.Add(ShrunkenLandGetAtkNums);

function ShenlinJustGuard(pCombatResult)
    local aUnit,dUnit,aPlayer,dPlayer,location = GetInfoFromCombat(pCombatResult)
    if IsLilyCivilization(dPlayer:GetID()) == false then return;end
    if aUnit == nil or dUnit == nil then return;end
    local name = string.match(dUnit:GetName(),"(%u+)_GREATNORMAL")
    if name then
        local rs = GameInfo.AL_GreatUnitNames[name].RareSkill
        if name and rs then
            if name == 'SHENLIN' and dUnit:GetProperty(rs) == 1 then
                local defender = pCombatResult[CombatResultParameters.DEFENDER]
                local damage = defender[CombatResultParameters.DAMAGE_TO]*0.5
                if damage >= 30 then
                    damage = 30
                end
                aUnit:ChangeDamage(damage)
                Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_ShenlinJustGuard"), location.x, location.y)
            end
        end
    end
end
Events.Combat.Add(ShenlinJustGuard)

function HeavensScalesCritical(pCombatResult)
    local attacker = pCombatResult[CombatResultParameters.ATTACKER];
    local attInfo = attacker[CombatResultParameters.ID]
    local pAttUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
    if pAttUnit == nil then return;end
    if IsLilyCivilization(attInfo.player) == false then return;end
    local name = string.match(pAttUnit:GetName(),"(%u+)_GREATNORMAL")
    if name then
        local rs = GameInfo.AL_GreatUnitNames[name].RareSkill
        if name == nil or pAttUnit:GetProperty(rs) ~= 1 or rs ~= 'HeavensScales' then return;end
        
        local defender = pCombatResult[CombatResultParameters.DEFENDER]
        local defInfo = defender[CombatResultParameters.ID]

        if attInfo.type ~= ComponentType.UNIT or defInfo.type ~= ComponentType.UNIT then return;end
        
        local randNum = Game.GetRandNum(100,'NO WHY')/100
        if randNum <= 0.5 then
            local location = pCombatResult[CombatResultParameters.LOCATION];
            local damage = defender[CombatResultParameters.DAMAGE_TO]*0.5
            local pDefUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)
            pDefUnit:ChangeDamage(damage)
            Game.AddWorldViewText(0, Locale.Lookup("LOC_AL_HeavensScales_CRITICAL"), location.x, location.y)
            if pAttUnit:GetProperty('RS_CHARM_OUTPUT') == nil then
                pAttUnit:SetProperty('RS_CHARM_OUTPUT',1)
                AlSetNeunweltCombat(pAttUnit:GetOwner(),5,name,'combat')
            end
            if name == 'YUJIA' then
                pAttUnit:ChangeDamage(-1*damage*0.5)
            end
        end
    end
end

Events.Combat.Add(HeavensScalesCritical)

function KanbaSetToutomi(playerID)
    local pPlayer = Players[playerID]
    if IsLilyCivilization(playerID) and IsLeader(playerID,'KANAHO') then
        local plots = GetAllPlots()
        for _, plotID in ipairs(plots) do
            local pPlot = Map.GetPlotByIndex(plotID)
            local toutomi = 0

            local NearKanbaGarden,IsNearKanbaGarden = IsNearKanbaGarden(pPlot)

            local NearKanbaTeagarden,FlagNearKanbaTeagarden= nil,nil
            local NearKanbaWonder,FlagNearKanbaWonder = nil,nil
            local NearTakane,FlagNearTakane = NearTakane(pPlot)
            local NearKanaho,FlagNearKanaho = NearKanaho(pPlot)
            if ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_TAKANE',2) then
                NearKanbaTeagarden,FlagNearKanbaTeagarden = IsNearKanbaTeagarden(pPlot,2)
                NearKanbaWonder,FlagNearKanbaWonder = IsNearKanbaWonder(pPlot)
            elseif ExposedMembers.AL.HasGovernorPomotion(playerID,'GOVERNOR_AL_TAKANE',2) == false then
                NearKanbaTeagarden,FlagNearKanbaTeagarden = IsNearKanbaTeagarden(pPlot,1)
            end

            local NearKanbaStage,IsNearKanbaStage = IsNearKanbaStage(pPlot)
            
            if pPlot:GetOwner() == playerID then
                toutomi = toutomi + 2
            end

            if IsNearKanbaGarden then
                toutomi = toutomi + NearKanbaGarden
            end

            if FlagNearKanbaTeagarden then
                toutomi = toutomi + NearKanbaTeagarden
            end

            if FlagNearKanbaWonder then
                toutomi = toutomi + NearKanbaWonder
            end

            if FlagNearTakane then
                toutomi = toutomi + NearTakane
            end
            if FlagNearKanaho then
                toutomi = toutomi + NearKanaho
            end

            if IsNearKanbaStage then
                if pPlot:GetDistrictType() == -1 then
                    toutomi = toutomi + NearKanbaStage
                elseif pPlot:GetDistrictType() ~= -1 and GameInfo.Districts[pPlot:GetDistrictType()].DistrictType ~= "DISTRICT_AL_STAGE" then
                    toutomi = toutomi + NearKanbaStage
                end
            end

            pPlot:SetProperty('TOUTOMI',toutomi)
            if pPlot:IsUnit() then
                for _,unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                    local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                    if pName then
                        unit:SetProperty('UNIT_TOUTOMI',toutomi)
                    end
                end
            end
        end
    end
end
function KanbaSetToutomiTrigger(iX, iY, eImprovement, playerID)
    if playerID then
        KanbaSetToutomi(playerID)
    end
end
Events.PlayerTurnActivated.Add(KanbaSetToutomi);
Events.CityProductionCompleted.Add(KanbaSetToutomi);
Events.UnitMoveComplete.Add(KanbaSetToutomi);
Events.ImprovementAddedToMap.Add(KanbaSetToutomiTrigger);
Events.UnitSelectionChanged.Add(KanbaSetToutomi);

function NearTakane(pPlot)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 1)
    local num = 0
    local FlagNearTakane = false
    for _,plot in ipairs(targetPlots) do
        if plot:IsUnit() then
            for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
                local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                if pName and pName == 'TAKANE' then
                    FlagNearTakane = true
                    local NearKanaho = NearLily(Map.GetPlot(unit:GetX(),unit:GetY()),'KANAHO')
                    if NearKanaho then
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_1_2'].Index) then
                            num = num + 2
                        end
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_2_1'].Index) then
                            num = num + 2
                        end
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_3_2'].Index) then
                            num = num + 2
                        end
                    end
                end
            end
        end
    end
    if FlagNearTakane == true then
        return num,FlagNearTakane
    else
        return num,FlagNearTakane
    end
end
function NearKanaho(pPlot)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 1)
    local num = 0
    local FlagNearKanaho = false
    for _,plot in ipairs(targetPlots) do
        if plot:IsUnit() then
            for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
                local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                if pName and pName == 'KANAHO' then
                    FlagNearKanaho = true
                    local NearTakane = NearLily(Map.GetPlot(unit:GetX(),unit:GetY()),'TAKANE')
                    if NearTakane then
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_KANAHO_GREATNORMAL_1_2'].Index) then
                            num = num + 2
                        end
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_KANAHO_GREATNORMAL_2_1'].Index) then
                            num = num + 2
                        end
                        if unit:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_KANAHO_GREATNORMAL_3_2'].Index) then
                            num = num + 2
                        end
                    end
                end
            end
        end
    end
    if FlagNearKanaho == true then
        return num,FlagNearKanaho
    else
        return num,FlagNearKanaho
    end
end

function NearLily(pPlot,name)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 1)
    for _,plot in ipairs(targetPlots) do
        if plot:IsUnit() then
            for _,unit in ipairs(Units.GetUnitsInPlot(plot)) do
                local pName = string.match(unit:GetName(),"(%u+)_GREATNORMAL")
                if pName and pName == name then
                    return true;
                end
            end
        end
    end
end

function SetPromotionLevel(playerID)
    if IsLilyCivilization(playerID) then
        local units = GetAllLilyUnits(playerID)
        if units then
            for _,unitID in ipairs(units) do
                local num = ExposedMembers.AL.GetPromotionNum(playerID,unitID)
                local unit = UnitManager.GetUnit(playerID,unitID)
                unit:SetProperty('LILY_PROMOTIONS',num)
            end
        end
    end
end
Events.PlayerTurnActivated.Add(SetPromotionLevel);
Events.UnitSelectionChanged.Add(SetPromotionLevel);

function TakaneGetHealFromKanaho(playerID)
    if IsLilyCivilization(playerID) then
        local takane = GetLilyUnit(playerID,'TAKANE')
        if takane then
            if takane:GetExperience():HasPromotion(GameInfo.UnitPromotions['PROMOTION_AL_TAKANE_GREATNORMAL_4_1'].Index) then
                local kanaho = GetLilyUnit(playerID,'KANAHO')
                if kanaho then
                    local promotionLevel = 0
                    local level = kanaho:GetProperty('LILY_PROMOTIONS')
                    if level then
                        promotionLevel = level
                    end
                    takane:SetProperty('KANAHO_PROMOTIONS',promotionLevel)
                    takane:ChangeDamage(-2*promotionLevel)
                end
            end
        end
    end
end
Events.PlayerTurnActivated.Add(TakaneGetHealFromKanaho);

function IsNearKanbaWonder(pPlot)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 2)
    local num = 0
    for _,plot in ipairs(targetPlots) do
        local eWonderType = plot:GetWonderType()
        if eWonderType and eWonderType ~= -1 then
            num = num + 1
        end
    end
    if num >0 then
        return num,true
    else
        return num,false
    end
end

function IsNearKanbaGarden(pPlot)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 2)
    local num = 0
    for _,plot in ipairs(targetPlots) do
        local etype = plot:GetDistrictType()
        if etype ~=-1 then
            if GameInfo.Districts[etype].DistrictType == "DISTRICT_AL_GARDEN" then
                num = num + 1
            end
        end
    end
    if num >0 then
        return num,true
    else
        return num,false
    end
end

function IsNearKanbaStage(pPlot)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), 2)
    local num = 0
    for _,plot in ipairs(targetPlots) do
        local etype = plot:GetDistrictType()
        if etype ~=-1 then
            if GameInfo.Districts[etype].DistrictType == "DISTRICT_AL_STAGE" then
                local toutomi = plot:GetProperty('TOUTOMI')
                num = num + toutomi
            end
        end
    end
    if num >0 then
        return num,true
    else
        return num,false
    end
end

function IsNearKanbaTeagarden(pPlot,range)
    local targetPlots = Map.GetNeighborPlots(pPlot:GetX(), pPlot:GetY(), range)
    local num = 0
    for _,plot in ipairs(targetPlots) do
        local etype = plot:GetImprovementType()
        if etype ~=-1 then
            if GameInfo.Improvements[etype].ImprovementType == "IMPROVEMENT_AL_TEAGARDEN" then
                num = num + 1
            end
        end
    end
    if num >0 then
        return num,true
    else
        return num,false
    end
end

function IsLeader(playerID,leadername)
    local pPlayerConfig = PlayerConfigurations[playerID];
    local name = string.match(pPlayerConfig:GetLeaderTypeName(),"LEADER_AL_(%u+)")
    if name and name == leadername then
        return true;
    end
    return false;
end

function KanbaResetBuildABL( playerID: number, unitID : number, newCharges : number, oldCharges : number )
    local pPlayer = Players[playerID]
    if IsLilyCivilization(playerID) and IsLeader(playerID,'KANAHO') then
        local unit = UnitManager.GetUnit(playerID, unitID)
        local unitType = GameInfo.Units[unit:GetType()].UnitType
		if unitType and unitType == "UNIT_AL_KANBALILY" and newCharges == 0 then
            local unitAbilities = unit:GetAbility(); 
            if unitAbilities:GetAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE') and unitAbilities:GetAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE') ==1 then
                unitAbilities:ChangeAbilityCount('ABILITY_AL_KANBA_BUILD_CHARGE', -1);
            end
        end
    end
end
Events.UnitChargesChanged.Add(		KanbaResetBuildABL );

function AlExecuteScript(iPlayerID, kParameters)
    local params = {}
    local i = 1
    while kParameters["misc"..i] do
        params[i] = kParameters["misc"..i]
        i = i + 1
    end
    if ExposedTable[kParameters.Name] then
        ExposedTable[kParameters.Name](unpack(params))
    end
end
GameEvents.AlExecuteScript.Add(AlExecuteScript)