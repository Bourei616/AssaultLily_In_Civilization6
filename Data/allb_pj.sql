-- 守护天使的誓言
INSERT INTO TraitModifiers
(TraitType, ModifierId) VALUES
('TRAIT_CIVILIZATION_AL_ANGEL_PROMISE', 'UNLOCK_PROJECT_ANGEL');

INSERT INTO Modifiers
(ModifierId, ModifierType) VALUES
('UNLOCK_PROJECT_ANGEL', 'MODIFIER_PLAYER_ALLOW_PROJECT_CHINA');

INSERT INTO ModifierArguments
(ModifierId, Name, Value) VALUES
('UNLOCK_PROJECT_ANGEL', 'ProjectType', 'PROJECT_ANGEL');

INSERT INTO Types
(Type, Kind) VALUES
('PROJECT_ANGEL', 'KIND_PROJECT');

INSERT INTO Projects
(ProjectType, Name, ShortName, Description, Cost, CostProgressionModel, CostProgressionParam1, UnlocksFromEffect) VALUES
('PROJECT_ANGEL', 'LOC_PROJECT_ANGEL_NAME', 'LOC_PROJECT_ANGEL_SHORT_NAME', 'LOC_PROJECT_ANGEL_DESCRIPTION', 50, 'COST_PROGRESSION_GAME_PROGRESS', 1500, 1);

INSERT INTO Project_YieldConversions
(ProjectType, YieldType, PercentOfProductionRate) VALUES
('PROJECT_ANGEL', 'YIELD_FAITH', 75);

INSERT INTO Project_GreatPersonPoints
(ProjectType, GreatPersonClassType, Points, PointProgressionModel, PointProgressionParam1) VALUES
('PROJECT_ANGEL', 'GREAT_PERSON_CLASS_ARTIST', 10, 'COST_PROGRESSION_GAME_PROGRESS', 800);