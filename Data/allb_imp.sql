-- ����֮ͥ
INSERT INTO Types
(Type, Kind) VALUES
('IMPROVEMENT_AL_QUAN', 'KIND_IMPROVEMENT');

INSERT INTO Improvements
(ImprovementType, Name, PrereqTech, Buildable, Description, Icon, PlunderType, PlunderAmount, TraitType, Housing, RequiresRiver, YieldFromAppeal, YieldFromAppealPercent, MovementChange, OnePerCity) VALUES
('IMPROVEMENT_AL_QUAN', 'LOC_IMPROVEMENT_AL_QUAN_NAME', 'TECH_POTTERY', 1, 'LOC_IMPROVEMENT_AL_QUAN_DESCRIPTION', 'ICON_IMPROVEMENT_AL_QUAN', 'PLUNDER_FAITH', 50, 'TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN', 1, 1, 'YIELD_SCIENCE', 50, -1, 1);

INSERT INTO Improvement_ValidTerrains
(ImprovementType, TerrainType) VALUES
('IMPROVEMENT_AL_QUAN', 'TERRAIN_TUNDRA'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_PLAINS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_GRASS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_SNOW'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_DESERT'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_DESERT_HILLS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_TUNDRA_HILLS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_PLAINS_HILLS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_GRASS_HILLS'),
('IMPROVEMENT_AL_QUAN', 'TERRAIN_SNOW_HILLS');

INSERT INTO Improvement_ValidBuildUnits
(ImprovementType, UnitType) VALUES
('IMPROVEMENT_AL_QUAN', 'UNIT_BUILDER');

INSERT INTO Improvement_YieldChanges
(ImprovementType, YieldType, YieldChange) VALUES
('IMPROVEMENT_AL_QUAN', 'YIELD_CULTURE', 2);

INSERT INTO Improvement_Tourism
(ImprovementType, TourismSource, PrereqTech, ScalingFactor) VALUES
('IMPROVEMENT_AL_QUAN', 'TOURISMSOURCE_APPEAL', 'TECH_FLIGHT', 100);

INSERT INTO ImprovementModifiers
(ImprovementType, ModifierId) VALUES
('IMPROVEMENT_AL_QUAN', 'AL_QUAN_AMENITY'),
('IMPROVEMENT_AL_QUAN', 'MOD_AL_QUAN_APPEAL_BUFF');

INSERT INTO Improvement_Adjacencies
(ImprovementType, YieldChangeId) VALUES
('IMPROVEMENT_AL_QUAN', 'YC_AL_QUAN_GARDEN1'),
('IMPROVEMENT_AL_QUAN', 'YC_AL_QUAN_GARDEN2');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict, AdjacentTerrain) VALUES
('YC_AL_QUAN_GARDEN1', 'LOC_YC_AL_QUAN_GARDEN1', 'YIELD_CULTURE', 2, 1, 'DISTRICT_GARDEN', NULL),
('YC_AL_QUAN_GARDEN2', 'LOC_YC_AL_QUAN_GARDEN2', 'YIELD_GOLD', 2, 1, 'DISTRICT_GARDEN', NULL);

INSERT INTO RequirementSetRequirements
(RequirementSetId, RequirementId) VALUES
('MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS', 'REQUIRES_PLOT_BREATHTAKING_APPEAL_ROOSEVELT');

INSERT INTO RequirementSets
(RequirementSetId, RequirementSetType) VALUES
('MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Modifiers
(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('AL_QUAN_AMENITY', 'MODIFIER_CITY_OWNER_ADJUST_IMPROVEMENT_AMENITY', NULL),
('MOD_AL_QUAN_APPEAL_BUFF', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER', 'MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('AL_QUAN_AMENITY', 'Amount', 1),
('MOD_AL_QUAN_APPEAL_BUFF', 'ImprovementType', 'IMPROVEMENT_AL_QUAN');