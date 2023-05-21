-- loop projects
    INSERT INTO GameModifiers
    (ModifierId) VALUES
    ('MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI_TRIGGER');

    INSERT INTO TraitModifiers
    (TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_AL_KANBA_COLLECTION', 'MOD_AL_UNLOCK_PROJECT_AL_COLLECTION'),
    ('TRAIT_CIVILIZATION_AL_ANGEL_PROMISE', 'MOD_AL_UNLOCK_PROJECT_AL_ANGEL');

    INSERT INTO Modifiers
    (ModifierId, ModifierType) VALUES
    ('MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA'),
    ('MOD_AL_UNLOCK_PROJECT_AL_ANGEL', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA'),
    ('MOD_AL_UNLOCK_PROJECT_AL_COLLECTION', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA'),
    ('MOD_AL_UNLOCK_PROJECT_AL_MOYU_RANDOM', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA');

    INSERT INTO ModifierArguments
    (ModifierId, Name, Value) VALUES
    ('MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI', 'ProjectType', 'PROJECT_AL_HITOTSUYANAGI'),
    ('MOD_AL_UNLOCK_PROJECT_AL_ANGEL', 'ProjectType', 'PROJECT_AL_ANGEL'),
    ('MOD_AL_UNLOCK_PROJECT_AL_COLLECTION', 'ProjectType', 'PROJECT_AL_COLLECTION'),
    ('MOD_AL_UNLOCK_PROJECT_AL_MOYU_RANDOM', 'ProjectType', 'PROJECT_AL_MOYU_RANDOM');

    INSERT INTO Types
    (Type, Kind) VALUES
    ('PROJECT_AL_HITOTSUYANAGI', 'KIND_PROJECT'),
    ('PROJECT_AL_ANGEL', 'KIND_PROJECT'),
    ('PROJECT_AL_COLLECTION', 'KIND_PROJECT'),
    ('PROJECT_AL_NEUNWELT_HUGE', 'KIND_PROJECT'),
    ('PROJECT_AL_MOYU_RANDOM', 'KIND_PROJECT'),
    ('PROJECT_AL_TADUSA_NEKO', 'KIND_PROJECT');

    INSERT INTO Projects
    (ProjectType, Name, ShortName, Description, Cost, CostProgressionModel, CostProgressionParam1, UnlocksFromEffect, RequiredBuilding, PrereqDistrict) VALUES
    ('PROJECT_AL_HITOTSUYANAGI', 'LOC_PROJECT_AL_HITOTSUYANAGI_NAME', 'LOC_PROJECT_AL_HITOTSUYANAGI_NAME', 'LOC_PROJECT_AL_HITOTSUYANAGI_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 1, NULL, 'DISTRICT_AL_GARDEN'),
    ('PROJECT_AL_ANGEL', 'LOC_PROJECT_AL_ANGEL_NAME', 'LOC_PROJECT_AL_ANGEL_SHORT_NAME', 'LOC_PROJECT_AL_ANGEL_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 1, 'BUILDING_AL_PROMISE', 'DISTRICT_AL_GARDEN'),
    ('PROJECT_AL_COLLECTION', 'LOC_PROJECT_AL_COLLECTION_NAME', 'LOC_PROJECT_AL_COLLECTION_NAME', 'LOC_PROJECT_AL_COLLECTION_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 1, NULL, 'DISTRICT_AL_GARDEN'),
    ('PROJECT_AL_NEUNWELT_HUGE', 'LOC_PROJECT_AL_NEUNWELT_HUGE_NAME', 'LOC_PROJECT_AL_NEUNWELT_HUGE_NAME', 'LOC_PROJECT_AL_NEUNWELT_HUGE_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 0, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN'),
    ('PROJECT_AL_MOYU_RANDOM', 'LOC_PROJECT_AL_MOYU_RANDOM_NAME', 'LOC_PROJECT_AL_MOYU_RANDOM_NAME', 'LOC_PROJECT_AL_MOYU_RANDOM_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 1, NULL, 'DISTRICT_AL_MOYU'),
    ('PROJECT_AL_TADUSA_NEKO', 'LOC_PROJECT_AL_TADUSA_NEKO_NAME', 'LOC_PROJECT_AL_TADUSA_NEKO_NAME', 'LOC_PROJECT_AL_TADUSA_NEKO_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 750, 1, NULL, NULL);

    INSERT INTO Projects_XP2
    (ProjectType, MaxSimultaneousInstances) VALUES
    ('PROJECT_AL_MOYU_RANDOM', 1),
    ('PROJECT_AL_TADUSA_NEKO', 1);


    INSERT INTO Project_YieldConversions
    (ProjectType, YieldType, PercentOfProductionRate) VALUES
    ('PROJECT_AL_HITOTSUYANAGI', 'YIELD_CULTURE', 25),
    ('PROJECT_AL_ANGEL', 'YIELD_FAITH', 50),
    ('PROJECT_AL_COLLECTION', 'YIELD_CULTURE', 50),
    ('PROJECT_AL_MOYU_RANDOM', 'YIELD_SCIENCE', 100),
    ('PROJECT_AL_TADUSA_NEKO', 'YIELD_FAITH', 100);

    INSERT INTO Project_GreatPersonPoints
    (ProjectType, GreatPersonClassType, Points, PointProgressionModel, PointProgressionParam1) VALUES
    ('PROJECT_AL_HITOTSUYANAGI', 'GREAT_PERSON_CLASS_AL_LILY', 10, 'COST_PROGRESSION_GAME_PROGRESS', 800),
    ('PROJECT_AL_COLLECTION', 'GREAT_PERSON_CLASS_AL_LILY', 10, 'COST_PROGRESSION_GAME_PROGRESS', 800),
    ('PROJECT_AL_ANGEL', 'GREAT_PERSON_CLASS_AL_LILY', 10, 'COST_PROGRESSION_GAME_PROGRESS', 800);

    INSERT INTO Project_ResourceCosts
    (ProjectType, ResourceType, StartProductionCost) VALUES
    ('PROJECT_AL_HITOTSUYANAGI', 'RESOURCE_AL_MAGI', 15),
    ('PROJECT_AL_ANGEL', 'RESOURCE_AL_MAGI', 15),
    ('PROJECT_AL_COLLECTION', 'RESOURCE_AL_MAGI', 15),
    ('PROJECT_AL_MOYU_RANDOM', 'RESOURCE_AL_MAGI', 15),
    ('PROJECT_AL_TADUSA_NEKO', 'RESOURCE_AL_MAGI', 15),
    ('PROJECT_AL_NEUNWELT_HUGE', 'RESOURCE_AL_MAGI', 30);

    INSERT INTO ProjectCompletionModifiers
    (ProjectType, ModifierId) VALUES
    ('PROJECT_AL_ANGEL', 'MOD_AL_PROJECT_AL_ANGEL_FOOD'),
    ('PROJECT_AL_NEUNWELT_HUGE', 'MOD_PROJECT_AL_NEUNWELT_HUGE_GET');

    INSERT INTO Modifiers
    (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent) VALUES
    ('MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI_TRIGGER','MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_IS_RIRI_CAPITAL',0,0),
    ('MOD_AL_PROJECT_AL_ANGEL_FOOD', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'REQSET_AL_ANGEL_PLOT_HAS_ONSEN', 1, 1),
    ('MOD_PROJECT_AL_NEUNWELT_HUGE_GET', 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY', NULL, 0, 0);

    INSERT INTO ModifierArguments
    (ModifierId, Name, Value) VALUES
    ('MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI_TRIGGER', 'ModifierId', 'MOD_AL_UNLOCK_PROJECT_AL_HITOTSUYANAGI'),
    ('MOD_AL_PROJECT_AL_ANGEL_FOOD', 'YieldType', 'YIELD_FOOD'),
    ('MOD_AL_PROJECT_AL_ANGEL_FOOD', 'Amount', 1),
    ('MOD_PROJECT_AL_NEUNWELT_HUGE_GET', 'Amount', 1),
    ('MOD_PROJECT_AL_NEUNWELT_HUGE_GET', 'ResourceType', 'RESOURCE_AL_NEUNWELT');

    INSERT INTO RequirementSets
    (RequirementSetId, RequirementSetType) VALUES
    ('REQSET_CITY_IS_RIRI_CAPITAL', 'REQUIREMENTSET_TEST_ANY'),
    ('REQSET_AL_ANGEL_PLOT_HAS_ONSEN', 'REQUIREMENTSET_TEST_ANY');

    INSERT INTO RequirementSetRequirements
    (RequirementSetId, RequirementId) VALUES
    ('REQSET_CITY_IS_RIRI_CAPITAL', 'REQ_CITY_IS_RIRI_CAPITAL'),
    ('REQSET_AL_ANGEL_PLOT_HAS_ONSEN', 'REQ_AL_ANGEL_PLOT_HAS_ONSEN'),
    ('REQSET_AL_ANGEL_PLOT_HAS_ONSEN', 'REQ_AL_ANGEL_PLOT_HAS_QUAN'),
    ('REQSET_AL_ANGEL_PLOT_HAS_ONSEN', 'REQ_AL_ANGEL_PLOT_HAS_ONSEN_SEA');

    INSERT INTO Requirements
    (RequirementId, RequirementType) VALUES
    ('REQ_CITY_IS_RIRI_CAPITAL', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('REQ_AL_ANGEL_PLOT_HAS_ONSEN', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES'),
    ('REQ_AL_ANGEL_PLOT_HAS_ONSEN_SEA', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES'),
    ('REQ_AL_ANGEL_PLOT_HAS_QUAN', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES');

    INSERT INTO RequirementArguments
    (RequirementId, Name, Value) VALUES
    ('REQ_CITY_IS_RIRI_CAPITAL', 'PropertyName', 'RIRI_CAPITAL'),
    ('REQ_CITY_IS_RIRI_CAPITAL', 'PropertyMinimum', 1),

    ('REQ_AL_ANGEL_PLOT_HAS_QUAN', 'ImprovementType', 'IMPROVEMENT_AL_QUAN'),
    ('REQ_AL_ANGEL_PLOT_HAS_ONSEN', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN'),
    ('REQ_AL_ANGEL_PLOT_HAS_ONSEN_SEA', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN_SEA');

-- once projects
    INSERT INTO Types
        (Type, Kind) VALUES
        --训练设施
            ('PROJECT_AL_TRANNING_EXP_1', 'KIND_PROJECT'),
            ('PROJECT_AL_TRANNING_EXP_2', 'KIND_PROJECT'),
            ('PROJECT_AL_TRANNING_EXP_3', 'KIND_PROJECT'),
            ('PROJECT_AL_TRANNING_ABL_1', 'KIND_PROJECT'),
            ('PROJECT_AL_TRANNING_ABL_2', 'KIND_PROJECT'),
            ('PROJECT_AL_TRANNING_ABL_3', 'KIND_PROJECT'),
        --工厂科
            ('PROJECT_AL_ARSENAL_1', 'KIND_PROJECT'),
            ('PROJECT_AL_ARSENAL_2', 'KIND_PROJECT'),
            ('PROJECT_AL_ARSENAL_3', 'KIND_PROJECT'),
            ('PROJECT_AL_ARSENAL_4', 'KIND_PROJECT'),
            ('PROJECT_AL_ARSENAL_5', 'KIND_PROJECT'),
            ('PROJECT_AL_ARSENAL_6', 'KIND_PROJECT'),
        --工厂科能力
            ('ABL_PROJECT_AL_ARSENAL_1', 'KIND_ABILITY'),
            ('ABL_PROJECT_AL_ARSENAL_2', 'KIND_ABILITY'),
            ('ABL_PROJECT_AL_ARSENAL_3', 'KIND_ABILITY'),
            ('ABL_PROJECT_AL_ARSENAL_4', 'KIND_ABILITY'),
            ('ABL_PROJECT_AL_ARSENAL_5', 'KIND_ABILITY'),
            ('ABL_PROJECT_AL_ARSENAL_6', 'KIND_ABILITY'),
        --契约礼堂
            ('PROJECT_AL_PROMISE_1', 'KIND_PROJECT'),
            ('PROJECT_AL_PROMISE_2', 'KIND_PROJECT'),
            ('PROJECT_AL_PROMISE_3', 'KIND_PROJECT'),
        --往世祭所
            ('PROJECT_AL_OHAKA_1', 'KIND_PROJECT'),
            ('PROJECT_AL_OHAKA_2', 'KIND_PROJECT'),
            ('PROJECT_AL_OHAKA_3', 'KIND_PROJECT'),
            ('PROJECT_AL_OHAKA_4', 'KIND_PROJECT'),
            ('PROJECT_AL_OHAKA_5', 'KIND_PROJECT'),
            ('PROJECT_AL_OHAKA_6', 'KIND_PROJECT'),
            
            ('PROJECT_AL_AREA_DEFFENSE_1', 'KIND_PROJECT'),
            ('PROJECT_AL_AREA_DEFFENSE_2', 'KIND_PROJECT'),
            ('PROJECT_AL_AREA_DEFFENSE_3', 'KIND_PROJECT'),
            ('PROJECT_AL_AREA_DEFFENSE_4', 'KIND_PROJECT'),
            
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'KIND_PROJECT'),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'KIND_PROJECT'),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'KIND_PROJECT'),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'KIND_PROJECT'),
            
            ('PROJECT_AL_SEITOKAI_1', 'KIND_PROJECT'),
            ('PROJECT_AL_SEITOKAI_2', 'KIND_PROJECT'),
            ('PROJECT_AL_SEITOKAI_3', 'KIND_PROJECT'),
            ('PROJECT_AL_SEITOKAI_4', 'KIND_PROJECT'),
            
            ('PROJECT_AL_FUUKI_1', 'KIND_PROJECT'),
            ('PROJECT_AL_FUUKI_2', 'KIND_PROJECT'),
            ('PROJECT_AL_FUUKI_3', 'KIND_PROJECT'),
            ('PROJECT_AL_FUUKI_4', 'KIND_PROJECT');



    INSERT INTO Project_ResourceCosts
        (ProjectType, ResourceType, StartProductionCost) VALUES
            ('PROJECT_AL_TRANNING_EXP_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_TRANNING_EXP_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_TRANNING_EXP_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_TRANNING_ABL_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_TRANNING_ABL_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_TRANNING_ABL_3', 'RESOURCE_AL_MAGI', 30),
        --工厂科
            ('PROJECT_AL_ARSENAL_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_ARSENAL_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_ARSENAL_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_ARSENAL_4', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_ARSENAL_5', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_ARSENAL_6', 'RESOURCE_AL_MAGI', 30),
        --契约礼堂
            ('PROJECT_AL_PROMISE_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_PROMISE_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_PROMISE_3', 'RESOURCE_AL_MAGI', 30),
        --往世祭所
            ('PROJECT_AL_OHAKA_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_OHAKA_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_OHAKA_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_OHAKA_4', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_OHAKA_5', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_OHAKA_6', 'RESOURCE_AL_MAGI', 30),
            
            ('PROJECT_AL_AREA_DEFFENSE_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_AREA_DEFFENSE_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_AREA_DEFFENSE_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_AREA_DEFFENSE_4', 'RESOURCE_AL_MAGI', 30),
            
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'RESOURCE_AL_MAGI', 30),
            
            ('PROJECT_AL_SEITOKAI_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_SEITOKAI_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_SEITOKAI_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_SEITOKAI_4', 'RESOURCE_AL_MAGI', 30),
            
            ('PROJECT_AL_FUUKI_1', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_FUUKI_2', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_FUUKI_3', 'RESOURCE_AL_MAGI', 30),
            ('PROJECT_AL_FUUKI_4', 'RESOURCE_AL_MAGI', 30);

    INSERT INTO ProjectPrereqs
        (ProjectType, PrereqProjectType, MinimumPlayerInstances) VALUES
            ('PROJECT_AL_TRANNING_EXP_2', 'PROJECT_AL_TRANNING_EXP_1', 1),
            ('PROJECT_AL_TRANNING_EXP_3', 'PROJECT_AL_TRANNING_EXP_2', 1),

            ('PROJECT_AL_TRANNING_ABL_2', 'PROJECT_AL_TRANNING_ABL_1', 1),
            ('PROJECT_AL_TRANNING_ABL_3', 'PROJECT_AL_TRANNING_ABL_2', 1),

            ('PROJECT_AL_ARSENAL_2', 'PROJECT_AL_ARSENAL_1', 1),
            ('PROJECT_AL_ARSENAL_3', 'PROJECT_AL_ARSENAL_2', 1),
            ('PROJECT_AL_ARSENAL_4', 'PROJECT_AL_ARSENAL_3', 1),
            ('PROJECT_AL_ARSENAL_5', 'PROJECT_AL_ARSENAL_4', 1),
            ('PROJECT_AL_ARSENAL_6', 'PROJECT_AL_ARSENAL_5', 1),

            ('PROJECT_AL_PROMISE_2', 'PROJECT_AL_PROMISE_1', 1),
            ('PROJECT_AL_PROMISE_3', 'PROJECT_AL_PROMISE_2', 1),

            ('PROJECT_AL_OHAKA_2', 'PROJECT_AL_OHAKA_1', 1),
            ('PROJECT_AL_OHAKA_3', 'PROJECT_AL_OHAKA_2', 1),

            ('PROJECT_AL_OHAKA_5', 'PROJECT_AL_OHAKA_4', 1),
            ('PROJECT_AL_OHAKA_6', 'PROJECT_AL_OHAKA_5', 1),
            
            ('PROJECT_AL_AREA_DEFFENSE_2', 'PROJECT_AL_AREA_DEFFENSE_1', 1),
            ('PROJECT_AL_AREA_DEFFENSE_3', 'PROJECT_AL_AREA_DEFFENSE_2', 1),
            ('PROJECT_AL_AREA_DEFFENSE_4', 'PROJECT_AL_AREA_DEFFENSE_3', 1),
            
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'PROJECT_AL_KOUNAI_ONSEN_1', 1),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'PROJECT_AL_KOUNAI_ONSEN_2', 1),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'PROJECT_AL_KOUNAI_ONSEN_3', 1),
            
            ('PROJECT_AL_SEITOKAI_2', 'PROJECT_AL_SEITOKAI_1', 1),
            ('PROJECT_AL_SEITOKAI_3', 'PROJECT_AL_SEITOKAI_2', 1),
            ('PROJECT_AL_SEITOKAI_4', 'PROJECT_AL_SEITOKAI_3', 1),
            
            ('PROJECT_AL_FUUKI_2', 'PROJECT_AL_FUUKI_1', 1),
            ('PROJECT_AL_FUUKI_3', 'PROJECT_AL_FUUKI_2', 1),
            ('PROJECT_AL_FUUKI_4', 'PROJECT_AL_FUUKI_3', 1);

    INSERT INTO TypeTags
        (Type, Tag) VALUES
            ('ABL_PROJECT_AL_ARSENAL_1', 'CLASS_AL_LILY'),
            ('ABL_PROJECT_AL_ARSENAL_2', 'CLASS_AL_LILY'),
            ('ABL_PROJECT_AL_ARSENAL_3', 'CLASS_AL_LILY'),
            ('ABL_PROJECT_AL_ARSENAL_4', 'CLASS_AL_LILY'),
            ('ABL_PROJECT_AL_ARSENAL_5', 'CLASS_AL_LILY'),
            ('ABL_PROJECT_AL_ARSENAL_6', 'CLASS_AL_LILY');

    INSERT INTO UnitAbilities
        (UnitAbilityType, Name, Description, Inactive) VALUES
            ('ABL_PROJECT_AL_ARSENAL_1', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_1', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_1', 1),
            ('ABL_PROJECT_AL_ARSENAL_2', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_2', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_2', 1),
            ('ABL_PROJECT_AL_ARSENAL_3', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_3', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_3', 1),
            ('ABL_PROJECT_AL_ARSENAL_4', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_4', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_4', 1),
            ('ABL_PROJECT_AL_ARSENAL_5', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_5', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_5', 1),
            ('ABL_PROJECT_AL_ARSENAL_6', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_6', 'LOC_NAME_ABL_PROJECT_AL_ARSENAL_6', 1);

    INSERT INTO UnitAbilityModifiers
        (UnitAbilityType, ModifierId) VALUES
            ('ABL_PROJECT_AL_ARSENAL_1', 'BUFF_PROJECT_AL_ARSENAL_1'),
            ('ABL_PROJECT_AL_ARSENAL_2', 'BUFF_PROJECT_AL_ARSENAL_2'),
            ('ABL_PROJECT_AL_ARSENAL_3', 'BUFF_PROJECT_AL_ARSENAL_3'),
            ('ABL_PROJECT_AL_ARSENAL_4', 'BUFF_PROJECT_AL_ARSENAL_4'),
            ('ABL_PROJECT_AL_ARSENAL_5', 'BUFF_PROJECT_AL_ARSENAL_5'),
            ('ABL_PROJECT_AL_ARSENAL_6', 'BUFF_PROJECT_AL_ARSENAL_6');

    INSERT INTO Projects
        (ProjectType, Name, ShortName, Description, PrereqTech, MaxPlayerInstances, Cost, RequiredBuilding, PrereqDistrict, PrereqCivic) VALUES
        --训练设施
            ('PROJECT_AL_TRANNING_EXP_1', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_1', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_1', 'LOC_DESC_PROJECT_AL_TRANNING_EXP_1', 'TECH_AL_RENAISSANCE', 1, 700, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_TRANNING_EXP_2', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_2', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_2', 'LOC_DESC_PROJECT_AL_TRANNING_EXP_2', 'TECH_AL_MODERN', 1, 1200, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_TRANNING_EXP_3', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_3', 'LOC_NAME_PROJECT_AL_TRANNING_EXP_3', 'LOC_DESC_PROJECT_AL_TRANNING_EXP_3', 'TECH_AL_INFORMATION', 1, 1800, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_TRANNING_ABL_1', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_1', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_1', 'LOC_DESC_PROJECT_AL_TRANNING_ABL_1', 'TECH_AL_INDUSTRIAL', 1, 900, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_TRANNING_ABL_2', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_2', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_2', 'LOC_DESC_PROJECT_AL_TRANNING_ABL_2', 'TECH_AL_ATOMIC', 1, 1600, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_TRANNING_ABL_3', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_3', 'LOC_NAME_PROJECT_AL_TRANNING_ABL_3', 'LOC_DESC_PROJECT_AL_TRANNING_ABL_3', 'TECH_AL_FUTURE', 1, 2400, 'BUILDING_AL_TRAINING', 'DISTRICT_AL_GARDEN', NULL),
        --工厂科
            ('PROJECT_AL_ARSENAL_1', 'LOC_NAME_PROJECT_AL_ARSENAL_1', 'LOC_NAME_PROJECT_AL_ARSENAL_1', 'LOC_DESC_PROJECT_AL_ARSENAL_1', 'TECH_AL_RENAISSANCE', 1, 700, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_ARSENAL_2', 'LOC_NAME_PROJECT_AL_ARSENAL_2', 'LOC_NAME_PROJECT_AL_ARSENAL_2', 'LOC_DESC_PROJECT_AL_ARSENAL_2', 'TECH_AL_INDUSTRIAL', 1, 900, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_ARSENAL_3', 'LOC_NAME_PROJECT_AL_ARSENAL_3', 'LOC_NAME_PROJECT_AL_ARSENAL_3', 'LOC_DESC_PROJECT_AL_ARSENAL_3', 'TECH_AL_MODERN', 1, 1200, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_ARSENAL_4', 'LOC_NAME_PROJECT_AL_ARSENAL_4', 'LOC_NAME_PROJECT_AL_ARSENAL_4', 'LOC_DESC_PROJECT_AL_ARSENAL_4', 'TECH_AL_ATOMIC', 1, 1600, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_ARSENAL_5', 'LOC_NAME_PROJECT_AL_ARSENAL_5', 'LOC_NAME_PROJECT_AL_ARSENAL_5', 'LOC_DESC_PROJECT_AL_ARSENAL_5', 'TECH_AL_INFORMATION', 1, 1800, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_ARSENAL_6', 'LOC_NAME_PROJECT_AL_ARSENAL_6', 'LOC_NAME_PROJECT_AL_ARSENAL_6', 'LOC_DESC_PROJECT_AL_ARSENAL_6', 'TECH_AL_FUTURE', 1, 2400, 'BUILDING_AL_ARSENAL', 'DISTRICT_AL_GARDEN', NULL),

        --契约礼堂
            ('PROJECT_AL_PROMISE_1', 'LOC_NAME_PROJECT_AL_PROMISE_1', 'LOC_NAME_PROJECT_AL_PROMISE_1', 'LOC_DESC_PROJECT_AL_PROMISE_1', NULL, 1, 900, 'BUILDING_AL_PROMISE', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INDUSTRIAL'),
            ('PROJECT_AL_PROMISE_2', 'LOC_NAME_PROJECT_AL_PROMISE_2', 'LOC_NAME_PROJECT_AL_PROMISE_2', 'LOC_DESC_PROJECT_AL_PROMISE_2', NULL, 1, 1600, 'BUILDING_AL_PROMISE', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_ATOMIC'),
            ('PROJECT_AL_PROMISE_3', 'LOC_NAME_PROJECT_AL_PROMISE_3', 'LOC_NAME_PROJECT_AL_PROMISE_3', 'LOC_DESC_PROJECT_AL_PROMISE_3', NULL, 1, 2400, 'BUILDING_AL_PROMISE', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INFORMATION'),
        
        --往世祭所
            ('PROJECT_AL_OHAKA_1', 'LOC_NAME_PROJECT_AL_OHAKA_1', 'LOC_NAME_PROJECT_AL_OHAKA_1', 'LOC_DESC_PROJECT_AL_OHAKA_1', NULL, 1, 700, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_MEDIEVAL'),
            ('PROJECT_AL_OHAKA_2', 'LOC_NAME_PROJECT_AL_OHAKA_2', 'LOC_NAME_PROJECT_AL_OHAKA_2', 'LOC_DESC_PROJECT_AL_OHAKA_2', NULL, 1, 900, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_FUTURE'),
            ('PROJECT_AL_OHAKA_3', 'LOC_NAME_PROJECT_AL_OHAKA_3', 'LOC_NAME_PROJECT_AL_OHAKA_3', 'LOC_DESC_PROJECT_AL_OHAKA_3', NULL, 1, 1600, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INDUSTRIAL'),
            ('PROJECT_AL_OHAKA_4', 'LOC_NAME_PROJECT_AL_OHAKA_4', 'LOC_NAME_PROJECT_AL_OHAKA_4', 'LOC_DESC_PROJECT_AL_OHAKA_4', NULL, 1, 1200, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_RENAISSANCE'),
            ('PROJECT_AL_OHAKA_5', 'LOC_NAME_PROJECT_AL_OHAKA_5', 'LOC_NAME_PROJECT_AL_OHAKA_5', 'LOC_DESC_PROJECT_AL_OHAKA_5', NULL, 1, 1800, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_MODERN'),
            ('PROJECT_AL_OHAKA_6', 'LOC_NAME_PROJECT_AL_OHAKA_6', 'LOC_NAME_PROJECT_AL_OHAKA_6', 'LOC_DESC_PROJECT_AL_OHAKA_6', NULL, 1, 2400, 'BUILDING_AL_OHAKA', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_ATOMIC'),
            
            ('PROJECT_AL_AREA_DEFFENSE_1', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_1', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_1', 'LOC_DESC_PROJECT_AL_AREA_DEFFENSE_1', 'TECH_AL_INDUSTRIAL', 1, 900, 'BUILDING_AL_AREA_DEFENSE', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_AREA_DEFFENSE_2', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_2', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_2', 'LOC_DESC_PROJECT_AL_AREA_DEFFENSE_2', 'TECH_AL_MODERN', 1, 1200, 'BUILDING_AL_AREA_DEFENSE', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_AREA_DEFFENSE_3', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_3', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_3', 'LOC_DESC_PROJECT_AL_AREA_DEFFENSE_3', 'TECH_AL_ATOMIC', 1, 1600, 'BUILDING_AL_AREA_DEFENSE', 'DISTRICT_AL_GARDEN', NULL),
            ('PROJECT_AL_AREA_DEFFENSE_4', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_4', 'LOC_NAME_PROJECT_AL_AREA_DEFFENSE_4', 'LOC_DESC_PROJECT_AL_AREA_DEFFENSE_4', 'TECH_AL_INFORMATION', 1, 1800, 'BUILDING_AL_AREA_DEFENSE', 'DISTRICT_AL_GARDEN', NULL),
            
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'LOC_NAME_AL_KOUNAI_ONSEN_1', 'LOC_NAME_AL_KOUNAI_ONSEN_1', 'LOC_DESC_AL_KOUNAI_ONSEN_1', NULL, 1, 700, 'BUILDING_AL_KOUNAI_ONSEN', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_MEDIEVAL'),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'LOC_NAME_AL_KOUNAI_ONSEN_2', 'LOC_NAME_AL_KOUNAI_ONSEN_2', 'LOC_DESC_AL_KOUNAI_ONSEN_2', NULL, 1, 900, 'BUILDING_AL_KOUNAI_ONSEN', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_FUTURE'),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'LOC_NAME_AL_KOUNAI_ONSEN_3', 'LOC_NAME_AL_KOUNAI_ONSEN_3', 'LOC_DESC_AL_KOUNAI_ONSEN_3', NULL, 1, 1200, 'BUILDING_AL_KOUNAI_ONSEN', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_RENAISSANCE'),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'LOC_NAME_AL_KOUNAI_ONSEN_4', 'LOC_NAME_AL_KOUNAI_ONSEN_4', 'LOC_DESC_AL_KOUNAI_ONSEN_4', NULL, 1, 1600, 'BUILDING_AL_KOUNAI_ONSEN', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INDUSTRIAL'),
            
            ('PROJECT_AL_SEITOKAI_1', 'LOC_NAME_AL_SEITOKAI_1', 'LOC_NAME_AL_SEITOKAI_1', 'LOC_DESC_AL_SEITOKAI_1', NULL, 1, 900, 'BUILDING_AL_SEITOKAI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_FUTURE'),
            ('PROJECT_AL_SEITOKAI_2', 'LOC_NAME_AL_SEITOKAI_2', 'LOC_NAME_AL_SEITOKAI_2', 'LOC_DESC_AL_SEITOKAI_2', NULL, 1, 1600, 'BUILDING_AL_SEITOKAI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INDUSTRIAL'),
            ('PROJECT_AL_SEITOKAI_3', 'LOC_NAME_AL_SEITOKAI_3', 'LOC_NAME_AL_SEITOKAI_3', 'LOC_DESC_AL_SEITOKAI_3', NULL, 1, 2000, 'BUILDING_AL_SEITOKAI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_ATOMIC'),
            ('PROJECT_AL_SEITOKAI_4', 'LOC_NAME_AL_SEITOKAI_4', 'LOC_NAME_AL_SEITOKAI_4', 'LOC_DESC_AL_SEITOKAI_4', NULL, 1, 2400, 'BUILDING_AL_SEITOKAI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INFORMATION'),
            
            ('PROJECT_AL_FUUKI_1', 'LOC_NAME_AL_FUUKI_1', 'LOC_NAME_AL_FUUKI_1', 'LOC_DESC_AL_FUUKI_1', NULL, 1, 1200, 'BUILDING_AL_FUUKI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_RENAISSANCE'),
            ('PROJECT_AL_FUUKI_2', 'LOC_NAME_AL_FUUKI_2', 'LOC_NAME_AL_FUUKI_2', 'LOC_DESC_AL_FUUKI_2', NULL, 1, 1800, 'BUILDING_AL_FUUKI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_MODERN'),
            ('PROJECT_AL_FUUKI_3', 'LOC_NAME_AL_FUUKI_3', 'LOC_NAME_AL_FUUKI_3', 'LOC_DESC_AL_FUUKI_3', NULL, 1, 2000, 'BUILDING_AL_FUUKI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_ATOMIC'),
            ('PROJECT_AL_FUUKI_4', 'LOC_NAME_AL_FUUKI_4', 'LOC_NAME_AL_FUUKI_4', 'LOC_DESC_AL_FUUKI_4', NULL, 1, 2400, 'BUILDING_AL_FUUKI', 'DISTRICT_AL_GARDEN', 'CIVIC_AL_INFORMATION');

    INSERT INTO Project_YieldConversions
        (ProjectType, YieldType, PercentOfProductionRate) VALUES
        --训练设施
            ('PROJECT_AL_TRANNING_EXP_1', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_TRANNING_EXP_2', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_TRANNING_EXP_3', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_TRANNING_ABL_1', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_TRANNING_ABL_2', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_TRANNING_ABL_3', 'YIELD_SCIENCE', 50),
        --工厂科
            ('PROJECT_AL_ARSENAL_1', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_ARSENAL_2', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_ARSENAL_3', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_ARSENAL_4', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_ARSENAL_5', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_ARSENAL_6', 'YIELD_SCIENCE', 50),
        --契约礼堂
            ('PROJECT_AL_PROMISE_1', 'YIELD_FOOD', 50),
            ('PROJECT_AL_PROMISE_2', 'YIELD_FOOD', 50),
            ('PROJECT_AL_PROMISE_3', 'YIELD_FOOD', 50),
        --往世祭所
            ('PROJECT_AL_OHAKA_1', 'YIELD_FAITH', 50),
            ('PROJECT_AL_OHAKA_2', 'YIELD_FAITH', 50),
            ('PROJECT_AL_OHAKA_3', 'YIELD_FAITH', 50),
            ('PROJECT_AL_OHAKA_4', 'YIELD_FAITH', 50),
            ('PROJECT_AL_OHAKA_5', 'YIELD_FAITH', 50),
            ('PROJECT_AL_OHAKA_6', 'YIELD_FAITH', 50),
            
            ('PROJECT_AL_AREA_DEFFENSE_1', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_AREA_DEFFENSE_2', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_AREA_DEFFENSE_3', 'YIELD_SCIENCE', 50),
            ('PROJECT_AL_AREA_DEFFENSE_4', 'YIELD_SCIENCE', 50),
            
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'YIELD_FOOD', 50),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'YIELD_FOOD', 50),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'YIELD_FOOD', 50),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'YIELD_FOOD', 50),
            
            ('PROJECT_AL_SEITOKAI_1', 'YIELD_GOLD', 50),
            ('PROJECT_AL_SEITOKAI_2', 'YIELD_GOLD', 50),
            ('PROJECT_AL_SEITOKAI_3', 'YIELD_GOLD', 50),
            ('PROJECT_AL_SEITOKAI_4', 'YIELD_GOLD', 50),
            
            ('PROJECT_AL_FUUKI_1', 'YIELD_CULTURE', 50),
            ('PROJECT_AL_FUUKI_2', 'YIELD_CULTURE', 50),
            ('PROJECT_AL_FUUKI_3', 'YIELD_CULTURE', 50),
            ('PROJECT_AL_FUUKI_4', 'YIELD_CULTURE', 50);

    INSERT INTO ProjectCompletionModifiers
        (ProjectType, ModifierId) VALUES
        --工厂科
            ('PROJECT_AL_ARSENAL_1', 'MOD_PROJECT_AL_ARSENAL_1'),
            ('PROJECT_AL_ARSENAL_2', 'MOD_PROJECT_AL_ARSENAL_2'),
            ('PROJECT_AL_ARSENAL_3', 'MOD_PROJECT_AL_ARSENAL_3'),
            ('PROJECT_AL_ARSENAL_4', 'MOD_PROJECT_AL_ARSENAL_4'),
            ('PROJECT_AL_ARSENAL_5', 'MOD_PROJECT_AL_ARSENAL_5'),

            ('PROJECT_AL_ARSENAL_1', 'BOOST_PROJECT_AL_ARSENAL_1'),
            ('PROJECT_AL_ARSENAL_2', 'BOOST_PROJECT_AL_ARSENAL_2'),
            ('PROJECT_AL_ARSENAL_3', 'BOOST_PROJECT_AL_ARSENAL_3'),
            ('PROJECT_AL_ARSENAL_4', 'BOOST_PROJECT_AL_ARSENAL_4'),
            ('PROJECT_AL_ARSENAL_5', 'BOOST_PROJECT_AL_ARSENAL_5'),

            ('PROJECT_AL_ARSENAL_6', 'MOD_PROJECT_AL_ARSENAL_6'),
        --往世祭所
            ('PROJECT_AL_OHAKA_1', 'MOD_PROJECT_AL_OHAKA_1'),
            ('PROJECT_AL_OHAKA_2', 'MOD_PROJECT_AL_OHAKA_2'),
            ('PROJECT_AL_OHAKA_3', 'MOD_PROJECT_AL_OHAKA_3'),
            
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'MOD_PROJECT_AL_KOUNAI_ONSEN_1_1'),
            ('PROJECT_AL_KOUNAI_ONSEN_1', 'MOD_PROJECT_AL_KOUNAI_ONSEN_1_2'),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'MOD_PROJECT_AL_KOUNAI_ONSEN_2_1'),
            ('PROJECT_AL_KOUNAI_ONSEN_2', 'MOD_PROJECT_AL_KOUNAI_ONSEN_2_2'),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'MOD_PROJECT_AL_KOUNAI_ONSEN_3_1'),
            ('PROJECT_AL_KOUNAI_ONSEN_3', 'MOD_PROJECT_AL_KOUNAI_ONSEN_3_2'),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'MOD_PROJECT_AL_KOUNAI_ONSEN_4_1'),
            ('PROJECT_AL_KOUNAI_ONSEN_4', 'MOD_PROJECT_AL_KOUNAI_ONSEN_4_2');

    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent) VALUES
        --工厂科
            ('MOD_PROJECT_AL_ARSENAL_1', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),
            ('MOD_PROJECT_AL_ARSENAL_2', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),
            ('MOD_PROJECT_AL_ARSENAL_3', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),
            ('MOD_PROJECT_AL_ARSENAL_4', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),
            ('MOD_PROJECT_AL_ARSENAL_5', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),

            ('BOOST_PROJECT_AL_ARSENAL_1', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', NULL, 1, 1),
            ('BOOST_PROJECT_AL_ARSENAL_2', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', NULL, 1, 1),
            ('BOOST_PROJECT_AL_ARSENAL_3', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', NULL, 1, 1),
            ('BOOST_PROJECT_AL_ARSENAL_4', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', NULL, 1, 1),
            ('BOOST_PROJECT_AL_ARSENAL_5', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECH_BOOST', NULL, 1, 1),

            ('MOD_PROJECT_AL_ARSENAL_6', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, 0, 1),
        --工厂科能力
            ('BUFF_PROJECT_AL_ARSENAL_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
            ('BUFF_PROJECT_AL_ARSENAL_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
            ('BUFF_PROJECT_AL_ARSENAL_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
            ('BUFF_PROJECT_AL_ARSENAL_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
            ('BUFF_PROJECT_AL_ARSENAL_5', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
            ('BUFF_PROJECT_AL_ARSENAL_6', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 1),
        --往世祭所
            ('MOD_PROJECT_AL_OHAKA_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_HAS_OHAKA', 0, 1),
            ('MOD_PROJECT_AL_OHAKA_2', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_HAS_OHAKA', 0, 1),
            ('MOD_PROJECT_AL_OHAKA_3', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_HAS_OHAKA', 0, 1),
        --往世祭所城市BUFF
            ('MOD_CITY_AL_OHAKA_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0, 1),
            ('MOD_CITY_AL_OHAKA_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0, 1),
            ('MOD_CITY_AL_OHAKA_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0, 1),
            
        --往世祭所人物BUFF
            ('BUFF_PROJECT_AL_OHAKA_1', 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD', 'REQSET_AL_OPPONENT_IS_HUGE', 0, 1),
            ('BUFF_PROJECT_AL_OHAKA_2', 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD', 'REQSET_AL_OPPONENT_IS_HUGE', 0, 1),
            ('BUFF_PROJECT_AL_OHAKA_3', 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD', 'REQSET_AL_OPPONENT_IS_HUGE', 0, 1),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_1_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_HAS_KOUNAI_ONSEN', 0, 1),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_1_2', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY', 'REQSET_CITY_HAS_KOUNAI_ONSEN', 0, 1),

            ('MOD_PROJECT_AL_KOUNAI_ONSEN_2_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_CITY_HAS_KOUNAI_ONSEN', 0, 1),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_2_2', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY', 'REQSET_CITY_HAS_KOUNAI_ONSEN', 0, 1),
            
            ('MOD_CITY_AL_KOUNAI_ONSEN_1_1', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', NULL, 0, 1),
            ('MOD_CITY_AL_KOUNAI_ONSEN_2_1', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', NULL, 0, 1),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_1', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_NEAR_ONSEN', 0, 1),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_2', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_NEAR_ONSEN', 0, 1),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_1', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_NEAR_ONSEN_SEA', 0, 1),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_2', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_NEAR_ONSEN_SEA', 0, 1);

    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
        --工厂科
            ('MOD_PROJECT_AL_ARSENAL_1', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_1'),
            ('MOD_PROJECT_AL_ARSENAL_2', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_2'),
            ('MOD_PROJECT_AL_ARSENAL_3', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_3'),
            ('MOD_PROJECT_AL_ARSENAL_4', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_4'),
            ('MOD_PROJECT_AL_ARSENAL_5', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_5'),

            ('BOOST_PROJECT_AL_ARSENAL_1', 'TechType', 'TECH_AL_INDUSTRIAL'),
            ('BOOST_PROJECT_AL_ARSENAL_2', 'TechType', 'TECH_AL_MODERN'),
            ('BOOST_PROJECT_AL_ARSENAL_3', 'TechType', 'TECH_AL_ATOMIC'),
            ('BOOST_PROJECT_AL_ARSENAL_4', 'TechType', 'TECH_AL_INFORMATION'),
            ('BOOST_PROJECT_AL_ARSENAL_5', 'TechType', 'TECH_AL_FUTURE'),

            ('MOD_PROJECT_AL_ARSENAL_6', 'AbilityType', 'ABL_PROJECT_AL_ARSENAL_6'),
        --工厂科能力
            ('BUFF_PROJECT_AL_ARSENAL_1', 'Amount', 10),
            ('BUFF_PROJECT_AL_ARSENAL_2', 'Amount', 10),
            ('BUFF_PROJECT_AL_ARSENAL_3', 'Amount', 10),
            ('BUFF_PROJECT_AL_ARSENAL_4', 'Amount', 10),
            ('BUFF_PROJECT_AL_ARSENAL_5', 'Amount', 10),
            ('BUFF_PROJECT_AL_ARSENAL_6', 'Amount', 10),
        --往世祭所
            ('MOD_PROJECT_AL_OHAKA_1', 'ModifierId', 'MOD_CITY_AL_OHAKA_1'),
            ('MOD_PROJECT_AL_OHAKA_2', 'ModifierId', 'MOD_CITY_AL_OHAKA_2'),
            ('MOD_PROJECT_AL_OHAKA_3', 'ModifierId', 'MOD_CITY_AL_OHAKA_3'),
        --往世祭所城市
            ('MOD_CITY_AL_OHAKA_1', 'ModifierId', 'BUFF_PROJECT_AL_OHAKA_1'),
            ('MOD_CITY_AL_OHAKA_2', 'ModifierId', 'BUFF_PROJECT_AL_OHAKA_2'),
            ('MOD_CITY_AL_OHAKA_3', 'ModifierId', 'BUFF_PROJECT_AL_OHAKA_3'),
            
        --往世祭所人物
            ('BUFF_PROJECT_AL_OHAKA_1', 'PercentDefeatedStrength', 25),
            ('BUFF_PROJECT_AL_OHAKA_2', 'PercentDefeatedStrength', 25),
            ('BUFF_PROJECT_AL_OHAKA_3', 'PercentDefeatedStrength', 25),
            ('BUFF_PROJECT_AL_OHAKA_1', 'YieldType', 'YIELD_GOLD'),
            ('BUFF_PROJECT_AL_OHAKA_2', 'YieldType', 'YIELD_CULTURE'),
            ('BUFF_PROJECT_AL_OHAKA_3', 'YieldType', 'YIELD_SCIENCE'),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_1_1', 'ModifierId', 'MOD_CITY_AL_KOUNAI_ONSEN_1_1'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_1_2', 'Amount', 0.5),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_2_1', 'ModifierId', 'MOD_CITY_AL_KOUNAI_ONSEN_2_1'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_2_2', 'Amount', 1),
            
            ('MOD_CITY_AL_KOUNAI_ONSEN_1_1', 'ResourceType', 'RESOURCE_AL_MAGI'),
            ('MOD_CITY_AL_KOUNAI_ONSEN_1_1', 'Amount', 2),
            
            ('MOD_CITY_AL_KOUNAI_ONSEN_2_1', 'ResourceType', 'RESOURCE_AL_MAGI'),
            ('MOD_CITY_AL_KOUNAI_ONSEN_2_1', 'Amount', 2),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_1', 'YieldType', 'YIELD_SCIENCE'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_1', 'Amount', 2),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_2', 'YieldType', 'YIELD_PRODUCTION'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_3_2', 'Amount', 1),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_1', 'YieldType', 'YIELD_CULTURE'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_1', 'Amount', 2),
            
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_2', 'YieldType', 'YIELD_FOOD'),
            ('MOD_PROJECT_AL_KOUNAI_ONSEN_4_2', 'Amount', 1);

    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
            ('BUFF_PROJECT_AL_ARSENAL_1', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_1}'),
            ('BUFF_PROJECT_AL_ARSENAL_2', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_2}'),
            ('BUFF_PROJECT_AL_ARSENAL_3', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_3}'),
            ('BUFF_PROJECT_AL_ARSENAL_4', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_4}'),
            ('BUFF_PROJECT_AL_ARSENAL_5', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_5}'),
            ('BUFF_PROJECT_AL_ARSENAL_6', 'Preview', '+{1_Amount} {LOC_NAME_ABL_PROJECT_AL_ARSENAL_6}');

    INSERT INTO RequirementSets
        (RequirementSetId, RequirementSetType) VALUES
            ('REQSET_CITY_HAS_OHAKA', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_CITY_HAS_KOUNAI_ONSEN', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_NEAR_ONSEN', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_NEAR_ONSEN_SEA', 'REQUIREMENTSET_TEST_ALL');

    INSERT INTO RequirementSetRequirements
        (RequirementSetId, RequirementId) VALUES
            ('REQSET_CITY_HAS_OHAKA', 'REQ_CITY_HAS_OHAKA'),
            ('REQSET_CITY_HAS_KOUNAI_ONSEN', 'REQ_CITY_HAS_KOUNAI_ONSEN'),
            ('REQSET_AL_PLOT_NEAR_ONSEN', 'REQ_AL_PLOT_NEAR_ONSEN'),
            ('REQSET_AL_PLOT_NEAR_ONSEN_SEA', 'REQ_AL_PLOT_NEAR_ONSEN');

    INSERT INTO Requirements
        (RequirementId, RequirementType) VALUES
            ('REQ_CITY_HAS_OHAKA', 'REQUIREMENT_CITY_HAS_BUILDING'),
            ('REQ_CITY_HAS_KOUNAI_ONSEN', 'REQUIREMENT_CITY_HAS_BUILDING'),
            ('REQ_AL_PLOT_NEAR_ONSEN', 'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'),
            ('REQSET_AL_PLOT_NEAR_ONSEN_SEA', 'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES');

    INSERT INTO RequirementArguments
        (RequirementId, Name, Value) VALUES
            ('REQ_CITY_HAS_OHAKA', 'BuildingType', 'BUILDING_AL_OHAKA'),
            ('REQ_CITY_HAS_KOUNAI_ONSEN', 'BuildingType', 'BUILDING_AL_KOUNAI_ONSEN'),
            ('REQ_AL_PLOT_NEAR_ONSEN', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN'),
            ('REQSET_AL_PLOT_NEAR_ONSEN_SEA', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN_SEA');

