
-- TRIGGER
CREATE TABLE property_civ_number(n);
        WITH RECURSIVE
        cnt(x) AS (
            SELECT 1
            UNION ALL
            SELECT x+1 FROM cnt WHERE x <= 99
        )
        INSERT INTO property_civ_number(n)
        SELECT x FROM cnt;
    
    INSERT INTO TraitModifiers (TraitType, ModifierId)
        SELECT 'TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_TRAIT_AL_KANBA_TOUTOMI_CULTURE' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_CULTURE' || n, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_CULTURE' || n, 'YieldType', 'YIELD_CULTURE'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_CULTURE' || n, 'Amount', 1
        FROM property_civ_number;

    INSERT INTO TraitModifiers (TraitType, ModifierId)
        SELECT 'TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_TRAIT_AL_KANBA_TOUTOMI_FAITH' || n
        FROM property_civ_number;
    INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_FAITH' || n, 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_FAITH' || n, 'YieldType', 'YIELD_FAITH'
        FROM property_civ_number;
    INSERT INTO ModifierArguments (ModifierId, Name, Value)
        SELECT 'MOD_TRAIT_AL_KANBA_TOUTOMI_FAITH' || n, 'Amount', 1
        FROM property_civ_number;

    INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
        SELECT 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n, 'REQUIREMENTSET_TEST_ALL'
        FROM property_civ_number;
    INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
        SELECT 'REQSET_AL_PLOT_HAS_TOUTOMI_' || n, 'REQ_AL_PLOT_HAS_TOUTOMI_' || n
        FROM property_civ_number;
    INSERT INTO Requirements (RequirementId, RequirementType)
        SELECT 'REQ_AL_PLOT_HAS_TOUTOMI_' || n, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
        FROM property_civ_number;
    INSERT INTO RequirementArguments (RequirementId, Name, Value)
        SELECT 'REQ_AL_PLOT_HAS_TOUTOMI_' || n, 'PropertyName', 'TOUTOMI'
        FROM property_civ_number;
    INSERT INTO RequirementArguments (RequirementId, Name, Value)
        SELECT 'REQ_AL_PLOT_HAS_TOUTOMI_' || n, 'PropertyMinimum', n*2
        FROM property_civ_number;

INSERT INTO Types
(Type, Kind) VALUES
('CIVILIZATION_AL_YURIGAOKA', 'KIND_CIVILIZATION'),
('CIVILIZATION_AL_KANBA', 'KIND_CIVILIZATION'),

('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_KANBA_LILY', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_KANBA_STAGE', 'KIND_TRAIT'),

('TRAIT_CIVILIZATION_AL_GARDEN', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_ANGEL_PROMISE', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU', 'KIND_TRAIT'),
('TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN', 'KIND_TRAIT');

INSERT INTO Traits
(TraitType, Name, Description) VALUES
('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_COLLECTION_NAME', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_COLLECTION_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_KANBA_LILY', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_LILY_NAME', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_LILY_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN_NAME', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_KANBA_STAGE', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_STAGE_NAME', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_STAGE_DESCRIPTION'),

('TRAIT_CIVILIZATION_AL_GARDEN', 'LOC_TRAIT_CIVILIZATION_AL_GARDEN_NAME', 'LOC_TRAIT_CIVILIZATION_AL_GARDEN_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_ANGEL_PROMISE', 'LOC_TRAIT_CIVILIZATION_AL_ANGEL_PROMISE_NAME', 'LOC_TRAIT_CIVILIZATION_AL_ANGEL_PROMISE_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA', 'LOC_TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA_NAME', 'LOC_TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU', 'LOC_TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU_NAME', 'LOC_TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU_DESCRIPTION'),
('TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN', 'LOC_TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN_NAME', 'LOC_TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN_DESCRIPTION');

INSERT INTO TraitModifiers
(TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_TRAIT_AL_KANBA_COLLECTION_1'),
('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_TRAIT_AL_KANBA_COLLECTION_2'),
('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_TRAIT_AL_KANBA_COLLECTION_3'),
('TRAIT_CIVILIZATION_AL_GARDEN', 'MOD_TRAIT_CIVILIZATION_AL_GARDEN_LAND_CORPS_EARLY'),
('TRAIT_CIVILIZATION_AL_GARDEN', 'MOD_TRAIT_CIVILIZATION_AL_GARDEN_MAGI');

INSERT INTO Modifiers
(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('MOD_TRAIT_AL_KANBA_COLLECTION_1', 'MODIFIER_ALL_DISTRICTS_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', 'REQSET_AL_LEADER_IS_KANAHO'),
('MOD_TRAIT_AL_KANBA_COLLECTION_2', 'MODIFIER_PLAYER_ADJUST_UNIT_DISTRICT_PERCENT', NULL),
('MOD_TRAIT_AL_KANBA_COLLECTION_3', 'MODIFIER_PLAYER_ADJUST_UNIT_WONDER_PERCENT', NULL),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_MAGI', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', NULL),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_LAND_CORPS_EARLY', 'MODIFIER_PLAYER_CORPS_ARMY_PREREQ', NULL);

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('MOD_TRAIT_AL_KANBA_COLLECTION_1', 'YieldTypeToMirror', 'YIELD_SCIENCE'),
('MOD_TRAIT_AL_KANBA_COLLECTION_1', 'YieldTypeToGrant', 'YIELD_CULTURE'),

('MOD_TRAIT_AL_KANBA_COLLECTION_2', 'Amount', 25),
('MOD_TRAIT_AL_KANBA_COLLECTION_3', 'Amount', 25),

('MOD_TRAIT_CIVILIZATION_AL_GARDEN_MAGI', 'ResourceType', 'RESOURCE_AL_MAGI'),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_MAGI', 'Amount', 3),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_LAND_CORPS_EARLY', 'Corps', 1),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_LAND_CORPS_EARLY', 'Domain', 'DOMAIN_LAND'),
('MOD_TRAIT_CIVILIZATION_AL_GARDEN_LAND_CORPS_EARLY', 'CivicType', 'CIVIC_STATE_WORKFORCE');

INSERT INTO Civilizations
(CivilizationType, Name, Description, Adjective, StartingCivilizationLevelType, RandomCityNameDepth, Ethnicity) VALUES
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CIVILIZATION_AL_YURIGAOKA_NAME', 'LOC_CIVILIZATION_AL_YURIGAOKA_DESCRIPTION', 'LOC_CIVILIZATION_AL_YURIGAOKA_ADJECTIVE', 'CIVILIZATION_LEVEL_FULL_CIV', 10, 'ETHNICITY_ASIAN'),
('CIVILIZATION_AL_KANBA', 'LOC_CIVILIZATION_AL_KANBA_NAME', 'LOC_CIVILIZATION_AL_KANBA_DESCRIPTION', 'LOC_CIVILIZATION_AL_KANBA_ADJECTIVE', 'CIVILIZATION_LEVEL_FULL_CIV', 10, 'ETHNICITY_ASIAN');

INSERT INTO CivilizationLeaders
(CivilizationType, LeaderType, CapitalName) VALUES
('CIVILIZATION_AL_YURIGAOKA', 'LEADER_AL_RIRI', 'LOC_CITY_NAME_HITOTSUYANAGI'),
('CIVILIZATION_AL_KANBA', 'LEADER_AL_KANAHO', 'LOC_CITY_NAME_KANBA_1');

INSERT INTO CivilizationTraits
(CivilizationType, TraitType) VALUES
('CIVILIZATION_AL_YURIGAOKA', 'TRAIT_CIVILIZATION_AL_GARDEN'),
('CIVILIZATION_AL_YURIGAOKA', 'TRAIT_CIVILIZATION_AL_ANGEL_PROMISE'),
('CIVILIZATION_AL_YURIGAOKA', 'TRAIT_CIVILIZATION_AL_BUILDING_AL_SAKURA'),
('CIVILIZATION_AL_YURIGAOKA', 'TRAIT_CIVILIZATION_AL_DISTRICT_AL_MOYU'),
('CIVILIZATION_AL_YURIGAOKA', 'TRAIT_CIVILIZATION_AL_IMPROVEMENT_AL_QUAN'),

('CIVILIZATION_AL_KANBA', 'TRAIT_CIVILIZATION_AL_GARDEN'),
('CIVILIZATION_AL_KANBA', 'TRAIT_CIVILIZATION_AL_KANBA_COLLECTION'),
('CIVILIZATION_AL_KANBA', 'TRAIT_CIVILIZATION_AL_KANBA_LILY'),
('CIVILIZATION_AL_KANBA', 'TRAIT_CIVILIZATION_AL_KANBA_TEAGARDEN'),
('CIVILIZATION_AL_KANBA', 'TRAIT_CIVILIZATION_AL_KANBA_STAGE');

INSERT INTO CivilizationInfo
(CivilizationType, Header, Caption, SortIndex) VALUES
('CIVILIZATION_AL_KANBA', 'LOC_CIVINFO_LOCATION', 'LOC_CIVINFO_AL_KANBA_LOCATION', 10),
('CIVILIZATION_AL_KANBA', 'LOC_CIVINFO_SIZE', 'LOC_CIVINFO_AL_KANBA_SIZE', 10),
('CIVILIZATION_AL_KANBA', 'LOC_CIVINFO_POPULATION', 'LOC_CIVINFO_AL_KANBA_POPULATION', 10),
('CIVILIZATION_AL_KANBA', 'LOC_CIVINFO_CAPITAL', 'LOC_CIVINFO_AL_KANBA_CAPITAL', 10),

('CIVILIZATION_AL_YURIGAOKA', 'LOC_CIVINFO_LOCATION', 'LOC_CIVINFO_AL_YURIGAOKA_LOCATION', 10),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CIVINFO_SIZE', 'LOC_CIVINFO_AL_YURIGAOKA_SIZE', 10),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CIVINFO_POPULATION', 'LOC_CIVINFO_AL_YURIGAOKA_POPULATION', 10),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CIVINFO_CAPITAL', 'LOC_CIVINFO_AL_YURIGAOKA_CAPITAL', 10);

INSERT INTO CityNames
(CivilizationType, CityName) VALUES
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_1'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_2'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_3'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_4'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_5'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_6'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_7'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_8'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_9'),
('CIVILIZATION_AL_KANBA', 'LOC_CITY_NAME_KANBA_10'),

('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_HITOTSUYANAGI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_LOHENGRIN'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_VINGOLF'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_RADGRID'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_REGINLEIF'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_MIZUKI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_BRYNHILDRLINE'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_HERFJOTUR'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_ROSSWEISSE'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SCHWARTZGRAIL'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_GINNUNGAGAP'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SANNGRIDR'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SIGRDRIFA'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_IPPAN'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_EIR'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SINSI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SCHWERTLEITE'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_GEIRAVOR'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SVANHVIT'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_VIDOFNIR'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITY_NAME_SKULD');

INSERT INTO CivilizationCitizenNames
(CivilizationType, CitizenName) VALUES
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_1'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_2'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_3'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_4'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_5'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_6'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_7'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_8'),
('CIVILIZATION_AL_KANBA', 'LOC_CITIZEN_KANBA_9'),

('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_RIRI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_YURI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_YUYU'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_MILI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_KAED'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_MAI'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_TADU'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_SHEN'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_YUJIA'),
('CIVILIZATION_AL_YURIGAOKA', 'LOC_CITIZEN_YURIGAOKA_FUMI');

INSERT INTO StartBiasTerrains
(CivilizationType, TerrainType, Tier) VALUES
('CIVILIZATION_AL_YURIGAOKA', 'TERRAIN_COAST', 1),
('CIVILIZATION_AL_KANBA', 'TERRAIN_COAST', 1);

INSERT INTO StartBiasResources
(CivilizationType, ResourceType, Tier) VALUES
('CIVILIZATION_AL_KANBA', 'RESOURCE_AL_MAGI', 1),
('CIVILIZATION_AL_YURIGAOKA', 'RESOURCE_AL_MAGI', 1);

INSERT INTO LoadingInfo
(LeaderType, ForegroundImage, BackgroundImage, LeaderText) VALUES
('LEADER_AL_KANAHO', 'ICON_LEADER_AL_KANAHO_LOADFORGE', 'ICON_LEADER_AL_KANAHO_LOADBACK', 'LOC_LOADING_INFO_LEADER_AL_KANAHO'),
('LEADER_AL_RIRI', 'ICON_LEADER_AL_RIRI_LOADFORGE', 'ICON_LEADER_AL_RIRI_LOADBACK', 'LOC_LOADING_INFO_LEADER_AL_RIRI');

INSERT INTO DiplomacyInfo
(Type, BackgroundImage) VALUES
('LEADER_AL_RIRI', 'ICON_LEADER_AL_RIRI_DIPLOBACK'),
('LEADER_AL_KANAHO', 'ICON_LEADER_AL_KANAHO_DIPLOBACK');