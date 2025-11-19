-- UNIVERSO
INSERT INTO universo (idade_bilhoes_anos, diametro_bilhoes_anos, nome) VALUES
(13.80, 93.00, 'Universo Observável'),
(12.50, 85.00, 'Universo Paralelo A'),
(11.20, 78.00, 'Universo Paralelo B'),
(14.00, 95.00, 'Universo X'),
(13.00, 90.00, 'Universo Y'),
(12.80, 88.00, 'Universo Z'),
(13.60, 92.00, 'Universo Alfa'),
(13.70, 91.00, 'Universo Beta'),
(13.90, 94.00, 'Universo Gama'),
(13.85, 93.50, 'Universo Delta');

-- GALAXIA
INSERT INTO galaxia (id_universo, massa_solar, num_estrela_aprox, nome) VALUES
((SELECT id_universo FROM universo where nome = 'Universo Observável'), 1.5e12, 100000000000, 'Via Láctea'),
((SELECT id_universo FROM universo where nome = 'Universo Observável'), 1.0e12, 80000000000, 'Andrômeda'),
((SELECT id_universo FROM universo where nome = 'Universo Observável'), 0.5e12, 30000000000, 'Triângulo'),
((SELECT id_universo FROM universo where nome = 'Universo Paralelo A'), 2.0e12, 120000000000, 'Galáxia Sombria'),
((SELECT id_universo FROM universo where nome = 'Universo Paralelo B'), 0.8e12, 60000000000, 'Galáxia Espiral A'),
((SELECT id_universo FROM universo where nome = 'Universo X'), 1.2e12, 90000000000, 'Galáxia Espiral B'),
((SELECT id_universo FROM universo where nome = 'Universo Y'), 1.1e12, 85000000000, 'Galáxia Elíptica A'),
((SELECT id_universo FROM universo where nome = 'Universo X'), 0.9e12, 70000000000, 'Galáxia Elíptica B'),
((SELECT id_universo FROM universo where nome = 'Universo Alfa'), 1.3e12, 95000000000, 'Galáxia Anã A'),
((SELECT id_universo FROM universo where nome = 'Universo Beta'), 1.4e12, 98000000000, 'Galáxia Anã B');

-- CONSTELACAO
INSERT INTO constelacao (nome, area_grau2, numero_estrela) VALUES
('Órion', 594.12, 81),
('Ursa Maior', 1279.66, 93),
('Cassiopeia', 598.41, 55),
('Escorpião', 496.78, 70),
('Cão Maior', 380.12, 45),
('Touro', 797.25, 85),
('Peixes', 889.83, 75),
('Leão', 947.23, 77),
('Águia', 652.14, 60),
('Cisne', 804.56, 88);

-- ESTRELA
INSERT INTO estrela (id_galaxia, nome, massa_solar, raio_solar, luminosidade, temperatura_k, idade_milhoes_anos) VALUES
((SELECT id_galaxia FROM galaxia WHERE nome = 'Via Láctea'), 'Sol', 1.00, 1.00, 1.00, 5778, 4600.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Via Láctea'), 'Sirius', 2.02, 1.71, 25.4, 9940, 242.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Via Láctea'), 'Betelgeuse', 47.6, 887.0, 126000, 3500, 10000.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Andrômeda'), 'Rigel', 21.0, 78.9, 120000, 12100, 800.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Andrômeda'), 'Vega', 2.1, 2.3, 40.12, 9602, 455.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Triângulo'), 'Altair', 1.8, 1.6, 10.6, 7550, 1000.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Sombria'), 'Deneb', 19.0, 203.0, 196000, 8525, 100.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Espiral A'), 'Antares', 12.4, 680.0, 75000, 3400, 12000.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Espiral B'), 'Aldebaran', 1.7, 44.2, 518, 3910, 6500.00),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Elíptica A'), 'Proxima Centauri', 0.12, 0.14, 0.0017, 3042, 4500.00);

INSERT INTO tipo_espectral_estrela (id_estrela, tipo_espectral) VALUES
((SELECT id_estrela FROM estrela where nome = 'Sol'), 'G2V'),
((SELECT id_estrela FROM estrela where nome = 'Betelgeuse'), 'M1-2 Ia-ab'),
((SELECT id_estrela FROM estrela where nome = 'Altair'), 'A7V'),
((SELECT id_estrela FROM estrela where nome = 'Deneb'), 'A2Ia'),
((SELECT id_estrela FROM estrela where nome = 'Proxima Centauri'), 'M5.5');


-- COMETA
INSERT INTO cometa (nome, periodo_orbital_anos, velocidade_km_s) VALUES
('Halley', 75.3, 54.6),
('Encke', 3.3, 69.9),
('Hale-Bopp', 2533.0, 44.0),
('Borrelly', 6.9, 62.7),
('Tempel 1', 5.5, 39.0);

-- ASTEROIDE
INSERT INTO asteroide (nome, classe_orbital, diametro_km) VALUES
('Ceres', 'Cinturão Principal', 939.4),
('Vesta', 'Cinturão Principal', 525.4),
('Pallas', 'Cinturão Principal', 512.0),
('Hygiea', 'Cinturão Principal', 430.0),
('Eros', 'NEA', 16.8),
('Itokawa', 'NEA', 0.35),
('Apophis', 'NEA', 0.37),
('Bennu', 'NEA', 0.49),
('Ryugu', 'NEA', 0.87),
('Davida', 'Cinturão Principal', 326.0);

-- COMPOSIÇÃO_ASTEROIDE
INSERT INTO composicao_ast (composicao) VALUES
('Carbonáceo'),
('Silicatos'),
('Metálico'),
('Níquel-ferro'),
('Gelo');


-- COMPOSIÇÃO_cometa
INSERT INTO composicao_cometa (composicao) VALUES
('Metano'),
('Amônia'),
('Rocha'),
('Poeira'),
('CO2'),
('Gelo');

INSERT INTO cometa_composicao (id_cometa, id_composicao_cometa) VALUES
((SELECT id_cometa FROM cometa where nome = 'Halley'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Gelo')),
((SELECT id_cometa FROM cometa where nome = 'Halley'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Poeira')),
((SELECT id_cometa FROM cometa where nome = 'Halley'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Rocha')),
((SELECT id_cometa FROM cometa where nome = 'Encke'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Gelo')),
((SELECT id_cometa FROM cometa where nome = 'Encke'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Poeira')),
((SELECT id_cometa FROM cometa where nome = 'Hale-Bopp'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Gelo')),
((SELECT id_cometa FROM cometa where nome = 'Hale-Bopp'), (SELECT id_composicao_cometa FROM composicao_cometa where composicao = 'Amônia'));

-- TEMPESTADES
INSERT INTO tempestades (tipo_tempestade) VALUES
('Tempestade de poeira'),
('Furacão'),
('Tempestade elétrica'),
('Tempestade de gelo'),
('Tempestade de metano');

-- COMPOSIÇÕES
INSERT INTO composicao_atmosfera (composicao_atmosfera) VALUES
('Nitrogênio e Oxigênio'),
('Dióxido de Carbono'),
('Hidrogênio e Hélio'),
('Metano e Amônia'),
('Dióxido de Enxofre');

INSERT INTO composicao_crosta (composicao_crosta) VALUES
('Silicatos'),
('Basalto'),
('Granito'),
('Ferro e Níquel'),
('Gelo e Rocha');

INSERT INTO composicao_manto (composicao_manto) VALUES
('Peridotito'),
('Silicatos'),
('Ferro-Magnésio'),
('Gelo de água'),
('Rochas fundidas');

-- NEBULOSA
INSERT INTO nebulosa (id_galaxia, nome, tipo_nebulosa, distancia_anos_luz, tamanho_anos_luz) VALUES
((SELECT id_galaxia FROM galaxia WHERE nome = 'Via Láctea'), 'Nebulosa de Órion', 'Emissão', 1344.000, 24.000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Andrômeda'), 'Nebulosa do Caranguejo', 'Restos de Supernova', 6500.000, 11.000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Triângulo'), 'Nebulosa da Águia', 'Emissão', 7000.000, 70.000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Sombria'), 'Nebulosa de Helix', 'Planetária', 655.000, 2.500),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Espiral A'), 'Nebulosa de Laguna', 'Emissão', 4100.000, 110.000);

-- BURACO_NEGRO
INSERT INTO buraco_negro (id_galaxia, spin, massa_solar, raio_horizonte_evento_km) VALUES
((SELECT id_galaxia FROM galaxia WHERE nome = 'Via Láctea'), 0.98, 4.3e6, 12600000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Andrômeda'), 0.85, 6.5e9, 19500000000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Triângulo'), 0.70, 1.2e8, 360000000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Sombria'), 0.60, 3.0e7, 90000000),
((SELECT id_galaxia FROM galaxia WHERE nome = 'Galáxia Espiral A'), 0.95, 2.5e6, 7500000);


-- ORBITA_ESTRELA
INSERT INTO orbita_estrela (id_estrela, raio_km, perihelio_km, afelio_km, periodo_dias, excentricidade) VALUES
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), 149600000, 147100000, 152100000, 365.25, 0.017),
((SELECT id_estrela FROM estrela WHERE nome = 'Sirius'), 108200000, 107500000, 108900000, 224.70, 0.007),
((SELECT id_estrela FROM estrela WHERE nome = 'Betelgeuse'), 227900000, 206700000, 249200000, 687.00, 0.093),
((SELECT id_estrela FROM estrela WHERE nome = 'Rigel'), 778500000, 740500000, 816600000, 4331.00, 0.049),
((SELECT id_estrela FROM estrela WHERE nome = 'Vega'), 1433000000, 1353000000, 1513000000, 10747.00, 0.057);


-- PLANETA
INSERT INTO planeta (id_orbita_estrela, nome, massa_terra, raio_km, gravidade_m_s2, distancia_anos_luz) VALUES
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Sol') LIMIT 1), 'Terra', 1.00, 6371, 9.81, 0.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Sirius') LIMIT 1), 'Vênus', 0.82, 6052, 8.87, 0.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Betelgeuse') LIMIT 1), 'Marte', 0.11, 3390, 3.71, 0.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Rigel') LIMIT 1), 'Júpiter', 317.8, 69911, 24.79, 0.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Vega') LIMIT 1), 'Saturno', 95.2, 58232, 10.44, 0.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Sol') LIMIT 1), 'Kepler-22b', 2.4, 12000, 12.00, 600.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Sirius') LIMIT 1), 'Gliese 581g', 3.1, 14000, 13.00, 20.300),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Betelgeuse') LIMIT 1), 'HD 209458 b', 220.0, 90000, 9.00, 150.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Rigel') LIMIT 1), 'TRAPPIST-1e', 0.62, 5800, 7.80, 39.000),
((SELECT id_orbita_estrela FROM orbita_estrela WHERE id_estrela = (SELECT id_estrela FROM estrela WHERE nome = 'Vega') LIMIT 1), 'Proxima b', 1.27, 7100, 11.00, 4.240);

INSERT INTO gasoso (id_planeta, temperatura_atmosfera, velocidade_ventos) VALUES
((SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), 165.00, 400.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Saturno'), 134.00, 1800.00),
((SELECT id_planeta FROM planeta WHERE nome = 'HD 209458 b'), 1000.00, 2000.00),
((SELECT id_planeta FROM planeta WHERE nome = 'TRAPPIST-1e'), 250.00, 1500.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Proxima b'), 300.00, 1200.00);


INSERT INTO rochoso (id_planeta, topografia, vulcanismo, temperatura_superficie, presencia_agua_liquida, campo_magnetico) VALUES
((SELECT id_planeta FROM planeta WHERE nome = 'Terra'), 'Montanhas e oceanos', 'Moderado', 288.00, TRUE, 31.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Vênus'), 'Planícies e crateras', 'Intenso', 737.00, FALSE, 0.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Marte'), 'Cânions e desertos', 'Fraco', 210.00, FALSE, 15.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Kepler-22b'), 'Superfície rochosa', 'Desconhecido', 295.00, FALSE, 10.00),
((SELECT id_planeta FROM planeta WHERE nome = 'Gliese 581g'), 'Montanhas geladas', 'Desconhecido', 230.00, FALSE, 5.00);

INSERT INTO anao (id_planeta, criovulcanismo, albedo, gelo_volatil) VALUES
((SELECT id_planeta FROM planeta WHERE nome = 'Marte'), 'Possível', 0.67, TRUE),
((SELECT id_planeta FROM planeta WHERE nome = 'Gliese 581g'), 'Desconhecido', 0.45, TRUE),
((SELECT id_planeta FROM planeta WHERE nome = 'TRAPPIST-1e'), 'Sim', 0.52, TRUE),
((SELECT id_planeta FROM planeta WHERE nome = 'Proxima b'), 'Sim', 0.60, TRUE),
((SELECT id_planeta FROM planeta WHERE nome = 'Kepler-22b'), 'Não detectado', 0.30, FALSE);

-- AGRUPA_ESTRELA
INSERT INTO agrupa_estrela (id_constelacao, id_estrela) VALUES
((SELECT id_constelacao FROM constelacao WHERE nome = 'Órion'), (SELECT id_estrela FROM estrela WHERE nome = 'Sol')),
((SELECT id_constelacao FROM constelacao WHERE nome = 'Ursa Maior'), (SELECT id_estrela FROM estrela WHERE nome = 'Sirius')),
((SELECT id_constelacao FROM constelacao WHERE nome = 'Cassiopeia'), (SELECT id_estrela FROM estrela WHERE nome = 'Betelgeuse')),
((SELECT id_constelacao FROM constelacao WHERE nome = 'Escorpião'), (SELECT id_estrela FROM estrela WHERE nome = 'Rigel')),
((SELECT id_constelacao FROM constelacao WHERE nome = 'Cão Maior'), (SELECT id_estrela FROM estrela WHERE nome = 'Vega'));

-- INFLUENCIA_ESTRELA
INSERT INTO influencia_estrela (id_cometa, id_estrela) VALUES
((SELECT id_cometa FROM cometa WHERE nome = 'Halley'), (SELECT id_estrela FROM estrela WHERE nome = 'Sol')),
((SELECT id_cometa FROM cometa WHERE nome = 'Encke'), (SELECT id_estrela FROM estrela WHERE nome = 'Sirius')),
((SELECT id_cometa FROM cometa WHERE nome = 'Hale-Bopp'), (SELECT id_estrela FROM estrela WHERE nome = 'Betelgeuse')),
((SELECT id_cometa FROM cometa WHERE nome = 'Borrelly'), (SELECT id_estrela FROM estrela WHERE nome = 'Rigel')),
((SELECT id_cometa FROM cometa WHERE nome = 'Tempel 1'), (SELECT id_estrela FROM estrela WHERE nome = 'Vega'));

-- ASTEROIDE_COMPOSICAO
INSERT INTO asteroide_composicao (id_asteroide, id_composicao_ast) VALUES
((SELECT id_asteroide FROM asteroide WHERE nome = 'Ceres'), (SELECT id_composicao_ast FROM composicao_ast WHERE composicao = 'Carbonáceo')),
((SELECT id_asteroide FROM asteroide WHERE nome = 'Vesta'), (SELECT id_composicao_ast FROM composicao_ast WHERE composicao = 'Silicatos')),
((SELECT id_asteroide FROM asteroide WHERE nome = 'Pallas'), (SELECT id_composicao_ast FROM composicao_ast WHERE composicao = 'Metálico')),
((SELECT id_asteroide FROM asteroide WHERE nome = 'Hygiea'), (SELECT id_composicao_ast FROM composicao_ast WHERE composicao = 'Níquel-ferro')),
((SELECT id_asteroide FROM asteroide WHERE nome = 'Eros'), (SELECT id_composicao_ast FROM composicao_ast WHERE composicao = 'Gelo'));



-- INTERACAO
INSERT INTO interacao (id_planeta, id_asteroide, risco_colisao) VALUES
((SELECT id_planeta FROM planeta WHERE nome = 'Terra'), (SELECT id_asteroide FROM asteroide WHERE nome = 'Ceres'), FALSE),
((SELECT id_planeta FROM planeta WHERE nome = 'Vênus'), (SELECT id_asteroide FROM asteroide WHERE nome = 'Vesta'), FALSE),
((SELECT id_planeta FROM planeta WHERE nome = 'Marte'), (SELECT id_asteroide FROM asteroide WHERE nome = 'Pallas'), TRUE),
((SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), (SELECT id_asteroide FROM asteroide WHERE nome = 'Hygiea'), FALSE),
((SELECT id_planeta FROM planeta WHERE nome = 'Saturno'), (SELECT id_asteroide FROM asteroide WHERE nome = 'Eros'), TRUE);

-- SATELITE
INSERT INTO satelite (id_planeta, nome) VALUES
((SELECT id_planeta FROM planeta WHERE nome = 'Terra'), 'Lua'),
((SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), 'Io'),
((SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), 'Europa'),
((SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), 'Ganimedes'),
((SELECT id_planeta FROM planeta WHERE nome = 'Saturno'), 'Titã');

-- SAT_NATURAL
INSERT INTO sat_natural (id_satelite, massa_terra, raio_km, periodo_horas, descricao) VALUES
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 0.0123, 1737.1, 655.72, 'Satélite natural da Terra'),
((SELECT id_satelite FROM satelite WHERE nome = 'Io'), 0.015, 1821.6, 152.85, 'Satélite vulcânico de Júpiter'),
((SELECT id_satelite FROM satelite WHERE nome = 'Europa'), 0.008, 1560.8, 85.23, 'Possui oceano subterrâneo'),
((SELECT id_satelite FROM satelite WHERE nome = 'Ganimedes'), 0.025, 2634.1, 171.72, 'Maior satélite do sistema solar'),
((SELECT id_satelite FROM satelite WHERE nome = 'Titã'), 0.022, 2575.0, 382.68, 'Atmosfera densa de nitrogênio');

-- SAT_ARTIFICIAL
INSERT INTO sat_artificial (id_satelite, tamanho_m, objetivo, responsavel, status) VALUES
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 10.00, 'Observação terrestre', 'NASA', 'Ativo'),
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 3.50, 'Comunicação', 'ESA', 'Inativo'),
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 2.00, 'Meteorologia', 'INPE', 'Ativo'),
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 5.00, 'GPS', 'USAF', 'Ativo'),
((SELECT id_satelite FROM satelite WHERE nome = 'Lua'), 4.20, 'Pesquisa científica', 'JAXA', 'Ativo');

-- ORBITA_PLANETA
INSERT INTO orbita_planeta (id_estrela, id_planeta, raio_km, perihelio_km, afelio_km, periodo_dias, excentricidade) VALUES
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), (SELECT id_planeta FROM planeta WHERE nome = 'Terra'), 149600000, 147100000, 152100000, 365.25, 0.017),
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), (SELECT id_planeta FROM planeta WHERE nome = 'Vênus'), 108200000, 107500000, 108900000, 224.70, 0.007),
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), (SELECT id_planeta FROM planeta WHERE nome = 'Marte'), 227900000, 206700000, 249200000, 687.00, 0.093),
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), (SELECT id_planeta FROM planeta WHERE nome = 'Júpiter'), 778500000, 740500000, 816600000, 4331.00, 0.049),
((SELECT id_estrela FROM estrela WHERE nome = 'Sol'), (SELECT id_planeta FROM planeta WHERE nome = 'Saturno'), 1433000000, 1353000000, 1513000000, 10747.00, 0.057);
