INSERT INTO Types
(Type, Kind) VALUES
('NAMED_RIVER_AL_ASAOGAWA', 'KIND_NAMED_RIVER'),
('NAMED_RIVER_AL_HIGAWA', 'KIND_NAMED_RIVER'),
('NAMED_SEA_AL_SAGAMI', 'KIND_NAMED_SEA'),
('NAMED_SEA_AL_YUHIHAMA', 'KIND_NAMED_SEA'),
('NAMED_LAKE_AL_SAGAMIKO', 'KIND_NAMED_LAKE'),
('NAMED_LAKE_AL_KAMAKURAKO', 'KIND_NAMED_LAKE'),
('NAMED_MOUNTAIN_AL_BUTOUNOOKA', 'KIND_NAMED_MOUNTAIN'),
('NAMED_MOUNTAIN_AL_TAKAOYAMA', 'KIND_NAMED_MOUNTAIN'),
('NAMED_VOLCANO_AL_FUJI', 'KIND_NAMED_VOLCANO');

INSERT INTO NamedRivers
(NamedRiverType, Name) VALUES
('NAMED_RIVER_AL_ASAOGAWA', 'LOC_NAMED_RIVER_AL_ASAOGAWA'),
('NAMED_RIVER_AL_HIGAWA', 'LOC_NAMED_RIVER_AL_HIGAWA');

INSERT INTO NamedVolcanoes
(NamedVolcanoType, Name) VALUES
('NAMED_VOLCANO_AL_FUJI', 'LOC_NAMED_VOLCANO_AL_FUJI');

INSERT INTO NamedMountains
(NamedMountainType, Name) VALUES
('NAMED_MOUNTAIN_AL_BUTOUNOOKA', 'LOC_NAMED_MOUNTAIN_AL_BUTOUNOOKA'),
('NAMED_MOUNTAIN_AL_TAKAOYAMA', 'LOC_NAMED_MOUNTAIN_AL_TAKAOYAMA');

INSERT INTO NamedLakes
(NamedLakeType, Name) VALUES
('NAMED_LAKE_AL_SAGAMIKO', 'LOC_NAMED_LAKE_AL_SAGAMIKO'),
('NAMED_LAKE_AL_KAMAKURAKO', 'LOC_NAMED_LAKE_AL_KAMAKURAKO');

INSERT INTO NamedSeas
(NamedSeaType, Name) VALUES
('NAMED_SEA_AL_SAGAMI', 'LOC_NAMED_SEA_AL_SAGAMI'),
('NAMED_SEA_AL_YUHIHAMA', 'LOC_NAMED_SEA_AL_YUHIHAMA');

INSERT INTO NamedRiverCivilizations
(NamedRiverType, CivilizationType) VALUES
('NAMED_RIVER_AL_ASAOGAWA', 'CIVILIZATION_YURIGAOKA'),
('NAMED_RIVER_AL_HIGAWA', 'CIVILIZATION_YURIGAOKA');

INSERT INTO NamedVolcanoCivilizations
(NamedVolcanoType, CivilizationType) VALUES
('NAMED_VOLCANO_AL_FUJI', 'CIVILIZATION_YURIGAOKA');

INSERT INTO NamedMountainCivilizations
(NamedMountainType, CivilizationType) VALUES
('NAMED_MOUNTAIN_AL_BUTOUNOOKA', 'CIVILIZATION_YURIGAOKA'),
('NAMED_MOUNTAIN_AL_TAKAOYAMA', 'CIVILIZATION_YURIGAOKA');

INSERT INTO NamedLakeCivilizations
(NamedLakeType, CivilizationType) VALUES
('NAMED_LAKE_AL_SAGAMIKO', 'CIVILIZATION_YURIGAOKA'),
('NAMED_LAKE_AL_KAMAKURAKO', 'CIVILIZATION_YURIGAOKA');

INSERT INTO NamedSeaCivilizations
(NamedSeaType, CivilizationType) VALUES
('NAMED_SEA_AL_SAGAMI', 'CIVILIZATION_YURIGAOKA'),
('NAMED_SEA_AL_YUHIHAMA', 'CIVILIZATION_YURIGAOKA');