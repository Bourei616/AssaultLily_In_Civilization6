-- GARDEN����
INSERT INTO Types
(Type, Kind) VALUES 
('DISTRICT_AL_STAGE', 'KIND_DISTRICT'),
('DISTRICT_AL_MOYU', 'KIND_DISTRICT'),
('DISTRICT_AL_GARDEN', 'KIND_DISTRICT');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType) VALUES
('DISTRICT_AL_MOYU', 'DISTRICT_INDUSTRIAL_ZONE'),
('DISTRICT_AL_STAGE', 'DISTRICT_THEATER');

INSERT INTO Districts
(DistrictType, Name, PrereqTech, Description, Cost, RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, ZOC, HitPoints, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal, OnePerCity, Maintenance, CityStrengthModifier, AdvisorType) VALUES 
('DISTRICT_AL_MOYU', 'LOC_DISTRICT_AL_MOYU_NAME', 'TECH_APPRENTICESHIP', 'LOC_DISTRICT_AL_MOYU_DESCRIPTION', 54, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'PLUNDER_SCIENCE', 25, 'NO_DOMAIN', 'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH', 40, 'TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU', -1, 1, 2, 2, 'ADVISOR_GENERIC');

INSERT INTO Districts
(DistrictType, Name, PrereqTech, Description, Cost, RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, ZOC, HitPoints, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal, OnePerCity, Maintenance, CityStrengthModifier, AdvisorType) VALUES 
('DISTRICT_AL_GARDEN', 'LOC_DISTRICT_AL_GARDEN_NAME', 'TECH_AL_MEDIEVAL', 'LOC_DISTRICT_AL_GARDEN_DESCRIPTION', 54, 1, 1, 0, 0, 0, 1, 100, 0, 0, 'NO_PLUNDER', 0, 'DOMAIN_LAND', 'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH', 40, 'TRAIT_CIVILIZATION_AL_GARDEN', 1, 1, 2, 2, 'ADVISOR_GENERIC');

INSERT INTO Districts
(DistrictType, AllowsHolyCity,Name, PrereqCivic, Description, Cost, RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, ZOC, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal, Maintenance, CityStrengthModifier, AdvisorType) VALUES 
('DISTRICT_AL_STAGE',1, 'LOC_DISTRICT_AL_STAGE_NAME', 'CIVIC_DRAMA_POETRY', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_STAGE_DESCRIPTION', 54, 1, 1, 0, 0, 0, 0, 0, 0, 'PLUNDER_CULTURE', 25, 'NO_DOMAIN', 'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH', 40, 'TRAIT_CIVILIZATION_AL_KANBA_STAGE', 1, 2, 2, 'ADVISOR_CULTURE');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict, AdjacentTerrain) VALUES
('Moyu_Garden2', 'LOC_DISTRICT_AL_MOYU_GARDEN2', 'YIELD_PRODUCTION', 1, 1, 'DISTRICT_AL_GARDEN', NULL),
('Garden_Encampment1', 'LOC_DISTRICT_AL_GARDEN_ENCAMPMENT1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_ENCAMPMENT', NULL),
('Garden_Industrial_Zone1', 'LOC_DISTRICT_AL_GARDEN_INDUSTRIAL_ZONE1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_INDUSTRIAL_ZONE', NULL),
('Garden_Garden1', 'LOC_DISTRICT_AL_GARDEN_GARDEN1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_AL_GARDEN', NULL),
('Garden_Sea1', 'LOC_DISTRICT_AL_GARDEN_SEA1', 'YIELD_SCIENCE', 1, 1, NULL, 'TERRAIN_COAST');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement) VALUES
('Garden_Quan1', 'LOC_DISTRICT_AL_GARDEN_QUAN1', 'YIELD_SCIENCE', 2, 1, 'IMPROVEMENT_AL_QUAN'),
('Moyu_Quan1', 'LOC_DISTRICT_AL_MOYU_QUAN1', 'YIELD_PRODUCTION', 2, 1, 'IMPROVEMENT_AL_QUAN'),
('Stage_Teagarden', 'LOC_DISTRICT_AL_STAGE_TEAGARDEN', 'YIELD_CULTURE', 1, 1, 'IMPROVEMENT_AL_TEAGARDEN'),
('Garden_Teagarden', 'LOC_DISTRICT_AL_GARDEN_TEAGARDEN', 'YIELD_SCIENCE', 1, 1, 'IMPROVEMENT_AL_TEAGARDEN');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentResourceClass) VALUES
('Moyu_LUXURY1', 'LOC_DISTRICT_AL_MOYU_LUXURY1', 'YIELD_PRODUCTION', 2, 1, 'RESOURCECLASS_LUXURY');

INSERT INTO District_Adjacencies
(DistrictType, YieldChangeId) VALUES
('DISTRICT_AL_MOYU', 'Mine_Production'),
('DISTRICT_AL_MOYU', 'Quarry_Production'),
('DISTRICT_AL_MOYU', 'District_Production'),
('DISTRICT_AL_MOYU', 'Moyu_Garden2'),
('DISTRICT_AL_MOYU', 'Moyu_Quan1'),
('DISTRICT_AL_MOYU', 'Moyu_LUXURY1'),

('DISTRICT_AL_STAGE', 'Stage_Teagarden'),
('DISTRICT_AL_GARDEN', 'Garden_Teagarden'),
('DISTRICT_AL_GARDEN', 'Garden_Garden1'),
('DISTRICT_AL_GARDEN', 'Garden_Industrial_Zone1'),
('DISTRICT_AL_GARDEN', 'Garden_Sea1'),
('DISTRICT_AL_GARDEN', 'District_Science'),
('DISTRICT_AL_GARDEN', 'Garden_Quan1'),
('DISTRICT_AL_GARDEN', 'Garden_Encampment1');

    INSERT INTO District_Adjacencies (DistrictType, YieldChangeId)
        SELECT 'DISTRICT_AL_STAGE', YieldChangeId
        FROM District_Adjacencies WHERE DistrictType = 'DISTRICT_THEATER';

    INSERT INTO DistrictModifiers (DistrictType, ModifierId)
        SELECT 'DISTRICT_AL_STAGE', 'MOD_TRAIT_AL_KANBA_STAGE_CULTURE' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_TRAIT_AL_KANBA_STAGE_CULTURE' || n, 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'REQSET_AL_PLOT_HAS_GREAT_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_STAGE_CULTURE' || n, 'YieldType', 'YIELD_CULTURE'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_STAGE_CULTURE' || n, 'Amount', 1
        FROM property_civ_number;

    INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
        SELECT 'REQSET_AL_PLOT_HAS_GREAT_' || n, 'REQUIREMENTSET_TEST_ALL'
        FROM property_civ_number;
    INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
        SELECT 'REQSET_AL_PLOT_HAS_GREAT_' || n, 'REQ_AL_PLOT_HAS_GREAT_' || n
        FROM property_civ_number;
    INSERT INTO Requirements (RequirementId, RequirementType)
        SELECT 'REQ_AL_PLOT_HAS_GREAT_' || n, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
        FROM property_civ_number;
    INSERT INTO RequirementArguments (RequirementId, Name, Value)
        SELECT 'REQ_AL_PLOT_HAS_GREAT_' || n, 'PropertyName', 'KANBA_GREAT'
        FROM property_civ_number;
    INSERT INTO RequirementArguments (RequirementId, Name, Value)
        SELECT 'REQ_AL_PLOT_HAS_GREAT_' || n, 'PropertyMinimum', n
        FROM property_civ_number;

INSERT INTO DistrictModifiers
(DistrictType, ModifierId) VALUES
('DISTRICT_AL_MOYU', 'MOYU_YIELD_PRODUCTION'),
('DISTRICT_AL_STAGE', 'MOD_AL_STAGE_FAITH_ADJACENCY'),
('DISTRICT_AL_MOYU', 'MOD_AL_DISTRICT_MOYU_ADJACENCY'),
('DISTRICT_AL_GARDEN', 'GARDEN_YIELD_SCIENCE');

INSERT INTO Modifiers
(ModifierId, ModifierType) VALUES
('MOYU_YIELD_PRODUCTION', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'),
('MOD_AL_DISTRICT_MOYU_ADJACENCY', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS'),
('GARDEN_YIELD_SCIENCE', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');

INSERT INTO Modifiers
(ModifierId, ModifierType,SubjectRequirementSetId) VALUES
('MOD_AL_STAGE_FAITH_ADJACENCY', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS','REQSET_AL_PLOT_HAS_TOUTOMI_2');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('GARDEN_YIELD_SCIENCE', 'Amount', 2),
('GARDEN_YIELD_SCIENCE', 'YieldType', 'YIELD_SCIENCE'),
('MOYU_YIELD_PRODUCTION', 'Amount', 1),
('MOYU_YIELD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
('MOD_AL_DISTRICT_MOYU_ADJACENCY', 'YieldTypeToMirror', 'YIELD_PRODUCTION'),
('MOD_AL_DISTRICT_MOYU_ADJACENCY', 'YieldTypeToGrant', 'YIELD_SCIENCE'),
('MOD_AL_STAGE_FAITH_ADJACENCY', 'YieldTypeToMirror', 'YIELD_CULTURE'),
('MOD_AL_STAGE_FAITH_ADJACENCY', 'YieldTypeToGrant', 'YIELD_FAITH');

INSERT INTO District_GreatPersonPoints
(DistrictType, GreatPersonClassType, PointsPerTurn) VALUES
('DISTRICT_AL_MOYU', 'GREAT_PERSON_CLASS_ENGINEER', 1),
('DISTRICT_AL_MOYU', 'GREAT_PERSON_CLASS_AL_LILY', 1),
('DISTRICT_AL_GARDEN', 'GREAT_PERSON_CLASS_AL_LILY', 1),
('DISTRICT_AL_GARDEN', 'GREAT_PERSON_CLASS_SCIENTIST', 1);

INSERT INTO District_TradeRouteYields
(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination) VALUES 
('DISTRICT_AL_GARDEN', 'YIELD_SCIENCE', 1, 1, 1),
('DISTRICT_AL_MOYU', 'YIELD_PRODUCTION', 1, 1, 1);

INSERT INTO District_CitizenYieldChanges
(DistrictType, YieldType, YieldChange) VALUES 
('DISTRICT_AL_GARDEN', 'YIELD_SCIENCE', 1),
('DISTRICT_AL_MOYU', 'YIELD_PRODUCTION', 1);