-- PROMISE MODIFIERS --
    CREATE TABLE AL_PromiseEffects(
            'MainKey' INTEGER NOT NULL,
            'CPName' TEXT NOT NULL,
            'Name1' TEXT NOT NULL,
            'Name2' TEXT NOT NULL,
            'PromiseLevel' INTEGER NOT NULL,
            'Number' INTEGER NOT NULL,
            'Ability' INTEGER NOT NULL,
            'ModifierType' TEXT,
            'Adjaent' BOOLEAN,
            'Value' TEXT,
            'OtherTag' TEXT,
            PRIMARY KEY(MainKey)
            );
    CREATE TRIGGER AL_PromiseEffectsModifiers1 AFTER INSERT ON AL_PromiseEffects WHEN New.Ability = 1 BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'AbilityType', 'ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number);
        INSERT INTO Types
            (Type, Kind) VALUES
            ('ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'KIND_ABILITY');
        INSERT INTO TypeTags
            (Type, Tag) VALUES
            ('ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'CLASS_AL_'|| New.Name1 ||'_GREATNORMAL'),
            ('ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'CLASS_AL_'|| New.Name2 ||'_GREATNORMAL');
        INSERT INTO UnitAbilities
            (UnitAbilityType, Name, Description, Inactive) VALUES
            ('ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'LOC_NAME_ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'LOC_NAME_ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 1);
        INSERT INTO UnitAbilityModifiers
            (UnitAbilityType, ModifierId) VALUES
            ('ABL_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'BONUS_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('BONUS_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers2 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN' BEGIN
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('BONUS_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'Type', 'ALL');
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers3 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType, New.OtherTag);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'Amount', New.OtherTag);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers4 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('BUFF_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('BUFF_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'ResourceType', New.OtherTag),
            ('BUFF_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers5 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_GOODY_HUT' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'Source', New.OtherTag),
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers6 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_GOODY_HUT' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'Source', New.OtherTag),
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers7 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_ADJUST_GOVERNOR_POINTS' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, 'Delta', 1),
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers8 AFTER INSERT ON AL_PromiseEffects WHEN New.ModifierType = 'MODIFIER_PLAYER_GRANT_YIELD' BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'YieldType',  New.OtherTag);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value,Type) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value, 'ScaleByGameSpeed');
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers9 AFTER INSERT ON AL_PromiseEffects WHEN New.Ability = 0 BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType);
        INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number,'Amount',  New.Value);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers10 AFTER INSERT ON AL_PromiseEffects WHEN New.PromiseLevel = 1 BEGIN
        INSERT INTO RequirementSets
            (RequirementSetId, RequirementSetType) VALUES
            ('REQSET_AL_UNIT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_NOT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQUIREMENTSET_TEST_ANY');
        INSERT INTO RequirementSetRequirements
            (RequirementSetId, RequirementId) VALUES
            ('REQSET_AL_UNIT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQ_AL_UNIT_ADJACENT_'|| New.Name1),
            ('REQSET_AL_UNIT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQ_AL_UNIT_ADJACENT_'|| New.Name2),
            ('REQSET_AL_UNIT_NOT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQ_AL_UNIT_NOT_ADJACENT_'|| New.Name1),
            ('REQSET_AL_UNIT_NOT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2, 'REQ_AL_UNIT_NOT_ADJACENT_'|| New.Name2);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers11 AFTER INSERT ON AL_PromiseEffects WHEN New.Adjaent = 1 BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
            ('BONUS_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType, 'REQSET_AL_UNIT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2);
    END;

    CREATE TRIGGER AL_PromiseEffectsModifiers12 AFTER INSERT ON AL_PromiseEffects WHEN New.Adjaent = 0 BEGIN
        INSERT INTO Modifiers
            (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
            ('BONUS_AL_PROMISE_'|| New.CPName ||'_'|| New.PromiseLevel ||'_'|| New.Number, New.ModifierType, 'REQSET_AL_UNIT_NOT_ADJACENT_'|| New.Name1 ||'_OR_'|| New.Name2);
    END;

    INSERT INTO AL_PromiseEffects
            (MainKey, CPName,            Name1,      Name2,      PromiseLevel,   Number, Ability,    ModifierType,                                               Adjaent,        Value,      OtherTag          ) 
     VALUES (1,     'SHENLIN_YUJIA',   'SHENLIN',  'YUJIA',    1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (2,     'SHENLIN_YUJIA',   'SHENLIN',  'YUJIA',    2,              1,      2,          'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY',              NULL,           2,          'RESOURCE_AL_NEKO'  ),
            (3,     'SHENLIN_YUJIA',   'SHENLIN',  'YUJIA',    3,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT',                        1,              2,          NULL                ),
            (4,     'SHENLIN_YUJIA',   'SHENLIN',  'YUJIA',    4,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN',                1,              10,         NULL                ),
            (5,     'TADUSA_MAI',      'TADUSA',   'MAI',      1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (6,     'TADUSA_MAI',      'TADUSA',   'MAI',      2,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN',                1,              10,         NULL                ),
            (7,     'TADUSA_MAI',      'TADUSA',   'MAI',      3,              1,      2,          'MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES',             NULL,           1,          'UNIT_IS_BUILDER'   ),
            (8,     'TADUSA_MAI',      'TADUSA',   'MAI',      4,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_FROM_COMBAT',             1,              25,         NULL                ),
            (9,     'FUMI_KAEDE',      'FUMI',     'KAEDE',    1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (10,    'FUMI_KAEDE',      'FUMI',     'KAEDE',    2,              1,      1,          'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',                     1,              5,          NULL                ),
            (11,    'FUMI_KAEDE',      'FUMI',     'KAEDE',    3,              1,      0,          'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',              NULL,           1,          NULL                ),
            (12,    'FUMI_KAEDE',      'FUMI',     'KAEDE',    4,              1,      1,          'MODIFIER_UNIT_ADJUST_ATTACK_RANGE',                        1,              1,          NULL                ),
            (13,    'FUMI_KAEDE',      'FUMI',     'KAEDE',    4,              2,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT',                        1,              1,          NULL                ),
            (14,    'YUYU_MAI',        'YUYU',     'MAI',      1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              1,          NULL                ),
            (15,    'YUYU_MAI',        'YUYU',     'MAI',      2,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT',                        1,              1,          NULL                ),
            (16,    'YUYU_MAI',        'YUYU',     'MAI',      3,              1,      2,          'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_GOODY_HUT',  NULL,           3,          'CAPTURED_CITY'     ),
            (17,    'YUYU_MAI',        'YUYU',     'MAI',      4,              1,      2,          'MODIFIER_PLAYER_ADJUST_GOVERNOR_POINTS',                   NULL,           2,          NULL                ),
            (18,    'YUYU_RIRI',       'YUYU',     'RIRI',     1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (19,    'YUYU_RIRI',       'YUYU',     'RIRI',     2,              1,      0,          'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN',                    NULL,           2,          NULL                ),
            (20,    'YUYU_RIRI',       'YUYU',     'RIRI',     3,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',                     0,              2,          NULL                ),
            (21,    'YUYU_RIRI',       'YUYU',     'RIRI',     4,              1,      1,          'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',                     1,              7,          NULL                ),
            (22,    'KAEDE_RIRI',      'KAEDE',    'RIRI',     1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (23,    'KAEDE_RIRI',      'KAEDE',    'RIRI',     2,              1,      2,          'MODIFIER_PLAYER_GRANT_YIELD',                              NULL,           300,        'YIELD_GOLD'        ),
            (24,    'KAEDE_RIRI',      'KAEDE',    'RIRI',     3,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',                     1,              2,          NULL                ),
            (25,    'KAEDE_RIRI',      'KAEDE',    'RIRI',     4,              1,      2,          'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_GOODY_HUT',       NULL,           4,          'CAPTURED_CITY'     ),
            (26,    'TADUSA_RIRI',     'TADUSA',   'RIRI',     1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (27,    'TADUSA_RIRI',     'TADUSA',   'RIRI',     2,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',                     0,              1,          NULL                ),
            (28,    'TADUSA_RIRI',     'TADUSA',   'RIRI',     2,              2,      1,          'MODIFIER_UNIT_ADJUST_ATTACK_RANGE',                        0,              1,          NULL                ),
            (29,    'TADUSA_RIRI',     'TADUSA',   'RIRI',     4,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',                     1,              -1,         NULL                ),
            (30,    'TADUSA_RIRI',     'TADUSA',   'RIRI',     4,              2,      1,          'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',                     1,              10,         NULL                ),
            (31,    'MOYU_MILIAM',     'MOYU',     'MILIAM',   1,              1,      1,          'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER',     1,              25,         NULL                ),
            (32,    'MOYU_MILIAM',     'MOYU',     'MILIAM',   2,              1,      2,          'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY_BOOST_GOODY_HUT',  NULL,           3,          'CAPTURED_CITY'     ),
            (33,    'MOYU_MILIAM',     'MOYU',     'MILIAM',   3,              1,      0,          'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN',                    NULL,           2,          NULL                ),
            (34,    'MOYU_MILIAM',     'MOYU',     'MILIAM',   4,              1,      2,          'MODIFIER_PLAYER_ADJUST_GOVERNOR_POINTS',                   NULL,           2,          NULL                );

-- TRAINNING MODIFIERS --

    INSERT INTO GameModifiers
        (ModifierId) VALUES
        ('MOD_AL_PROMISE_STRENGTH'),
        ('MOD_AL_TRAINNING_TAKANOME'),
        ('MOD_AL_TRAINNING_LUNATIC'),
        ('MOD_AL_TRAINNING_PHANTOSM'),
        ('MOD_AL_TRAINNING_TESTAMENT'),
        ('MOD_AL_TRAINNING_HELIOSPHERE'),
        ('MOD_AL_TRAINNING_PHASE'),
        ('MOD_AL_TRAINNING_CHARISMA'),
        ('MOD_AL_TRAINNING_HAKARIME'),
        ('MOD_AL_TRAINNING_KOTOWARI'),
        ('MOD_AL_TRAINNING_SYUKUCHI'),
        ('MOD_AL_TRAINNING_UBER'),
        ('MOD_AL_TRAINNING_REGISTER'),
        
        ('MOD_AL_AREA_DEFFENSE_YIELD1'),
        ('MOD_AL_AREA_DEFFENSE_YIELD2'),
        ('MOD_AL_AREA_DEFFENSE_YIELD3'),
        ('MOD_AL_AREA_DEFFENSE_YIELD4');

    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent) VALUES
        ('MOD_AL_PROMISE_STRENGTH', 'MODIFIER_ALL_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0, 0),
        ('MOD_AL_PROMISE_STRENGTH_BUFF', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_UNIT_IS_LILY_GREAT', 0, 0),

        ('MOD_AL_KANBA_BUILD_CHARGE', 'MODIFIER_UNIT_ADJUST_BUILDER_CHARGES', NULL, 0, 0),

        ('MOD_AL_KANBA_COLLECTION_BOOST', 'MODIFIER_PLAYER_GRANT_RANDOM_CIVIC_BOOST_GOODY_HUT', NULL, 0, 0),

        ('MOD_AL_TRAINNING_TAKANOME', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_TAKANOME', 0, 1),
        ('MOD_AL_TRAINNING_LUNATIC', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_LUNATIC', 0, 1),
        ('MOD_AL_TRAINNING_PHANTOSM', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_PHANTOSM', 0, 1),
        ('MOD_AL_TRAINNING_TESTAMENT', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_TESTAMENT', 0, 1),
        ('MOD_AL_TRAINNING_HELIOSPHERE', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_HELIOSPHERE', 0, 1),
        ('MOD_AL_TRAINNING_PHASE', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_PHASE', 0, 1),
        ('MOD_AL_TRAINNING_CHARISMA', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_CHARISMA', 0, 1),
        ('MOD_AL_TRAINNING_HAKARIME', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_HAKARIME', 0, 1),
        ('MOD_AL_TRAINNING_KOTOWARI', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_KOTOWARI', 0, 1),
        ('MOD_AL_TRAINNING_SYUKUCHI', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_SYUKUCHI', 0, 1),
        ('MOD_AL_TRAINNING_UBER', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_UBER', 0, 1),
        ('MOD_AL_TRAINNING_REGISTER', 'MODIFIER_ALL_UNITS_GRANT_ABILITY', 'REQSET_AL_TRAINNING_REGISTER', 0, 1),
        
        ('MOD_AL_AREA_DEFFENSE_YIELD1', 'MODIFIER_GAME_ADJUST_PLOT_YIELD', 'REQSET_AL_AREA_DEFFENSE_YIELD1', 0, 1),
        ('MOD_AL_AREA_DEFFENSE_YIELD2', 'MODIFIER_GAME_ADJUST_PLOT_YIELD', 'REQSET_AL_AREA_DEFFENSE_YIELD2', 0, 1),
        ('MOD_AL_AREA_DEFFENSE_YIELD3', 'MODIFIER_GAME_ADJUST_PLOT_YIELD', 'REQSET_AL_AREA_DEFFENSE_YIELD1', 0, 1),
        ('MOD_AL_AREA_DEFFENSE_YIELD4', 'MODIFIER_GAME_ADJUST_PLOT_YIELD', 'REQSET_AL_AREA_DEFFENSE_YIELD2', 0, 1),
        
        ('MOD_RIRI_GARDEN_YIELD_BONUS', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'REQSET_AL_DISTRICT_IS_GARDEN', 0, 0);

    INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
            ('MOD_AL_KANBA_COLLECTION_BOOST', 'Source', 'CAPTURED_CITY'),
            ('MOD_AL_KANBA_COLLECTION_BOOST','Amount',  1),
            ('MOD_AL_KANBA_BUILD_CHARGE','Amount',  1);

    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
        ('MOD_AL_TRAINNING_TAKANOME', 'AbilityType', 'ABILITY_AL_TRAINNING_TAKANOME'),
        ('MOD_AL_TRAINNING_LUNATIC', 'AbilityType', 'ABILITY_AL_TRAINNING_LUNATIC'),
        ('MOD_AL_TRAINNING_PHANTOSM', 'AbilityType', 'ABILITY_AL_TRAINNING_PHANTOSM'),
        ('MOD_AL_TRAINNING_TESTAMENT', 'AbilityType', 'ABILITY_AL_TRAINNING_TESTAMENT'),
        ('MOD_AL_TRAINNING_HELIOSPHERE', 'AbilityType', 'ABILITY_AL_TRAINNING_HELIOSPHERE'),
        ('MOD_AL_TRAINNING_PHASE', 'AbilityType', 'ABILITY_AL_TRAINNING_PHASE'),
        ('MOD_AL_TRAINNING_CHARISMA', 'AbilityType', 'ABILITY_AL_TRAINNING_CHARISMA'),
        ('MOD_AL_TRAINNING_HAKARIME', 'AbilityType', 'ABILITY_AL_TRAINNING_HAKARIME'),
        ('MOD_AL_TRAINNING_KOTOWARI', 'AbilityType', 'ABILITY_AL_TRAINNING_KOTOWARI'),
        ('MOD_AL_TRAINNING_SYUKUCHI', 'AbilityType', 'ABILITY_AL_TRAINNING_SYUKUCHI'),
        ('MOD_AL_TRAINNING_UBER', 'AbilityType', 'ABILITY_AL_TRAINNING_UBER'),
        ('MOD_AL_TRAINNING_REGISTER', 'AbilityType', 'ABILITY_AL_TRAINNING_REGISTER'),

        ('MOD_AL_PROMISE_STRENGTH', 'ModifierId', 'MOD_AL_PROMISE_STRENGTH_BUFF'),
        ('MOD_AL_PROMISE_STRENGTH_BUFF', 'Key', 'PROMISE_LEVEL'),
        
        ('MOD_AL_AREA_DEFFENSE_YIELD1', 'YieldType', 'YIELD_PRODUCTION'),
        ('MOD_AL_AREA_DEFFENSE_YIELD1','Amount',  2),
        ('MOD_AL_AREA_DEFFENSE_YIELD2', 'YieldType', 'YIELD_FOOD'),
        ('MOD_AL_AREA_DEFFENSE_YIELD2','Amount',  2),
        ('MOD_AL_AREA_DEFFENSE_YIELD3', 'YieldType', 'YIELD_SCIENCE'),
        ('MOD_AL_AREA_DEFFENSE_YIELD3','Amount',  2),
        ('MOD_AL_AREA_DEFFENSE_YIELD4', 'YieldType', 'YIELD_CULTURE'),
        ('MOD_AL_AREA_DEFFENSE_YIELD4','Amount',  2),
        ('MOD_RIRI_GARDEN_YIELD_BONUS', 'YieldType', 'YIELD_SCIENCE'),
        ('MOD_RIRI_GARDEN_YIELD_BONUS','Amount',  3);

    INSERT INTO RequirementSets
        (RequirementSetId, RequirementSetType) VALUES
        ('REQSET_AL_TRAINNING_TAKANOME', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_LUNATIC', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_PHANTOSM', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_TESTAMENT', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_HELIOSPHERE', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_PHASE', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_CHARISMA', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_HAKARIME', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_KOTOWARI', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_SYUKUCHI', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_UBER', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_TRAINNING_REGISTER', 'REQUIREMENTSET_TEST_ALL'),
        
        ('REQSET_AL_AREA_DEFFENSE_YIELD1', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_AREA_DEFFENSE_YIELD2', 'REQUIREMENTSET_TEST_ALL'),
        ('REQSET_AL_DISTRICT_IS_STAGE', 'REQUIREMENTSET_TEST_ALL'),
        
        ('REQSET_AL_DISTRICT_IS_GARDEN', 'REQUIREMENTSET_TEST_ALL');

    INSERT INTO RequirementSetRequirements
        (RequirementSetId, RequirementId) VALUES
        ('REQSET_AL_TRAINNING_TAKANOME', 'REQ_AL_TRAINNING_TAKANOME_PROPERTY'),
        ('REQSET_AL_TRAINNING_TAKANOME', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_LUNATIC', 'REQ_AL_TRAINNING_LUNATIC_PROPERTY'),
        ('REQSET_AL_TRAINNING_LUNATIC', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_PHANTOSM', 'REQ_AL_TRAINNING_PHANTOSM_PROPERTY'),
        ('REQSET_AL_TRAINNING_PHANTOSM', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_TESTAMENT', 'REQ_AL_TRAINNING_TESTAMENT_PROPERTY'),
        ('REQSET_AL_TRAINNING_TESTAMENT', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_HELIOSPHERE', 'REQ_AL_TRAINNING_HELIOSPHERE_PROPERTY'),
        ('REQSET_AL_TRAINNING_HELIOSPHERE', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_PHASE', 'REQ_AL_TRAINNING_PHASE_PROPERTY'),
        ('REQSET_AL_TRAINNING_PHASE', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_CHARISMA', 'REQ_AL_TRAINNING_CHARISMA_PROPERTY'),
        ('REQSET_AL_TRAINNING_CHARISMA', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_HAKARIME', 'REQ_AL_TRAINNING_HAKARIME_PROPERTY'),
        ('REQSET_AL_TRAINNING_HAKARIME', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_KOTOWARI', 'REQ_AL_TRAINNING_KOTOWARI_PROPERTY'),
        ('REQSET_AL_TRAINNING_KOTOWARI', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_SYUKUCHI', 'REQ_AL_TRAINNING_SYUKUCHI_PROPERTY'),
        ('REQSET_AL_TRAINNING_SYUKUCHI', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_UBER', 'REQ_AL_TRAINNING_UBER_PROPERTY'),
        ('REQSET_AL_TRAINNING_UBER', 'REQUIRES_LAND_UNIT'),
        ('REQSET_AL_TRAINNING_REGISTER', 'REQ_AL_TRAINNING_REGISTER_PROPERTY'),
        ('REQSET_AL_TRAINNING_REGISTER', 'REQUIRES_LAND_UNIT'),
        
        ('REQSET_AL_AREA_DEFFENSE_YIELD1', 'REQ_AL_AREA_DEFFENSE_YIELD1'),
        ('REQSET_AL_AREA_DEFFENSE_YIELD2', 'REQ_AL_AREA_DEFFENSE_YIELD2'),
        
        ('REQSET_AL_DISTRICT_IS_GARDEN', 'REQ_AL_DISTRICT_IS_GARDEN'),
        ('REQSET_AL_DISTRICT_IS_STAGE', 'REQ_AL_DISTRICT_IS_STAGE');

    INSERT INTO Requirements
        (RequirementId, RequirementType) VALUES
        ('REQ_AL_TRAINNING_TAKANOME_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_LUNATIC_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_PHANTOSM_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_TESTAMENT_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_HELIOSPHERE_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_PHASE_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_CHARISMA_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_HAKARIME_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_KOTOWARI_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_SYUKUCHI_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_UBER_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_TRAINNING_REGISTER_PROPERTY', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        
        ('REQ_AL_AREA_DEFFENSE_YIELD1', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_AREA_DEFFENSE_YIELD2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
        ('REQ_AL_DISTRICT_IS_STAGE', 'REQUIREMENT_DISTRICT_TYPE_MATCHES'),
        
        ('REQ_AL_DISTRICT_IS_GARDEN', 'REQUIREMENT_DISTRICT_TYPE_MATCHES');

    INSERT INTO RequirementArguments
        (RequirementId, Name, Value) VALUES
        ('REQ_AL_TRAINNING_TAKANOME_PROPERTY', 'PropertyName', 'AL_TRAINNING_TAKANOME'),
        ('REQ_AL_TRAINNING_TAKANOME_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_LUNATIC_PROPERTY', 'PropertyName', 'AL_TRAINNING_LUNATIC'),
        ('REQ_AL_TRAINNING_LUNATIC_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_PHANTOSM_PROPERTY', 'PropertyName', 'AL_TRAINNING_PHANTOSM'),
        ('REQ_AL_TRAINNING_PHANTOSM_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_TESTAMENT_PROPERTY', 'PropertyName', 'AL_TRAINNING_TESTAMENT'),
        ('REQ_AL_TRAINNING_TESTAMENT_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_HELIOSPHERE_PROPERTY', 'PropertyName', 'AL_TRAINNING_HELIOSPHERE'),
        ('REQ_AL_TRAINNING_HELIOSPHERE_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_PHASE_PROPERTY', 'PropertyName', 'AL_TRAINNING_PHASE'),
        ('REQ_AL_TRAINNING_PHASE_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_CHARISMA_PROPERTY', 'PropertyName', 'AL_TRAINNING_CHARISMA'),
        ('REQ_AL_TRAINNING_CHARISMA_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_HAKARIME_PROPERTY', 'PropertyName', 'AL_TRAINNING_HAKARIME'),
        ('REQ_AL_TRAINNING_HAKARIME_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_KOTOWARI_PROPERTY', 'PropertyName', 'AL_TRAINNING_KOTOWARI'),
        ('REQ_AL_TRAINNING_KOTOWARI_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_SYUKUCHI_PROPERTY', 'PropertyName', 'AL_TRAINNING_SYUKUCHI'),
        ('REQ_AL_TRAINNING_SYUKUCHI_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_UBER_PROPERTY', 'PropertyName', 'AL_TRAINNING_UBER'),
        ('REQ_AL_TRAINNING_UBER_PROPERTY', 'PropertyMinimum', '1'),
        ('REQ_AL_TRAINNING_REGISTER_PROPERTY', 'PropertyName', 'AL_TRAINNING_REGISTER'),
        ('REQ_AL_TRAINNING_REGISTER_PROPERTY', 'PropertyMinimum', '1'),
        
        ('REQ_AL_AREA_DEFFENSE_YIELD1', 'PropertyName', 'area_deffense_flag_4'),
        ('REQ_AL_AREA_DEFFENSE_YIELD1', 'PropertyMinimum', '1'),
        ('REQ_AL_AREA_DEFFENSE_YIELD2', 'PropertyName', 'area_deffense_flag_5'),
        ('REQ_AL_AREA_DEFFENSE_YIELD2', 'PropertyMinimum', '1'),
        ('REQ_AL_DISTRICT_IS_STAGE', 'DistrictType', 'DISTRICT_AL_STAGE'),
        ('REQ_AL_DISTRICT_IS_GARDEN', 'DistrictType', 'DISTRICT_AL_GARDEN');

-- TRAINNING ABILITIES --

    INSERT INTO Types
        (Type, Kind) VALUES
        ('ABILITY_AL_KANBA_BUILD_CHARGE', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_TAKANOME', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_LUNATIC', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_PHANTOSM', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'KIND_ABILITY'),
        ('BUFF_AL_TRAINNING_TESTAMENT', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'KIND_ABILITY'),
        ('BUFF_AL_TRAINNING_HELIOSPHERE', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_PHASE', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_CHARISMA', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_HAKARIME', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_KOTOWARI', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_SYUKUCHI', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_UBER', 'KIND_ABILITY'),
        ('ABILITY_AL_TRAINNING_REGISTER', 'KIND_ABILITY'),
        ('BUFF_AL_TRAINNING_REGISTER', 'KIND_ABILITY');

    INSERT INTO TypeTags
        (Type, Tag) VALUES
        ('ABILITY_AL_TRAINNING_TAKANOME', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_TAKANOME', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_KANBA_BUILD_CHARGE', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_LUNATIC', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_LUNATIC', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_PHANTOSM', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_PHANTOSM', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'CLASS_AL_LILY'),
        ('BUFF_AL_TRAINNING_TESTAMENT', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('BUFF_AL_TRAINNING_TESTAMENT', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_PHASE', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_PHASE', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_CHARISMA', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_CHARISMA', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_HAKARIME', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_HAKARIME', 'CLASS_AL_LILY'),
        ('BUFF_AL_TRAINNING_HELIOSPHERE', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('BUFF_AL_TRAINNING_HELIOSPHERE', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_KOTOWARI', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_KOTOWARI', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_SYUKUCHI', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_SYUKUCHI', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_UBER', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_UBER', 'CLASS_AL_LILY'),
        ('ABILITY_AL_TRAINNING_REGISTER', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('ABILITY_AL_TRAINNING_REGISTER', 'CLASS_AL_LILY'),
        ('BUFF_AL_TRAINNING_REGISTER', 'CLASS_AL_LILY_GREAT_UNIT'),
        ('BUFF_AL_TRAINNING_REGISTER', 'CLASS_AL_LILY');

    INSERT INTO UnitAbilities
        (UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned) VALUES
        ('ABILITY_AL_TRAINNING_TAKANOME', 'LOC_NAME_ABILITY_AL_TRAINNING_TAKANOME', 'LOC_NAME_ABILITY_AL_TRAINNING_TAKANOME', 1, 1),
        ('ABILITY_AL_KANBA_BUILD_CHARGE', 'LOC_PROJECT_AL_COLLECTION_NAME', NULL, 1, 1),

        ('ABILITY_AL_TRAINNING_LUNATIC', 'LOC_NAME_ABILITY_AL_TRAINNING_LUNATIC', 'LOC_NAME_ABILITY_AL_TRAINNING_LUNATIC', 1, 1),
        ('ABILITY_AL_TRAINNING_PHANTOSM', 'LOC_NAME_ABILITY_AL_TRAINNING_PHANTOSM', 'LOC_NAME_ABILITY_AL_TRAINNING_PHANTOSM', 1, 1),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'LOC_NAME_ABILITY_AL_TRAINNING_TESTAMENT', 'LOC_NAME_ABILITY_AL_TRAINNING_TESTAMENT', 1, 1),
        ('BUFF_AL_TRAINNING_TESTAMENT', 'LOC_NAME_BUFF_AL_TRAINNING_TESTAMENT', 'LOC_NAME_BUFF_AL_TRAINNING_TESTAMENT', 1, 1),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'LOC_NAME_ABILITY_AL_TRAINNING_HELIOSPHERE', 'LOC_NAME_ABILITY_AL_TRAINNING_HELIOSPHERE', 1, 1),
        ('BUFF_AL_TRAINNING_HELIOSPHERE', 'LOC_NAME_BUFF_AL_TRAINNING_HELIOSPHERE', 'LOC_NAME_BUFF_AL_TRAINNING_HELIOSPHERE', 1, 1),
        ('ABILITY_AL_TRAINNING_PHASE', 'LOC_NAME_ABILITY_AL_TRAINNING_PHASE', 'LOC_NAME_ABILITY_AL_TRAINNING_PHASE', 1, 1),
        ('ABILITY_AL_TRAINNING_CHARISMA', 'LOC_NAME_ABILITY_AL_TRAINNING_CHARISMA', 'LOC_NAME_ABILITY_AL_TRAINNING_CHARISMA', 1, 1),
        ('ABILITY_AL_TRAINNING_HAKARIME', 'LOC_NAME_ABILITY_AL_TRAINNING_HAKARIME', 'LOC_NAME_ABILITY_AL_TRAINNING_HAKARIME', 1, 1),
        ('ABILITY_AL_TRAINNING_KOTOWARI', 'LOC_NAME_ABILITY_AL_TRAINNING_KOTOWARI', 'LOC_NAME_ABILITY_AL_TRAINNING_KOTOWARI', 1, 1),
        ('ABILITY_AL_TRAINNING_SYUKUCHI', 'LOC_NAME_ABILITY_AL_TRAINNING_SYUKUCHI', 'LOC_NAME_ABILITY_AL_TRAINNING_SYUKUCHI', 1, 1),
        ('ABILITY_AL_TRAINNING_UBER', 'LOC_NAME_ABILITY_AL_TRAINNING_UBER', 'LOC_NAME_ABILITY_AL_TRAINNING_UBER', 1, 1),
        ('ABILITY_AL_TRAINNING_REGISTER', 'LOC_NAME_ABILITY_AL_TRAINNING_REGISTER', 'LOC_NAME_ABILITY_AL_TRAINNING_REGISTER', 1, 1),
        ('BUFF_AL_TRAINNING_REGISTER', 'LOC_NAME_BUFF_AL_TRAINNING_REGISTER', 'LOC_NAME_BUFF_AL_TRAINNING_REGISTER', 1, 1);

    INSERT INTO UnitAbilityModifiers
        (UnitAbilityType, ModifierId) VALUES
        ('ABILITY_AL_TRAINNING_TAKANOME', 'BONUS_AL_TRAINNING_TAKANOME'),
        ('ABILITY_AL_KANBA_BUILD_CHARGE', 'MOD_AL_KANBA_BUILD_CHARGE'),

        ('ABILITY_AL_TRAINNING_LUNATIC', 'BONUS_AL_TRAINNING_LUNATIC'),
        ('ABILITY_AL_TRAINNING_PHANTOSM', 'BONUS_AL_TRAINNING_PHANTOSM'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'BONUS_AL_TRAINNING_TESTAMENT'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'DEBUFFMOD_AL_TRAINNING_TESTAMENT'),
        ('ABILITY_AL_TRAINNING_TESTAMENT', 'BUFFMOD_AL_TRAINNING_TESTAMENT'),
        ('BUFF_AL_TRAINNING_TESTAMENT', 'BUFFMOD_AL_TRAINNING_TESTAMENT'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'BONUS_AL_TRAINNING_HELIOSPHERE'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'DEBUFFMOD_AL_TRAINNING_HELIOSPHERE'),
        ('ABILITY_AL_TRAINNING_HELIOSPHERE', 'BUFFMOD_AL_TRAINNING_HELIOSPHERE'),
        ('BUFF_AL_TRAINNING_HELIOSPHERE', 'BUFFMOD_AL_TRAINNING_HELIOSPHERE'),
        ('ABILITY_AL_TRAINNING_PHASE', 'BONUS_AL_TRAINNING_PHASE'),
        ('ABILITY_AL_TRAINNING_CHARISMA', 'BONUS_AL_TRAINNING_CHARISMA'),
        ('ABILITY_AL_TRAINNING_HAKARIME', 'BONUS_AL_TRAINNING_HAKARIME'),
        ('ABILITY_AL_TRAINNING_KOTOWARI', 'BONUS_AL_TRAINNING_KOTOWARI'),
        ('ABILITY_AL_TRAINNING_SYUKUCHI', 'BONUS_AL_TRAINNING_SYUKUCHI'),
        ('ABILITY_AL_TRAINNING_UBER', 'BONUS_AL_TRAINNING_UBER'),
        ('ABILITY_AL_TRAINNING_REGISTER', 'BONUS_AL_TRAINNING_REGISTER'),
        ('ABILITY_AL_TRAINNING_REGISTER', 'BUFFMOD_AL_TRAINNING_REGISTER'),
        ('BUFF_AL_TRAINNING_REGISTER', 'BUFFMOD_AL_TRAINNING_REGISTER');

    INSERT INTO Modifiers
        (ModifierId, ModifierType, Permanent, SubjectRequirementSetId) VALUES
        ('BONUS_AL_TRAINNING_TAKANOME', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 1, NULL),
        ('BONUS_AL_TRAINNING_LUNATIC', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 1, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
        ('BONUS_AL_TRAINNING_PHANTOSM', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 1, NULL),
        
        ('BONUS_AL_TRAINNING_TESTAMENT', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 'AOE_LAND_REQUIREMENTS'),
        ('DEBUFFMOD_AL_TRAINNING_TESTAMENT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 'UNIT_WEAK_WHEN_DEFENDING_REQUIREMENTS'),
        ('BUFFMOD_AL_TRAINNING_TESTAMENT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),

        ('BONUS_AL_TRAINNING_HELIOSPHERE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 'AOE_LAND_REQUIREMENTS'),
        ('DEBUFFMOD_AL_TRAINNING_HELIOSPHERE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS'),
        ('BUFFMOD_AL_TRAINNING_HELIOSPHERE', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, 'UNIT_WEAK_WHEN_DEFENDING_REQUIREMENTS'),

        ('BONUS_AL_TRAINNING_PHASE', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 1, NULL),
        ('BONUS_AL_TRAINNING_CHARISMA', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', 0, 'MEDIC_HEALING_REQUIREMENTS'),
        ('BONUS_AL_TRAINNING_HAKARIME', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 1, NULL),
        ('BONUS_AL_TRAINNING_KOTOWARI', 'MODIFIER_PLAYER_UNIT_ADJUST_ATTACK_AND_MOVE', 1, NULL),
        ('BONUS_AL_TRAINNING_SYUKUCHI', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 1, NULL),
        ('BONUS_AL_TRAINNING_UBER', 'MODIFIER_PLAYER_UNIT_ADJUST_HIDDEN_VISIBILITY', 1, NULL),
        ('BONUS_AL_TRAINNING_REGISTER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 'AOE_LAND_REQUIREMENTS'),

        ('BUFFMOD_AL_TRAINNING_REGISTER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 0, NULL),
        
        ('MODIFIER_AL_KILL_HUGE_WELCOM_RIRI', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 1, 'REQSET_AL_LEADER_IS_RIRI'),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_KANAHO', 'MODIFIER_PLAYER_DIPLOMACY_SIMPLE_MODIFIER', 1, 'REQSET_AL_LEADER_IS_KANAHO');
        

    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
        ('BONUS_AL_TRAINNING_TAKANOME','Amount',  1),
        ('BONUS_AL_TRAINNING_LUNATIC','Amount',  10),
        ('BONUS_AL_TRAINNING_PHANTOSM','Amount',  7),
        ('BONUS_AL_TRAINNING_TESTAMENT', 'AbilityType', 'BUFF_AL_TRAINNING_TESTAMENT'),
        ('DEBUFFMOD_AL_TRAINNING_TESTAMENT','Amount',  -5),
        ('BUFFMOD_AL_TRAINNING_TESTAMENT','Amount',  5),
        ('BONUS_AL_TRAINNING_HELIOSPHERE', 'AbilityType', 'BUFF_AL_TRAINNING_HELIOSPHERE'),
        ('DEBUFFMOD_AL_TRAINNING_HELIOSPHERE','Amount',  -5),
        ('BUFFMOD_AL_TRAINNING_HELIOSPHERE','Amount',  5),
        ('BONUS_AL_TRAINNING_PHASE','Amount',  1),
        ('BONUS_AL_TRAINNING_CHARISMA', 'Type', 'ALL'),
        ('BONUS_AL_TRAINNING_CHARISMA','Amount',  10),
        ('BONUS_AL_TRAINNING_HAKARIME','Amount',  1),
        ('BONUS_AL_TRAINNING_KOTOWARI', 'CanMove', 1),
        ('BONUS_AL_TRAINNING_SYUKUCHI','Amount',  1),
        ('BONUS_AL_TRAINNING_UBER', 'Hidden', 1),
        ('BONUS_AL_TRAINNING_REGISTER', 'AbilityType', 'BUFF_AL_TRAINNING_REGISTER'),
        ('BUFFMOD_AL_TRAINNING_REGISTER','Amount',  3),
        
        ('MODIFIER_AL_KILL_HUGE_WELCOM_RIRI', 'InitialValue', 3),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_RIRI', 'StatementKey', 'LOC_DIPLO_KUDO_LEADER_AL_KILL_HUGE_WELCOME_REASON_ANY'),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_RIRI', 'SimpleModifierDescription', 'LOC_DIPLO_MODIFIER_DESCRIPTION_AL_KILL_HUGE_WELCOME'),
        
        ('MODIFIER_AL_KILL_HUGE_WELCOM_KANAHO', 'InitialValue', 3),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_KANAHO', 'StatementKey', 'LOC_DIPLO_KUDO_LEADER_AL_KILL_HUGE_WELCOME_REASON_ANY'),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_KANAHO', 'SimpleModifierDescription', 'LOC_DIPLO_MODIFIER_DESCRIPTION_AL_KILL_HUGE_WELCOME');

    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
        ('MOD_AL_PROMISE_STRENGTH_BUFF', 'Preview', 'LOC_MOD_AL_PROMISE_STRENGTH_BUFF'),
        ('BONUS_AL_TRAINNING_LUNATIC', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_LUNATIC}'),
        ('BONUS_AL_TRAINNING_PHANTOSM', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_PHANTOSM}'),
        ('DEBUFFMOD_AL_TRAINNING_TESTAMENT', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_TESTAMENT}'),
        ('BUFFMOD_AL_TRAINNING_TESTAMENT', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_TESTAMENT}'),
        ('DEBUFFMOD_AL_TRAINNING_HELIOSPHERE', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_HELIOSPHERE}'),
        ('BUFFMOD_AL_TRAINNING_HELIOSPHERE', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_HELIOSPHERE}'),
        ('BUFFMOD_AL_TRAINNING_REGISTER', 'Preview', '+{1_Amount} {LOC_NAME_ABILITY_AL_TRAINNING_REGISTER}'),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_KANAHO', 'Sample', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL'),
        ('MODIFIER_AL_KILL_HUGE_WELCOM_RIRI', 'Sample', 'LOC_TOOLTIP_SAMPLE_DIPLOMACY_ALL');