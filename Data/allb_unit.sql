-- ��˿ޱɪ
INSERT INTO Types (Type, Kind) VALUES 
('UNIT_ROSE', 'KIND_UNIT');

INSERT INTO Tags (Tag, Vocabulary) VALUES 
('CLASS_AL_ROSE', 'ABILITY_CLASS');

INSERT INTO TypeTags (Type, Tag) VALUES 
('UNIT_ROSE', 'CLASS_RECON'),
('UNIT_ROSE', 'CLASS_REVEAL_STEALTH'),
('UNIT_ROSE', 'CLASS_RANGED'),
('UNIT_ROSE', 'CLASS_AL_ROSE');

INSERT INTO Units
(UnitType, BaseMoves, Cost, AdvisorType, BaseSightRange, ZoneOfControl, Domain, FormationClass, Name, Description, PurchaseYield, PromotionClass, Combat, TraitType, RangedCombat, Range, BuildCharges) VALUES 
('UNIT_ROSE', 4, 50, 'ADVISOR_CONQUEST', 3, 1, 'DOMAIN_LAND', 'FORMATION_CLASS_LAND_COMBAT', 'LOC_UNIT_ROSE_NAME', 'LOC_UNIT_ROSE_DESCRIPTION', 'YIELD_GOLD', 'PROMOTION_CLASS_RECON', 25, 'TRAIT_CIVILIZATION_AL_UNIT_ROSE', 20, 2, 2);

INSERT INTO UnitAiInfos (UnitType, AiType) VALUES 
('UNIT_ROSE', 'UNITAI_EXPLORE'),
('UNIT_ROSE', 'UNITTYPE_LAND_COMBAT');

INSERT INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType) VALUES 
('UNIT_ROSE', 'UNIT_SCOUT');