CREATE TABLE IF NOT EXISTS MomentIllustrations (MomentIllustrationType TEXT, MomentDataType TEXT, GameDataType TEXT, Texture TEXT);
INSERT INTO MomentIllustrations
(MomentIllustrationType, MomentDataType, GameDataType, Texture)VALUES
('MOMENT_ILLUSTRATION_UNIQUE_UNIT',    'MOMENT_DATA_UNIT',    'UNIT_ROSE',          'ICON_UNIT_ROSE_MOMENT.dds'),
('MOMENT_ILLUSTRATION_UNIQUE_DISTRICT',    'MOMENT_DATA_DISTRICT',    'DISTRICT_GARDEN',          'ICON_DISTRICT_GARDEN_MOMENT.dds'),
('MOMENT_ILLUSTRATION_UNIQUE_DISTRICT',    'MOMENT_DATA_DISTRICT',    'DISTRICT_AL_MOYU',          'ICON_DISTRICT_AL_MOYU_MOMENT.dds'),
('MOMENT_ILLUSTRATION_UNIQUE_BUILDING',    'MOMENT_DATA_BUILDING',    'BUILDING_AL_PROMISE',          'ICON_BUILDING_AL_PROMISE_MOMENT.dds'),
('MOMENT_ILLUSTRATION_UNIQUE_IMPROVEMENT',    'MOMENT_DATA_IMPROVEMENT',    'IMPROVEMENT_AL_QUAN',          'ICON_IMPROVEMENT_AL_QUAN_MOMENT.dds'),
('MOMENT_ILLUSTRATION_UNIQUE_BUILDING',    'MOMENT_DATA_BUILDING',    'BUILDING_AL_SAKURA',          'ICON_BUILDING_AL_SAKURA_MOMENT.dds');