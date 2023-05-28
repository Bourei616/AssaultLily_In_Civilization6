CREATE TABLE AL_GreatPerson(
        'UnitName' TEXT NOT NULL,
        'Era' TEXT NOT NULL,
        'ActionType' TEXT NOT NULL,
        'DistrictType' TEXT,
        'ModNum' INTEGER,
        'Leader' BOOLEAN,
        PRIMARY KEY(UnitName)
    );
INSERT INTO AL_GreatPerson
        (UnitName,  Era,                ActionType,     DistrictType,           ModNum) VALUES
        ('MOYU',    'ERA_RENAISSANCE',    'GreatWork',    NULL,                   1),
        ('YUJIA',   'ERA_RENAISSANCE',    'GreatWork',    NULL,                   1),
        ('SHENLIN', 'ERA_RENAISSANCE',    'GreatWork',    NULL,                   1),
        ('KANAHO',  'ERA_RENAISSANCE',    'GreatWork',    NULL,                   1),
        ('TAKANE',  'ERA_RENAISSANCE',    'GreatWork',    NULL,                   1),
        ('AKEHI',   'ERA_CLASSICAL',      'GreatWork',    NULL,                   1),
        ('SUZUME',  'ERA_CLASSICAL',      'GreatWork',    NULL,                   1),
        ('FUMI',    'ERA_RENAISSANCE',  'Ability',      NULL,                   1),
        ('MAI',     'ERA_RENAISSANCE',  'Ability',      NULL,                   1),
        ('TADUSA',  'ERA_RENAISSANCE',  'Boom',         NULL,                   2),
        ('YUYU',    'ERA_RENAISSANCE',  'Boom',         NULL,                   2),
        ('AKARI',   'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_STAGE',    2),
        ('HIMEKA',  'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_STAGE',    2),
        ('MILIAM',  'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_MOYU',     2),
        ('KAEDE',   'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_GARDEN',   2),
        ('KUREHA',  'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_GARDEN',   2),
        ('HARUNA',  'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_GARDEN',   2),
        ('RIRI',    'ERA_RENAISSANCE',  'District',     'DISTRICT_AL_GARDEN',   1),
        ('FUJINO',  'ERA_CLASSICAL',    'District',     'DISTRICT_AL_GARDEN',   1);

    UPDATE AL_GreatPerson SET Leader = 1 WHERE UnitName = 'RIRI';
    UPDATE AL_GreatPerson SET Leader = 1 WHERE UnitName = 'KANAHO';
    ---------------------------------------------------------------------------------------------------------------------------------------
        --TYPES
            INSERT INTO Types (Type, Kind)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'KIND_GREAT_PERSON_INDIVIDUAL'
            FROM AL_GreatPerson;
            INSERT INTO Types (Type, Kind)
            SELECT 'ABILITY_LILY_GREATS_'||UnitName||'_ACTION_BUFF','KIND_ABILITY'
            FROM AL_GreatPerson
            WHERE ActionType = 'Ability';
            INSERT INTO Types
                (Type, Kind) VALUES
                ('GREAT_PERSON_CLASS_AL_LILY', 'KIND_GREAT_PERSON_CLASS'),
                ('PSEUDOYIELD_GPP_AL_LILY', 'KIND_PSEUDOYIELD'),
                ('UNIT_AL_LILY', 'KIND_UNIT');
            INSERT INTO PseudoYields
                (PseudoYieldType, DefaultValue) VALUES
                ('PSEUDOYIELD_GPP_AL_LILY', 1);
            INSERT INTO GreatPersonClasses
                (GreatPersonClassType, Name, UnitType, DistrictType, PseudoYieldType, IconString, ActionIcon, GenerateDuplicateIndividuals, AvailableInTimeline) VALUES
                ('GREAT_PERSON_CLASS_AL_LILY', 'LOC_GREAT_PERSON_CLASS_AL_LILY_NAME', 'UNIT_AL_LILY', 'DISTRICT_CITY_CENTER', 'PSEUDOYIELD_GPP_AL_LILY', '[ICON_GreatLily]', 'ICON_UNIT_AL_FUMI_GREATNORMAL', 0, 1);
        --GreatPersonIndividuals
            INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType,Name,GreatPersonClassType,EraType,Gender,ActionCharges,ActionNameTextOverride)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'LOC_GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName||'_NAME','GREAT_PERSON_CLASS_AL_LILY',Era,'M',0,'LOC_LILY_ACTION_'||UnitName
            FROM AL_GreatPerson
            WHERE ActionType = 'GreatWork';
            INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType,Name,GreatPersonClassType,EraType,Gender,ActionCharges,ActionNameTextOverride,ActionRequiresOwnedTile,ActionEffectTileHighlighting,AreaHighlightRadius,ActionRequiresLandMilitaryUnitWithinXTiles)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'LOC_GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName||'_NAME','GREAT_PERSON_CLASS_AL_LILY',Era,'M',1,'LOC_LILY_ACTION_'||UnitName,0,0,2,2
            FROM AL_GreatPerson
            WHERE ActionType = 'Ability';
            INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType,Name,GreatPersonClassType,EraType,Gender,ActionCharges,ActionNameTextOverride,ActionRequiresOwnedTile,ActionEffectTileHighlighting,AreaHighlightRadius,ActionRequiresEnemyMilitaryUnitWithinXTiles)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'LOC_GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName||'_NAME','GREAT_PERSON_CLASS_AL_LILY',Era,'M',1,'LOC_LILY_ACTION_'||UnitName,0,0,2,2
            FROM AL_GreatPerson
            WHERE ActionType = 'Boom';
            INSERT INTO GreatPersonIndividuals (GreatPersonIndividualType,Name,GreatPersonClassType,EraType,Gender,ActionCharges,ActionNameTextOverride,ActionRequiresCompletedDistrictType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'LOC_GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName||'_NAME','GREAT_PERSON_CLASS_AL_LILY',Era,'M',1,'LOC_LILY_ACTION_'||UnitName,DistrictType
            FROM AL_GreatPerson
            WHERE ActionType = 'District';
        --GreatPersonIndividualIconModifiers
            INSERT INTO GreatPersonIndividualIconModifiers (GreatPersonIndividualType, OverrideUnitIcon)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'ICON_UNIT_AL_'||UnitName||'_GREATNORMAL'
            FROM AL_GreatPerson;
        --GreatPersonIndividualActionModifiers
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_PLAYER'
            FROM AL_GreatPerson
            WHERE ActionType = 'GreatWork';
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_UNIT_GREATPERSON'
            FROM AL_GreatPerson
            WHERE ActionType = 'Ability';
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_UNIT_GREATPERSON'
            FROM AL_GreatPerson
            WHERE ActionType = 'Boom';
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
            FROM AL_GreatPerson
            WHERE ActionType = 'District';
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_2','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_UNIT_GREATPERSON'
            FROM AL_GreatPerson
            WHERE ModNum = 2 AND ActionType = 'Boom';
            INSERT INTO GreatPersonIndividualActionModifiers (GreatPersonIndividualType, ModifierId, AttachmentTargetType)
            SELECT 'GREAT_PERSON_INDIVIDUAL_AL_LILY_'||UnitName,'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_2','GREAT_PERSON_ACTION_ATTACHMENT_TARGET_DISTRICT_IN_TILE'
            FROM AL_GreatPerson
            WHERE ModNum = 2 AND ActionType = 'District';
        --Modifiers
            INSERT INTO Modifiers (ModifierId, ModifierType)
            SELECT 'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','MODIFIER_PLAYER_ADJUST_GOVERNOR_POINTS'
            FROM AL_GreatPerson
            WHERE ActionType = 'GreatWork';
            INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent)
            SELECT 'MOD_AL_GP_RIRI_ACTION_CHARISMA_'||UnitName, 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 'REQSET_AL_LEADER_IS_'||UnitName, 0, 1
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO ModifierArguments (ModifierId, Name, Value)
            SELECT 'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','Delta',1
            FROM AL_GreatPerson
            WHERE ActionType = 'GreatWork';
            INSERT INTO ModifierArguments (ModifierId, Name, Value)
            SELECT 'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','Amount',1
            FROM AL_GreatPerson
            WHERE ActionType = 'GreatWork';
            INSERT INTO ModifierArguments (ModifierId, Name, Value)
            SELECT 'MOD_AL_GP_RIRI_ACTION_CHARISMA_'||UnitName, 'InitialValue', 10
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO ModifierArguments (ModifierId, Name, Value)
            SELECT 'MOD_AL_GP_RIRI_ACTION_CHARISMA_'||UnitName, 'StatementKey', 'LOC_DIPLO_KUDO_LEADER_AL_GP_CHARISMA_RIRI_WELCOME_REASON_ANY'
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO ModifierArguments (ModifierId, Name, Value)
            SELECT 'MOD_AL_GP_RIRI_ACTION_CHARISMA_'||UnitName, 'SimpleModifierDescription', 'LOC_DIPLO_MODIFIER_DESCRIPTION_AL_GP_CHARISMA_RIRI_WELCOME'
            FROM AL_GreatPerson
            WHERE Leader = 1;
        --ModifierStrings
            INSERT INTO ModifierStrings (ModifierId, Context, Text)
            SELECT 'MOD_AL_GP_'||UnitName||'_ACTION_BUFF_1','Summary','LOC_MOD_AL_GP_'||UnitName||'_ACTION_BUFF_SUMMARY'
            FROM AL_GreatPerson;
            INSERT INTO ModifierStrings (ModifierId, Context, Text)
            SELECT 'MOD_AL_GP_RIRI_ACTION_CHARISMA_'||UnitName, 'Sample', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'
            FROM AL_GreatPerson
            WHERE Leader = 1;
        --RequirementSets
            INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
            SELECT 'REQSET_AL_LEADER_IS_'||UnitName, 'REQUIREMENTSET_TEST_ALL'
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
            SELECT 'REQSET_AL_LEADER_IS_'||UnitName, 'REQ_AL_LEADER_IS_'||UnitName
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO Requirements (RequirementId, RequirementType)
            SELECT 'REQ_AL_LEADER_IS_'||UnitName, 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'
            FROM AL_GreatPerson
            WHERE Leader = 1;
            INSERT INTO RequirementArguments (RequirementId, Name, Value)
            SELECT 'REQ_AL_LEADER_IS_'||UnitName, 'LeaderType', 'LEADER_AL_'||UnitName
            FROM AL_GreatPerson
            WHERE Leader = 1;
--MODIFIERS
    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent) VALUES
            --
            --FUJINO
                ('MOD_AL_GP_FUJINO_ACTION_BUFF_1', 'MODIFIER_PLAYER_UNITS_ADJUST_GRANT_EXPERIENCE', 'REQSET_UNIT_IS_LILY_GREAT',  1, 1),
            --HARUNA
                ('MOD_AL_GP_HARUNA_ACTION_BUFF_1', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_HOUSING_FROM_GREAT_PEOPLE', NULL,  1, 1),
                ('MOD_AL_GP_HARUNA_ACTION_BUFF_2', 'MODIFIER_PLAYER_ADJUST_FREE_GREAT_PERSON_POINTS', NULL, 1, 1),
        ---------------------------------------------------------------------------------------------------------------------------------------
            --KUREHA
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_1', 'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE', NULL,  1, 1),
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_2', 'MODIFIER_SINGLE_CITY_ADJUST_EXTRA_GREAT_WORK_SLOTS', NULL, 1, 1),
            --HIMEKA
                ('MOD_AL_GP_HIMEKA_ACTION_BUFF_1', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'REQSET_AL_DISTRICT_IS_STAGE', 0, 1),
                ('MOD_AL_GP_HIMEKA_ACTION_BUFF_2', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_TOURISM_CHANGE', 'REQSET_AL_DISTRICT_IS_STAGE', 1, 0),
            --miliam
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_1', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', NULL, 0, 1),
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_2', 'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_GOODY_HUT', NULL, 1, 0),
            --AKARI
                ('MOD_AL_GP_AKARI_ACTION_BUFF_1', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS', NULL, 1, 1),
                ('MOD_AL_GP_AKARI_ACTION_BUFF_2', 'MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER', NULL, 1, 1),
            --mai
                ('MOD_AL_GP_MAI_ACTION_BUFF_1', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'AOE_LAND_REQUIREMENTS', 0, 0),
                ('MOD_LILY_GREATS_MAI_ACTION_BUFF', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
            --fumi
                ('MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_SIGHT', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),
                ('MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_ATK_DISTRICT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'OPPONENT_IS_DISTRICT_REQUIREMENTS', 0, 0),
                ('MOD_AL_GP_FUMI_ACTION_BUFF_1', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'AOE_LAND_REQUIREMENTS', 1, 1),
            --yuyu
                ('MOD_AL_GP_YUYU_ACTION_BUFF_1', 'MODIFIER_WORLD_UNITS_ADJUST_DAMAGE', 'AOE_ENEMY_REQUIREMENTS', 1, 1),
                ('MOD_AL_GP_YUYU_ACTION_BUFF_2', 'MODIFIER_PLAYER_UNITS_ADJUST_DAMAGE', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 1, 1),
            --kaede
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_1', 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY', NULL, 1, 1),
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_2', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_PER_DESTINATION_LUXURY_FOR_INTERNATIONAL', NULL, 0, 1),
            --riri
                ('MOD_AL_GP_RIRI_ACTION_BUFF_1', 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY', NULL, 1, 1),
            --tadusa
                ('MOD_AL_GP_TADUSA_ACTION_BUFF_1', 'MODIFIER_WORLD_UNITS_ADJUST_DAMAGE', 'AOE_ENEMY_REQUIREMENTS', 1, 1),
                ('MOD_AL_GP_TADUSA_ACTION_BUFF_2', 'MODIFIER_PLAYER_UNITS_ADJUST_DAMAGE', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 1, 1),
            --OTHER
                ('MOD_AL_YURI_DIED_1', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', NULL, 0, 1),
                ('MOD_AL_YURI_DIED_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_UNIT_IS_RADGRID', 0, 1),
                ('BUFF_AL_YURI_DIED_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_RADGRID', 0, 1);
    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
            --FUJINO
                ('MOD_AL_GP_FUJINO_ACTION_BUFF_1', 'Amount', -1),
            --HARUNA
                ('MOD_AL_GP_HARUNA_ACTION_BUFF_1', 'Amount', 4),
                ('MOD_AL_GP_HARUNA_ACTION_BUFF_2', 'Amount', 100),
        ---------------------------------------------------------------------------------------------------------------------------------------
            --KUREHA
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_1', 'BuildingType', 'BUILDING_AL_PROMISE'),
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_2', 'Amount', 4),
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_2', 'BuildingType', 'BUILDING_AL_PROMISE'),
                ('MOD_AL_GP_KUREHA_ACTION_BUFF_2', 'GreatWorkSlotType', 'GREATWORKSLOT_PALACE'),
            --akari
                ('MOD_AL_GP_AKARI_ACTION_BUFF_1', 'YieldTypeToMirror', 'YIELD_CULTURE'),
                ('MOD_AL_GP_AKARI_ACTION_BUFF_1', 'YieldTypeToGrant', 'YIELD_SCIENCE'),
                ('MOD_AL_GP_AKARI_ACTION_BUFF_2', 'DistrictType', 'DISTRICT_AL_STAGE'),
            --himeka
                ('MOD_AL_GP_HIMEKA_ACTION_BUFF_1', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_AL_GP_HIMEKA_ACTION_BUFF_1', 'Amount', 4),
                ('MOD_AL_GP_HIMEKA_ACTION_BUFF_2', 'Amount', 10),
        
            --yuri
                ('MOD_AL_YURI_DIED_1', 'BuildingType', 'BUILDING_AL_SAKURA'),
                ('MOD_AL_YURI_DIED_1', 'YieldType', 'YIELD_FAITH'),
                ('MOD_AL_YURI_DIED_1', 'Amount', 4),
                ('MOD_AL_YURI_DIED_2', 'ModifierId', 'BUFF_AL_YURI_DIED_2'),
                ('BUFF_AL_YURI_DIED_2', 'Amount', 10),
            --miliam
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_1', 'BuildingType', 'BUILDING_AL_ARSENAL'),
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_1', 'YieldType', 'YIELD_PRODUCTION'),
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_1', 'Amount', 4),
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_2', 'Source', 'CAPTURED_CITY'),
                ('MOD_AL_GP_MILIAM_ACTION_BUFF_2', 'Amount', 2),
            --mai
                ('MOD_AL_GP_MAI_ACTION_BUFF_1','AbilityType', 'ABILITY_LILY_GREATS_MAI_ACTION_BUFF'),
                ('MOD_LILY_GREATS_MAI_ACTION_BUFF', 'Amount', 1),
            --fumi
                ('MOD_AL_GP_FUMI_ACTION_BUFF_1', 'AbilityType', 'ABILITY_LILY_GREATS_FUMI_ACTION_BUFF'),
                ('MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_SIGHT', 'Amount', 3),
                ('MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_ATK_DISTRICT', 'Amount', 5),
            --yuyu
                ('MOD_AL_GP_YUYU_ACTION_BUFF_1', 'Amount', 75),
                ('MOD_AL_GP_YUYU_ACTION_BUFF_2', 'Amount', 30),
            --kaede
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_1', 'ResourceType', 'RESOURCE_AL_DOLL'),
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_1', 'Amount', 2),
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_2', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_AL_GP_KAEDE_ACTION_BUFF_2', 'Amount', 2),
            --riri
                ('MOD_AL_GP_RIRI_ACTION_BUFF_1', 'ResourceType', 'RESOURCE_AL_RAMUNE'),
                ('MOD_AL_GP_RIRI_ACTION_BUFF_1', 'Amount', 2),
            --tadusa
                ('MOD_AL_GP_TADUSA_ACTION_BUFF_1', 'Amount', 40),
                ('MOD_AL_GP_TADUSA_ACTION_BUFF_2', 'Amount', -50);
            UPDATE ModifierArguments SET Type = 'ScaleByGameSpeed' WHERE ModifierId = 'MOD_AL_GP_HARUNA_ACTION_BUFF_2';
    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
            ('BUFF_AL_YURI_DIED_2', 'Preview', '+{1_Amount} {LOC_MOD_YURI_DIED}'),
            ('MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_ATK_DISTRICT', 'Preview', 'LOC_MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_ATK_DISTRICT');
    
--ABILITIES
    INSERT INTO TypeTags
        (Type, Tag) VALUES
        ('ABILITY_LILY_GREATS_MAI_ACTION_BUFF', 'CLASS_ALL_COMBAT_UNITS'),
        ('ABILITY_LILY_GREATS_FUMI_ACTION_BUFF', 'CLASS_ALL_COMBAT_UNITS');
    INSERT INTO UnitAbilities
        (UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
        ('ABILITY_LILY_GREATS_MAI_ACTION_BUFF', 'LOC_ABILITY_LILY_GREATS_MAI_ACTION_BUFF_NAME', 'LOC_ABILITY_LILY_GREATS_MAI_ACTION_BUFF_DESCRIPTION', 1, 0),
        ('ABILITY_LILY_GREATS_FUMI_ACTION_BUFF', 'LOC_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_NAME', 'LOC_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_DESCRIPTION', 1, 0);
    INSERT INTO UnitAbilityModifiers
        (UnitAbilityType, ModifierId) VALUES
        --mai
            ('ABILITY_LILY_GREATS_MAI_ACTION_BUFF', 'MOD_LILY_GREATS_MAI_ACTION_BUFF'),
        --fumi
            ('ABILITY_LILY_GREATS_FUMI_ACTION_BUFF', 'MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_SIGHT'),
            ('ABILITY_LILY_GREATS_FUMI_ACTION_BUFF', 'MOD_ABILITY_LILY_GREATS_FUMI_ACTION_BUFF_ATK_DISTRICT');
    INSERT INTO UnitAiInfos
        (UnitType, AiType) VALUES
        ('UNIT_AL_LILY', 'UNITTYPE_MELEE');
    INSERT INTO Units_XP2
        (UnitType, CanFormMilitaryFormation, CanEarnExperience) VALUES
        ('UNIT_AL_LILY', 0,0),
        ('UNIT_AL_NEKO', 0,0);
    INSERT INTO Units
        (UnitType, BaseMoves, Cost, AdvisorType, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name, Description, PromotionClass, Combat, RangedCombat, Range, CanCapture, CanTrain, CanRetreatWhenCaptured) VALUES 
        ('UNIT_AL_LILY', 4, 1, 'ADVISOR_CONQUEST', 3, 1, 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', 'LOC_UNIT_AL_LILY_NAME', 'LOC_UNIT_AL_LILY_DESCRIPTION', 'PROMOTION_CLASS_RECON', 30, 30, 1, 0, 0, 1);
    INSERT INTO DiplomaticVisibilitySources
        (VisibilitySourceType, Description, ActionDescription, GossipString,PrereqTech) VALUES
        ('SOURCE_HAWKEYE', 'LOC_VIZSOURCE_HAWKEYE', 'LOC_VIZSOURCE_ACTION_HAWKEYE', 'LOC_GOSSIP_SOURCE_HAWKEYE','TECH_PRINTING');
