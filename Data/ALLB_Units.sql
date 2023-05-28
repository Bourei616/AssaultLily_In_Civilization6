--TRIGGERS
    CREATE TABLE property_charm_values(n);
        WITH RECURSIVE
        cnt(x) AS (
            SELECT 1
            UNION ALL
            SELECT x+1 FROM cnt WHERE x <= 40
        )
        INSERT INTO property_charm_values(n)
        SELECT x FROM cnt;
    CREATE TABLE AL_RsEffects(
        'RsEffect' TEXT NOT NULL,
        'RareSkill' TEXT NOT NULL,
        PRIMARY KEY(RsEffect,RareSkill)
    );
    CREATE TABLE AL_RsDebuffEffects(
        'RsEffect' TEXT NOT NULL,
        'RareSkill' TEXT NOT NULL,
        PRIMARY KEY(RsEffect,RareSkill)
    );
    INSERT INTO Types
            (Type, Kind) VALUES
            --NEKO
                ('UNIT_AL_NEKO', 'KIND_UNIT'),
                ('UNIT_AL_KANBALILY', 'KIND_UNIT'),
                ('PROMOTION_CLASS_AL_NEKO', 'KIND_PROMOTION_CLASS'),
                ('PROMOTION_AL_NEKO_1', 'KIND_PROMOTION'),
                ('PROMOTION_AL_NEKO_2', 'KIND_PROMOTION'),
                ('PROMOTION_AL_NEKO_3', 'KIND_PROMOTION'),
                ('PROMOTION_AL_NEKO_4', 'KIND_PROMOTION'),
                ('PROMOTION_AL_NEKO_5', 'KIND_PROMOTION');

    INSERT INTO Tags
            (Tag, Vocabulary) VALUES
                ('CLASS_AL_LILY_GREAT_UNIT', 'ABILITY_CLASS'),
                ('CLASS_AL_GRANEPLE', 'ABILITY_CLASS'),
                ('CLASS_AL_KANBA', 'ABILITY_CLASS'),
                ('CLASS_AL_SEITOKAI', 'ABILITY_CLASS'),

                ('CLASS_AL_LILY', 'ABILITY_CLASS'),
                ('CLASS_AL_AZ', 'ABILITY_CLASS'),
                ('CLASS_AL_TZ', 'ABILITY_CLASS'),
                ('CLASS_AL_BZ', 'ABILITY_CLASS'),
                ('CLASS_AL_NEKO', 'ABILITY_CLASS'),
                ('CLASS_AL_RADGRID', 'ABILITY_CLASS'),
                ('CLASS_AL_NO_LEGION', 'ABILITY_CLASS'),
                ('CLASS_AL_YURIGAOKA', 'ABILITY_CLASS'),
                ('CLASS_AL_NEKOSUKI', 'ABILITY_CLASS');
    INSERT INTO AL_RsDebuffEffects
            (RsEffect, RareSkill) 
     VALUES ('MOD_AL_RS_DEBUFF_PhaseTranscendence_1','PhaseTranscendence');

    INSERT INTO AL_RsEffects
            (RsEffect, RareSkill) 
     VALUES ('MOD_AL_RS_LunaticTranser_1','LunaticTranser'),
            ('MOD_AL_RS_Register_1','Register'),
            ('MOD_AL_RS_Register_2','Register'),
            ('MOD_AL_RS_Register_3','Register'),
            ('MOD_MOVE_AFTER_ATTACKING','ZenoneParadoxa'),
            ('MOD_IGNORE_TERRAIN_COST','ZenoneParadoxa'),
            ('BUFF_AL_RS_TruthOfTheWorld_3','ZenoneParadoxa'),
            ('MOD_AL_RS_ZenoneParadoxa_1','ZenoneParadoxa'),
            ('MOD_AL_RS_ZenoneParadoxa_2','ZenoneParadoxa'),
            ('MOD_AL_RS_HeavensScales_1','HeavensScales'),
            ('MOD_AL_RS_HeavensScales_2','HeavensScales'),
            ('MOD_AL_RS_HawkEye_1','HawkEye'),
            ('MOD_AL_RS_HawkEye_2','HawkEye'),
            ('MOD_AL_RS_HawkEye_3','HawkEye'),
            ('MOD_AL_RS_HawkEye_4','HawkEye'),
            ('MOD_AL_RS_ShrunkenLand_1','ShrunkenLand'),
            ('MOD_AL_RS_ShrunkenLand_2','ShrunkenLand'),
            ('MOD_MOVE_AFTER_ATTACKING','ShrunkenLand'),
            ('MOD_IGNORE_TERRAIN_COST','ShrunkenLand'),
            ('MOD_AL_RS_Testament_1','Testament'),
            ('MOD_AL_RS_Testament_2','Testament'),
            ('MOD_AL_RS_Testament_3','Testament'),
            ('MOD_AL_RS_Phantasm_1','Phantasm'),
            ('MOD_AL_RS_Phantasm_2','Phantasm'),
            ('MOD_AL_RS_Laplace_1','Laplace'),
            ('MOD_AL_RS_PhaseTranscendence_1','PhaseTranscendence'),
            ('MOD_AL_RS_PhaseTranscendence_2','PhaseTranscendence'),
            ('MOD_AL_RS_TruthOfTheWorld_1','TruthOfTheWorld'),
            ('MOD_AL_RS_TruthOfTheWorld_2','TruthOfTheWorld'),
            ('MOD_AL_RS_TruthOfTheWorld_3','TruthOfTheWorld'),
            ('MOD_AL_RS_Laplace_2','Laplace');

    CREATE TABLE AL_GreatUnitNames(
        'UnitName' TEXT NOT NULL,
        'Ban' BOOLEAN NOT NULL CHECK (Ban IN (0,1)) DEFAULT 0,
        'Zone' TEXT NOT NULL,
        'Legion' TEXT NOT NULL,
        'Garden' TEXT NOT NULL,
        'Nekosuki' BOOLEAN NOT NULL CHECK (Nekosuki IN (0,1)) DEFAULT 0,
        'UnitType1' TEXT NOT NULL,
        'HasUnitType2' BOOLEAN NOT NULL CHECK (HasUnitType2 IN (0,1)) DEFAULT 0,
        'UnitType2' TEXT DEFAULT NULL,
        'BaseMoves' INTEGER NOT NULL DEFAULT 2,
        'BaseSightRange' INTEGER NOT NULL DEFAULT 2,
        'Combat' INTEGER NOT NULL DEFAULT 30,
        'RangedCombat' INTEGER NOT NULL DEFAULT 30,
        'Range' INTEGER NOT NULL DEFAULT 1,
        'NeunweltCombat' INTEGER NOT NULL DEFAULT 0,
        'NeunweltCD' INTEGER NOT NULL DEFAULT 10,
        'RareSkill' TEXT,
        'RareSkillCD' INTEGER,
        PRIMARY KEY(UnitName)
        FOREIGN KEY (Zone) REFERENCES Tags(Tag) ON DELETE CASCADE ON UPDATE CASCADE
        FOREIGN KEY (Legion) REFERENCES Tags(Tag) ON DELETE CASCADE ON UPDATE CASCADE
        FOREIGN KEY (UnitType1) REFERENCES Tags(Tag) ON DELETE CASCADE ON UPDATE CASCADE
        FOREIGN KEY (UnitType2) REFERENCES Tags(Tag) ON DELETE CASCADE ON UPDATE CASCADE
    );

    
--TRIGGERS
    CREATE TRIGGER CreateAlUnits AFTER INSERT ON AL_GreatUnitNames WHEN New.Ban = 0 BEGIN
        --
            INSERT INTO Types
                (Type, Kind) VALUES
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_1', 'KIND_PROMOTION'),
                ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'KIND_UNIT'),
                ('PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL', 'KIND_PROMOTION_CLASS'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_2', 'KIND_PROMOTION'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1', 'KIND_PROMOTION'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2', 'KIND_PROMOTION'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1', 'KIND_PROMOTION'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2', 'KIND_PROMOTION'),
                ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1', 'KIND_PROMOTION');
            INSERT INTO Tags
                (Tag, Vocabulary) VALUES
                ('CLASS_AL_'|| New.UnitName ||'_GREATNORMAL', 'ABILITY_CLASS');
            INSERT INTO TypeTags
                (Type, Tag) VALUES
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.UnitType1),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'CLASS_AL_LILY_GREAT_UNIT'),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'CLASS_AL_LILY'),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.Zone),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.Legion),
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.Garden);
            INSERT INTO Units
                (UnitType, BaseMoves, Cost, AdvisorType, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name, Description, PurchaseYield, PromotionClass, Combat, TraitType, RangedCombat, Range, CanTrain, CanRetreatWhenCaptured, Maintenance,StrategicResource) VALUES
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.BaseMoves, 1, 'ADVISOR_CONQUEST', New.BaseSightRange, 1, 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', 'LOC_UNIT_AL_'|| New.UnitName ||'_GREATNORMAL_NAME', 'LOC_UNIT_AL_'|| New.UnitName ||'_GREATNORMAL_DESCRIPTION', NULL, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL', New.Combat, NULL, New.RangedCombat, New.Range, 0, 1, 3,'RESOURCE_AL_MAGI');

            INSERT INTO UnitAiInfos
                (UnitType, AiType) VALUES
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'UNITTYPE_LAND_COMBAT');
            INSERT INTO UnitPromotionClasses
                (PromotionClassType, Name) VALUES
                    ('PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL', 'LOC_PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL_NAME');
            INSERT INTO UnitPromotions
                (UnitPromotionType, Name, Description, Level, Specialization, Column, PromotionClass) VALUES
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_1_NAME', '{LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_1_DESCRIPTION}{LOC_GREATNORMAL_PROMOTION_1_1}{LOC_GREATNORMAL_PROMOTION_1_2}', 1, NULL, 1, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_2', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_2_NAME', '{LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_2_DESCRIPTION}{LOC_GREATNORMAL_PROMOTION_1_1}{LOC_GREATNORMAL_PROMOTION_1_2}', 1, NULL, 3, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1_NAME', '{LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1_DESCRIPTION}{LOC_GREATNORMAL_PROMOTION_2}', 2, NULL, 1, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2_NAME', '{LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2_DESCRIPTION}{LOC_GREATNORMAL_PROMOTION_2}', 2, NULL, 3, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1_NAME', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1_DESCRIPTION', 3, NULL, 1, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2_NAME', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2_DESCRIPTION', 3, NULL, 3, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1_NAME', '{LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1_DESCRIPTION}{LOC_GREATNORMAL_PROMOTION_4}', 4, NULL, 2, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL');
            INSERT INTO UnitPromotionPrereqs
                (UnitPromotion, PrereqUnitPromotion) VALUES
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_1'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_1_2'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_1'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_2_2'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_1'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_3_2');
            INSERT INTO UnitRetreats_XP1
                (BuildingType, UnitType, UnitRetreatType) VALUES
                    ('BUILDING_PALACE', 'UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'UNIT_RETREAT_'|| New.UnitName ||'_TO_CAPITAL'),
                    ('BUILDING_AL_OHAKA', 'UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'UNIT_RETREAT_'|| New.UnitName ||'_TO_OHAKA'),
                    ('BUILDING_AL_SAKURA', 'UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'UNIT_RETREAT_'|| New.UnitName ||'_TO_SAKURA');

        INSERT INTO RequirementSets
            (RequirementSetId, RequirementSetType) VALUES

            ('REQSET_AL_'|| New.UnitName ||'_CHARM_GOOD', 'REQUIREMENTSET_TEST_ANY'),

            ('REQSET_AL_'|| New.UnitName ||'_RS', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName, 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_NOT_ADJACENT_'|| New.UnitName, 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_IS_'|| New.UnitName, 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING_HUGE', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING_HUGE', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_DEFFENDING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_ATTACKING', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_BAD', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_VERY_BAD', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL');
        --
            INSERT INTO RequirementSetRequirements
                (RequirementSetId, RequirementId) VALUES
                ('REQSET_AL_'|| New.UnitName ||'_RS', 'REQ_AL_'|| New.UnitName ||'_RS'),

                ('REQSET_AL_'|| New.UnitName ||'_CHARM_GOOD', 'REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL4'),
                ('REQSET_AL_'|| New.UnitName ||'_CHARM_GOOD', 'REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL3'),
                ('REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_BAD', 'REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL2'),
                ('REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_VERY_BAD', 'REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL1'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName, 'REQ_AL_UNIT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_NOT_ADJACENT_'|| New.UnitName, 'REQ_AL_UNIT_NOT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_IS_'|| New.UnitName, 'REQ_AL_UNIT_IS_'|| New.UnitName),
                ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_DEFFENDING', 'REQ_AL_UNIT_IS_'|| New.UnitName),
                ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_DEFFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),
                ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_ATTACKING', 'REQ_AL_UNIT_IS_'|| New.UnitName),
                ('REQSET_AL_UNIT_IS_'|| New.UnitName||'_AND_ATTACKING', 'REQ_AL_UNIT_IS_ATTACKER'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING', 'REQ_AL_UNIT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING', 'REQ_AL_UNIT_IS_ATTACKER'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING', 'REQ_AL_UNIT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING_HUGE', 'REQ_AL_UNIT_IS_DEFFENDER'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING_HUGE', 'REQ_AL_UNIT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_DEFFENDING_HUGE', 'REQ_OPPONENT_UNIT_IS_HUGE'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING_HUGE', 'REQ_AL_UNIT_IS_ATTACKER'),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING_HUGE', 'REQ_AL_UNIT_ADJACENT_'|| New.UnitName),
                ('REQSET_AL_UNIT_ADJACENT_'|| New.UnitName ||'_AND_ATTACKING_HUGE', 'REQ_OPPONENT_UNIT_IS_HUGE'),
                ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT_2_PLOT', 'REQ_AL_UNIT_IS_'|| New.UnitName),
                ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
                ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT', 'REQ_AL_UNIT_IS_'|| New.UnitName),
                ('REQSET_AL_GRANT_ADJACENT_'|| New.UnitName ||'_UNIT', 'REQ_AL_GRANT_TO_NEAR_UNITS');

            INSERT INTO Requirements
                (RequirementId, RequirementType, Inverse) VALUES
                ('REQ_AL_'|| New.UnitName ||'_RS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES',0),
                ('REQ_AL_PLOT_HAS_'|| New.UnitName , 'REQUIREMENT_PLOT_UNIT_TYPE_MATCHES',0),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_GOOD', 'REQUIREMENT_COLLECTION_ALL_MET',0),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL3', 'REQUIREMENT_PLOT_PROPERTY_MATCHES',0),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL4', 'REQUIREMENT_PLOT_PROPERTY_MATCHES',0),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL1', 'REQUIREMENT_PLOT_PROPERTY_MATCHES',0),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES',0),
                ('REQ_AL_UNIT_IS_'|| New.UnitName, 'REQUIREMENT_UNIT_TAG_MATCHES', 0),
                ('REQ_AL_UNIT_ADJACENT_'|| New.UnitName, 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
                ('REQ_AL_UNIT_NOT_ADJACENT_'|| New.UnitName, 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 1);

            INSERT INTO RequirementArguments
                (RequirementId, Name, Value) VALUES
                ('REQ_AL_'|| New.UnitName ||'_RS', 'PropertyName','RS_PLOT_'|| New.UnitName),
                ('REQ_AL_'|| New.UnitName ||'_RS', 'PropertyMinimum',1),

                ('REQ_AL_PLOT_HAS_'|| New.UnitName , 'UnitType','UNIT_AL_'|| New.UnitName ||'_GREATNORMAL'),
                ('REQ_AL_PLOT_HAS_'|| New.UnitName , 'LayerIndex',1),

                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL3', 'PropertyName',New.UnitName ||'_charm_break_level_3'),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL4', 'PropertyName',New.UnitName ||'_charm_break_level_4'),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL3', 'PropertyMinimum',1),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL4', 'PropertyMinimum',1),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL1', 'PropertyName',New.UnitName ||'_charm_break_level_1'),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL2', 'PropertyName',New.UnitName ||'_charm_break_level_2'),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL1', 'PropertyMinimum',1),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL2', 'PropertyMinimum',1),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_GOOD', 'CollectionType','COLLECTION_OWNER'),
                ('REQ_AL_'|| New.UnitName ||'_CHARM_GOOD', 'RequirementSetId','REQSET_AL_'|| New.UnitName ||'_CHARM_GOOD'),
                ('REQ_AL_UNIT_ADJACENT_'|| New.UnitName, 'Tag', 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                ('REQ_AL_UNIT_NOT_ADJACENT_'|| New.UnitName, 'Tag', 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                ('REQ_AL_UNIT_IS_'|| New.UnitName, 'Tag', 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL');

            INSERT INTO BuildingModifiers
                (BuildingType, ModifierId) VALUES
                ('BUILDING_AL_VISUAL_CHARM', 'MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_BAD'),
                ('BUILDING_AL_VISUAL_CHARM', 'MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_VERY_BAD');

            INSERT INTO Modifiers
                (ModifierId, ModifierType, OwnerRequirementSetId,SubjectRequirementSetId) VALUES
                ('MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_BAD', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER','REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_BAD', 'REQSET_AL_UNIT_IS_'|| New.UnitName),
                ('MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_VERY_BAD', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER','REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_VERY_BAD', 'REQSET_AL_UNIT_IS_'|| New.UnitName);

            INSERT INTO Modifiers
                (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
                ('MOD_'|| New.UnitName ||'_CHARM_BAD', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_'|| New.UnitName),
                ('MOD_'|| New.UnitName ||'_CHARM_VERY_BAD', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_'|| New.UnitName);

            INSERT INTO ModifierArguments
                (ModifierId, Name, Value) VALUES
                ('MOD_'|| New.UnitName ||'_CHARM_BAD', 'Amount', -10),
                ('MOD_'|| New.UnitName ||'_CHARM_VERY_BAD', 'Amount', -20),
                ('MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_BAD', 'ModifierId', 'MOD_'|| New.UnitName ||'_CHARM_BAD'),
                ('MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_VERY_BAD', 'ModifierId', 'MOD_'|| New.UnitName ||'_CHARM_VERY_BAD');

            INSERT INTO ModifierStrings
                (ModifierId, Context, Text) VALUES
                ('MOD_'|| New.UnitName ||'_CHARM_BAD', 'Preview', '{1_Amount} {LOC_AL_CHARM_BROKEN_2}'),
                ('MOD_'|| New.UnitName ||'_CHARM_VERY_BAD', 'Preview', '{1_Amount} {LOC_AL_CHARM_BROKEN_1}');

            INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
                SELECT 'REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'REQUIREMENTSET_TEST_ALL'
                FROM property_charm_values;

            INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
                SELECT 'REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'REQ_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n
                FROM property_charm_values;
            
            INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
                SELECT 'REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'REQ_AL_'|| New.UnitName ||'_CHARM_BREAK_LEVEL4'
                FROM property_charm_values;

            INSERT INTO Requirements (RequirementId, RequirementType)
                SELECT 'REQ_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'REQUIREMENT_PLOT_PROPERTY_MATCHES'
                FROM property_charm_values;

            INSERT INTO RequirementArguments (RequirementId, Name, Value)
                SELECT 'REQ_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'PropertyName', New.UnitName ||'_neunwelt_combat_'|| n
                FROM property_charm_values;

            INSERT INTO RequirementArguments (RequirementId, Name, Value)
                SELECT 'REQ_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'PropertyMinimum', 1
                FROM property_charm_values;

            INSERT INTO BuildingModifiers (BuildingType, ModifierId)
                SELECT 'BUILDING_AL_VISUAL_CHARM', 'MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_'|| n
                FROM property_charm_values;

            INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId)
                SELECT 'MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_'|| n, 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_'|| New.UnitName ||'_PROPERTY_CHARM_'|| n, 'REQSET_AL_UNIT_IS_'|| New.UnitName
                FROM property_charm_values;

            INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
                SELECT 'MOD_'|| New.UnitName ||'_CHARM_'|| n, 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_'|| New.UnitName
                FROM property_charm_values;

            INSERT INTO ModifierArguments (ModifierId, Name, Value)
                SELECT 'MOD_'|| New.UnitName ||'_CHARM_'|| n, 'Amount', n
                FROM property_charm_values;

            INSERT INTO ModifierArguments (ModifierId, Name, Value)
                SELECT 'MOD_BUILDING_AL_CHARM_'|| New.UnitName ||'_'|| n, 'ModifierId', 'MOD_'|| New.UnitName ||'_CHARM_'|| n
                FROM property_charm_values;

            INSERT INTO ModifierStrings (ModifierId, Context, Text)
                SELECT 'MOD_'|| New.UnitName ||'_CHARM_'|| n, 'Preview', '+{1_Amount} {LOC_CHARM_NAME_'|| New.UnitName ||'} {LOC_AL_CHARM_BROKEN_4}'
                FROM property_charm_values;
            END;

            CREATE TRIGGER AddNekosukiClass AFTER INSERT ON AL_GreatUnitNames WHEN New.Nekosuki = 1 BEGIN
                INSERT INTO TypeTags
                    (Type, Tag) VALUES
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', 'CLASS_AL_NEKOSUKI');
            END;

            CREATE TRIGGER AddSecondClass AFTER INSERT ON AL_GreatUnitNames WHEN New.HasUnitType2 = 1 BEGIN
                INSERT INTO TypeTags
                    (Type, Tag) VALUES
                    ('UNIT_AL_'|| New.UnitName ||'_GREATNORMAL', New.UnitType2);
            END;

            CREATE TRIGGER AddMagiConsume AFTER INSERT ON TypeTags WHEN New.Tag = 'CLASS_AL_LILY_GREAT_UNIT' BEGIN
                INSERT INTO Units_XP2
                    (UnitType, ResourceCost, ResourceMaintenanceType, ResourceMaintenanceAmount,CanFormMilitaryFormation, CanEarnExperience) VALUES
                    (New.Type, 1, 'RESOURCE_AL_MAGI', 1,0,1);
            END;

            CREATE TRIGGER AddYuriPromotions AFTER INSERT ON AL_GreatUnitNames WHEN New.UnitName = 'YURI' BEGIN
                INSERT INTO Types
                    (Type, Kind) VALUES
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_6_1', 'KIND_PROMOTION'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1', 'KIND_PROMOTION');
                INSERT INTO UnitPromotions
                    (UnitPromotionType, Name, Description, Level, Specialization, Column, PromotionClass) VALUES
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_6_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_6_1_NAME', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_6_1_DESCRIPTION', 6, NULL, 1, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1_NAME', 'LOC_PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1_DESCRIPTION', 5, NULL, 1, 'PROMOTION_CLASS_AL_'|| New.UnitName ||'_GREATNORMAL');
                INSERT INTO UnitPromotionPrereqs
                    (UnitPromotion, PrereqUnitPromotion) VALUES
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_6_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1'),
                    ('PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_5_1', 'PROMOTION_AL_'|| New.UnitName ||'_GREATNORMAL_4_1');
            END;

            CREATE TRIGGER AddRsABL AFTER INSERT ON AL_GreatUnitNames WHEN New.RareSkillCD > 0 BEGIN
                INSERT INTO Types
                    (Type, Kind) VALUES
                    ('ABL_AL_RS_'|| New.UnitName, 'KIND_ABILITY');
                INSERT INTO TypeTags
                    (Type, Tag) VALUES
                    ('ABL_AL_RS_'|| New.UnitName, 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL');
                INSERT INTO UnitAbilities
                    (UnitAbilityType, Name, Description, Inactive) VALUES
                    ('ABL_AL_RS_'|| New.UnitName, 'LOC_RS_NAME_'|| New.RareSkill, '{LOC_RS_EFFECT_'|| New.RareSkill ||'} {LOC_RS_EFFECT_'|| New.UnitName ||'}', 1);
            END;

            CREATE TRIGGER AddRsDebuffABL AFTER INSERT ON AL_GreatUnitNames WHEN New.RareSkill = 'PhaseTranscendence' BEGIN
                INSERT INTO Types
                    (Type, Kind) VALUES
                    ('ABL_AL_RS_DEBUFF_'|| New.UnitName, 'KIND_ABILITY');
                INSERT INTO TypeTags
                    (Type, Tag) VALUES
                    ('ABL_AL_RS_DEBUFF_'|| New.UnitName, 'CLASS_AL_'|| New.UnitName ||'_GREATNORMAL');
                INSERT INTO UnitAbilities
                    (UnitAbilityType, Name, Description, Inactive) VALUES
                    ('ABL_AL_RS_DEBUFF_'|| New.UnitName, '{LOC_RS_DEBUFF_NAME_'|| New.RareSkill, '{LOC_RS_DEBUFF_EFFECT_'|| New.RareSkill ||'} {LOC_RS_DEBUFF_EFFECT_'|| New.UnitName ||'}', 1);
            END;

            CREATE TRIGGER AddRsModifier AFTER INSERT ON AL_GreatUnitNames BEGIN
                INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) SELECT 'ABL_AL_RS_'|| New.UnitName, RsEffect FROM AL_RsEffects WHERE RareSkill = New.RareSkill;
            END;

            CREATE TRIGGER AddRsDebuffModifier AFTER INSERT ON AL_GreatUnitNames BEGIN
                INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) SELECT 'ABL_AL_RS_DEBUFF_'|| New.UnitName, RsEffect FROM AL_RsDebuffEffects WHERE RareSkill = New.RareSkill;
            END;

    INSERT INTO AL_GreatUnitNames
            (UnitName,  Ban,    Zone,           Legion,                 Garden,                 Nekosuki,   UnitType1,          HasUnitType2,   UnitType2,      BaseMoves,  BaseSightRange, Combat, RangedCombat,   Range,  NeunweltCombat, RareSkill,          RareSkillCD ) 
     VALUES ('FUMI',    0,      'CLASS_AL_BZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_RANGED',     1,              'CLASS_RECON',  3,          5,              20,     10,             2,      4,              'HawkEye',          5        ),
            ('YURI',    0,      'CLASS_AL_BZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   1,          'CLASS_MELEE',      1,              'CLASS_RECON',  3,          4,              15,     16,             2,      4,              NULL,               NULL        ),
            ('YUJIA',   0,      'CLASS_AL_BZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   1,          'CLASS_RANGED',     0,              NULL,           2,          4,              20,     30,             3,      6,              'HeavensScales',    3        ),
            ('KANAHO',  0,      'CLASS_AL_TZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_MELEE',      0,              NULL,           2,          2,              25,     27,             2,      6,              'Register',    3        ),
            ('TAKANE',  0,      'CLASS_AL_TZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_MELEE',      0,              NULL,           3,          2,              27,     25,             2,      6,              'ZenoneParadoxa',    3        ),
            ('RIRI',    0,      'CLASS_AL_BZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_RANGED',     0,              NULL,           2,          2,              21,     20,             2,      6,              'Laplace',          3        ),
            ('SHENLIN', 0,      'CLASS_AL_TZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_MELEE',      0,              NULL,           2,          2,              25,     24,             2,      6,              'Testament',          3        ),
            ('YUYU',    0,      'CLASS_AL_AZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_MELEE',      0,              NULL,           2,          2,              30,     20,             2,      7,              'LunaticTranser',   3           ),
            ('MAI',     0,      'CLASS_AL_AZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   1,          'CLASS_MELEE',      0,              NULL,           3,          2,              27,     22,             2,      7,              'ShrunkenLand',          3        ),
            ('TADUSA',  0,      'CLASS_AL_AZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   1,          'CLASS_MELEE',      0,              NULL,           2,          2,              30,     20,             2,      5,              'Phantasm',          3        ),
            ('KAEDE',   0,      'CLASS_AL_TZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_RANGED',     0,              NULL,           2,          2,              26,     25,             3,      6,              'Register',         3        ),
            ('MOYU',    0,      'CLASS_AL_TZ',  'CLASS_AL_NO_LEGION',   'CLASS_AL_YURIGAOKA',   0,          'CLASS_RANGED',     0,              NULL,           2,          2,              20,     15,             2,      5,              'TruthOfTheWorld',          3        ),
            ('HIMEKA',  0,      'CLASS_AL_AZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_MELEE',      0,              NULL,           2,          2,              20,     19,             2,      4,              'TruthOfTheWorld',          3        ),
            ('AKARI',   0,      'CLASS_AL_BZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_RANGED',     0,              NULL,           3,          3,              16,     25,             3,      4,              'HeavensScales',          3        ),
            ('HARUNA',  0,      'CLASS_AL_AZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_MELEE',      1,          'CLASS_AL_SEITOKAI',3,          3,              25,     18,             2,      5,              'PhaseTranscendence',          1        ),
            
            ('FUJINO',   0,      'CLASS_AL_BZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_RANGED',     0,              NULL,           3,          3,              16,     25,             3,      4,              'HeavensScales',          3        ),
            ('AKEHI',    0,      'CLASS_AL_BZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_RANGED',     0,              NULL,           3,          3,              16,     25,             3,      4,              'HeavensScales',          3        ),
            ('SUZUME',   0,      'CLASS_AL_BZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_RANGED',     0,              NULL,           3,          3,              16,     25,             3,      4,              'HeavensScales',          3        ),
            
            ('KUREHA',  0,      'CLASS_AL_BZ',  'CLASS_AL_GRANEPLE',    'CLASS_AL_KANBA',       0,          'CLASS_RANGED',     0,              NULL,           3,          3,              18,     20,             2,      4,              'Testament',          3        ),
            ('MILIAM',  0,      'CLASS_AL_AZ',  'CLASS_AL_RADGRID',     'CLASS_AL_YURIGAOKA',   0,          'CLASS_RANGED',     0,              NULL,           2,          2,              27,     20,             1,      5,              'PhaseTranscendence',          1        );

    UPDATE Units_XP2 SET CanEarnExperience = 0 WHERE UnitType = 'UNIT_AL_YURI_GREATNORMAL';
    UPDATE Units SET BuildCharges = 99 WHERE UnitType = 'UNIT_AL_AKARI_GREATNORMAL';
    UPDATE Units SET FormationClass = 'FORMATION_CLASS_CIVILIAN' WHERE UnitType = 'UNIT_AL_AKARI_GREATNORMAL';

    

--————————————UNITS————————————
    INSERT INTO TypeTags
        (Type, Tag) VALUES
            ('UNIT_AL_KANBALILY', 'CLASS_LANDCIVILIAN'),
            ('UNIT_AL_KANBALILY', 'CLASS_AL_LILY'),
            ('UNIT_AL_KANBALILY', 'CLASS_RANGED'),
            ('UNIT_AL_KANBALILY', 'CLASS_BUILDER'),
            ('UNIT_AL_NEKO', 'CLASS_LANDCIVILIAN'),
            ('UNIT_AL_NEKO', 'CLASS_AL_NEKO');
        
    

    INSERT INTO Units
        (UnitType, BaseMoves, Cost, AdvisorType, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name, Description, PurchaseYield, PromotionClass, Combat, TraitType, RangedCombat, Range, CanTrain, CanRetreatWhenCaptured, Maintenance,StrategicResource) VALUES
        -- rose
        ('UNIT_AL_NEKO', 3, 1, 'ADVISOR_CONQUEST', 2, 1, 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', 'LOC_UNIT_AL_NEKO_NAME', 'LOC_UNIT_AL_NEKO_DESCRIPTION', NULL, 'PROMOTION_CLASS_AL_NEKO', 0, NULL, 0, 0, 0, 1, 0,NULL);
    INSERT INTO Units
        (UnitType, BaseMoves, Cost, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name, Description, CostProgressionModel, CostProgressionParam1, PurchaseYield, Combat, TraitType, RangedCombat, Range, CanRetreatWhenCaptured, Maintenance,StrategicResource,BuildCharges) VALUES
        -- rose
        ('UNIT_AL_KANBALILY', 3, 75, 2, 0, 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', 'LOC_UNIT_AL_KANBALILY_NAME', 'LOC_TRAIT_CIVILIZATION_AL_KANBA_LILY_DESCRIPTION', 'COST_PROGRESSION_PREVIOUS_COPIES', 6,'YIELD_FAITH', 25, 'TRAIT_CIVILIZATION_AL_KANBA_LILY', 25, 2, 1, 1,'RESOURCE_AL_MAGI',3);
    INSERT INTO UnitAiInfos
        (UnitType, AiType) VALUES
        -- rose
            ('UNIT_AL_NEKO', 'UNITTYPE_CIVILIAN'),
            ('UNIT_AL_KANBALILY', 'UNITAI_BUILD'),
            ('UNIT_AL_KANBALILY', 'UNITTYPE_CIVILIAN');

    INSERT INTO UnitReplaces
        (CivUniqueUnitType, ReplacesUnitType) VALUES
        -- rose
            ('UNIT_AL_KANBALILY', 'UNIT_BUILDER');

    INSERT INTO Units_XP2
            (UnitType, ResourceCost, ResourceMaintenanceType, ResourceMaintenanceAmount,CanFormMilitaryFormation, CanEarnExperience) VALUES
            ('UNIT_AL_KANBALILY', 5, 'RESOURCE_AL_MAGI', 1,0,0);

    INSERT OR REPLACE INTO  Improvement_ValidBuildUnits (ImprovementType, UnitType)
        SELECT ImprovementType, 'UNIT_AL_KANBALILY' FROM Improvement_ValidBuildUnits WHERE UnitType IN ('UNIT_BUILDER', 'UNIT_MILITARY_ENGINEER');



    INSERT OR REPLACE INTO Route_ValidBuildUnits (RouteType, UnitType)
        SELECT RouteType, 'UNIT_AL_KANBALILY'	FROM Route_ValidBuildUnits WHERE UnitType = 'UNIT_MILITARY_ENGINEER';

    INSERT INTO UnitPromotionClasses
        (PromotionClassType, Name) VALUES
            ('PROMOTION_CLASS_AL_NEKO', 'LOC_PROMOTION_CLASS_AL_NEKO_GREATNORMAL_NAME');

    INSERT INTO UnitPromotions
        (UnitPromotionType, Name, Description, Level, Specialization, Column, PromotionClass) VALUES            
        --NEKO
            ('PROMOTION_AL_NEKO_1', 'LOC_PROMOTION_AL_NEKO_1_NAME', 'LOC_PROMOTION_AL_NEKO_1_DESCRIPTION', 1, NULL, 1, 'PROMOTION_CLASS_AL_NEKO'),
            ('PROMOTION_AL_NEKO_2', 'LOC_PROMOTION_AL_NEKO_2_NAME', 'LOC_PROMOTION_AL_NEKO_2_DESCRIPTION', 1, NULL, 3, 'PROMOTION_CLASS_AL_NEKO'),
            ('PROMOTION_AL_NEKO_3', 'LOC_PROMOTION_AL_NEKO_3_NAME', 'LOC_PROMOTION_AL_NEKO_3_DESCRIPTION', 2, NULL, 1, 'PROMOTION_CLASS_AL_NEKO'),
            ('PROMOTION_AL_NEKO_4', 'LOC_PROMOTION_AL_NEKO_4_NAME', 'LOC_PROMOTION_AL_NEKO_4_DESCRIPTION', 2, NULL, 3, 'PROMOTION_CLASS_AL_NEKO'),
            ('PROMOTION_AL_NEKO_5', 'LOC_PROMOTION_AL_NEKO_5_NAME', 'LOC_PROMOTION_AL_NEKO_5_DESCRIPTION', 3, NULL, 1, 'PROMOTION_CLASS_AL_NEKO');

    INSERT INTO UnitPromotionPrereqs
        (UnitPromotion, PrereqUnitPromotion) VALUES
        --NEKO
            ('PROMOTION_AL_NEKO_3', 'PROMOTION_AL_NEKO_1'),
            ('PROMOTION_AL_NEKO_4', 'PROMOTION_AL_NEKO_2'),
            ('PROMOTION_AL_NEKO_5', 'PROMOTION_AL_NEKO_3'),
            ('PROMOTION_AL_NEKO_5', 'PROMOTION_AL_NEKO_4');
--Promotions
    INSERT INTO UnitPromotionModifiers
            (UnitPromotionType,                   ModifierId) VALUES
            --
            --HARUNA
                ('PROMOTION_AL_HARUNA_GREATNORMAL_1_1', 'MOD_AL_HARUNA_GREATNORMAL_1_1_1'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_1_1', 'MOD_AL_HARUNA_GREATNORMAL_1_1_2'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_1_2', 'MOD_AL_HARUNA_GREATNORMAL_1_2_1'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_1_2', 'MOD_AL_HARUNA_GREATNORMAL_1_2_2'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_2_1', 'MOD_AL_HARUNA_GREATNORMAL_2_1_1'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_2_1', 'MOD_AL_HARUNA_GREATNORMAL_2_1_2'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_2_2', 'MOD_AL_HARUNA_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_HARUNA_GREATNORMAL_2_2', 'MOD_AL_HARUNA_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_HARUNA_GREATNORMAL_3_1', 'MOD_AL_HARUNA_GREATNORMAL_3_1_1'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_3_2', 'MOD_AL_HARUNA_GREATNORMAL_3_2_1'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_3_2', 'MOD_AL_HARUNA_GREATNORMAL_3_2_2'), 
                ('PROMOTION_AL_HARUNA_GREATNORMAL_4_1', 'MOD_AL_HARUNA_GREATNORMAL_4_1_1'), 
        -----------------------------------------------------------------------
            --KUREHA
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_1', 'MOD_AL_KUREHA_GREATNORMAL_1_1_1'), 
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_1', 'MOD_AL_KUREHA_GREATNORMAL_1_1_2'),  
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_1', 'MOD_AL_KUREHA_GREATNORMAL_1_1_3'),
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_2', 'MOD_AL_KUREHA_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_2', 'MOD_AL_KUREHA_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_KUREHA_GREATNORMAL_1_2', 'MOD_AL_KUREHA_GREATNORMAL_1_2_3'),
                ('PROMOTION_AL_KUREHA_GREATNORMAL_2_1', 'MOD_AL_KUREHA_GREATNORMAL_2_1_1'), 
                ('PROMOTION_AL_KUREHA_GREATNORMAL_2_1', 'MOD_AL_KUREHA_GREATNORMAL_2_1_2'),  
                ('PROMOTION_AL_KUREHA_GREATNORMAL_2_1', 'MOD_AL_KUREHA_GREATNORMAL_2_1_3'),
                ('PROMOTION_AL_KUREHA_GREATNORMAL_3_1', 'MOD_AL_KUREHA_GREATNORMAL_3_1_1'), 
                ('PROMOTION_AL_KUREHA_GREATNORMAL_3_1', 'MOD_AL_KUREHA_GREATNORMAL_3_1_2'),  
                ('PROMOTION_AL_KUREHA_GREATNORMAL_3_1', 'MOD_AL_KUREHA_GREATNORMAL_3_1_3'),
            --HIMEKA
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_1_1', 'MOD_AL_HIMEKA_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_1_1', 'MOD_AL_HIMEKA_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_1_1', 'MOD_AL_HIMEKA_GREATNORMAL_1_1_3'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_1_2', 'MOD_AL_HIMEKA_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_1_2', 'MOD_AL_HIMEKA_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_2_1', 'MOD_AL_HIMEKA_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_2_1', 'MOD_AL_HIMEKA_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_2_1', 'MOD_AL_HIMEKA_GREATNORMAL_2_1_3'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_2_2', 'MOD_AL_HIMEKA_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_2_2', 'MOD_AL_HIMEKA_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_3_1', 'MOD_AL_HIMEKA_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_3_1', 'MOD_AL_HIMEKA_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_3_2', 'MOD_AL_HIMEKA_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_HIMEKA_GREATNORMAL_3_2', 'MOD_AL_HIMEKA_GREATNORMAL_3_2_2'),
            --AKARI
                ('PROMOTION_AL_AKARI_GREATNORMAL_1_1', 'MOD_IGNORE_TERRAIN_COST'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_1_1', 'MOD_AL_AKARI_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_1_1', 'MOD_AL_AKARI_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_1_2', 'MOD_AL_AKARI_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_2_1', 'MOD_AL_AKARI_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_2_1', 'MOD_AL_AKARI_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_2_2', 'MOD_AL_AKARI_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_2_2', 'MOD_AL_AKARI_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_3_1', 'MOD_AL_AKARI_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_3_1', 'MOD_AL_AKARI_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_3_2', 'MOD_AL_AKARI_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_AKARI_GREATNORMAL_3_2', 'MOD_AL_AKARI_GREATNORMAL_3_2_2'),
        
            --TAKANE
                ('PROMOTION_AL_TAKANE_GREATNORMAL_1_1', 'MOD_AL_TAKANE_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_1_1', 'MOD_AL_TAKANE_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_1_2', 'MOD_AL_TAKANE_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_1_2', 'MOD_AL_TAKANE_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_1_2', 'MOD_AL_TAKANE_GREATNORMAL_1_2_3'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_2_1', 'NIHANG_NO_WOUNDED_PENALTY'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_2_1', 'MOD_AL_TAKANE_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_3_1', 'MOD_AL_TAKANE_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_3_1', 'MOD_AL_TAKANE_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_3_1', 'MOD_AL_TAKANE_GREATNORMAL_3_1_3'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_3_2', 'MOD_AL_TAKANE_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_3_2', 'MOD_AL_TAKANE_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_TAKANE_GREATNORMAL_4_1', 'MOD_AL_TAKANE_GREATNORMAL_4_1_1'),
            --KANAHO
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_1', 'MOD_AL_KANAHO_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_1', 'MOD_AL_KANAHO_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_1', 'MOD_AL_KANAHO_GREATNORMAL_1_1_3'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_2', 'MOD_AL_KANAHO_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_2', 'MOD_AL_KANAHO_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_1_2', 'MOD_AL_KANAHO_GREATNORMAL_1_2_3'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_2_1', 'MOD_AL_KANAHO_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_2_1', 'MOD_AL_KANAHO_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_2_2', 'MOD_AL_KANAHO_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_2_2', 'MOD_AL_KANAHO_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_1', 'MOD_AL_KANAHO_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_1', 'MOD_AL_KANAHO_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_1', 'MOD_AL_KANAHO_GREATNORMAL_3_1_3'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_2', 'MOD_AL_KANAHO_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_2', 'MOD_AL_KANAHO_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_3_2', 'MOD_AL_KANAHO_GREATNORMAL_3_2_3'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_4_1', 'MOD_AL_KANAHO_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_KANAHO_GREATNORMAL_4_1', 'MOD_AL_KANAHO_GREATNORMAL_4_1_2'),
        
            --YURI
                ('PROMOTION_AL_YURI_GREATNORMAL_1_1', 'MOD_AL_YURI_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_1_1', 'MOD_AL_YURI_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_1_1', 'MOD_AL_YURI_GREATNORMAL_1_1_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_1_2', 'MOD_AL_YURI_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_1_2', 'MOD_AL_YURI_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_1_2', 'MOD_AL_YURI_GREATNORMAL_1_2_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_1', 'MOD_AL_YURI_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_1', 'MOD_AL_YURI_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_1', 'MOD_AL_YURI_GREATNORMAL_2_1_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_2', 'MOD_AL_YURI_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_2', 'MOD_AL_YURI_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_2_2', 'MOD_AL_YURI_GREATNORMAL_2_2_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_1', 'MOD_AL_YURI_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_1', 'MOD_AL_YURI_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_1', 'MOD_AL_YURI_GREATNORMAL_3_1_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_2', 'MOD_AL_YURI_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_2', 'MOD_AL_YURI_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_3_2', 'MOD_AL_YURI_GREATNORMAL_3_2_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_4_1', 'MOD_AL_YURI_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_4_1', 'MOD_AL_YURI_GREATNORMAL_4_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_4_1', 'MOD_AL_YURI_GREATNORMAL_4_1_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_5_1', 'MOD_AL_YURI_GREATNORMAL_5_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_5_1', 'MOD_AL_YURI_GREATNORMAL_5_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_5_1', 'MOD_AL_YURI_GREATNORMAL_5_1_3'),
                ('PROMOTION_AL_YURI_GREATNORMAL_6_1', 'MOD_AL_YURI_GREATNORMAL_6_1_1'),
                ('PROMOTION_AL_YURI_GREATNORMAL_6_1', 'MOD_AL_YURI_GREATNORMAL_6_1_2'),
                ('PROMOTION_AL_YURI_GREATNORMAL_6_1', 'MOD_AL_YURI_GREATNORMAL_6_1_3'),
            --MOYU
                ('PROMOTION_AL_MOYU_GREATNORMAL_1_1', 'MOD_AL_MOYU_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_MOYU_GREATNORMAL_2_1', 'MOD_AL_MOYU_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_MOYU_GREATNORMAL_2_1', 'MOD_AL_MOYU_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_MOYU_GREATNORMAL_3_1', 'MOD_AL_MOYU_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_MOYU_GREATNORMAL_3_1', 'MOD_AL_MOYU_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_MOYU_GREATNORMAL_4_1', 'MOD_AL_MOYU_GREATNORMAL_4_1_1'),
            --MILIAM
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_1', 'MOD_AL_MILIAM_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_3'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_4'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_5'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_6'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_1_2', 'MOD_AL_MILIAM_GREATNORMAL_1_2_7'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_2_2', 'MOD_AL_MILIAM_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_2_2', 'MOD_AL_MILIAM_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_3_1', 'MOD_AL_MILIAM_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_3_1', 'MOD_AL_MILIAM_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_3_2', 'MOD_AL_MILIAM_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_3_2', 'MOD_AL_MILIAM_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_MILIAM_GREATNORMAL_3_2', 'MOD_AL_MILIAM_GREATNORMAL_3_2_3'),

            --yujia
                ('PROMOTION_AL_YUJIA_GREATNORMAL_1_1', 'MOD_AL_YUJIA_GREATNORMAL_1_1_0'),
                ('PROMOTION_AL_YUJIA_GREATNORMAL_1_2', 'MOD_AL_YUJIA_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_YUJIA_GREATNORMAL_1_2', 'MOD_AL_YUJIA_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_YUJIA_GREATNORMAL_2_2', 'MOD_AL_YUJIA_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_YUJIA_GREATNORMAL_2_2', 'MOD_AL_YUJIA_GREATNORMAL_2_2_2'),
            --mai
                ('PROMOTION_AL_MAI_GREATNORMAL_1_1', 'MOD_AL_MAI_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_MAI_GREATNORMAL_1_1', 'MOD_AL_MAI_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_MAI_GREATNORMAL_2_1', 'MOD_AL_MAI_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_MAI_GREATNORMAL_2_1', 'MOD_AL_MAI_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_MAI_GREATNORMAL_2_1', 'MOD_AL_MAI_GREATNORMAL_2_1_3'),
                ('PROMOTION_AL_MAI_GREATNORMAL_2_2', 'MOD_AL_MAI_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_MAI_GREATNORMAL_3_1', 'MOD_AL_MAI_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_MAI_GREATNORMAL_3_1', 'MOD_AL_MAI_GREATNORMAL_3_1_3'),
                ('PROMOTION_AL_MAI_GREATNORMAL_3_1', 'MOD_AL_MAI_GREATNORMAL_3_1_4'),
                ('PROMOTION_AL_MAI_GREATNORMAL_3_2', 'MOD_AL_MAI_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_MAI_GREATNORMAL_3_2', 'MOD_AL_MAI_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_MAI_GREATNORMAL_4_1', 'MOD_AL_MAI_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_MAI_GREATNORMAL_4_1', 'MOD_AL_MAI_GREATNORMAL_4_1_2'),
                ('PROMOTION_AL_MAI_GREATNORMAL_4_1', 'MOD_AL_MAI_GREATNORMAL_4_1_3'),
                ('PROMOTION_AL_MAI_GREATNORMAL_4_1', 'MOD_AL_MAI_GREATNORMAL_4_1_4'),
            --fumi
                ('PROMOTION_AL_FUMI_GREATNORMAL_1_1', 'MOD_AL_FUMI_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_1_2', 'MOD_AL_FUMI_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_2_1', 'MOD_AL_FUMI_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_2_2', 'MOD_AL_FUMI_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_2_2', 'MOD_AL_FUMI_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_3_1', 'MOD_AL_FUMI_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_3_1', 'MOD_AL_FUMI_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_3_1', 'CAMOUFLAGE_STEALTH'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_3_2', 'SENTRY_SEE_THROUGH_FEATURES'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_3_2', 'MOD_MOVE_AFTER_ATTACKING'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_4_1', 'MOD_AL_FUMI_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_4_1', 'MOD_AL_FUMI_GREATNORMAL_4_1_2'),
                ('PROMOTION_AL_FUMI_GREATNORMAL_4_1', 'NIHANG_NO_WOUNDED_PENALTY'),
            --yuyu
                ('PROMOTION_AL_YUYU_GREATNORMAL_1_1', 'MOD_AL_YUYU_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_1_1', 'MOD_AL_YUYU_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_1_2', 'MOD_AL_YUYU_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_1_2', 'MOD_AL_YUYU_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_1_2', 'NIHANG_NO_WOUNDED_PENALTY'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_2_1', 'MOD_AL_YUYU_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_2_1', 'MOD_IGNORE_TERRAIN_COST'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_2_2', 'MOD_AL_YUYU_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_3_1', 'MOD_AL_YUYU_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_3_1', 'MOD_AL_YUYU_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_3_2', 'MOD_AL_YUYU_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_3_2', 'MOD_AL_YUYU_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_YUYU_GREATNORMAL_4_1', 'MOD_AL_YUYU_GREATNORMAL_4_1_1'),
            --kaede
                ('PROMOTION_AL_KAEDE_GREATNORMAL_1_1','MOD_AL_KAEDE_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_1_1','MOD_AL_KAEDE_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_1_2','MOD_AL_KAEDE_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_1_2','MOD_AL_KAEDE_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_2_1','MOD_AL_KAEDE_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_2_1','MOD_AL_KAEDE_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_2_2','MOD_AL_KAEDE_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_2_2','MOD_AL_KAEDE_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_3_1','MOD_AL_KAEDE_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_3_1','MOD_AL_KAEDE_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_3_2','MOD_AL_KAEDE_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_3_2','MOD_AL_KAEDE_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_4_1','MOD_AL_KAEDE_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_KAEDE_GREATNORMAL_4_1','MOD_AL_KAEDE_GREATNORMAL_4_1_2'),
            --RIRI
                ('PROMOTION_AL_RIRI_GREATNORMAL_1_1','MOD_AL_RIRI_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_1_1','MOD_AL_RIRI_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_1_2','MOD_AL_RIRI_GREATNORMAL_1_2_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_1_2','MOD_AL_RIRI_GREATNORMAL_1_2_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_2_1','MOD_AL_RIRI_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_2_1','MOD_AL_RIRI_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_2_2','MOD_AL_RIRI_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_2_2','MOD_AL_RIRI_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_3_1','MOD_AL_RIRI_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_3_1','MOD_AL_RIRI_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_3_2','MOD_AL_RIRI_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_3_2','MOD_AL_RIRI_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_RIRI_GREATNORMAL_4_1','MOD_AL_RIRI_GREATNORMAL_4_1_1'),
            --TADUSA
                ('PROMOTION_AL_TADUSA_GREATNORMAL_1_1','MOD_AL_TADUSA_GREATNORMAL_1_1_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_1_1','MOD_AL_TADUSA_GREATNORMAL_1_1_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_2_1','NIHANG_NO_WOUNDED_PENALTY'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_2_1','MOD_AL_TADUSA_GREATNORMAL_2_1_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_2_1','MOD_AL_TADUSA_GREATNORMAL_2_1_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_2_2','MOD_AL_TADUSA_GREATNORMAL_2_2_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_2_2','MOD_AL_TADUSA_GREATNORMAL_2_2_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_3_1','MOD_AL_TADUSA_GREATNORMAL_3_1_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_3_1','MOD_AL_TADUSA_GREATNORMAL_3_1_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_3_2','MOD_AL_TADUSA_GREATNORMAL_3_2_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_3_2','MOD_AL_TADUSA_GREATNORMAL_3_2_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_4_1','MOD_AL_TADUSA_GREATNORMAL_4_1_1'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_4_1','MOD_AL_TADUSA_GREATNORMAL_4_1_2'),
                ('PROMOTION_AL_TADUSA_GREATNORMAL_4_1','MOD_AL_TADUSA_GREATNORMAL_4_1_3'),
            --NEKO
                ('PROMOTION_AL_NEKO_2','MOD_AL_NEKO_1_2_1'),
                ('PROMOTION_AL_NEKO_4','MOD_AL_NEKO_2_2_1'),
                ('PROMOTION_AL_NEKO_5','MOD_AL_NEKO_3_1_1');
    


    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent) VALUES
            --
            --HARUNA
                ('MOD_AL_HARUNA_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_TAKANE', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TAKANE_AND_ATTACKING', 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_KANAHO', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KANAHO_AND_DEFFENDING', 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_HUGE', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_GARRISON_HUGE', 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REDCOAT_PLOT_IS_FOREIGN_CONTINENT', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_2_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER', 'REQSET_AL_UNIT_ADJACENT_AKEHI', 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_SEITOKAI_UNIT', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_HARUNA_UNIT', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_3_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_3_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_ATTACK_AND_MOVE', 'REQSET_AL_UNIT_ADJACENT_HIMEKA', 0, 0),
                ('MOD_AL_HARUNA_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 'REQSET_AL_UNIT_ADJACENT_HIMEKA', 0, 0),

                ('MOD_AL_HARUNA_GREATNORMAL_4_1_1', 'MODIFIER_SINGLE_UNIT_ADJUST_COMBAT_FOR_UNUSED_MOVEMENT', NULL, 0, 0),
        -----------------------------------------------------------------------
            --KUREHA
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HIDDEN_VISIBILITY', 'REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 'REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 0, 0),

                ('MOD_AL_KUREHA_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 0, 0),

                ('MOD_AL_KUREHA_GREATNORMAL_2_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_ATTACK_AND_MOVE', 'REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_2_1_3', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 'REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 0, 0),

                ('MOD_AL_KUREHA_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION', 'REQSET_AL_UNIT_ADJACENT_SUZUME', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_SUZUME', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_SUZUME_UNIT', 0, 0),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
            
        
            --
            --AKARI
                ('MOD_AL_AKARI_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_ZOC', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KUREHA_AND_ATTACKING', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_KUREHA_UNIT', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_2_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_2_2_1', 'MODIFIER_AL_PLAYER_CITIES_ADJUST_ALLOWED_IMPROVEMENT', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_3_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_FUJINO_AND_DEFFENDING', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_FUJINO_UNIT', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_3_1_3', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_3_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLOT_HAS_UNICORN_AKARI', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLOT_HAS_UNICORN_AKARI', 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_3', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_AKARI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_2', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_3', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_4', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_5', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_6', 'MODIFIER_PLAYER_CITIES_ADJUST_GREATWORK_YIELD', NULL, 0, 0),
            --himeka
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLOT_STAGE_IS_HIMEKA', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLOT_STAGE_IS_HIMEKA', 0, 0),
                ('BUFF_AL_HIMEKA_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),
                ('BUFF_AL_HIMEKA_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_3', 'MODIFIER_AL_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'REQSET_AL_PLOT_STAGE_HAS_HIMEKA', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_4', 'MODIFIER_AL_PLAYER_DISTRICT_ADJUST_YIELD_MODIFIER', NULL, 0, 0),

                ('MOD_AL_HIMEKA_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 'REQSET_AL_UNIT_ADJACENT_AKARI', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_AKARI', 0, 0),

                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER', NULL, 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_4', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_HIMEKA_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_KUREHA', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KUREHA', 0, 0),

                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_KANBALILY_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_KANBALILY_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_4', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_HIMEKA_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 'REQSET_AL_UNIT_ADJACENT_HARUNA', 0, 0),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_HARUNA', 0, 0),
        
            --takane
                ('MOD_AL_TAKANE_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_KANAHO', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_TAKANE_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KANAHO_AND_ATTACKING', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_KANAHO', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_3', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_2_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),

                ('MOD_AL_TAKANE_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_KANAHO_UNIT', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_KANAHO_UNIT', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_3_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KANAHO', 0, 0),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),

                ('MOD_AL_TAKANE_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 'REQSET_AL_UNIT_ADJACENT_KANAHO', 0, 0),
                ('MOD_AL_TAKANE_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),

                ('MOD_AL_TAKANE_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
            --kanaho
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TAKANE_AND_DEFFENDING', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', 'REQSET_AL_UNIT_ADJACENT_TAKANE', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_1_2_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_TAKANE_UNIT', 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_2_3', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_2_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0, 0),
                ('MID1_AL_KANAHO_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_KANAHO_UNIT_2_PLOT', 0, 0),
                ('MID1_AL_KANAHO_GREATNORMAL_2_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_KANAHO_UNIT_2_PLOT', 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_TAKANE_UNIT', 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_3_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_TAKANE_UNIT', 0, 0),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_2_3', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),

                ('MOD_AL_KANAHO_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KANAHO_GREATNORMAL_4_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0, 0),
        
            --yuri
                ('MOD_AL_YURI_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_FUMI', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_1_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KAEDE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_1_2_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_MILIAM', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TADUSA', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_2_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_MAI', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_SHENLIN', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_2_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_4_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_YUJIA', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_4_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_5_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_5_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_6_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_6_1_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_OPPONENT_IS_YURIHUGE', 0, 0),

                ('MOD_AL_YURI_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 'REQSET_AL_UNIT_ADJACENT_FUMI', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER', 'REQSET_AL_UNIT_ADJACENT_KAEDE', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_MILIAM_AND_ATTACKING', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TADUSA_AND_DEFFENDING', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_MAI', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 'REQSET_AL_UNIT_ADJACENT_SHENLIN', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 'REQSET_AL_UNIT_ADJACENT_YUJIA', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_5_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_NO_REDUCTION_DAMAGE', 'REQSET_AL_UNIT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_YURI_GREATNORMAL_6_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
            --MOYU
                ('MOD_AL_MOYU_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_BUILDING_AL_VISUAL_MOYU', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_2_1_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU', 0, 0),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_1', 'MODIFIER_AL_SINGLE_CITY_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_CITY_HAS_MOYU', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU', 0, 0),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_2', 'MODIFIER_AL_SINGLE_CITY_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_CITY_HAS_MOYU', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU_AND_MILIAM', 0, 0),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_1', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU_AND_MILIAM_AND_BUILDING_ARSENAL', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU_AND_MILIAM', 0, 0),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_2', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU_AND_MILIAM_AND_BUILDING_ARSENAL', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'REQSET_AL_CITY_HAS_MOYU_AND_BUILDING_ARSENAL', 0, 0),
                ('MOD_AL_MOYU_GREATNORMAL_4_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_UNIT_IS_MOYU', 0, 0),
                ('BUFF_AL_MOYU_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MOYU', 0, 0),
            --MILIAM
                ('MOD_AL_MILIAM_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),

                ('MOD_AL_MILIAM_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_MEDIEVAL_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_RENAISSANCE_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_INDUSTRIAL_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_4', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_MODERN_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_5', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_ATOMIC_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_6', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_INFORMATION_FOR_MILIAM', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_7', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_PLAYER_HAS_TECH_AL_FUTURE_FOR_MILIAM', 0, 0),

                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_5', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_6', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_7', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_MILIAM', 0, 0),

                ('MOD_AL_MILIAM_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KAEDE_AND_ATTACKING', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KAEDE_AND_DEFFENDING', 0, 0),

                ('MOD_AL_MILIAM_GREATNORMAL_3_1_1', 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD', 'REQSET_AL_UNIT_ADJACENT_MOYU', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_MOYU_AND_DEFFENDING', 0, 0),

                ('MOD_AL_MILIAM_GREATNORMAL_3_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_FUMI_AND_ATTACKING', 0, 0),
                ('MOD_AL_MILIAM_GREATNORMAL_3_2_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_FUMI_AND_DEFFENDING', 0, 0),
                
            --YUJIA
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_0', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 0, 0),
                ('BUFF_AL_YUJIA_GREATNORMAL_1_1_0', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'REQSET_AL_GRANT_ADJACENT_YUJIA_UNIT', 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_SEE_THROUGH_FEATURES', NULL, 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_IN_COLD_AREA', 0, 0),
                ('MOD_AL_YUJIA_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_COLD_AREA', 0, 0),
            --mai
                ('MOD_AL_MAI_GREATNORMAL_1_1_1', 'MODIFIER_SINGLE_UNIT_ADJUST_JUMP_DISTANCE', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_1', 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_YUYU_UNIT', 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_2_1_3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_YUYU', 0, 0),
                
                ('BUFF_AL_MAI_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 'REQSET_AL_UNIT_ADJACENT_TADUSA', 0, 0),

                ('MOD_AL_MAI_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_YUYU_UNIT', 0, 0),
                ('BUFF_AL_MAI_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_3_1_3', 'MODIFIER_SINGLE_UNIT_ADJUST_JUMP_DISTANCE', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_3_1_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_1_PLOT', 0, 0),
                ('BUFF_AL_MAI_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_MAI_UNIT', 0, 0),
                ('BONUS_AL_MAI_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', 'MEDIC_HEALING_REQUIREMENTS', 0, 0),
                ('BUFF_AL_MAI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),
                ('BUFF_AL_MAI_GREATNORMAL_4_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_4_1_3', 'MODIFIER_SINGLE_UNIT_ADJUST_JUMP_DISTANCE', NULL, 0, 0),
                ('MOD_AL_MAI_GREATNORMAL_4_1_4', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
                
            --fumi
                ('MOD_AL_FUMI_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SUPPORT_BONUS_MODIFIER', NULL, 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'CHOKE_POINTS_REQUIREMENTS', 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KAEDE', 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_KAEDE', 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_FUMI_GREATNORMAL_4_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
            --yuyu
                ('MOD_AL_YUYU_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_2_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDING_RANGED', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_YUYU_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_BZ', 0, 0),
                ('BUFF_AL_YUYU_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('DEBUFF_AL_YUYU_GREATNORMAL_1_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
            --kaede
                ('MOD_AL_KAEDE_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_BZ_UNIT', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_2_2_2', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_3_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_BZ_UNIT', 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_2', 'MODIFIER_UNIT_ADJUST_POST_COMBAT_YIELD', NULL, 0, 0),
                ('BUFF_AL_KAEDE_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER', NULL, 0, 0),
                ('BUFF_AL_KAEDE_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER', NULL, 0, 0),
                ('BUFF_AL_KAEDE_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('BUFF_AL_KAEDE_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0, 0),

            --RIRI
                ('MOD_AL_RIRI_GREATNORMAL_1_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_1_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDING_HUGE', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_1_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_TADUSA', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_2_1_2', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', 'MEDIC_HEALING_REQUIREMENTS', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TADUSA', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_2_2_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_ATTACK_AND_MOVE', NULL, 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_3_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_NOT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_NOT_ADJACENT_YUYU', 0, 0),
                ('MOD_AL_RIRI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_2_PLOT', 0, 0),
                ('BUFF_AL_RIRI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_1_PLOT', 0, 0),
                ('BONUS_AL_RIRI_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_RADGRID', 0, 0),
                ('BUFF_AL_RIRI_GREATNORMAL_3_1_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0, 0),
            --tadusa
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_3_PLOT', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_4', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_2_4_PLOT', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_5', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_6', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_2_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_2_1_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_2_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_MAI', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_2_2_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_MAI', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_3_1_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_3_1_2', 'MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_3_2_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_RIRI', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_3_2_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_RIRI_AND_DEFFENDING', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_2', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', NULL, 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 0, 0),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_4', 'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER', NULL, 0, 0),
            --NEKO
                ('MOD_AL_NEKO_1_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_NEKO_2_2_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0, 0),
                ('MOD_AL_NEKO_3_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0, 0),

                ('BUFF_AL_NEKO_1_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', 'REQSET_AL_UNIT_IS_NEKOSUKI', 0, 0),
                ('BUFF_AL_NEKO_2_2_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_IS_NEKOSUKI', 0, 0),
                ('BUFF_AL_NEKO_3_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0, 0),
                ('BONUS_AL_NEKO_3_1_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_NEKOSUKI', 0, 0);

                INSERT INTO Modifiers
                (ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent, OwnerRequirementSetId) VALUES
                    ('MOD_AL_MAI_GREATNORMAL_4_1_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_YUYU_UNIT', 0, 0,'REQSET_AL_UNIT_ADJACENT_RIRI'),
                    ('MOD_AL_MAI_GREATNORMAL_4_1_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GRANT_ADJACENT_YUYU_UNIT', 0, 0,'REQSET_AL_UNIT_ADJACENT_RIRI');


    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
            --
            --HARUNA
                ('MOD_AL_HARUNA_GREATNORMAL_1_1_1', 'Amount', -2),
                ('MOD_AL_HARUNA_GREATNORMAL_1_1_2', 'Amount', 10),

                ('MOD_AL_HARUNA_GREATNORMAL_1_2_1', 'Amount', 2),
                ('MOD_AL_HARUNA_GREATNORMAL_1_2_2', 'Amount', -5),

                ('MOD_AL_HARUNA_GREATNORMAL_2_1_1', 'Amount', 5),
                ('MOD_AL_HARUNA_GREATNORMAL_2_1_2', 'Amount', 10),

                ('MOD_AL_HARUNA_GREATNORMAL_2_2_1', 'Amount', 10),
                ('MOD_AL_HARUNA_GREATNORMAL_2_2_2', 'Amount', 100),

                ('MOD_AL_HARUNA_GREATNORMAL_3_1_1', 'ModifierId', 'MOD_AL_HARUNA_GREATNORMAL_3_1_2'),
                ('MOD_AL_HARUNA_GREATNORMAL_3_1_2', 'ModifierId', 'MOD_AL_HARUNA_GREATNORMAL_3_1_3'),
                ('MOD_AL_HARUNA_GREATNORMAL_3_1_3', 'Amount', 1),

                ('MOD_AL_HARUNA_GREATNORMAL_3_2_1', 'CanMove', 1),
                ('MOD_AL_HARUNA_GREATNORMAL_3_2_2', 'Amount', 1),

                ('MOD_AL_HARUNA_GREATNORMAL_4_1_1', 'Amount', 3),
        -----------------------------------------------------------------------
            --kureha
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_1', 'Hidden', 1),
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_2', 'Amount', 7),
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_3', 'Amount', 4),

                ('MOD_AL_KUREHA_GREATNORMAL_1_2_1', 'Key', 'UNIT_TOUTOMI'),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_2', 'Amount', -10),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_3', 'Amount', 3),

                ('MOD_AL_KUREHA_GREATNORMAL_2_1_1', 'CanMove', 1),
                ('MOD_AL_KUREHA_GREATNORMAL_2_1_2', 'Amount', 7),
                ('MOD_AL_KUREHA_GREATNORMAL_2_1_3', 'Amount', 2),

                ('MOD_AL_KUREHA_GREATNORMAL_3_1_2', 'Amount', 7),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_3', 'ModifierId', 'MOD_AL_KUREHA_GREATNORMAL_3_1_4'),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_4', 'Amount', 7),
            
        
            --
            --akari
                ('MOD_AL_AKARI_GREATNORMAL_1_1_1', 'Ignore', 1),
                ('MOD_AL_AKARI_GREATNORMAL_1_1_2', 'Amount', 2),

                ('MOD_AL_AKARI_GREATNORMAL_1_2_1', 'ResourceType', 'RESOURCE_AL_UNICORN'),

                ('MOD_AL_AKARI_GREATNORMAL_2_1_1', 'Amount', 7),
                ('MOD_AL_AKARI_GREATNORMAL_2_1_2', 'ModifierId', 'MOD_AL_AKARI_GREATNORMAL_2_1_3'),
                ('MOD_AL_AKARI_GREATNORMAL_2_1_3', 'Amount', 1),

                ('MOD_AL_AKARI_GREATNORMAL_2_2_1', 'ImprovementType', 'IMPROVEMENT_AL_UNICORN'),
                ('MOD_AL_AKARI_GREATNORMAL_2_2_2', 'Key', 'UNICORN_NUM'),

                ('MOD_AL_AKARI_GREATNORMAL_3_1_1', 'Amount', 7),
                ('MOD_AL_AKARI_GREATNORMAL_3_1_2', 'ModifierId', 'MOD_AL_AKARI_GREATNORMAL_3_1_3'),
                ('MOD_AL_AKARI_GREATNORMAL_3_1_3', 'Amount', 1),
                
                ('MOD_AL_AKARI_GREATNORMAL_3_2_1', 'ModifierId', 'MOD_AL_AKARI_GREATNORMAL_3_2_3'),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_3', 'Amount', 2),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_2', 'ModifierId', 'MOD_AL_AKARI_GREATNORMAL_3_2_4'),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_4', 'Amount', 15),

                ('MOD_AL_AKARI_GREATNORMAL_4_1_1', 'GreatWorkObjectType', 'GREATWORKOBJECT_PORTRAIT'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_1', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_1', 'YieldChange', 1),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_2', 'GreatWorkObjectType', 'GREATWORKOBJECT_PORTRAIT'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_2', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_2', 'YieldChange', 1),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_3', 'GreatWorkObjectType', 'GREATWORKOBJECT_LANDSCAPE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_3', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_3', 'YieldChange', 1),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_4', 'GreatWorkObjectType', 'GREATWORKOBJECT_LANDSCAPE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_4', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_4', 'YieldChange', 1),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_5', 'GreatWorkObjectType', 'GREATWORKOBJECT_RELIGIOUS'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_5', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_5', 'YieldChange', 1),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_6', 'GreatWorkObjectType', 'GREATWORKOBJECT_RELIGIOUS'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_6', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_AL_AKARI_GREATNORMAL_4_1_6', 'YieldChange', 1),
            --himeka
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_1', 'ModifierId', 'BUFF_AL_HIMEKA_GREATNORMAL_1_1_1'),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_2', 'ModifierId', 'BUFF_AL_HIMEKA_GREATNORMAL_1_1_2'),
                ('BUFF_AL_HIMEKA_GREATNORMAL_1_1_1', 'Amount', 3),
                ('BUFF_AL_HIMEKA_GREATNORMAL_1_1_2', 'Amount', 10),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_3', 'ModifierId', 'MOD_AL_HIMEKA_GREATNORMAL_1_1_4'),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_4', 'Amount', 100),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_1_4', 'YieldType', 'YIELD_CULTURE'),

                ('MOD_AL_HIMEKA_GREATNORMAL_1_2_1', 'Amount', 1),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_2_2', 'Key', 'AKARI_PROMOTIONS'),

                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_1', 'ModifierId', 'MOD_AL_HIMEKA_GREATNORMAL_2_1_3'),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_2', 'ModifierId', 'MOD_AL_HIMEKA_GREATNORMAL_2_1_4'),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_3', 'Amount', 100),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_1_4', 'Amount', 1),

                ('MOD_AL_HIMEKA_GREATNORMAL_2_2_1', 'Amount', 1),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_2_2', 'Key', 'KUREHA_PROMOTIONS'),

                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_1', 'ModifierId', 'MOD_AL_HIMEKA_GREATNORMAL_3_1_3'),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_2', 'ModifierId', 'MOD_AL_HIMEKA_GREATNORMAL_3_1_4'),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_3', 'Amount', 10),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_4', 'Amount', 2),

                ('MOD_AL_HIMEKA_GREATNORMAL_3_2_1', 'Amount', 1),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_2_2', 'Key', 'RIRI_PROMOTIONS'),

            --takane
                ('MOD_AL_TAKANE_GREATNORMAL_1_1_1', 'Amount', 1),
                ('MOD_AL_TAKANE_GREATNORMAL_1_1_2', 'Amount', 5),

                ('MOD_AL_TAKANE_GREATNORMAL_1_2_1', 'Amount', 10),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_2', 'Amount', 1),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_3', 'Amount', -10),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_3', 'Type', 'ALL'),
                ('MOD_AL_TAKANE_GREATNORMAL_2_1_1', 'Amount', -15),
                ('MOD_AL_TAKANE_GREATNORMAL_2_1_1', 'Type', 'ALL'),

                ('MOD_AL_TAKANE_GREATNORMAL_3_1_1', 'ModifierId', 'BUFF_AL_TAKANE_GREATNORMAL_3_1_1'),
                ('MOD_AL_TAKANE_GREATNORMAL_3_1_2', 'ModifierId', 'BUFF_AL_TAKANE_GREATNORMAL_3_1_2'),
                ('MOD_AL_TAKANE_GREATNORMAL_3_1_3', 'Amount', 7),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_1', 'Amount', 7),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_2', 'Amount', 10),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_2', 'Type', 'ALL'),

                ('MOD_AL_TAKANE_GREATNORMAL_3_2_1', 'Amount', 2),
                ('MOD_AL_TAKANE_GREATNORMAL_3_2_2', 'Amount', -10),
                ('MOD_AL_TAKANE_GREATNORMAL_3_2_2', 'Type', 'ALL'),

                ('MOD_AL_TAKANE_GREATNORMAL_4_1_1', 'Key', 'KANAHO_PROMOTIONS'),
            --kanaho
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_1', 'Amount', 5),
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_2', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_1_1_2'),
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_3', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_1_1_3'),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_1_2', 'Amount', 5),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_1_3', 'Amount', 1),

                ('MOD_AL_KANAHO_GREATNORMAL_1_2_1', 'Amount', 5),
                ('MOD_AL_KANAHO_GREATNORMAL_1_2_2', 'Type', 'ALL'),
                ('MOD_AL_KANAHO_GREATNORMAL_1_2_2', 'Amount', -5),
                ('MOD_AL_KANAHO_GREATNORMAL_1_2_3', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_1_2_3'),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_2_3', 'Type', 'ALL'),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_2_3', 'Amount', 10),

                ('MOD_AL_KANAHO_GREATNORMAL_2_1_1', 'Amount', 15),
                ('MOD_AL_KANAHO_GREATNORMAL_2_1_2', 'Amount', -1),
                ('MOD_AL_KANAHO_GREATNORMAL_2_2_1', 'ModifierId', 'MID1_AL_KANAHO_GREATNORMAL_2_2_1'),
                ('MOD_AL_KANAHO_GREATNORMAL_2_2_2', 'ModifierId', 'MID1_AL_KANAHO_GREATNORMAL_2_2_2'),
                ('MID1_AL_KANAHO_GREATNORMAL_2_2_1', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_2_2_1'),
                ('MID1_AL_KANAHO_GREATNORMAL_2_2_2', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_2_2_2'),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_1', 'Amount', 2),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_1', 'Type', 'ALL'),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_2', 'Amount', 2),

                ('MOD_AL_KANAHO_GREATNORMAL_3_1_1', 'Amount', 10),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_1', 'Type', 'ALL'),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_2', 'Amount', 7),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_3', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_3_1_3'),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_1_3', 'Amount', 7),

                ('MOD_AL_KANAHO_GREATNORMAL_3_2_1', 'Amount', -5),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_1', 'Type', 'ALL'),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_2', 'Amount', 5),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_3', 'ModifierId', 'BUFF_AL_KANAHO_GREATNORMAL_3_2_3'),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_2_3', 'Amount', 10),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_2_3', 'Type', 'ALL'),

                ('MOD_AL_KANAHO_GREATNORMAL_4_1_1', 'Key', 'LILY_PROMOTIONS'),
                ('MOD_AL_KANAHO_GREATNORMAL_4_1_2', 'ModifierId', 'MOD_AL_KANAHO_GREATNORMAL_4_1_1'),
        
            --yuri
                ('MOD_AL_YURI_GREATNORMAL_1_1_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_1_1_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_1_2_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_1_2_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_2_1_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_2_1_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_2_2_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_2_2_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_3_1_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_3_1_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_3_2_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_3_2_3', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_4_1_2', 'Amount', 5),
                ('MOD_AL_YURI_GREATNORMAL_4_1_3', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_5_1_2', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_5_1_3', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_6_1_2', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_6_1_3', 'Amount', 10),

                ('MOD_AL_YURI_GREATNORMAL_1_1_1', 'Amount', 1),
                ('MOD_AL_YURI_GREATNORMAL_1_2_1', 'Percent', 100),
                ('MOD_AL_YURI_GREATNORMAL_2_1_1', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_2_2_1', 'Amount', 10),
                ('MOD_AL_YURI_GREATNORMAL_3_1_1', 'Amount', 1),
                ('MOD_AL_YURI_GREATNORMAL_3_2_1', 'Amount', 1),
                ('MOD_AL_YURI_GREATNORMAL_4_1_1', 'Amount', 1),
                ('MOD_AL_YURI_GREATNORMAL_5_1_1', 'NoReduction', 1),
                ('MOD_AL_YURI_GREATNORMAL_6_1_1', 'Type', 'ALL'),
                ('MOD_AL_YURI_GREATNORMAL_6_1_1', 'Amount', 100),
            --miliam
                ('MOD_AL_MOYU_GREATNORMAL_4_1_1', 'ModifierId', 'MOD_AL_MOYU_GREATNORMAL_4_1_2'),
                ('MOD_AL_MOYU_GREATNORMAL_4_1_2', 'ModifierId', 'BUFF_AL_MOYU_GREATNORMAL_4_1_1'),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_1', 'Amount', 15),
                ('BUFF_AL_MOYU_GREATNORMAL_4_1_1', 'Amount', 30),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_1', 'YieldType', 'YIELD_SCIENCE'),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_2', 'Amount', 15),
                ('BUFF_AL_MOYU_GREATNORMAL_3_1_2', 'YieldType', 'YIELD_PRODUCTION'),
                ('MOD_AL_MOYU_GREATNORMAL_3_1_1', 'ModifierId', 'BUFF_AL_MOYU_GREATNORMAL_3_1_1'),
                ('MOD_AL_MOYU_GREATNORMAL_3_1_2', 'ModifierId', 'BUFF_AL_MOYU_GREATNORMAL_3_1_2'),
                ('MOD_AL_MOYU_GREATNORMAL_1_1_1', 'ModifierId', 'MOD_AL_UNLOCK_PROJECT_AL_MOYU_RANDOM'),
                ('MOD_AL_MOYU_GREATNORMAL_2_1_1', 'ModifierId', 'BUFF_AL_MOYU_GREATNORMAL_2_1_1'),
                ('MOD_AL_MOYU_GREATNORMAL_2_1_2', 'ModifierId', 'BUFF_AL_MOYU_GREATNORMAL_2_1_2'),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_1', 'BuildingType', 'BUILDING_AL_ARSENAL'),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_1', 'YieldType', 'YIELD_PRODUCTION'),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_1', 'Amount', 6),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_2', 'BuildingType', 'BUILDING_AL_ARSENAL'),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_2', 'YieldType', 'YIELD_SCIENCE'),
                ('BUFF_AL_MOYU_GREATNORMAL_2_1_2', 'Amount', 6),
            --miliam
                ('MOD_AL_MILIAM_GREATNORMAL_1_1_1', 'Key', 'NEUNWELT_COMBAT'),

                ('MOD_AL_MILIAM_GREATNORMAL_1_2_1', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_1'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_2', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_2'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_3', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_3'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_4', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_4'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_5', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_5'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_6', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_6'),
                ('MOD_AL_MILIAM_GREATNORMAL_1_2_7', 'ModifierId', 'BUFF_AL_MILIAM_GREATNORMAL_1_2_7'),

                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_1', 'Amount', 3),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_2', 'Amount', 6),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_3', 'Amount', 9),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_4', 'Amount', 12),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_5', 'Amount', 15),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_6', 'Amount', 18),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_7', 'Amount', 21),

                ('MOD_AL_MILIAM_GREATNORMAL_2_2_1', 'Amount', 5),
                ('MOD_AL_MILIAM_GREATNORMAL_2_2_2', 'Amount', -5),

                ('MOD_AL_MILIAM_GREATNORMAL_3_1_1', 'PercentDefeatedStrength', 25),
                ('MOD_AL_MILIAM_GREATNORMAL_3_1_1', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_AL_MILIAM_GREATNORMAL_3_1_2', 'Amount', 10),

                ('MOD_AL_MILIAM_GREATNORMAL_3_2_1', 'Amount', 1),
                ('MOD_AL_MILIAM_GREATNORMAL_3_2_2', 'Amount', -5),
                ('MOD_AL_MILIAM_GREATNORMAL_3_2_3', 'Amount', 5),
            --yujia
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_0', 'ModifierId', 'BUFF_AL_YUJIA_GREATNORMAL_1_1_0'),
                ('BUFF_AL_YUJIA_GREATNORMAL_1_1_0', 'AbilityType', 'ABL_AL_YUJIA_GREATNORMAL_1_1_0'),
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_1', 'Amount', -5),
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_2', 'Amount', 10),
                ('MOD_AL_YUJIA_GREATNORMAL_1_2_1', 'Amount', 1),
                ('MOD_AL_YUJIA_GREATNORMAL_1_2_2', 'CanSee', 1),
                ('MOD_AL_YUJIA_GREATNORMAL_2_2_1', 'Amount', 2),
                ('MOD_AL_YUJIA_GREATNORMAL_2_2_2', 'Amount', 15),
            --mai
                ('MOD_AL_MAI_GREATNORMAL_1_1_1', 'Range', 3),
                ('MOD_AL_MAI_GREATNORMAL_1_1_2', 'Amount', 10),
                ('MOD_AL_MAI_GREATNORMAL_2_1_1', 'Amount', 10),
                ('MOD_AL_MAI_GREATNORMAL_2_1_2', 'ModifierId', 'BUFF_AL_MAI_GREATNORMAL_2_1_2'),
                ('MOD_AL_MAI_GREATNORMAL_2_1_3', 'Amount', 2),
                ('BUFF_AL_MAI_GREATNORMAL_2_1_2', 'Amount', 10),
                ('MOD_AL_MAI_GREATNORMAL_2_2_1', 'Amount', 1),

                ('MOD_AL_MAI_GREATNORMAL_3_1_2', 'ModifierId', 'BUFF_AL_MAI_GREATNORMAL_3_1_2'),
                ('BUFF_AL_MAI_GREATNORMAL_3_1_2', 'Amount', 5),
                ('MOD_AL_MAI_GREATNORMAL_3_1_3', 'Range', 5),
                ('MOD_AL_MAI_GREATNORMAL_3_1_4', 'Amount', 5),
                ('MOD_AL_MAI_GREATNORMAL_3_2_1', 'Amount', 1),
                ('MOD_AL_MAI_GREATNORMAL_3_2_2', 'ModifierId', 'BUFF_AL_MAI_GREATNORMAL_3_2_2'),
                ('BUFF_AL_MAI_GREATNORMAL_3_2_2', 'ModifierId', 'BONUS_AL_MAI_GREATNORMAL_3_2_2'),
                ('BONUS_AL_MAI_GREATNORMAL_3_2_2', 'Type', 'ALL'),
                ('BONUS_AL_MAI_GREATNORMAL_3_2_2', 'Amount', 3),
                ('MOD_AL_MAI_GREATNORMAL_4_1_1', 'ModifierId', 'BUFF_AL_MAI_GREATNORMAL_4_1_1'),
                ('MOD_AL_MAI_GREATNORMAL_4_1_2', 'ModifierId', 'BUFF_AL_MAI_GREATNORMAL_4_1_2'),
                ('BUFF_AL_MAI_GREATNORMAL_4_1_1', 'Amount', 1),
                ('BUFF_AL_MAI_GREATNORMAL_4_1_2', 'Amount', 5),
                ('MOD_AL_MAI_GREATNORMAL_4_1_3', 'Range', 7),
                ('MOD_AL_MAI_GREATNORMAL_4_1_4', 'Amount', 10),
            --fumi
                ('MOD_AL_FUMI_GREATNORMAL_1_1_1', 'Percent', '200'),
                ('MOD_AL_FUMI_GREATNORMAL_1_2_1', 'Amount', '7'),
                ('MOD_AL_FUMI_GREATNORMAL_2_1_1', 'Amount', 7),
                ('MOD_AL_FUMI_GREATNORMAL_2_2_1', 'Amount', '1'),
                ('MOD_AL_FUMI_GREATNORMAL_2_2_2', 'Amount', '1'),
                ('MOD_AL_FUMI_GREATNORMAL_3_1_1', 'Amount', '1'),
                ('MOD_AL_FUMI_GREATNORMAL_3_1_2', 'Amount', '5'),
                ('MOD_AL_FUMI_GREATNORMAL_4_1_1', 'Amount', '2'),
                ('MOD_AL_FUMI_GREATNORMAL_4_1_2', 'Amount', '15'),
            --yuyu
                ('MOD_AL_YUYU_GREATNORMAL_1_1_1', 'Amount', 10),
                ('MOD_AL_YUYU_GREATNORMAL_1_1_2', 'Amount', -10),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_1', 'Amount', 7),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_2', 'ModifierId', 'DEBUFF_AL_YUYU_GREATNORMAL_1_2_2'),
                ('DEBUFF_AL_YUYU_GREATNORMAL_1_2_2', 'Amount', -6),
                ('MOD_AL_YUYU_GREATNORMAL_2_1_1', 'Amount', '1'),
                ('MOD_AL_YUYU_GREATNORMAL_2_2_1', 'Type', 'ALL'),
                ('MOD_AL_YUYU_GREATNORMAL_2_2_1', 'Amount', 10),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_1', 'Amount', 10),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_2', 'Amount', -10),
                ('MOD_AL_YUYU_GREATNORMAL_3_2_1', 'Amount', 12),
                ('MOD_AL_YUYU_GREATNORMAL_3_2_2', 'ModifierId', 'BUFF_AL_YUYU_GREATNORMAL_3_2_2'),
                ('BUFF_AL_YUYU_GREATNORMAL_3_2_2', 'Amount', 10),
                ('MOD_AL_YUYU_GREATNORMAL_4_1_1', 'Amount', 12),
            --kaede
                ('MOD_AL_KAEDE_GREATNORMAL_1_1_1', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_1_1_2', 'ModifierId', 'BUFF_AL_KAEDE_GREATNORMAL_1_1_2'),
                ('BUFF_AL_KAEDE_GREATNORMAL_1_1_2', 'Percent', '100'),
                ('MOD_AL_KAEDE_GREATNORMAL_1_2_1', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_1_2_2', 'ModifierId', 'BUFF_AL_KAEDE_GREATNORMAL_1_2_2'),
                ('BUFF_AL_KAEDE_GREATNORMAL_1_2_2', 'Percent', '100'),
                ('MOD_AL_KAEDE_GREATNORMAL_2_1_1', 'Amount', '10'),
                ('MOD_AL_KAEDE_GREATNORMAL_2_1_2', 'Amount', '2'),
                ('MOD_AL_KAEDE_GREATNORMAL_2_2_1', 'Amount', '10'),
                ('MOD_AL_KAEDE_GREATNORMAL_2_2_2', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_3_1_1', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_3_1_2', 'ModifierId', 'BUFF_AL_KAEDE_GREATNORMAL_3_1_2'),
                ('BUFF_AL_KAEDE_GREATNORMAL_3_1_2', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_3_2_1', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_3_2_2', 'ModifierId', 'BUFF_AL_KAEDE_GREATNORMAL_3_2_2'),
                ('BUFF_AL_KAEDE_GREATNORMAL_3_2_2', 'Amount', '1'),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_1', 'Amount', '10'),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_2', 'PercentDefeatedStrength', '100'),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_2', 'YieldType', 'YIELD_GOLD'),
            --riri
                ('MOD_AL_RIRI_GREATNORMAL_1_1_1', 'Amount', '7'),
                ('MOD_AL_RIRI_GREATNORMAL_1_1_2', 'Amount', '7'),
                ('MOD_AL_RIRI_GREATNORMAL_1_2_1', 'Amount', '1'),
                ('MOD_AL_RIRI_GREATNORMAL_1_2_2', 'Amount', '1'),
                ('MOD_AL_RIRI_GREATNORMAL_2_1_1', 'Amount', '7'),
                ('MOD_AL_RIRI_GREATNORMAL_2_1_2', 'Type', 'ALL'),
                ('MOD_AL_RIRI_GREATNORMAL_2_1_2', 'Amount', 10),
                ('MOD_AL_RIRI_GREATNORMAL_2_2_1', 'Amount', 7),
                ('MOD_AL_RIRI_GREATNORMAL_2_2_2', 'ModifierId', 'NIHANG_NO_WOUNDED_PENALTY'),
                ('MOD_AL_RIRI_GREATNORMAL_3_1_1', 'CanMove', 1),
                ('MOD_AL_RIRI_GREATNORMAL_3_1_2', 'ModifierId', 'BUFF_AL_RIRI_GREATNORMAL_3_1_2'),
                ('BUFF_AL_RIRI_GREATNORMAL_3_1_2', 'Amount', 1),
                ('MOD_AL_RIRI_GREATNORMAL_3_2_1', 'Amount', 3),
                ('MOD_AL_RIRI_GREATNORMAL_3_2_2', 'Amount', -15),
                ('MOD_AL_RIRI_GREATNORMAL_4_1_1', 'ModifierId', 'BUFF_AL_RIRI_GREATNORMAL_4_1_1'),
                ('BUFF_AL_RIRI_GREATNORMAL_4_1_1', 'ModifierId', 'BONUS_AL_RIRI_GREATNORMAL_4_1_1'),
                ('BONUS_AL_RIRI_GREATNORMAL_4_1_1', 'Amount', 2),
            --tadusa
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_1', 'ModifierId', 'MOD_AL_TADUSA_GREATNORMAL_1_1_3'),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_2', 'ModifierId', 'MOD_AL_TADUSA_GREATNORMAL_1_1_4'),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_3', 'ModifierId', 'MOD_AL_TADUSA_GREATNORMAL_1_1_5'),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_4', 'ModifierId', 'MOD_AL_TADUSA_GREATNORMAL_1_1_6'),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_5', 'Amount', -3),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_6', 'Amount', 1),
                ('MOD_AL_TADUSA_GREATNORMAL_2_1_1', 'Amount', 12),
                ('MOD_AL_TADUSA_GREATNORMAL_2_1_2', 'Amount', -7),
                ('MOD_AL_TADUSA_GREATNORMAL_2_2_1', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_2_2_2', 'Amount', 1),
                ('MOD_AL_TADUSA_GREATNORMAL_3_1_1', 'Type', 'ALL'),
                ('MOD_AL_TADUSA_GREATNORMAL_3_1_1', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_3_2_1', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_3_2_2', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_1', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_2', 'Type', 'ALL'),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_2', 'Amount', 10),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_3', 'ModifierId', 'MOD_AL_TADUSA_GREATNORMAL_4_1_4'),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_4', 'Percent', '100'),
            --NEKO
                ('MOD_AL_NEKO_1_2_1', 'ModifierId', 'BUFF_AL_NEKO_1_2_1'),
                ('MOD_AL_NEKO_2_2_1', 'ModifierId', 'BUFF_AL_NEKO_2_2_1'),
                ('MOD_AL_NEKO_3_1_1', 'ModifierId', 'BUFF_AL_NEKO_3_1_1'),
                ('BUFF_AL_NEKO_3_1_1', 'ModifierId', 'BONUS_AL_NEKO_3_1_1'),
                
                ('BUFF_AL_NEKO_1_2_1', 'Type', 'ALL'),
                ('BUFF_AL_NEKO_1_2_1', 'Amount', 15),
                ('BUFF_AL_NEKO_2_2_1', 'Amount', 2),
                ('BONUS_AL_NEKO_3_1_1', 'Amount', 5);

    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
            --
            --HARUNA
                ('MOD_AL_HARUNA_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HARUNA_GREATNORMAL_1_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HARUNA_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HARUNA_GREATNORMAL_2_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HARUNA_GREATNORMAL_2_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --KUREHA
                ('MOD_AL_KUREHA_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_1', 'Preview', '+{Property} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KUREHA_GREATNORMAL_1_2_2', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KUREHA_GREATNORMAL_2_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KUREHA_GREATNORMAL_3_1_4', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
        -----------------------------------------------------------------------
            --himeka
                ('MOD_AL_AKARI_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_AKARI_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_AKARI_GREATNORMAL_3_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_AKARI_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_AKARI_GREATNORMAL_3_2_3', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_AKARI_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_AKARI_GREATNORMAL_2_2_2', 'Preview', '+{Property} {LOC_PROMOTION_AL_AKARI_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --himeka
                ('BUFF_AL_HIMEKA_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_HIMEKA_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_1_3', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_HIMEKA_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HIMEKA_GREATNORMAL_1_2_2', 'Preview', '+{Property} {LOC_PROMOTION_AL_HIMEKA_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HIMEKA_GREATNORMAL_2_2_2', 'Preview', '+{Property} {LOC_PROMOTION_AL_HIMEKA_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_HIMEKA_GREATNORMAL_3_2_2', 'Preview', '+{Property} {LOC_PROMOTION_AL_HIMEKA_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --takane
                ('MOD_AL_TAKANE_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TAKANE_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TAKANE_GREATNORMAL_1_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TAKANE_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TAKANE_GREATNORMAL_3_1_3', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TAKANE_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_TAKANE_GREATNORMAL_3_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TAKANE_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TAKANE_GREATNORMAL_4_1_1', 'Preview', '+{Property} {LOC_PROMOTION_AL_TAKANE_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --kanaho
                ('MOD_AL_KANAHO_GREATNORMAL_1_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_KANAHO_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KANAHO_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_KANAHO_GREATNORMAL_2_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KANAHO_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_KANAHO_GREATNORMAL_3_1_3', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KANAHO_GREATNORMAL_3_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KANAHO_GREATNORMAL_4_1_1', 'Preview', '+{Property} {LOC_PROMOTION_AL_KANAHO_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            
            --yuri
                ('MOD_AL_YURI_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),

                ('MOD_AL_YURI_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_1_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_2_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_2_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_3_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_4_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_5_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_5_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YURI_GREATNORMAL_6_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YURI_GREATNORMAL_6_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),

                ('MOD_AL_YURI_GREATNORMAL_1_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_1_1_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_1_2_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_1_2_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_2_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_2_1_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_2_2_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_2_2_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_3_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_3_1_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_3_2_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_3_2_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_4_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_4_1_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_5_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_5_1_NAME}'),
                ('MOD_AL_YURI_GREATNORMAL_6_1_3', 'Preview', '+{1_Amount} {LOC_YURI_OPPONENT_HUGE_6_1_NAME}'),
                
            --moyu
                ('BUFF_AL_MOYU_GREATNORMAL_4_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MOYU_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --miliam
                ('MOD_AL_MILIAM_GREATNORMAL_1_1_1', 'Preview', '+{Property} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_3', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_4', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_5', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_6', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MILIAM_GREATNORMAL_1_2_7', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MILIAM_GREATNORMAL_2_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MILIAM_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MILIAM_GREATNORMAL_3_2_2', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_MILIAM_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --yujia
                ('MOD_AL_YUJIA_GREATNORMAL_1_1_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_YUJIA_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUJIA_GREATNORMAL_2_2_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUJIA_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --mai
                ('MOD_AL_MAI_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MAI_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MAI_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MAI_GREATNORMAL_3_1_4', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BUFF_AL_MAI_GREATNORMAL_4_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_MAI_GREATNORMAL_4_1_4', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_MAI_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --fumi
                ('MOD_AL_FUMI_GREATNORMAL_1_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_FUMI_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_FUMI_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_FUMI_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_FUMI_GREATNORMAL_3_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_FUMI_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_FUMI_GREATNORMAL_4_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_FUMI_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --yuyu
                ('MOD_AL_YUYU_GREATNORMAL_1_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_1_1_2', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_1_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_1_2_2', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_1_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_3_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_3_1_2', 'Preview', 'LOC_ABILITY_WEAK_WHEN_DEFENDING_DESCRIPTION'),
                ('MOD_AL_YUYU_GREATNORMAL_3_2_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_YUYU_GREATNORMAL_4_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_YUYU_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),

                ('BONUS_AL_NEKO_3_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_NEKO_5_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --kaede
                ('MOD_AL_KAEDE_GREATNORMAL_2_1_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_KAEDE_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KAEDE_GREATNORMAL_2_2_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_KAEDE_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_KAEDE_GREATNORMAL_4_1_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_KAEDE_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --riri
                ('MOD_AL_RIRI_GREATNORMAL_2_1_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_RIRI_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_RIRI_GREATNORMAL_2_2_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_RIRI_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_RIRI_GREATNORMAL_3_2_2', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_RIRI_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('BONUS_AL_RIRI_GREATNORMAL_4_1_1', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_RIRI_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
            --tadusa
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_5', 'Preview', '{1_Amount} {LOC_BUFF_AL_GP_TADUSA_BIRTH_1}'),
                ('MOD_AL_TADUSA_GREATNORMAL_1_1_6', 'Preview', '+{1_Amount} {LOC_BUFF_AL_GP_TADUSA_BIRTH_2}'),
                ('MOD_AL_TADUSA_GREATNORMAL_2_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TADUSA_GREATNORMAL_2_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TADUSA_GREATNORMAL_2_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TADUSA_GREATNORMAL_2_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TADUSA_GREATNORMAL_3_2_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TADUSA_GREATNORMAL_3_2_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}'),
                ('MOD_AL_TADUSA_GREATNORMAL_4_1_1', 'Preview', '+{1_Amount} {LOC_PROMOTION_AL_TADUSA_GREATNORMAL_4_1_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');



--————————————ABILITIES————————————
    --
        INSERT INTO Types
            (Type, Kind) VALUES
                ('ABL_AL_YUJIA_GREATNORMAL_1_1_0','KIND_ABILITY'),
                ('ABILITY_AL_LILY_AREA_DEFFENSE','KIND_ABILITY'),
                ('ABILITY_AL_HUGE_AREA_DEFFENSE','KIND_ABILITY'),
                ('ABILITY_AL_LILY_AZ','KIND_ABILITY'),
                ('ABILITY_AL_LILY_TZ','KIND_ABILITY'),
                ('ABILITY_AL_LILY_BZ','KIND_ABILITY'),
                ('ABL_AL_PHANTASM_EFFECT','KIND_ABILITY'),
                ('ABL_AL_GEHENA_LILY','KIND_ABILITY'),
                ('ABILITY_AL_KUREHA_ATTACK','KIND_ABILITY'),
                ('ABILITY_AL_LILY_NEKO','KIND_ABILITY');

        INSERT INTO TypeTags
            (Type, Tag) VALUES
                ('ABL_AL_YUJIA_GREATNORMAL_1_1_0','CLASS_AL_YUJIA_GREATNORMAL'),
                ('ABILITY_AL_KUREHA_ATTACK','CLASS_AL_KUREHA_GREATNORMAL'),
                ('ABILITY_AL_LILY_AREA_DEFFENSE','CLASS_AL_LILY'),
                ('ABL_AL_PHANTASM_EFFECT','CLASS_AL_LILY'),
                ('ABL_AL_GEHENA_LILY','CLASS_AL_LILY'),
                ('ABILITY_AL_LILY_AZ','CLASS_AL_AZ'),
                ('ABILITY_AL_LILY_TZ','CLASS_AL_TZ'),
                ('ABILITY_AL_LILY_BZ','CLASS_AL_BZ'),
                ('ABILITY_AL_HUGE_AREA_DEFFENSE','CLASS_AL_HUGE'),
                ('ABILITY_AL_LILY_NEKO','CLASS_AL_NEKO');

        INSERT INTO UnitAbilities
            (UnitAbilityType, Name, Description, Inactive) VALUES
            ('ABL_AL_YUJIA_GREATNORMAL_1_1_0', 'LOC_PROMOTION_AL_YUJIA_GREATNORMAL_1_1_NAME', 'LOC_PROMOTION_AL_YUJIA_GREATNORMAL_1_1_DESCRIPTION', 1),
            ('ABILITY_AL_LILY_AREA_DEFFENSE', 'LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME', 'LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME', 0),
            ('ABILITY_AL_HUGE_AREA_DEFFENSE', 'LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME', 'LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME', 0),
            ('ABILITY_AL_KUREHA_ATTACK', 'LOC_PROMOTION_AL_KUREHA_GREATNORMAL_4_1_NAME', 'LOC_PROMOTION_AL_KUREHA_GREATNORMAL_4_1_NAME', 1),
            ('ABILITY_AL_LILY_AZ', 'LOC_ABILITY_AL_LILY_AZ_NAME', 'LOC_ABILITY_AL_LILY_AZ_NAME', 0),
            ('ABILITY_AL_LILY_BZ', 'LOC_ABILITY_AL_LILY_BZ_NAME', 'LOC_ABILITY_AL_LILY_BZ_NAME', 0),
            ('ABILITY_AL_LILY_TZ', 'LOC_ABILITY_AL_LILY_TZ_NAME', 'LOC_ABILITY_AL_LILY_TZ_NAME', 0),
            ('ABL_AL_GEHENA_LILY', 'LOC_ABL_AL_GEHENA_LILY_NAME', 'LOC_ABL_AL_GEHENA_LILY_NAME', 1),
            ('ABL_AL_PHANTASM_EFFECT', 'LOC_ABL_AL_PHANTASM_EFFECT_NAME', 'LOC_ABL_AL_PHANTASM_EFFECT_NAME', 1),
            ('ABILITY_AL_LILY_NEKO', 'LOC_ABILITY_AL_LILY_NEKO_NAME', 'LOC_ABILITY_AL_LILY_NEKO_NAME', 0);

        INSERT INTO UnitAbilityModifiers
            (UnitAbilityType, ModifierId) VALUES
                ('ABL_AL_RS_YUYU', 'MOD_AL_RS_YUYU_1'),
                ('ABL_AL_RS_TADUSA', 'MOD_AL_RS_TADUSA_1'),
                ('ABL_AL_RS_KANAHO', 'MOD_AL_RS_KANAHO_1'),
                ('ABL_AL_RS_TAKANE', 'MOD_AL_RS_TAKANE_1'),
                ('ABL_AL_RS_TAKANE', 'MOD_AL_RS_TAKANE_2'),
                ('ABL_AL_RS_HIMEKA', 'MOD_AL_RS_HIMEKA_1'),
                ('ABL_AL_RS_HARUNA', 'MOD_AL_RS_HARUNA_1'),
                ('ABL_AL_RS_AKARI', 'MOD_AL_RS_AKARI_1'),
                ('ABL_AL_RS_KUREHA', 'MOD_AL_RS_KUREHA_1'),
                ('ABL_AL_GEHENA_LILY', 'MOD_AL_GEHENA_LILY_1'),
                ('ABILITY_AL_KUREHA_ATTACK', 'MOD_AL_KUREHA_ATTACK'),
            -----------------------------------------------------------------------
                ('ABL_AL_YUJIA_GREATNORMAL_1_1_0', 'MOD_AL_YUJIA_GREATNORMAL_1_1_1'),
                ('ABL_AL_YUJIA_GREATNORMAL_1_1_0', 'MOD_AL_YUJIA_GREATNORMAL_1_1_2'),

                ('ABILITY_AL_LILY_AREA_DEFFENSE', 'BUFF_AL_LILY_AREA_DEFFENSE_LEVEL1'),
                ('ABILITY_AL_LILY_AREA_DEFFENSE', 'BUFF_AL_LILY_AREA_DEFFENSE_LEVEL2'),
                ('ABILITY_AL_LILY_AREA_DEFFENSE', 'BUFF_AL_LILY_AREA_DEFFENSE_LEVEL3'),
                
                ('ABILITY_AL_HUGE_AREA_DEFFENSE', 'BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL1'),
                ('ABILITY_AL_HUGE_AREA_DEFFENSE', 'BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL2'),
                ('ABILITY_AL_HUGE_AREA_DEFFENSE', 'BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL3'),
                
                ('ABILITY_AL_LILY_AZ', 'BUFF_AL_LILY_AZ_1'),
                ('ABILITY_AL_LILY_AZ', 'BUFF_AL_LILY_AZ_2'),
                ('ABILITY_AL_LILY_AZ', 'BUFF_AL_LILY_AZ_3'),

                ('ABILITY_AL_LILY_AZ', 'BUFF_AL_LILY_EMBARKED'),
                
                ('ABILITY_AL_LILY_TZ', 'BUFF_AL_LILY_TZ_1'),
                ('ABILITY_AL_LILY_TZ', 'BUFF_AL_LILY_TZ_2'),

                ('ABL_AL_PHANTASM_EFFECT', 'BUFF_AL_PHANTASM_EFFECT_1'),
                ('ABL_AL_PHANTASM_EFFECT', 'BUFF_AL_PHANTASM_EFFECT_2'),
                
                ('ABILITY_AL_LILY_BZ', 'BUFF_AL_LILY_BZ_1'),
                ('ABILITY_AL_LILY_BZ', 'BUFF_AL_LILY_BZ_2'),
                ('ABILITY_AL_LILY_BZ', 'BUFF_AL_LILY_BZ_3'),
                
                ('ABILITY_AL_LILY_NEKO', 'MOD_AL_NEKO_1'),
                ('ABILITY_AL_LILY_NEKO', 'MOD_AL_NEKO_2');

    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, Permanent) VALUES
            ('MOD_AL_RS_KANAHO_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_KANAHO_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_PHANTASM_PLAYER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'REQSET_AL_LILY_IS_ON_PHANTASM_PLOT', 0),
            ('MOD_AL_RS_KUREHA_1', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', 'REQSET_AL_PLOT_HAS_TOUTOMI_2', 0),
            ('MOD_AL_RS_TAKANE_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_RS_TAKANE_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0),
            ('MOD_AL_RS_AKARI_1', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0),
            ('MOD_AL_KUREHA_ATTACK', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),
            ('MOD_AL_RS_LunaticTranser_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_ATTACKER', 0),
            ('MOD_AL_GEHENA_LILY_1', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', NULL, 0),
            ('MOD_AL_RS_PhaseTranscendence_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),
            ('MOD_AL_RS_PhaseTranscendence_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0),
            ('MOD_AL_RS_HIMEKA_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0),
            ('MOD_AL_RS_HARUNA_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_HARUNA_RS', 0),
            ('MOD_AL_RS_TruthOfTheWorld_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('MOD_AL_RS_TruthOfTheWorld_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('MOD_AL_RS_TruthOfTheWorld_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_TruthOfTheWorld_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('BUFF_AL_RS_TruthOfTheWorld_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('BUFF_AL_RS_TruthOfTheWorld_3', 'MODIFIER_PLAYER_UNIT_ADJUST_IGNORE_ZOC', 'REQSET_UNIT_IS_LILY_GREAT', 0),
        -----------------------------------------------------------------------
            ('MOD_AL_RS_DEBUFF_PhaseTranscendence_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),

            ('MOD_AL_RS_ZenoneParadoxa_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0),
            ('MOD_AL_RS_ZenoneParadoxa_2', 'MODIFIER_UNIT_ADJUST_NUM_ATTACKS', NULL, 0),

            ('BUFF_AL_PHANTASM_EFFECT_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),
            ('BUFF_AL_PHANTASM_EFFECT_2', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0),

            ('MOD_AL_RS_HeavensScales_1', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', NULL, 0),
            ('MOD_AL_RS_HeavensScales_2', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0),

            ('MOD_AL_RS_ShrunkenLand_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0),
            ('MOD_AL_RS_ShrunkenLand_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),

            ('MOD_AL_RS_Testament_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_RS_Testament_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_RS_Testament_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT_ON_RS_PLOT', 0),
            ('BUFF_AL_RS_Testament_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 0),

            ('MOD_AL_RS_Laplace_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_Laplace_1', 'MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('MOD_AL_RS_Laplace_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_Laplace_2', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', 'REQSET_UNIT_IS_LILY_GREAT', 0),

            ('MOD_AL_RS_Register_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_Register_1', 'MODIFIER_UNIT_ADJUST_FORCE_RETREAT', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('MOD_AL_RS_Register_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('BUFF_AL_RS_Register_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('MOD_AL_RS_Register_3', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0),

            ('MOD_AL_RS_HawkEye_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('MOD_AL_RS_HawkEye_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 0),
            ('MOD_AL_RS_HawkEye_3', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', NULL, 0),
            ('MOD_AL_RS_HawkEye_4', 'MODIFIER_PLAYER_ADD_DIPLO_VISIBILITY', NULL, 0),
            ('BUFF_AL_RS_HawkEye_1', 'MODIFIER_PLAYER_UNIT_ADJUST_FLANKING_BONUS_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0),
            ('BUFF_AL_RS_HawkEye_2', 'MODIFIER_PLAYER_UNIT_ADJUST_SUPPORT_BONUS_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT', 0),

            ('MOD_AL_RS_Phantasm_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_RS_Phantasm_2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_DEFFENDER', 0),
            ('MOD_AL_RS_TADUSA_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', NULL, 0),

            ('BUFF_AL_LILY_EMBARKED', 'MODIFIER_SINGLE_UNIT_ADJUST_FIGHT_WHILE_EMBARKED', NULL, 0),

            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_1', 0),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_2', 0),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_3', 0),

            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_1', 0),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL2', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_2', 0),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_IN_AREA_DEFFENSE_3', 0),
            
            ('BUFF_AL_LILY_AZ_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TZ', 0),
            ('BUFF_AL_LILY_AZ_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_TZ', 0),
            ('BUFF_AL_LILY_AZ_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TZ_AND_DEFFENDING', 0),
            
            ('BUFF_AL_LILY_TZ_1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 'REQSET_AL_UNIT_ADJACENT_AZ', 0),
            ('BUFF_AL_LILY_TZ_2', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_UNIT_ADJACENT_BZ', 0),
            
            ('BUFF_AL_LILY_BZ_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_AZ_AND_DEFFENDING', 0),
            ('BUFF_AL_LILY_BZ_2', 'MODIFIER_UNIT_ADJUST_ATTACK_RANGE', 'REQSET_AL_UNIT_ADJACENT_TZ', 0),
            ('BUFF_AL_LILY_BZ_3', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_ADJACENT_TZ', 0),
            
            ('MOD_AL_NEKO_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0),
            ('MOD_AL_NEKO_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 0),
            ('BUFF_AL_NEKO_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_UNIT_IS_NEKOSUKI', 0),
            ('BUFF_AL_NEKO_2', 'MODIFIER_UNIT_ADJUST_ESCORT_MOBILITY', 'REQSET_AL_UNIT_IS_NEKOSUKI', 0);
    INSERT INTO Modifiers
        (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit) VALUES
        ('MOD_AL_RS_YUYU_1', 'MODIFIER_ALL_UNITS_ATTACH_MODIFIER', 'REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 1),
        ('BUFF_AL_RS_YUYU_1', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL, 1);
    INSERT INTO ModifierArguments
        (ModifierId, Name, Value) VALUES
            ('MOD_AL_RS_YUYU_1', 'ModifierId', 'BUFF_AL_RS_YUYU_1'),
            ('BUFF_AL_RS_YUYU_1', 'Amount', -5),
            ('MOD_AL_RS_LunaticTranser_1', 'Amount', 20),
            ('MOD_AL_RS_KUREHA_1', 'Amount', 20),
            ('MOD_AL_RS_KUREHA_1', 'Type', 'ALL'),
            ('MOD_AL_RS_AKARI_1', 'Amount', 1),
            ('MOD_AL_KUREHA_ATTACK', 'Amount', 10),
            ('MOD_AL_RS_HARUNA_1', 'Amount', 10),
        -----------------------------------------------------------------------
            ('MOD_AL_GEHENA_LILY_1', 'Amount', 5),
            ('MOD_AL_GEHENA_LILY_1', 'YieldType', 'YIELD_SCIENCE'),

            ('MOD_AL_RS_PhaseTranscendence_1', 'Amount', 15),
            ('MOD_AL_RS_PhaseTranscendence_2', 'Amount', 5),

            ('MOD_AL_RS_TAKANE_1', 'Amount', -10),
            ('MOD_AL_RS_TAKANE_2', 'Amount', 10),

            ('MOD_AL_RS_HIMEKA_1', 'Amount', 2),

            ('MOD_AL_RS_KANAHO_1', 'ModifierId', 'BUFF_AL_RS_KANAHO_1'),

            ('MOD_AL_RS_TruthOfTheWorld_1', 'ModifierId', 'BUFF_AL_RS_TruthOfTheWorld_1'),
            ('MOD_AL_RS_TruthOfTheWorld_2', 'ModifierId', 'BUFF_AL_RS_TruthOfTheWorld_2'),
            ('MOD_AL_RS_TruthOfTheWorld_3', 'ModifierId', 'BUFF_AL_RS_TruthOfTheWorld_3'),
            ('BUFF_AL_RS_TruthOfTheWorld_1', 'Amount', 1),
            ('BUFF_AL_RS_KANAHO_1', 'Amount', 5),
            ('BUFF_AL_RS_TruthOfTheWorld_2', 'Amount', 1),
            ('BUFF_AL_RS_TruthOfTheWorld_3', 'Ignore', 1),

            ('MOD_AL_RS_DEBUFF_PhaseTranscendence_1', 'Amount', -25),

            ('MOD_AL_RS_HeavensScales_1', 'Amount', 2),
            ('MOD_AL_RS_HeavensScales_2', 'Amount', 4),

            ('MOD_AL_RS_Testament_1', 'Amount', -15),
            ('MOD_AL_RS_Testament_2', 'Key', 'PROMISE_LEVEL'),
            ('MOD_AL_RS_Testament_3', 'ModifierId', 'BUFF_AL_RS_Testament_3'),
            ('BUFF_AL_RS_Testament_3', 'Amount', 12),

            ('MOD_AL_RS_ZenoneParadoxa_1', 'Amount', 1),
            ('MOD_AL_RS_ZenoneParadoxa_2', 'Amount', 1),

            ('MOD_AL_RS_ShrunkenLand_1', 'Amount', 2),
            ('MOD_AL_RS_ShrunkenLand_2', 'Key', 'ATTACK_NUMBER'),

            ('MOD_AL_PHANTASM_PLAYER', 'AbilityType', 'ABL_AL_PHANTASM_EFFECT'),
            
            ('MOD_AL_RS_Laplace_1', 'ModifierId', 'BUFF_AL_RS_Laplace_1'),
            ('MOD_AL_RS_Laplace_2', 'ModifierId', 'BUFF_AL_RS_Laplace_2'),
            ('BUFF_AL_RS_Laplace_2', 'Amount', 15),
            ('BUFF_AL_RS_Laplace_2', 'Type', 'ALL'),

            ('MOD_AL_RS_Register_1', 'ModifierId', 'BUFF_AL_RS_Register_1'),
            ('BUFF_AL_RS_Register_1', 'ForceRetreat', 1),
            ('MOD_AL_RS_Register_2', 'ModifierId', 'BUFF_AL_RS_Register_2'),
            ('BUFF_AL_RS_Register_2', 'Amount', 7),
            ('MOD_AL_RS_Register_3', 'Amount', 5),

            ('MOD_AL_RS_HawkEye_1', 'ModifierId', 'BUFF_AL_RS_HawkEye_1'),
            ('MOD_AL_RS_HawkEye_2', 'ModifierId', 'BUFF_AL_RS_HawkEye_2'),
            ('MOD_AL_RS_HawkEye_3', 'Amount', 8),
            ('MOD_AL_RS_HawkEye_4', 'Amount', 2),
            ('MOD_AL_RS_HawkEye_4', 'Source', 'SOURCE_HAWKEYE'),
            ('MOD_AL_RS_HawkEye_4', 'SourceType', 'DIPLO_SOURCE_ALL_NAMES'),
            ('BUFF_AL_RS_HawkEye_1', 'Percent', '200'),
            ('BUFF_AL_RS_HawkEye_2', 'Percent', '200'),

            ('MOD_AL_RS_Phantasm_1', 'Amount', -10),
            ('MOD_AL_RS_Phantasm_2', 'Key', 'PROMISE_LEVEL'),

            ('MOD_AL_RS_TADUSA_1', 'Amount',2),
            ('BUFF_AL_LILY_EMBARKED', 'CanFight', 1),

            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL1', 'Amount', 5),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL2', 'Amount', 5),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL3', 'Amount', 5),

            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL1', 'Amount', -5),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL2', 'Amount', -5),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL3', 'Amount', -5),
            
            ('BUFF_AL_LILY_AZ_1', 'Amount', 4),
            ('BUFF_AL_LILY_AZ_2', 'Amount', 1),
            ('BUFF_AL_LILY_AZ_3', 'Amount', 5),
            
            ('BUFF_AL_LILY_TZ_1', 'Amount', 2),
            ('BUFF_AL_LILY_TZ_2', 'Amount', 1),
            
            ('BUFF_AL_LILY_BZ_1', 'Amount', 5),
            ('BUFF_AL_LILY_BZ_2', 'Amount', 1),
            ('BUFF_AL_LILY_BZ_3', 'Amount', 4),
            
            ('MOD_AL_NEKO_1', 'ModifierId', 'BUFF_AL_NEKO_1'),
            ('MOD_AL_NEKO_2', 'ModifierId', 'BUFF_AL_NEKO_2'),
            
            ('BUFF_AL_NEKO_1', 'Amount', 7),
            ('BUFF_AL_NEKO_2', 'EscortMobility', 1);

    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
            ('BUFF_AL_RS_Register_2', 'Preview', '+{1_Amount} {LOC_RS_NAME_Register}'),
            ('MOD_AL_RS_DEBUFF_PhaseTranscendence_1', 'Preview', '{1_Amount} {LOC_RS_NAME_PhaseTranscendence} {LOC_RS_DEBUFF}'),
            ('MOD_AL_RS_PhaseTranscendence_1', 'Preview', '+{1_Amount} {LOC_RS_NAME_PhaseTranscendence}'),
            ('MOD_AL_RS_LunaticTranser_1', 'Preview', '+{1_Amount} {LOC_RS_NAME_LunaticTranser}'),
            ('BUFF_AL_RS_YUYU_1', 'Preview', '{1_Amount} {LOC_RS_NAME_LunaticTranser}'),
            ('MOD_AL_KUREHA_ATTACK', 'Preview', '{1_Amount} {LOC_PROMOTION_AL_KUREHA_GREATNORMAL_4_1_NAME}'),
            ('MOD_AL_RS_HARUNA_1', 'Preview', '{1_Amount} {LOC_RS_NAME_PhaseTranscendence}'),

            ('MOD_AL_RS_TAKANE_1', 'Preview', '{1_Amount} {LOC_RS_NAME_ZenoneParadoxa}'),
            ('MOD_AL_RS_TAKANE_2', 'Preview', '{1_Amount} {LOC_RS_NAME_ZenoneParadoxa}'),

            ('MOD_AL_RS_ShrunkenLand_2', 'Preview', '+{Property}  {LOC_RS_NAME_ShrunkenLand}'),
            ('MOD_AL_RS_Testament_1', 'Preview', '{Property}  {LOC_RS_NAME_Testament}'),
            ('MOD_AL_RS_Testament_2', 'Preview', '+{1_Amount}  {LOC_RS_NAME_Testament}'),
            ('BUFF_AL_RS_Testament_3', 'Preview', '+{1_Amount}  {LOC_RS_NAME_Testament}'),

            ('BUFF_AL_PHANTASM_EFFECT_1', 'Preview', '+{1_Amount} {LOC_RS_NAME_Phantasm}'),

            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL1', 'Preview', '+{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL2', 'Preview', '+{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),
            ('BUFF_AL_LILY_AREA_DEFFENSE_LEVEL3', 'Preview', '+{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),

            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL1', 'Preview', '{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL2', 'Preview', '{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),
            ('BUFF_AL_HUGE_AREA_DEFFENSE_LEVEL3', 'Preview', '{1_Amount} {LOC_ABILITY_AL_LILY_AREA_DEFFENSE_NAME}'),
            ('BUFF_AL_NEKO_1', 'Preview', '{1_Amount} {LOC_ABILITY_NEKO_ATTACK}'),
            ('BUFF_AL_LILY_AZ_1', 'Preview', '{1_Amount} {LOC_ABILITY_AL_LILY_AZ_WITH_TZ}'),
            ('BUFF_AL_LILY_BZ_3', 'Preview', '{1_Amount} {LOC_ABILITY_AL_LILY_BZ_WITH_TZ}');

--————————————REQUIRES————————————
    INSERT INTO RequirementSets
        (RequirementSetId, RequirementSetType) VALUES
            ('REQSET_AL_LILY_IS_ON_PHANTASM_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_HAS_STAGE', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_STAGE_HAS_HIMEKA', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT_ON_RS_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_HAS_UNICORN_AKARI', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_HARUNA_RS', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_IS_SEITOKAI', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_HARUNA_2_2', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GRANT_ADJACENT_SEITOKAI_UNIT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE', 'REQUIREMENTSET_TEST_ANY'),
    -----------------------------------------------------------------------
            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_1_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_KANBALILY_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_3_PLOT', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_NEAR_LILY_AND_ATTACKING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_NEAR_LILY_AND_DEFENDING', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_1_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_MAI_UNIT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_2_4_PLOT', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_2_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_1_PLOT', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_DEFFENDER', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_IS_DEFFENDING_RANGED', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_IS_DEFFENDING_HUGE', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_ATTACKER', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_NEKOSUKI', 'REQUIREMENTSET_TEST_ALL'),
            
            ('REQSET_AL_IN_AREA_DEFFENSE_1', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_IN_AREA_DEFFENSE_2', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_IN_AREA_DEFFENSE_3', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_GRANT_ADJACENT_BZ_UNIT', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_ADJACENT_TZ', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_DEFFENDING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_ATTACKING_HUGE', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_ADJACENT_AZ', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_NOT_ADJACENT_AZ', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_DEFFENDING', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_ATTACKING', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_ADJACENT_BZ', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_BZ_AND_DEFFENDING', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_RADGRID', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_RADGRID', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_UNIT_IS_GRANEPLE', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_UNIT_ADJACENT_GRANEPLE', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_STAGE_IS_HIMEKA', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_IN_COLD_AREA', 'REQUIREMENTSET_TEST_ANY');

    INSERT INTO RequirementSetRequirements
        (RequirementSetId, RequirementId) VALUES
            ('REQSET_AL_HARUNA_RS', 'REQ_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE'),
            ('REQSET_AL_HARUNA_RS', 'REQ_AL_UNIT_IS_ATTACKER'),
            ('REQSET_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE', 'REQ_AL_UNIT_ADJACENT_HIMEKA'),
            ('REQSET_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE', 'REQ_AL_UNIT_ADJACENT_TAKANE'),
            ('REQSET_AL_HARUNA_2_2', 'REQ_AL_UNIT_ADJACENT_AKEHI'),
            ('REQSET_AL_HARUNA_2_2', 'NOT_OWNER_CAPITAL_CONTINENT_REQUIREMENT'),
            ('REQSET_AL_UNIT_IS_SEITOKAI', 'REQ_AL_UNIT_IS_SEITOKAI'),

            ('REQSET_AL_GRANT_ADJACENT_SEITOKAI_UNIT', 'REQ_AL_UNIT_IS_SEITOKAI'),
            ('REQSET_AL_GRANT_ADJACENT_SEITOKAI_UNIT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
        -----------------------------------------------------------------------
            ('REQSET_AL_LILY_IS_ON_PHANTASM_PLOT', 'REQ_AL_UNIT_IS_ON_PHANTASM_PLOT'),
            ('REQSET_AL_LILY_IS_ON_PHANTASM_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),
            ('REQSET_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 'REQ_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2'),

            ('REQSET_AL_PLOT_HAS_STAGE', 'REQ_AL_PLOT_HAS_STAGE'),
            ('REQSET_AL_PLOT_STAGE_HAS_HIMEKA', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_PLOT_STAGE_HAS_HIMEKA', 'REQ_AL_DISTRICT_IS_STAGE'),

            ('REQSET_AL_PLOT_STAGE_IS_HIMEKA', 'REQ_AL_PLOT_HAS_STAGE'),
            ('REQSET_AL_PLOT_STAGE_IS_HIMEKA', 'REQ_AL_UNIT_IS_HIMEKA'),

            ('REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 'REQ_AL_UNIT_ADJACENT_AKARI'),
            ('REQSET_AL_UNIT_ADJACENT_AKARI_AND_HIMEKA', 'REQ_AL_UNIT_ADJACENT_HIMEKA'),

            ('REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 'REQ_AL_UNIT_ADJACENT_KANAHO'),
            ('REQSET_AL_UNIT_ADJACENT_KANAHO_AND_TAKANE', 'REQ_AL_UNIT_ADJACENT_TAKANE'),

            ('REQSET_AL_PLOT_HAS_UNICORN_AKARI', 'REQ_AL_PLOT_HAS_UNICORN'),
            ('REQSET_AL_PLOT_HAS_UNICORN_AKARI', 'REQ_AL_UNIT_IS_AKARI'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT_ON_RS_PLOT', 'REQ_AL_UNIT_IS_ON_RS_PLOT'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT_ON_RS_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT_ON_RS_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),

            ('REQSET_AL_NEAR_LILY_AND_ATTACKING', 'REQ_AL_UNIT_IS_ATTACKER'),
            ('REQSET_AL_NEAR_LILY_AND_ATTACKING', 'REQ_AL_UNIT_ADJACENT_LILY'),
            ('REQSET_AL_NEAR_LILY_AND_DEFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),
            ('REQSET_AL_NEAR_LILY_AND_DEFENDING', 'REQ_AL_UNIT_ADJACENT_LILY'),

            ('REQSET_AL_IN_COLD_AREA', 'REQ_AL_TERRAIN_IS_TUNDRA'),
            ('REQSET_AL_IN_COLD_AREA', 'REQ_AL_TERRAIN_IS_SNOW'),
        
            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_1_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),

            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_1_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),

            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
            ('REQSET_AL_GARNT_ADJACENT_LILY_UNIT_2_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),

            ('REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
            ('REQSET_AL_GARNT_ADJACENT_GRANEPLE_UNIT_2_PLOT', 'REQ_AL_UNIT_IS_GRANEPLE'),

            ('REQSET_AL_GARNT_ADJACENT_KANBALILY_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
            ('REQSET_AL_GARNT_ADJACENT_KANBALILY_UNIT_2_PLOT', 'REQ_AL_UNIT_IS_KANBALILY'),

            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
            ('REQSET_AL_GARNT_ADJACENT_ALL_UNIT_2_3_PLOT', 'REQ_AL_GRANT_TO_AWAY_UNITS'),

            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_1_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_1_PLOT', 'REQ_AL_UNIT_IS_TADUSA'),

            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_2_4_PLOT', 'REQ_AL_GRANT_TO_AWAY_UNITS'),
            ('REQSET_AL_GARNT_ADJACENT_TADUSA_UNIT_2_4_PLOT', 'REQ_AL_UNIT_IS_TADUSA'),

            ('REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GARNT_ADJACENT_NEKOSUKI_UNIT_1_PLOT', 'REQ_AL_UNIT_IS_NEKOSUKI'),

            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_1_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_1_PLOT', 'REQ_AL_UNIT_IS_RADGRID'),
            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_2_PLOT', 'REQ_AL_GRANT_TO_NEAR_UNITS_2'),
            ('REQSET_AL_GARNT_ADJACENT_RADGRID_UNIT_2_PLOT', 'REQ_AL_UNIT_IS_RADGRID'),

            ('REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GRANT_ADJACENT_AZ_UNIT', 'REQ_AL_UNIT_IS_AZ'),
            ('REQSET_AL_GRANT_ADJACENT_BZ_UNIT', 'REQ_AL_GRANT_TO_NEAR_UNITS'),
            ('REQSET_AL_GRANT_ADJACENT_BZ_UNIT', 'REQ_AL_UNIT_IS_BZ'),
        
            ('REQSET_AL_UNIT_IS_DEFFENDER', 'REQ_AL_UNIT_IS_DEFFENDER'),
            ('REQSET_AL_UNIT_IS_ATTACKER', 'REQ_AL_UNIT_IS_ATTACKER'),

            ('REQSET_AL_UNIT_IS_DEFFENDING_RANGED', 'REQ_AL_UNIT_IS_DEFFENDER'),
            ('REQSET_AL_UNIT_IS_DEFFENDING_RANGED', 'RANGED_COMBAT_REQUIREMENTS'),

            ('REQSET_AL_UNIT_IS_DEFFENDING_HUGE', 'REQ_AL_UNIT_IS_DEFFENDER'),
            ('REQSET_AL_UNIT_IS_DEFFENDING_HUGE', 'REQ_OPPONENT_UNIT_IS_HUGE'),
            ('REQSET_AL_UNIT_IS_NEKOSUKI', 'REQ_AL_UNIT_IS_NEKOSUKI'),

            ('REQSET_AL_IN_AREA_DEFFENSE_1', 'REQ_AL_AL_IN_AREA_DEFFENSE_1'),
            ('REQSET_AL_IN_AREA_DEFFENSE_2', 'REQ_AL_AL_IN_AREA_DEFFENSE_2'),
            ('REQSET_AL_IN_AREA_DEFFENSE_3', 'REQ_AL_AL_IN_AREA_DEFFENSE_3'),
            
            ('REQSET_AL_UNIT_ADJACENT_TZ', 'REQ_AL_UNIT_ADJACENT_TZ'),

            ('REQSET_AL_UNIT_ADJACENT_AZ', 'REQ_AL_UNIT_ADJACENT_AZ'),
            
            ('REQSET_AL_UNIT_NOT_ADJACENT_AZ', 'REQ_AL_UNIT_NOT_ADJACENT_AZ'),

            ('REQSET_AL_UNIT_ADJACENT_BZ', 'REQ_AL_UNIT_ADJACENT_BZ'),
            ('REQSET_AL_UNIT_ADJACENT_BZ_AND_DEFFENDING', 'REQ_AL_UNIT_ADJACENT_BZ'),
            ('REQSET_AL_UNIT_ADJACENT_BZ_AND_DEFFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),

            ('REQSET_AL_UNIT_ADJACENT_RADGRID', 'REQ_AL_UNIT_ADJACENT_RADGRID'),
            ('REQSET_AL_UNIT_IS_RADGRID', 'REQ_AL_UNIT_IS_RADGRID'),

            ('REQSET_AL_UNIT_ADJACENT_GRANEPLE', 'REQ_AL_UNIT_ADJACENT_GRANEPLE'),
            ('REQSET_AL_UNIT_IS_GRANEPLE', 'REQ_AL_UNIT_IS_GRANEPLE'),

            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_DEFFENDING', 'REQ_AL_UNIT_ADJACENT_TZ'),
            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_DEFFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),

            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_ATTACKING_HUGE', 'REQ_AL_UNIT_ADJACENT_TZ'),
            ('REQSET_AL_UNIT_ADJACENT_TZ_AND_ATTACKING_HUGE', 'REQ_OPPONENT_UNIT_IS_HUGE'),

            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_DEFFENDING', 'REQ_AL_UNIT_ADJACENT_AZ'),
            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_DEFFENDING', 'REQ_AL_UNIT_IS_DEFFENDER'),
            
            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_ATTACKING', 'REQ_AL_UNIT_ADJACENT_AZ'),
            ('REQSET_AL_UNIT_ADJACENT_AZ_AND_ATTACKING', 'REQ_AL_UNIT_IS_ATTACKER');

    INSERT INTO Requirements
        (RequirementId, RequirementType, Inverse) VALUES
            ('REQ_AL_UNIT_IS_DEFFENDER', 'REQUIREMENT_PLAYER_IS_ATTACKING', 1),
            ('REQ_AL_UNIT_IS_ATTACKER', 'REQUIREMENT_PLAYER_IS_ATTACKING', 0),
            ('REQ_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 1),
            ('REQSET_AL_UNIT_IS_SEITOKAI', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),

            ('REQ_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE', 'REQUIREMENT_REQUIREMENTSET_IS_MET', 1),
        -----------------------------------------------------------------------
            ('REQ_AL_PLOT_HAS_STAGE', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 0),

            ('REQ_AL_TERRAIN_IS_TUNDRA', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES', 0),
            ('REQ_AL_TERRAIN_IS_SNOW', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES', 0),

            ('REQ_AL_UNIT_ADJACENT_LILY', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_ADJACENT_RADGRID', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_ADJACENT_TZ', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_ADJACENT_AZ', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_NOT_ADJACENT_AZ', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 1),
            ('REQ_AL_UNIT_ADJACENT_BZ', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),

            ('REQ_AL_HIGHT_HP', 'REQUIREMENT_PLAYER_IS_ATTACKING', 0),

            ('REQ_AL_UNIT_IS_AZ', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_IS_BZ', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),

            ('REQ_AL_UNIT_IS_RADGRID', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_IS_NEKOSUKI', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),

            ('REQ_AL_UNIT_ADJACENT_GRANEPLE', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_UNIT_TAG_MATCHES', 0),
            ('REQ_AL_UNIT_IS_GRANEPLE', 'REQUIREMENT_UNIT_TAG_MATCHES', 0),
            
            ('REQ_AL_PLOT_HAS_UNICORN', 'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES', 0),
            
            
            ('REQ_AL_GRANT_TO_NEAR_UNITS', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER', 0),
            ('REQ_AL_GRANT_TO_NEAR_UNITS_2', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER', 0),
            ('REQ_AL_GRANT_TO_AWAY_UNITS', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER', 0),

            ('REQ_AL_UNIT_IS_ON_PHANTASM_PLOT', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0),
            ('REQ_AL_UNIT_IS_ON_RS_PLOT', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0),

            ('REQ_AL_AL_IN_AREA_DEFFENSE_1', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_2', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_3', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0);

    INSERT INTO RequirementArguments
        (RequirementId, Name, Value) VALUES
            ('REQ_AL_UNIT_IS_AZ', 'Tag', 'CLASS_AL_AZ'),
            ('REQ_AL_UNIT_IS_BZ', 'Tag', 'CLASS_AL_BZ'),
            ('REQ_AL_PLOT_HAS_UNICORN', 'ResourceType', 'RESOURCE_AL_UNICORN'),
            ('REQ_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 'PropertyMinimum', 2),
            ('REQ_AL_PLOT_HAS_TOUTOMI_LESS_THAN_2', 'PropertyName', 'TOUTOMI'),

            ('REQ_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE', 'RequirementSetId', 'REQSET_AL_UNIT_ADJACENT_HIMEKA_OR_TAKANE'),

            ('REQ_AL_PLOT_HAS_STAGE', 'DistrictType', 'DISTRICT_AL_STAGE'),

            ('REQ_AL_TERRAIN_IS_TUNDRA', 'TerrainClass', 'TERRAIN_CLASS_TUNDRA'),
            ('REQ_AL_TERRAIN_IS_SNOW', 'TerrainClass', 'TERRAIN_CLASS_SNOW'),

            ('REQ_AL_UNIT_IS_RADGRID', 'Tag', 'CLASS_AL_RADGRID'),
            ('REQSET_AL_UNIT_IS_SEITOKAI', 'Tag', 'CLASS_AL_SEITOKAI'),
            ('REQ_AL_UNIT_IS_NEKOSUKI', 'Tag', 'CLASS_AL_NEKOSUKI'),

            ('REQ_AL_UNIT_ADJACENT_RADGRID', 'Tag', 'CLASS_AL_RADGRID'),

            ('REQ_AL_UNIT_ADJACENT_GRANEPLE', 'Tag', 'CLASS_AL_GRANEPLE'),
            ('REQ_AL_UNIT_IS_GRANEPLE', 'Tag', 'CLASS_AL_GRANEPLE'),

            ('REQ_AL_UNIT_ADJACENT_LILY', 'Tag', 'CLASS_AL_LILY'),
            ('REQ_AL_UNIT_ADJACENT_TZ', 'Tag', 'CLASS_AL_TZ'),
            ('REQ_AL_UNIT_ADJACENT_AZ', 'Tag', 'CLASS_AL_AZ'),
            ('REQ_AL_UNIT_NOT_ADJACENT_AZ', 'Tag', 'CLASS_AL_AZ'),
            ('REQ_AL_UNIT_ADJACENT_BZ', 'Tag', 'CLASS_AL_BZ'),

            ('REQ_AL_GRANT_TO_NEAR_UNITS', 'MaxDistance', 1),
            ('REQ_AL_GRANT_TO_NEAR_UNITS', 'MinDistance', 0),

            ('REQ_AL_GRANT_TO_NEAR_UNITS_2', 'MinDistance', 0),
            ('REQ_AL_GRANT_TO_NEAR_UNITS_2', 'MaxDistance', 2),

            ('REQ_AL_GRANT_TO_AWAY_UNITS', 'MinDistance', 2),
            ('REQ_AL_GRANT_TO_AWAY_UNITS', 'MaxDistance', 3),

            ('REQ_AL_UNIT_IS_ON_PHANTASM_PLOT', 'PropertyName', 'PHANTASM_PLOT'),
            ('REQ_AL_UNIT_IS_ON_PHANTASM_PLOT', 'PropertyMinimum', '1'),
            ('REQ_AL_UNIT_IS_ON_RS_PLOT', 'PropertyName', 'USING_RS'),
            ('REQ_AL_UNIT_IS_ON_RS_PLOT', 'PropertyMinimum', '1'),

            ('REQ_AL_AL_IN_AREA_DEFFENSE_1', 'PropertyName', 'area_deffense_flag_1'),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_1', 'PropertyMinimum', '1'),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_2', 'PropertyName', 'area_deffense_flag_2'),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_2', 'PropertyMinimum', '1'),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_3', 'PropertyName', 'area_deffense_flag_3'),
            ('REQ_AL_AL_IN_AREA_DEFFENSE_3', 'PropertyMinimum', '1');

    INSERT INTO UnitRetreats_XP1
        (BuildingType, UnitType, UnitRetreatType) VALUES
            ('BUILDING_PALACE', 'UNIT_AL_LILY', 'UNIT_RETREAT_LILY_TO_CAPITAL'),
            ('BUILDING_PALACE', 'UNIT_AL_NEKO', 'UNIT_RETREAT_NEKO_TO_CAPITAL'),
            ('BUILDING_PALACE', 'UNIT_AL_KANBALILY', 'UNIT_RETREAT_KANBALILY_TO_CAPITAL'),
            ('BUILDING_AL_OHAKA', 'UNIT_AL_LILY', 'UNIT_RETREAT_LILY_TO_OHAKA'),
            ('BUILDING_AL_SAKURA', 'UNIT_AL_LILY', 'UNIT_RETREAT_LILY_TO_SAKURA');