-- GARDEN����
INSERT INTO Types
(Type, Kind) VALUES 
('DISTRICT_GARDEN', 'KIND_DISTRICT');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType) VALUES 
('DISTRICT_GARDEN', 'DISTRICT_CAMPUS');

INSERT INTO Districts
(DistrictType, Name, PrereqTech, Description, Cost, RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, ZOC, HitPoints, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal, OnePerCity, Maintenance, CityStrengthModifier, AdvisorType) VALUES 
('DISTRICT_GARDEN', 'LOC_DISTRICT_GARDEN_NAME', 'TECH_WRITING', 'LOC_DISTRICT_GARDEN_DESCRIPTION', 1, 1, 1, 0, 0, 0, 1, 100, 1, 0, 'NO_PLUNDER', 0, 'DOMAIN_LAND', 'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH', 40, 'TRAIT_CIVILIZATION_AL_GARDEN', 1, 1, 2, 2, 'ADVISOR_GENERIC');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict, AdjacentTerrain) VALUES 
('Garden_Encampment1', 'LOC_DISTRICT_GARDEN_ENCAMPMENT1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_ENCAMPMENT', NULL),
('Garden_Industrial_Zone1', 'LOC_DISTRICT_GARDEN_INDUSTRIAL_ZONE1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_INDUSTRIAL_ZONE', NULL),
('Garden_Garden1', 'LOC_DISTRICT_GARDEN_GARDEN1', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_GARDEN', NULL),
('Garden_Sea1', 'LOC_DISTRICT_GARDEN_SEA1', 'YIELD_SCIENCE', 1, 1, NULL, 'TERRAIN_COAST');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement) VALUES
('Garden_Quan1', 'LOC_DISTRICT_GARDEN_QUAN1', 'YIELD_SCIENCE', 2, 1, 'IMPROVEMENT_AL_QUAN');

INSERT INTO District_Adjacencies
(DistrictType, YieldChangeId) VALUES 
('DISTRICT_GARDEN', 'Garden_Garden1'),
('DISTRICT_GARDEN', 'Garden_Industrial_Zone1'),
('DISTRICT_GARDEN', 'Mountains_Science1'),
('DISTRICT_GARDEN', 'Mountains_Science2'),
('DISTRICT_GARDEN', 'Mountains_Science3'),
('DISTRICT_GARDEN', 'Mountains_Science4'),
('DISTRICT_GARDEN', 'Mountains_Science5'),
('DISTRICT_GARDEN', 'Garden_Sea1'),
('DISTRICT_GARDEN', 'District_Science'),
('DISTRICT_GARDEN', 'Garden_Quan1'),
('DISTRICT_GARDEN', 'Garden_Encampment1');

INSERT INTO DistrictModifiers
(DistrictType, ModifierId) VALUES 
('DISTRICT_GARDEN', 'GARDEN_YIELD_SCIENCE');

INSERT INTO Modifiers
(ModifierId, ModifierType) VALUES 
('GARDEN_YIELD_SCIENCE', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('GARDEN_YIELD_SCIENCE', 'Amount', 4),
('GARDEN_YIELD_SCIENCE', 'YieldType', 'YIELD_SCIENCE');

INSERT INTO District_GreatPersonPoints
(DistrictType, GreatPersonClassType, PointsPerTurn) VALUES 
('DISTRICT_GARDEN', 'GREAT_PERSON_CLASS_AL_LILY', 1),
('DISTRICT_GARDEN', 'GREAT_PERSON_CLASS_SCIENTIST', 1);

INSERT INTO District_TradeRouteYields
(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination) VALUES 
('DISTRICT_GARDEN', 'YIELD_SCIENCE', 1, 1, 1);

INSERT INTO District_CitizenYieldChanges
(DistrictType, YieldType, YieldChange) VALUES 
('DISTRICT_GARDEN', 'YIELD_SCIENCE', 2);

-- �о�����
INSERT INTO Types
(Type, Kind) VALUES 
('DISTRICT_AL_MOYU', 'KIND_DISTRICT');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType) VALUES 
('DISTRICT_AL_MOYU', 'DISTRICT_INDUSTRIAL_ZONE');

INSERT INTO Districts
(DistrictType, Name, PrereqTech, Description, Cost, RequiresPlacement, RequiresPopulation, NoAdjacentCity, Aqueduct, InternalOnly, ZOC, HitPoints, CaptureRemovesBuildings, CaptureRemovesCityDefenses, PlunderType, PlunderAmount, MilitaryDomain, CostProgressionModel, CostProgressionParam1, TraitType, Appeal, OnePerCity, Maintenance, CityStrengthModifier, AdvisorType) VALUES 
('DISTRICT_AL_MOYU', 'LOC_DISTRICT_AL_MOYU_NAME', 'TECH_APPRENTICESHIP', 'LOC_DISTRICT_AL_MOYU_DESCRIPTION', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'PLUNDER_SCIENCE', 25, 'NO_DOMAIN', 'COST_PROGRESSION_NUM_UNDER_AVG_PLUS_TECH', 40, 'TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU', -1, 1, 2, 2, 'ADVISOR_GENERIC');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict, AdjacentTerrain) VALUES
('Moyu_Encampment1', 'LOC_DISTRICT_AL_MOYU_ENCAMPMENT1', 'YIELD_SCIENCE', 1, 1, 'DISTRICT_ENCAMPMENT', NULL),
('Moyu_Encampment2', 'LOC_DISTRICT_AL_MOYU_ENCAMPMENT2', 'YIELD_PRODUCTION', 1, 1, 'DISTRICT_ENCAMPMENT', NULL),
('Moyu_ENTERTAINMENT_COMPLEX1', 'LOC_DISTRICT_AL_MOYU_ENTERTAINMENT_COMPLEX1', 'YIELD_SCIENCE', 1, 1, 'DISTRICT_ENTERTAINMENT_COMPLEX', NULL),
('Moyu_ENTERTAINMENT_COMPLEX2', 'LOC_DISTRICT_AL_MOYU_ENTERTAINMENT_COMPLEX2', 'YIELD_PRODUCTION', 1, 1, 'DISTRICT_ENTERTAINMENT_COMPLEX', NULL),
('Moyu_Garden1', 'LOC_DISTRICT_AL_MOYU_GARDEN1', 'YIELD_SCIENCE', 1, 1, 'DISTRICT_GARDEN', NULL),
('Moyu_Garden2', 'LOC_DISTRICT_AL_MOYU_GARDEN2', 'YIELD_PRODUCTION', 1, 1, 'DISTRICT_GARDEN', NULL);

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentResourceClass) VALUES
('Moyu_LUXURY1', 'LOC_DISTRICT_AL_MOYU_LUXURY1', 'YIELD_PRODUCTION', 2, 1, 'RESOURCECLASS_LUXURY');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement) VALUES
('Moyu_Quan1', 'LOC_DISTRICT_AL_MOYU_QUAN1', 'YIELD_PRODUCTION', 2, 1, 'IMPROVEMENT_AL_QUAN');

INSERT INTO District_Adjacencies
(DistrictType, YieldChangeId) VALUES
('DISTRICT_AL_MOYU', 'Mine_Production'),
('DISTRICT_AL_MOYU', 'Quarry_Production'),
('DISTRICT_AL_MOYU', 'District_Production'),
('DISTRICT_AL_MOYU', 'Moyu_Garden1'),
('DISTRICT_AL_MOYU', 'Moyu_Garden2'),
('DISTRICT_AL_MOYU', 'Moyu_Encampment1'),
('DISTRICT_AL_MOYU', 'Moyu_Encampment2'),
('DISTRICT_AL_MOYU', 'Moyu_ENTERTAINMENT_COMPLEX1'),
('DISTRICT_AL_MOYU', 'Moyu_ENTERTAINMENT_COMPLEX2'),
('DISTRICT_AL_MOYU', 'Moyu_Quan1'),
('DISTRICT_AL_MOYU', 'Moyu_LUXURY1');

INSERT INTO DistrictModifiers
(DistrictType, ModifierId) VALUES 
('DISTRICT_AL_MOYU', 'MOYU_YIELD_PRODUCTION');

INSERT INTO Modifiers
(ModifierId, ModifierType) VALUES 
('MOYU_YIELD_PRODUCTION', 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('MOYU_YIELD_PRODUCTION', 'Amount', 3),
('MOYU_YIELD_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION');

INSERT INTO District_GreatPersonPoints
(DistrictType, GreatPersonClassType, PointsPerTurn) VALUES 
('DISTRICT_AL_MOYU', 'GREAT_PERSON_CLASS_ENGINEER', 1),
('DISTRICT_AL_MOYU', 'GREAT_PERSON_CLASS_AL_LILY', 1);

INSERT INTO District_TradeRouteYields
(DistrictType, YieldType, YieldChangeAsOrigin, YieldChangeAsDomesticDestination, YieldChangeAsInternationalDestination) VALUES 
('DISTRICT_AL_MOYU', 'YIELD_PRODUCTION', 1, 1, 1);

INSERT INTO District_CitizenYieldChanges
(DistrictType, YieldType, YieldChange) VALUES 
('DISTRICT_AL_MOYU', 'YIELD_PRODUCTION', 2);