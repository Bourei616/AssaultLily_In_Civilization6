    INSERT INTO Types
            (Type, Kind) VALUES
                ('POLICY_AL_SEITOKAI_1', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_2', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_3', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_4', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_5', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_6', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_7', 'KIND_POLICY'),
                ('POLICY_AL_SEITOKAI_8', 'KIND_POLICY'),

                ('POLICY_AL_FUUKI_1', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_2', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_3', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_4', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_5', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_6', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_7', 'KIND_POLICY'),
                ('POLICY_AL_FUUKI_8', 'KIND_POLICY'),
                
                ('MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', 'KIND_MODIFIER'),
                ('MODIFIER_AL_PLAYER_CITIES_ADJUST_DISTRICT_YIELD', 'KIND_MODIFIER'),
                ('MODIFIER_AL_SINGLE_CITY_ADJUST_BUILDING_YIELD_CHANGE', 'KIND_MODIFIER'),
                ('MODIFIER_AL_PLAYER_UNITS_ADJUST_SIGHT', 'KIND_MODIFIER'),
                ('MODIFIER_AL_SINGLE_CITIY_ADJUST_YIELD_MODIFIER_FROM_FAITH', 'KIND_MODIFIER'),
                ('MODIFIER_AL_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'KIND_MODIFIER'),
                ('MODIFIER_AL_PLAYER_DISTRICT_ADJUST_YIELD_MODIFIER', 'KIND_MODIFIER'),
                ('MODIFIER_AL_SINGLE_CITY_ADJUST_HAPPINESS_YIELD', 'KIND_MODIFIER'),
                ('MODIFIER_AL_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'KIND_MODIFIER');

    INSERT INTO ObsoletePolicies
            (PolicyType, ObsoletePolicy) VALUES
                ('POLICY_AL_SEITOKAI_6', 'POLICY_AL_SEITOKAI_8'),
                ('POLICY_AL_FUUKI_2', 'POLICY_AL_SEITOKAI_8'),
                ('POLICY_AL_FUUKI_6', 'POLICY_AL_FUUKI_8'),
                ('POLICY_AL_SEITOKAI_4', 'POLICY_AL_FUUKI_8');

    INSERT INTO DynamicModifiers
            (ModifierType, CollectionType, EffectType) VALUES
                ('MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', 'COLLECTION_OWNER', 'EFFECT_ADJUST_PLAYER_BAN_POLICY'),
                ('MODIFIER_AL_PLAYER_DISTRICT_ADJUST_YIELD_MODIFIER', 'COLLECTION_OWNER', 'EFFECT_ADJUST_DISTRICT_YIELD_MODIFIER'),
                ('MODIFIER_AL_PLAYER_CITIES_ADJUST_DISTRICT_YIELD', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_DISTRICT_YIELD_CHANGE'),
                ('MODIFIER_AL_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ATTACH_MODIFIER'),
                ('MODIFIER_AL_SINGLE_CITY_ADJUST_HAPPINESS_YIELD', 'COLLECTION_OWNER', 'EFFECT_ADJUST_CITY_HAPPINESS_YIELD'),
                ('MODIFIER_AL_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'COLLECTION_PLAYER_IMPROVEMENTS', 'EFFECT_ATTACH_MODIFIER'),
                ('MODIFIER_AL_SINGLE_CITY_ADJUST_BUILDING_YIELD_CHANGE', 'COLLECTION_OWNER', 'EFFECT_ADJUST_BUILDING_YIELD_CHANGE'),
                ('MODIFIER_AL_PLAYER_UNITS_ADJUST_SIGHT', 'COLLECTION_PLAYER_UNITS', 'EFFECT_ADJUST_UNIT_SIGHT'),
                ('MODIFIER_AL_SINGLE_CITIY_ADJUST_YIELD_MODIFIER_FROM_FAITH', 'COLLECTION_OWNER', 'EFFECT_ADJUST_CITY_YIELD_MODIFIER_FROM_FAITH');

    INSERT INTO Policies
            (PolicyType, Name, Description, GovernmentSlotType, ExplicitUnlock) VALUES
                ('POLICY_AL_SEITOKAI_1', 'LOC_NAME_POLICY_AL_SEITOKAI_1', 'LOC_DESC_POLICY_AL_SEITOKAI_1', 'SLOT_ECONOMIC', 1),
                ('POLICY_AL_SEITOKAI_2', 'LOC_NAME_POLICY_AL_SEITOKAI_2', 'LOC_DESC_POLICY_AL_SEITOKAI_2', 'SLOT_MILITARY', 1),
                ('POLICY_AL_SEITOKAI_3', 'LOC_NAME_POLICY_AL_SEITOKAI_3', 'LOC_DESC_POLICY_AL_SEITOKAI_3', 'SLOT_MILITARY', 1),
                ('POLICY_AL_SEITOKAI_4', 'LOC_NAME_POLICY_AL_SEITOKAI_4', 'LOC_DESC_POLICY_AL_SEITOKAI_4', 'SLOT_DIPLOMATIC', 1),
                ('POLICY_AL_SEITOKAI_5', 'LOC_NAME_POLICY_AL_SEITOKAI_5', 'LOC_DESC_POLICY_AL_SEITOKAI_5', 'SLOT_ECONOMIC', 1),
                ('POLICY_AL_SEITOKAI_6', 'LOC_NAME_POLICY_AL_SEITOKAI_6', 'LOC_DESC_POLICY_AL_SEITOKAI_6', 'SLOT_GREAT_PERSON', 1),
                ('POLICY_AL_SEITOKAI_7', 'LOC_NAME_POLICY_AL_SEITOKAI_7', 'LOC_DESC_POLICY_AL_SEITOKAI_7', 'SLOT_ECONOMIC', 1),
                ('POLICY_AL_SEITOKAI_8', 'LOC_NAME_POLICY_AL_SEITOKAI_8', 'LOC_DESC_POLICY_AL_SEITOKAI_8', 'SLOT_GREAT_PERSON', 1),
                
                ('POLICY_AL_FUUKI_1', 'LOC_NAME_POLICY_AL_FUUKI_1', 'LOC_DESC_POLICY_AL_FUUKI_1', 'SLOT_ECONOMIC', 1),
                ('POLICY_AL_FUUKI_2', 'LOC_NAME_POLICY_AL_FUUKI_2', 'LOC_DESC_POLICY_AL_FUUKI_2', 'SLOT_GREAT_PERSON', 1),
                ('POLICY_AL_FUUKI_3', 'LOC_NAME_POLICY_AL_FUUKI_3', 'LOC_DESC_POLICY_AL_FUUKI_3', 'SLOT_ECONOMIC', 1),
                ('POLICY_AL_FUUKI_4', 'LOC_NAME_POLICY_AL_FUUKI_4', 'LOC_DESC_POLICY_AL_FUUKI_4', 'SLOT_MILITARY', 1),
                ('POLICY_AL_FUUKI_5', 'LOC_NAME_POLICY_AL_FUUKI_5', 'LOC_DESC_POLICY_AL_FUUKI_5', 'SLOT_MILITARY', 1),
                ('POLICY_AL_FUUKI_6', 'LOC_NAME_POLICY_AL_FUUKI_6', 'LOC_DESC_POLICY_AL_FUUKI_6', 'SLOT_DIPLOMATIC', 1),
                ('POLICY_AL_FUUKI_7', 'LOC_NAME_POLICY_AL_FUUKI_7', 'LOC_DESC_POLICY_AL_FUUKI_7', 'SLOT_MILITARY', 1),
                ('POLICY_AL_FUUKI_8', 'LOC_NAME_POLICY_AL_FUUKI_8', 'LOC_DESC_POLICY_AL_FUUKI_8', 'SLOT_DIPLOMATIC', 1);

    INSERT INTO PolicyModifiers
            (PolicyType, ModifierId) VALUES
                ('POLICY_AL_SEITOKAI_1', 'MOD_POLICY_AL_SEITOKAI_1_1'),
                ('POLICY_AL_SEITOKAI_1', 'MOD_POLICY_AL_SEITOKAI_1_2'),
                ('POLICY_AL_SEITOKAI_1', 'MOD_POLICY_AL_SEITOKAI_1_3'),
                ('POLICY_AL_SEITOKAI_1', 'MOD_POLICY_AL_SEITOKAI_1_4'),
                ('POLICY_AL_SEITOKAI_1', 'MOD_POLICY_AL_SEITOKAI_1_5'),
                ('POLICY_AL_SEITOKAI_2', 'MOD_POLICY_AL_SEITOKAI_2_1'),
                ('POLICY_AL_SEITOKAI_3', 'MOD_POLICY_AL_SEITOKAI_3_1'),
                
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_1'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_2'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_3'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_4'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_5'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_6'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_7'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_8'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_9'),
                ('POLICY_AL_SEITOKAI_5', 'MOD_POLICY_AL_SEITOKAI_5_10'),
                
                ('POLICY_AL_SEITOKAI_6', 'MOD_POLICY_AL_SEITOKAI_6_1'),
                ('POLICY_AL_SEITOKAI_6', 'MOD_POLICY_AL_SEITOKAI_6_2'),
                
                ('POLICY_AL_SEITOKAI_8', 'MOD_POLICY_AL_SEITOKAI_6_1'),
                ('POLICY_AL_SEITOKAI_8', 'MOD_POLICY_AL_SEITOKAI_6_2'),
                ('POLICY_AL_SEITOKAI_8', 'MOD_POLICY_AL_SEITOKAI_8_1'),
                
                ('POLICY_AL_FUUKI_1', 'MOD_POLICY_AL_FUUKI_1_1'),
                ('POLICY_AL_FUUKI_2', 'MOD_POLICY_AL_SEITOKAI_8_1'),
                
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_1'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_2'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_3'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_4'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_5'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_6'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_7'),
                ('POLICY_AL_FUUKI_3', 'MOD_POLICY_AL_FUUKI_3_8'),

                ('POLICY_AL_FUUKI_4', 'MOD_POLICY_AL_FUUKI_4_3'),
                ('POLICY_AL_FUUKI_4', 'MOD_POLICY_AL_FUUKI_4_4'),
                
                ('POLICY_AL_FUUKI_5', 'MOD_POLICY_AL_FUUKI_5_1'),
                ('POLICY_AL_FUUKI_5', 'MOD_POLICY_AL_FUUKI_5_2'),
                ('POLICY_AL_FUUKI_5', 'MOD_POLICY_AL_FUUKI_5_3'),
                
                ('POLICY_AL_FUUKI_7', 'MOD_POLICY_AL_FUUKI_7_1'),
                ('POLICY_AL_FUUKI_7', 'MOD_POLICY_AL_FUUKI_7_2');

    INSERT INTO Modifiers
            (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
                ('MOD_POLICY_AL_SEITOKAI_1_1', 'MODIFIER_PLAYER_ADJUST_RESOURCE_ACCUMULATION_MODIFIER', NULL),
                ('MOD_POLICY_AL_SEITOKAI_1_2', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_ONSEN'),
                ('MOD_POLICY_AL_SEITOKAI_1_3', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_ONSEN'),
                ('MOD_POLICY_AL_SEITOKAI_1_4', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_ONSEN_SEA'),
                ('MOD_POLICY_AL_SEITOKAI_1_5', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_AL_PLOT_HAS_ONSEN_SEA'),
                ('MOD_POLICY_AL_SEITOKAI_2_1', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_LILY_FIGHT_WITH_HUGE'),
                ('MOD_POLICY_AL_SEITOKAI_3_1', 'MODIFIER_PLAYER_ADJUST_UNIT_MAINTENANCE_DISCOUNT', NULL),
                
                ('MOD_POLICY_AL_SEITOKAI_5_1', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_SEITOKAI_5_2', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_SEITOKAI_5_3', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_SEITOKAI_5_4', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_SEITOKAI_5_5', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_SEITOKAI_5_6', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_SEITOKAI_5_7', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_SEITOKAI_5_8', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_SEITOKAI_5_9', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_SEITOKAI_5_10', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                
                ('MOD_POLICY_AL_SEITOKAI_6_1', 'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT', 'REQSET_AL_BUILDING_IS_ARSENAL'),
                ('MOD_POLICY_AL_SEITOKAI_6_2', 'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT', 'REQSET_AL_BUILDING_IS_TRANNING'),
                ('MOD_POLICY_AL_SEITOKAI_6_3', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'REQSET_AL_DISTRICT_IS_GARDEN'),

                ('MOD_POLICY_AL_SEITOKAI_7_1', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_TOURISM_CHANGE', 'REQSET_AL_DISTRICT_IS_GARDEN'),
                
                ('MOD_POLICY_AL_SEITOKAI_8_1', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_EXPERIENCE_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT'),
                
                ('MOD_AL_BAN_SEITOKAI_6', 'MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', NULL),
                ('MOD_AL_BAN_FUUKI_2', 'MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', NULL),
                ('MOD_AL_BAN_SEITOKAI_4', 'MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', NULL),
                ('MOD_AL_BAN_FUUKI_6', 'MODIFIER_AL_PLAYER_ADJUST_BANNED_POLICY', NULL),
                
                ('MOD_POLICY_AL_FUUKI_1_1', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER', 'REQSET_AL_DISTRICT_IS_GARDEN'),
                
                ('MOD_POLICY_AL_FUUKI_3_1', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_FUUKI_3_2', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_FUUKI_3_3', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_FUUKI_3_4', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'CITY_HAS_HIGH_POPULATION'),
                ('MOD_POLICY_AL_FUUKI_3_5', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_FUUKI_3_6', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_FUUKI_3_7', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),
                ('MOD_POLICY_AL_FUUKI_3_8', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY'),

                ('MOD_POLICY_AL_FUUKI_4_3', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT'),
                ('MOD_POLICY_AL_FUUKI_4_4', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT'),
                
                ('MOD_POLICY_AL_FUUKI_4_1', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_NOT_NEARBY_FRIENDLY_PLOT'),
                ('MOD_POLICY_AL_FUUKI_4_2', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT', 'REQSET_AL_NOT_NEARBY_FRIENDLY_PLOT'),
                
                ('MOD_POLICY_AL_FUUKI_5_1', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY', 'REQSET_AL_CITY_HAS_GARRISON_LILY_UNIT'),
                ('MOD_POLICY_AL_FUUKI_5_2', 'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_MODIFIER_FROM_FAITH', 'REQSET_AL_CITY_HAS_GARRISON_LILY_UNIT'),
                ('MOD_POLICY_AL_FUUKI_5_3', 'MODIFIER_PLAYER_CITIES_ADJUST_YIELD_MODIFIER_FROM_FAITH', 'REQSET_AL_CITY_HAS_GARRISON_LILY_UNIT'),
                
                ('MOD_POLICY_AL_FUUKI_7_1', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT'),
                ('MOD_POLICY_AL_FUUKI_7_2', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'REQSET_UNIT_IS_LILY_GREAT'),
                
                ('MOD_POLICY_AL_FUUKI_7_3', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'REQSET_AL_NEARBY_FRIENDLY_PLOT'),
                ('MOD_POLICY_AL_FUUKI_7_4', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_AL_NEARBY_FRIENDLY_PLOT');

    INSERT INTO ModifierArguments
            (ModifierId, Name, Value) VALUES
                ('MOD_POLICY_AL_SEITOKAI_1_1', 'Amount', 2),
                ('MOD_POLICY_AL_SEITOKAI_1_1', 'ResourceType', 'RESOURCE_AL_MAGI'),
                
                ('MOD_POLICY_AL_SEITOKAI_1_2', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_SEITOKAI_1_2', 'Amount', 3),
                
                ('MOD_POLICY_AL_SEITOKAI_1_3', 'YieldType', 'YIELD_PRODUCTION'),
                ('MOD_POLICY_AL_SEITOKAI_1_3', 'Amount', 3),
                
                ('MOD_POLICY_AL_SEITOKAI_1_4', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_1_4', 'Amount', 3),
                
                ('MOD_POLICY_AL_SEITOKAI_1_5', 'YieldType', 'YIELD_FOOD'),
                ('MOD_POLICY_AL_SEITOKAI_1_5', 'Amount', 3),

                ('MOD_POLICY_AL_SEITOKAI_2_1', 'Amount', 15),
                
                ('MOD_POLICY_AL_SEITOKAI_3_1', 'Amount', 3),
            --5
                ('MOD_POLICY_AL_SEITOKAI_5_1', 'BuildingType', 'BUILDING_AL_PROMISE'),
                ('MOD_POLICY_AL_SEITOKAI_5_1', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_1', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_2', 'BuildingType', 'BUILDING_AL_OHAKA'),
                ('MOD_POLICY_AL_SEITOKAI_5_2', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_2', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_3', 'BuildingType', 'BUILDING_AL_SAKURA'),
                ('MOD_POLICY_AL_SEITOKAI_5_3', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_3', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_4', 'BuildingType', 'BUILDING_AL_SEITOKAI'),
                ('MOD_POLICY_AL_SEITOKAI_5_4', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_4', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_5', 'BuildingType', 'BUILDING_AL_FUUKI'),
                ('MOD_POLICY_AL_SEITOKAI_5_5', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_5', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_6', 'BuildingType', 'BUILDING_AL_PROMISE'),
                ('MOD_POLICY_AL_SEITOKAI_5_6', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_6', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_7', 'BuildingType', 'BUILDING_AL_OHAKA'),
                ('MOD_POLICY_AL_SEITOKAI_5_7', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_7', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_8', 'BuildingType', 'BUILDING_AL_SAKURA'),
                ('MOD_POLICY_AL_SEITOKAI_5_8', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_8', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_9', 'BuildingType', 'BUILDING_AL_SEITOKAI'),
                ('MOD_POLICY_AL_SEITOKAI_5_9', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_9', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_SEITOKAI_5_10', 'BuildingType', 'BUILDING_AL_FUUKI'),
                ('MOD_POLICY_AL_SEITOKAI_5_10', 'Amount', 6),
                ('MOD_POLICY_AL_SEITOKAI_5_10', 'YieldType', 'YIELD_CULTURE'),
            --6
                ('MOD_POLICY_AL_SEITOKAI_6_1', 'Amount', 4),
                ('MOD_POLICY_AL_SEITOKAI_6_1', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_AL_LILY'),
                
                ('MOD_POLICY_AL_SEITOKAI_6_2', 'Amount', 4),
                ('MOD_POLICY_AL_SEITOKAI_6_2', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_AL_LILY'),
                
                ('MOD_POLICY_AL_SEITOKAI_6_3', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_SEITOKAI_6_3', 'Amount', 1),

                ('MOD_POLICY_AL_SEITOKAI_7_1', 'Amount', 1),
                
                ('MOD_POLICY_AL_SEITOKAI_8_1', 'Amount', 100),
                
                ('MOD_AL_BAN_SEITOKAI_6', 'PolicyType', 'POLICY_AL_SEITOKAI_6'),
                ('MOD_AL_BAN_FUUKI_2', 'PolicyType', 'POLICY_AL_FUUKI_2'),
                ('MOD_AL_BAN_SEITOKAI_4', 'PolicyType', 'POLICY_AL_SEITOKAI_4'),
                ('MOD_AL_BAN_FUUKI_6', 'PolicyType', 'POLICY_AL_FUUKI_6'),
                
                ('MOD_POLICY_AL_FUUKI_1_1', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_1_1', 'Amount', 100),
                
            --3
                ('MOD_POLICY_AL_FUUKI_3_1', 'BuildingType', 'BUILDING_AL_ARSENAL'),
                ('MOD_POLICY_AL_FUUKI_3_1', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_1', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_2', 'BuildingType', 'BUILDING_AL_TRAINING'),
                ('MOD_POLICY_AL_FUUKI_3_2', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_2', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_3', 'BuildingType', 'BUILDING_AL_AREA_DEFENSE'),
                ('MOD_POLICY_AL_FUUKI_3_3', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_3', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_4', 'BuildingType', 'BUILDING_AL_KOUNAI_ONSEN'),
                ('MOD_POLICY_AL_FUUKI_3_4', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_4', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_5', 'BuildingType', 'BUILDING_AL_ARSENAL'),
                ('MOD_POLICY_AL_FUUKI_3_5', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_5', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_6', 'BuildingType', 'BUILDING_AL_TRAINING'),
                ('MOD_POLICY_AL_FUUKI_3_6', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_6', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_7', 'BuildingType', 'BUILDING_AL_AREA_DEFENSE'),
                ('MOD_POLICY_AL_FUUKI_3_7', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_7', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_3_8', 'BuildingType', 'BUILDING_AL_KOUNAI_ONSEN'),
                ('MOD_POLICY_AL_FUUKI_3_8', 'Amount', 6),
                ('MOD_POLICY_AL_FUUKI_3_8', 'YieldType', 'YIELD_SCIENCE'),
            --4
                ('MOD_POLICY_AL_FUUKI_4_1', 'Amount', 1),
                ('MOD_POLICY_AL_FUUKI_4_2', 'Amount', 1),

                ('MOD_POLICY_AL_FUUKI_4_3', 'ModifierId', 'MOD_POLICY_AL_FUUKI_4_1'),
                ('MOD_POLICY_AL_FUUKI_4_4', 'ModifierId', 'MOD_POLICY_AL_FUUKI_4_2'),
                
                ('MOD_POLICY_AL_FUUKI_5_1', 'Amount', 3),
                
                ('MOD_POLICY_AL_FUUKI_5_2', 'YieldType', 'YIELD_SCIENCE'),
                ('MOD_POLICY_AL_FUUKI_5_2', 'Amount', 40),
                
                ('MOD_POLICY_AL_FUUKI_5_3', 'YieldType', 'YIELD_CULTURE'),
                ('MOD_POLICY_AL_FUUKI_5_3', 'Amount', 40),
                
                ('MOD_POLICY_AL_FUUKI_7_1', 'ModifierId', 'MOD_POLICY_AL_FUUKI_7_3'),
                ('MOD_POLICY_AL_FUUKI_7_2', 'ModifierId', 'MOD_POLICY_AL_FUUKI_7_4'),
                ('MOD_POLICY_AL_FUUKI_7_3', 'Amount', 2),
                ('MOD_POLICY_AL_FUUKI_7_4', 'Amount', 10);

    INSERT INTO RequirementSets
        (RequirementSetId, RequirementSetType) VALUES
            ('REQSET_AL_PLOT_HAS_ONSEN', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_PLOT_HAS_ONSEN_SEA', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_LILY_FIGHT_WITH_HUGE', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY', 'REQUIREMENTSET_TEST_ALL'),
            
            ('REQSET_AL_BUILDING_IS_ARSENAL', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_BUILDING_IS_TRANNING', 'REQUIREMENTSET_TEST_ALL'),

            ('REQSET_AL_NOT_NEARBY_FRIENDLY_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            ('REQSET_AL_NEARBY_FRIENDLY_PLOT', 'REQUIREMENTSET_TEST_ALL'),
            
            ('REQSET_AL_CITY_HAS_GARRISON_LILY_UNIT', 'REQUIREMENTSET_TEST_ALL');

    INSERT INTO RequirementSetRequirements
        (RequirementSetId, RequirementId) VALUES
            ('REQSET_AL_PLOT_HAS_ONSEN', 'REQ_AL_PLOT_HAS_ONSEN'),
            ('REQSET_AL_PLOT_HAS_ONSEN_SEA', 'REQ_AL_PLOT_HAS_ONSEN_SEA'),
            ('REQSET_AL_LILY_FIGHT_WITH_HUGE', 'REQ_UNIT_IS_LILY_GREAT'),
            ('REQSET_AL_LILY_FIGHT_WITH_HUGE', 'REQ_OPPONENT_UNIT_IS_HUGE'),

            ('REQSET_AL_BUILDING_IS_ARSENAL', 'REQ_AL_CITY_HAS_ARSENAL'),
            ('REQSET_AL_BUILDING_IS_TRANNING', 'REQ_AL_CITY_HAS_TRAINNING'),
            
            ('REQSET_AL_GARDEN_HAS_HIGH_ADJACENCY', 'REQ_AL_GARDEN_HAS_HIGH_ADJACENCY'),
            
            ('REQSET_AL_NOT_NEARBY_FRIENDLY_PLOT', 'REQ_AL_NOT_NEARBY_FRIENDLY_PLOT'),
            ('REQSET_AL_NOT_NEARBY_FRIENDLY_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),

            ('REQSET_AL_NEARBY_FRIENDLY_PLOT', 'REQ_AL_NEARBY_FRIENDLY_PLOT'),
            ('REQSET_AL_NEARBY_FRIENDLY_PLOT', 'REQ_UNIT_IS_LILY_GREAT'),
            
            ('REQSET_AL_CITY_HAS_GARRISON_LILY_UNIT', 'REQ_PLOT_IS_LILY_GREAT');

    INSERT INTO Requirements
        (RequirementId, RequirementType, Inverse) VALUES
            ('REQ_AL_PLOT_HAS_ONSEN', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES', 0),
            ('REQ_AL_PLOT_HAS_ONSEN_SEA', 'REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES', 0),

            ('REQ_AL_CITY_HAS_ARSENAL', 'REQUIREMENT_CITY_HAS_BUILDING', 0),
            ('REQ_AL_CITY_HAS_TRAINNING', 'REQUIREMENT_CITY_HAS_BUILDING', 0),
            
            ('REQ_AL_GARDEN_HAS_HIGH_ADJACENCY', 'REQUIREMENT_CITY_HAS_HIGH_ADJACENCY_DISTRICT', 0),
            
            ('REQ_AL_NOT_NEARBY_FRIENDLY_PLOT', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_TERRITORY', 1),
            ('REQ_AL_NEARBY_FRIENDLY_PLOT', 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_TERRITORY', 0),
            
            ('REQ_PLOT_IS_LILY_GREAT', 'REQUIREMENT_PLOT_PROPERTY_MATCHES', 0);

    INSERT INTO RequirementArguments
        (RequirementId, Name, Value) VALUES
            ('REQ_AL_PLOT_HAS_ONSEN', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN'),
            ('REQ_AL_PLOT_HAS_ONSEN_SEA', 'ImprovementType', 'IMPROVEMENT_AL_ONSEN_SEA'),

            ('REQ_AL_CITY_HAS_ARSENAL', 'BuildingType', 'BUILDING_AL_ARSENAL'),
            ('REQ_AL_CITY_HAS_TRAINNING', 'BuildingType', 'BUILDING_AL_TRAINING'),
            
            ('REQ_AL_GARDEN_HAS_HIGH_ADJACENCY', 'DistrictType', 'DISTRICT_AL_GARDEN'),
            ('REQ_AL_GARDEN_HAS_HIGH_ADJACENCY', 'YieldType', 'YIELD_SCIENCE'),
            ('REQ_AL_GARDEN_HAS_HIGH_ADJACENCY', 'Amount', 4),
            
            ('REQ_AL_NOT_NEARBY_FRIENDLY_PLOT', 'MinRange', 0),
            ('REQ_AL_NOT_NEARBY_FRIENDLY_PLOT', 'MaxRange', 1),

            ('REQ_AL_NEARBY_FRIENDLY_PLOT', 'MinRange', 0),
            ('REQ_AL_NEARBY_FRIENDLY_PLOT', 'MaxRange', 1),
            
            ('REQ_PLOT_IS_LILY_GREAT', 'PropertyName', 'LILY_UNIT_GARRISON'),
            ('REQ_PLOT_IS_LILY_GREAT', 'PropertyMinimum', '1');

    INSERT INTO ModifierStrings
        (ModifierId, Context, Text) VALUES
            ('MOD_POLICY_AL_SEITOKAI_2_1', 'Preview', '+{1_Amount} {LOC_NAME_POLICY_AL_SEITOKAI_2}'),
            ('MOD_POLICY_AL_FUUKI_7_4', 'Preview', '+{1_Amount} {LOC_NAME_POLICY_AL_FUUKI_7}');