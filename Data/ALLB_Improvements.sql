INSERT INTO Types
(Type, Kind) VALUES
    --yurigaoka UI
    ('IMPROVEMENT_AL_QUAN', 'KIND_IMPROVEMENT'),
    ('IMPROVEMENT_AL_TEAGARDEN', 'KIND_IMPROVEMENT'),
    ('IMPROVEMENT_AL_UNICORN', 'KIND_IMPROVEMENT'),
    --MAGI ONSEN
    ('IMPROVEMENT_AL_ONSEN', 'KIND_IMPROVEMENT'),
    ('IMPROVEMENT_AL_ONSEN_SEA', 'KIND_IMPROVEMENT');

INSERT INTO Improvements
(ImprovementType, Name, PrereqTech, Buildable, Description, Icon, PlunderType, PlunderAmount, TraitType, Housing, RequiresRiver, YieldFromAppeal, YieldFromAppealPercent, MovementChange, OnePerCity, Appeal, EnforceTerrain, Domain, PrereqCivic) VALUES
    --yurigaoka UI
    ('IMPROVEMENT_AL_QUAN', 'LOC_IMPROVEMENT_AL_QUAN_NAME', 'TECH_POTTERY', 1, 'LOC_IMPROVEMENT_AL_QUAN_DESCRIPTION', 'ICON_IMPROVEMENT_AL_QUAN', 'PLUNDER_FAITH', 50, 'TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN', 1, 1, 'YIELD_FAITH', 50, -1, 1, 1, 0, 'DOMAIN_LAND', NULL),
    --MAGI ONSEN
    ('IMPROVEMENT_AL_ONSEN', 'LOC_IMPROVEMENT_AL_ONSEN_NAME', 'TECH_AL_CLASSICAL', 1, 'LOC_IMPROVEMENT_AL_ONSEN_DESCRIPTION', 'ICON_IMPROVEMENT_AL_ONSEN', 'PLUNDER_SCIENCE', 50, NULL, 1, 0, 'YIELD_PRODUCTION', 25, -1, 0, 1, 1, 'DOMAIN_LAND', NULL),

    ('IMPROVEMENT_AL_UNICORN', 'LOC_IMPROVEMENT_AL_UNICORN_NAME', NULL, 1, 'LOC_IMPROVEMENT_AL_UNICORN_DESCRIPTION', 'ICON_IMPROVEMENT_AL_UNICORN', 'PLUNDER_SCIENCE', 50, 'TRAIT_CIVILIZATION_NO_PLAYER', 1, 0, NULL, 0, -1, 0, 1, 1, 'DOMAIN_LAND', NULL),

    ('IMPROVEMENT_AL_ONSEN_SEA', 'LOC_IMPROVEMENT_AL_ONSEN_SEA_NAME', NULL, 1, 'LOC_IMPROVEMENT_AL_ONSEN_SEA_DESCRIPTION', 'ICON_IMPROVEMENT_AL_ONSEN_SEA', 'PLUNDER_SCIENCE', 50, NULL, 1, 0, 'YIELD_SCIENCE', 25, -1, 0, 1, 1, 'DOMAIN_SEA', 'CIVIC_AL_CLASSICAL');

INSERT INTO Improvements (ImprovementType, Name, PrereqTech, Buildable, Description, Icon, PlunderType, PlunderAmount, TraitType, Appeal, Domain, SameAdjacentValid,OnePerCity) VALUES
    ('IMPROVEMENT_AL_TEAGARDEN', 'LOC_IMPROVEMENT_AL_TEAGARDEN_NAME', 'TECH_POTTERY', 1, 'LOC_TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN_DESCRIPTION', 'ICON_IMPROVEMENT_AL_TEAGARDEN', 'PLUNDER_FAITH', 50, 'TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN', 1, 'DOMAIN_LAND',0,1);

INSERT INTO Improvement_ValidTerrains
(ImprovementType, TerrainType) VALUES
    --yurigaoka UI
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_TUNDRA'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_PLAINS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_GRASS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_SNOW'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_DESERT'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_DESERT_HILLS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_TUNDRA_HILLS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_AL_QUAN', 'TERRAIN_SNOW_HILLS'),
    --yurigaoka UI
    ('IMPROVEMENT_AL_TEAGARDEN', 'TERRAIN_PLAINS'),
    ('IMPROVEMENT_AL_TEAGARDEN', 'TERRAIN_GRASS'),
    ('IMPROVEMENT_AL_TEAGARDEN', 'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_AL_TEAGARDEN', 'TERRAIN_GRASS_HILLS'),
    --MAGI ONSEN
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_TUNDRA'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_TUNDRA_HILLS'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_PLAINS'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_GRASS'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_SNOW'),
    ('IMPROVEMENT_AL_ONSEN', 'TERRAIN_SNOW_HILLS'),

    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_TUNDRA'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_TUNDRA_HILLS'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_PLAINS'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_GRASS'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_SNOW'),
    ('IMPROVEMENT_AL_UNICORN', 'TERRAIN_SNOW_HILLS'),

    ('IMPROVEMENT_AL_ONSEN_SEA', 'TERRAIN_COAST'),
    ('IMPROVEMENT_AL_ONSEN_SEA', 'TERRAIN_OCEAN');

INSERT INTO Improvement_ValidResources
(ImprovementType, ResourceType, MustRemoveFeature) VALUES
('IMPROVEMENT_AL_ONSEN', 'RESOURCE_AL_MAGI', 0),
('IMPROVEMENT_AL_UNICORN', 'RESOURCE_AL_UNICORN', 0),
('IMPROVEMENT_AL_ONSEN_SEA', 'RESOURCE_AL_MAGI', 0);

INSERT INTO Improvement_ValidBuildUnits
(ImprovementType, UnitType) VALUES
('IMPROVEMENT_AL_TEAGARDEN', 'UNIT_AL_KANBALILY'),
('IMPROVEMENT_AL_UNICORN', 'UNIT_AL_AKARI_GREATNORMAL'),
('IMPROVEMENT_AL_QUAN', 'UNIT_BUILDER'),
('IMPROVEMENT_AL_ONSEN', 'UNIT_BUILDER'),
('IMPROVEMENT_AL_ONSEN_SEA', 'UNIT_BUILDER');

UPDATE Improvement_ValidBuildUnits SET ConsumesCharge = 0 WHERE ImprovementType = 'IMPROVEMENT_AL_UNICORN';
UPDATE Improvement_ValidBuildUnits SET ValidRepairOnly = 1 WHERE ImprovementType = 'IMPROVEMENT_AL_UNICORN';

INSERT INTO Improvement_YieldChanges
(ImprovementType, YieldType, YieldChange) VALUES
('IMPROVEMENT_AL_QUAN', 'YIELD_CULTURE', 2),
('IMPROVEMENT_AL_ONSEN', 'YIELD_PRODUCTION', 1),
('IMPROVEMENT_AL_ONSEN', 'YIELD_SCIENCE', 1),

('IMPROVEMENT_AL_UNICORN', 'YIELD_PRODUCTION', 1),
('IMPROVEMENT_AL_UNICORN', 'YIELD_SCIENCE', 2),

('IMPROVEMENT_AL_ONSEN_SEA', 'YIELD_SCIENCE', 1),
('IMPROVEMENT_AL_ONSEN_SEA', 'YIELD_PRODUCTION', 1);

INSERT INTO Improvement_Tourism
(ImprovementType, TourismSource, PrereqTech, ScalingFactor) VALUES
('IMPROVEMENT_AL_QUAN', 'TOURISMSOURCE_APPEAL', 'TECH_FLIGHT', 100),
('IMPROVEMENT_AL_ONSEN', 'TOURISMSOURCE_APPEAL', 'TECH_FLIGHT', 100),
('IMPROVEMENT_AL_ONSEN_SEA', 'TOURISMSOURCE_APPEAL', 'TECH_FLIGHT', 100);

INSERT INTO ImprovementModifiers
(ImprovementType, ModifierId) VALUES
('IMPROVEMENT_AL_QUAN', 'AL_QUAN_AMENITY'),
('IMPROVEMENT_AL_TEAGARDEN', 'MOD_AL_TEAGARDEN_AMENITY'),
('IMPROVEMENT_AL_QUAN', 'MOD_AL_QUAN_APPEAL_BUFF'),
('IMPROVEMENT_AL_QUAN', 'MOD_AL_QUAN_MAGI'),
('IMPROVEMENT_AL_ONSEN', 'MOD_AL_ONSEN_APPEAL'),
('IMPROVEMENT_AL_ONSEN_SEA', 'MOD_AL_ONSEN_SEA_APPEAL');

    INSERT INTO ImprovementModifiers (ImprovementType, ModifierId)
        SELECT 'IMPROVEMENT_AL_TEAGARDEN', 'MOD_IMP_AL_KANBA_TOUTOMI_CULTURE' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_CULTURE' || n, 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_CULTURE' || n, 'YieldType', 'YIELD_CULTURE'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_CULTURE' || n, 'Amount', 1
        FROM property_civ_number;

    INSERT INTO ImprovementModifiers (ImprovementType, ModifierId)
        SELECT 'IMPROVEMENT_AL_TEAGARDEN', 'MOD_IMP_AL_KANBA_TOUTOMI_FAITH' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_FAITH' || n, 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_FAITH' || n, 'YieldType', 'YIELD_FAITH'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_FAITH' || n, 'Amount', 1
        FROM property_civ_number;

    INSERT INTO ImprovementModifiers (ImprovementType, ModifierId)
        SELECT 'IMPROVEMENT_AL_UNICORN', 'MOD_IMP_AL_KANBA_TOUTOMI_SCIENCE' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_SCIENCE' || n, 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_SCIENCE' || n, 'YieldType', 'YIELD_SCIENCE'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_IMP_AL_KANBA_TOUTOMI_SCIENCE' || n, 'Amount', 1
        FROM property_civ_number;

INSERT INTO Improvement_Adjacencies
(ImprovementType, YieldChangeId) VALUES
('IMPROVEMENT_AL_UNICORN', 'YC_AL_UNICRON_GARDEN'),
('IMPROVEMENT_AL_UNICORN', 'YC_AL_UNICORN_STAGE'),

('IMPROVEMENT_AL_QUAN', 'YC_AL_QUAN_GARDEN1'),
('IMPROVEMENT_AL_QUAN', 'YC_AL_QUAN_GARDEN2'),
('IMPROVEMENT_AL_ONSEN', 'YC_AL_ONSEN_GARDEN1');

INSERT INTO Adjacency_YieldChanges
(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict, AdjacentTerrain) VALUES
('YC_AL_QUAN_GARDEN1', 'LOC_YC_AL_QUAN_GARDEN1', 'YIELD_CULTURE', 2, 1, 'DISTRICT_AL_GARDEN', NULL),

('YC_AL_UNICRON_GARDEN', 'LOC_YC_YC_AL_UNICRON_GARDEN', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_AL_GARDEN', NULL),
('YC_AL_UNICORN_STAGE', 'LOC_YC_AL_UNICORN_STAGE', 'YIELD_SCIENCE', 2, 1, 'DISTRICT_AL_STAGE', NULL),

('YC_AL_QUAN_GARDEN2', 'LOC_YC_AL_QUAN_GARDEN2', 'YIELD_GOLD', 2, 1, 'DISTRICT_AL_GARDEN', NULL),
('YC_AL_ONSEN_GARDEN1', 'LOC_YC_AL_ONSEN_GARDEN1', 'YIELD_PRODUCTION', 2, 1, 'DISTRICT_AL_GARDEN', NULL);

INSERT INTO RequirementSetRequirements
(RequirementSetId, RequirementId) VALUES
('MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS', 'REQUIRES_PLOT_BREATHTAKING_APPEAL_ROOSEVELT');

INSERT INTO RequirementSets
(RequirementSetId, RequirementSetType) VALUES
('MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Modifiers
(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MOD_AL_GOV_TEAGARDEN_1', 'MODIFIER_SINGLE_CITY_ADJUST_FREE_POWER', NULL),
('MOD_AL_GOV_TEAGARDEN_2', 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', NULL),

('AL_QUAN_AMENITY', 'MODIFIER_CITY_OWNER_ADJUST_IMPROVEMENT_AMENITY', NULL),
('MOD_AL_TEAGARDEN_AMENITY', 'MODIFIER_CITY_OWNER_ADJUST_IMPROVEMENT_AMENITY', 'REQSET_AL_PLOT_HAS_TOUTOMI_2'),
('MOD_AL_QUAN_APPEAL_BUFF', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER', 'MOD_AL_QUAN_APPEAL_BUFF_REQUIREMENTS'),
('MOD_AL_QUAN_MAGI', 'MODIFIER_PLAYER_CITIES_ADJUST_EXTRA_ACCUMULATION_SPECIFIC_RESOURCE', NULL),
('MOD_AL_ONSEN_APPEAL', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL', NULL),
('MOD_AL_ONSEN_SEA_APPEAL', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL', NULL);

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('MOD_AL_GOV_TEAGARDEN_1', 'Amount', 4),
('MOD_AL_GOV_TEAGARDEN_1', 'SourceType', 'FREE_POWER_SOURCE_SOLAR'),
('MOD_AL_GOV_TEAGARDEN_2', 'Amount', 2),
('MOD_AL_GOV_TEAGARDEN_2', 'YieldType', 'YIELD_PRODUCTION'),

('AL_QUAN_AMENITY', 'Amount', 1),
('MOD_AL_TEAGARDEN_AMENITY', 'Amount', 1),
('MOD_AL_QUAN_APPEAL_BUFF', 'ImprovementType', 'IMPROVEMENT_AL_QUAN'),
('MOD_AL_QUAN_MAGI', 'ResourceType', 'RESOURCE_AL_MAGI'),
('MOD_AL_QUAN_MAGI', 'Amount', 2),
('MOD_AL_ONSEN_APPEAL', 'Amount', 1),
('MOD_AL_ONSEN_SEA_APPEAL', 'Amount', 1);