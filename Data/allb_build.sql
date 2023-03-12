-- ��Լ����
INSERT INTO Types
(Type, Kind) VALUES
('BUILDING_AL_PROMISE', 'KIND_BUILDING'),
('ABILITY_AL_INCREASED_COMBAT', 'KIND_ABILITY');

INSERT INTO TypeTags
(Type, Tag) VALUES
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_MELEE'),
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_ANTI_CAVALRY'),
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_RECON'),
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_HEAVY_CAVALRY'),
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_LIGHT_CAVALRY'),
('ABILITY_AL_INCREASED_COMBAT', 'CLASS_RANGED');

INSERT INTO UnitAbilities
(UnitAbilityType, Name, Description, Inactive) VALUES 
('ABILITY_AL_INCREASED_COMBAT', 'LOC_ABILITY_AL_INCREASED_COMBAT_NAME', 'LOC_ABILITY_AL_INCREASED_COMBAT_DESCRIPTION', 1);

INSERT INTO UnitAbilityModifiers
(UnitAbilityType, ModifierId) VALUES 
('ABILITY_AL_INCREASED_COMBAT', 'AL_PROMISE_COMBAT_BUFF');

INSERT INTO Buildings
(BuildingType, Name, Description, PrereqTech, PrereqDistrict, PurchaseYield, Cost, AdvisorType, Maintenance, Housing, CitizenSlots, TraitType) VALUES 
('BUILDING_AL_PROMISE', 'LOC_BUILDING_AL_PROMISE_NAME', 'LOC_BUILDING_AL_PROMISE_DESCRIPTION', 'TECH_BRONZE_WORKING', 'DISTRICT_ENCAMPMENT', 'YIELD_GOLD', 1, 'ADVISOR_CONQUEST', 1, 2, 2, 'TRAIT_CIVILIZATION_AL_GARDEN');

INSERT INTO BuildingReplaces
(CivUniqueBuildingType, ReplacesBuildingType) VALUES 
('BUILDING_AL_PROMISE', 'BUILDING_BARRACKS');

INSERT INTO Building_YieldChanges
(BuildingType, YieldType, YieldChange) VALUES
('BUILDING_AL_PROMISE', 'YIELD_PRODUCTION', 1000);

INSERT INTO Building_GreatPersonPoints
(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES 
('BUILDING_AL_PROMISE', 'GREAT_PERSON_CLASS_GENERAL', 1);

INSERT INTO BuildingModifiers
(BuildingType, ModifierId) VALUES 
('BUILDING_AL_PROMISE', 'BARRACKS_TRAINED_UNIT_XP_MODIFIER'),
('BUILDING_AL_PROMISE', 'AL_PROMISE_COMBAT');

INSERT INTO Modifiers
(ModifierId, ModifierType, Permanent) VALUES
('AL_PROMISE_COMBAT', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 1),
('AL_PROMISE_COMBAT_BUFF', 'MODIFIER_UNIT_ADJUST_BASE_COMBAT_STRENGTH', 0);

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES 
('AL_PROMISE_COMBAT', 'AbilityType', 'ABILITY_AL_INCREASED_COMBAT'),
('AL_PROMISE_COMBAT_BUFF', 'Amount', 5);

-- Ⱦ����Ұ֮��
INSERT INTO Types
(Type, Kind) VALUES
('BUILDING_AL_SAKURA', 'KIND_BUILDING');

INSERT INTO Buildings
(BuildingType, Name, Description, PrereqTech, PrereqDistrict, PurchaseYield, Cost, AdvisorType, Maintenance, CitizenSlots, TraitType) VALUES 
('BUILDING_AL_SAKURA', 'LOC_BUILDING_AL_SAKURA_NAME', 'LOC_BUILDING_AL_SAKURA_DESCRIPTION', 'TECH_ASTROLOGY', 'DISTRICT_HOLY_SITE', 'YIELD_GOLD', 1, 'ADVISOR_RELIGIOUS', 1, 2, 'TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA');

INSERT INTO BuildingReplaces
(CivUniqueBuildingType, ReplacesBuildingType) VALUES 
('BUILDING_AL_SAKURA', 'BUILDING_SHRINE');

INSERT INTO Building_YieldChanges
(BuildingType, YieldType, YieldChange) VALUES
('BUILDING_AL_SAKURA', 'YIELD_PRODUCTION', 1),
('BUILDING_AL_SAKURA', 'YIELD_FAITH', 1);

INSERT INTO Building_GreatPersonPoints
(BuildingType, GreatPersonClassType, PointsPerTurn) VALUES 
('BUILDING_AL_SAKURA', 'GREAT_PERSON_CLASS_PROPHET', 1);

INSERT INTO Building_GreatWorks
(BuildingType, GreatWorkSlotType, NumSlots) VALUES 
('BUILDING_AL_SAKURA', 'GREATWORKSLOT_RELIC', 1);

INSERT INTO BuildingModifiers
(BuildingType, ModifierId) VALUES
('BUILDING_AL_SAKURA', 'MOD_AL_SAKURA_APPEAL'),
('BUILDING_AL_SAKURA', 'AL_SAKURA_FAITH_TRAINED_UNIT');

INSERT INTO Modifiers
(ModifierId, ModifierType, RunOnce, Permanent) VALUES
('AL_SAKURA_FAITH_TRAINED_UNIT', 'MODIFIER_SINGLE_CITY_GRANT_YIELD_PER_UNIT_COST', 1, 1);

INSERT INTO RequirementSetRequirements
(RequirementSetId, RequirementId) VALUES
('AL_SAKURA_PLOT_IS_HILLS_REQUIREMENTS', 'PLOT_IS_HILLS_REQUIREMENT');

INSERT INTO RequirementSets
(RequirementSetId, RequirementSetType) VALUES
('AL_SAKURA_PLOT_IS_HILLS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Modifiers
(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MOD_AL_SAKURA_APPEAL', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL', 'AL_SAKURA_PLOT_IS_HILLS_REQUIREMENTS');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES 
('AL_SAKURA_FAITH_TRAINED_UNIT', 'YieldType', 'YIELD_FAITH'),
('AL_SAKURA_FAITH_TRAINED_UNIT', 'UnitProductionPercent', 25),
('MOD_AL_SAKURA_APPEAL', 'Amount', 1);