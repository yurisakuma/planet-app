-- 1. UNIVERSO ⟶ GALÁXIA (1:N)
CREATE TABLE universo (
  id_universo SERIAL PRIMARY KEY,
  idade_bilhoes_anos DECIMAL(5,2) CHECK (idade_bilhoes_anos > 0),
  diametro_bilhoes_anos DECIMAL(7,2) CHECK (diametro_bilhoes_anos > 0),
  nome VARCHAR(50) NOT NULL
);

CREATE TABLE galaxia (
  id_galaxia SERIAL PRIMARY KEY,
  id_universo INT NOT NULL,
  massa_solar DOUBLE PRECISION CHECK (massa_solar > 0),
  num_estrela_aprox BIGINT CHECK (num_estrela_aprox > 0),
  nome VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_universo) REFERENCES universo(id_universo)
);

-- 2. NEBULOSA & BURACO_NEGRO ← GALÁXIA (1:N)
CREATE TABLE nebulosa (
  id_nebulosa SERIAL PRIMARY KEY,
  id_galaxia INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  tipo_nebulosa VARCHAR(30),
  distancia_anos_luz DECIMAL(10,3),
  tamanho_anos_luz DECIMAL(10,3),
  FOREIGN KEY (id_galaxia) REFERENCES galaxia(id_galaxia)
);

CREATE TABLE buraco_negro (
  id_buraco_negro SERIAL PRIMARY KEY,
  id_galaxia INT NOT NULL,
  spin DECIMAL(4,2),
  massa_solar DOUBLE PRECISION,
  raio_horizonte_evento_km DOUBLE PRECISION,
  FOREIGN KEY (id_galaxia) REFERENCES galaxia(id_galaxia)
);

-- 3. CONSTELAÇÃO ⟷ ESTRELA (M:N)
CREATE TABLE constelacao (
  id_constelacao SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  area_grau2 DECIMAL(7,2) CHECK (area_grau2 > 0),
  numero_estrela INT CHECK (numero_estrela > 0)
);

CREATE TABLE estrela (
  id_estrela SERIAL PRIMARY KEY,
  id_galaxia INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  massa_solar DOUBLE PRECISION CHECK (massa_solar > 0),
  raio_solar DOUBLE PRECISION CHECK (raio_solar > 0),
  luminosidade DOUBLE PRECISION CHECK (luminosidade > 0),
  temperatura_k INT CHECK (temperatura_k > 0),
  idade_milhoes_anos DECIMAL(7,2) CHECK (idade_milhoes_anos > 0),
  FOREIGN KEY (id_galaxia) REFERENCES galaxia(id_galaxia)
);

CREATE TABLE tipo_espectral_estrela (
	id_tipo_espectral SERIAL PRIMARY KEY,
    id_estrela INT NOT NULL,
    tipo_espectral VARCHAR(10),
	FOREIGN KEY (id_estrela) REFERENCES estrela(id_estrela)
);

CREATE TABLE agrupa_estrela (
  id_agrupa_estrela SERIAL PRIMARY KEY,
  id_constelacao INT NOT NULL,
  id_estrela INT NOT NULL,
  FOREIGN KEY (id_constelacao) REFERENCES constelacao(id_constelacao),
  FOREIGN KEY (id_estrela) REFERENCES estrela(id_estrela)
);

-- 4. COMETA ⟷ ESTRELA (M:N)
CREATE TABLE cometa (
  id_cometa SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  periodo_orbital_anos DECIMAL(6,2) CHECK (periodo_orbital_anos > 0),
  velocidade_km_s DECIMAL(6,2) CHECK (velocidade_km_s > 0)
);

-- COMPOSIÇÃO_COMETA (M:N)
CREATE TABLE composicao_cometa (
  id_composicao_cometa SERIAL PRIMARY KEY,
  composicao VARCHAR(50)
);

-- 10. RELAÇÃO COMETA-COMPOSIÇÃO
CREATE TABLE cometa_composicao (
  id_cometa INT,
  id_composicao_cometa INT,
  FOREIGN KEY (id_cometa) REFERENCES cometa(id_cometa),
  FOREIGN KEY (id_composicao_cometa) REFERENCES composicao_cometa(id_composicao_cometa)
);

CREATE TABLE influencia_estrela (
  id_influencia_estrela SERIAL PRIMARY KEY,
  id_cometa INT NOT NULL,
  id_estrela INT NOT NULL,
  FOREIGN KEY (id_cometa) REFERENCES cometa(id_cometa),
  FOREIGN KEY (id_estrela) REFERENCES estrela(id_estrela)
);

-- 5. PLANETA ← Órbita (1:N)
CREATE TABLE orbita_estrela (
  id_orbita_estrela SERIAL PRIMARY KEY,
  id_estrela INT NOT NULL,
  raio_km DOUBLE PRECISION CHECK (raio_km > 0),
  perihelio_km DOUBLE PRECISION CHECK (perihelio_km > 0),
  afelio_km DOUBLE PRECISION CHECK (afelio_km > 0),
  periodo_dias DECIMAL(8,2) CHECK (periodo_dias > 0),
  excentricidade DECIMAL(4,3) CHECK (excentricidade >= 0),
  FOREIGN KEY (id_estrela) REFERENCES estrela(id_estrela)
);

CREATE TABLE planeta (
  id_planeta SERIAL PRIMARY KEY,
  id_orbita_estrela INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  massa_terra DOUBLE PRECISION,
  raio_km DOUBLE PRECISION,
  gravidade_m_s2 DECIMAL(5,2),
  distancia_anos_luz DECIMAL(10,3),
  FOREIGN KEY (id_orbita_estrela) REFERENCES orbita_estrela(id_orbita_estrela)
);

-- 6. TIPO_PLANETA ← Planeta (1:1)
CREATE TABLE gasoso (
  id_gasosos SERIAL PRIMARY KEY,
  id_planeta INT,
  temperatura_atmosfera DECIMAL(6,2),
  velocidade_ventos DECIMAL(6,2) CHECK (velocidade_ventos >= 0),
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);

CREATE TABLE rochoso (
  id_rochoso SERIAL PRIMARY KEY,
  id_planeta INT,
  topografia VARCHAR(100),
  vulcanismo VARCHAR(100),
  temperatura_superficie DECIMAL(6,2),
  presencia_agua_liquida BOOLEAN,
  campo_magnetico DECIMAL(6,2),
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);

CREATE TABLE anao (
  id_ano SERIAL PRIMARY KEY,
  id_planeta INT,
  criovulcanismo VARCHAR(100),
  albedo DECIMAL(4,2),
  gelo_volatil BOOLEAN,
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);

-- 7. CARACTERISTICAS SOBRE PLANETA (1:N)
CREATE TABLE tempestades (
  id_tempestade SERIAL PRIMARY KEY,
  tipo_tempestade VARCHAR(50)
);

CREATE TABLE composicao_atmosfera (
  id_composicao_atmosfera SERIAL PRIMARY KEY,
  composicao_atmosfera VARCHAR(100)
);

CREATE TABLE composicao_crosta (
  id_composicao_crosta SERIAL PRIMARY KEY,
  composicao_crosta VARCHAR(100)
);

CREATE TABLE composicao_manto (
  id_composicao_manto SERIAL PRIMARY KEY,
  composicao_manto VARCHAR(100)
);

CREATE TABLE caracteristica (
  id_tempestade INT,
  id_composicao_atmosfera INT,
  id_composicao_crosta INT,
  id_composicao_manto INT,
  id_planeta INT NOT NULL,
  FOREIGN KEY (id_tempestade) REFERENCES tempestades(id_tempestade),
  FOREIGN KEY (id_composicao_atmosfera) REFERENCES composicao_atmosfera(id_composicao_atmosfera),
  FOREIGN KEY (id_composicao_crosta) REFERENCES composicao_crosta(id_composicao_crosta),
  FOREIGN KEY (id_composicao_manto) REFERENCES composicao_manto(id_composicao_manto),
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);

-- 8. ASTEROIDE
CREATE TABLE asteroide (
  id_asteroide SERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  classe_orbital VARCHAR(30),
  diametro_km DECIMAL(7,2) CHECK (diametro_km >= 0)
);

-- 9. COMPOSIÇÃO_ASTEROIDE (M:N)
CREATE TABLE composicao_ast (
  id_composicao_ast SERIAL PRIMARY KEY,
  composicao VARCHAR(50)
);

-- 10. RELAÇÃO ASTEROIDE-COMPOSIÇÃO
CREATE TABLE asteroide_composicao (
  id_asteroide INT,
  id_composicao_ast INT,
  FOREIGN KEY (id_asteroide) REFERENCES asteroide(id_asteroide),
  FOREIGN KEY (id_composicao_ast) REFERENCES composicao_ast(id_composicao_ast)
);

-- 11. INTERAÇÃO PLANETA–ASTEROIDE
CREATE TABLE interacao (
  id_interacao SERIAL PRIMARY KEY,
  id_planeta INT,
  id_asteroide INT NOT NULL,
  risco_colisao BOOLEAN,
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta),
  FOREIGN KEY (id_asteroide) REFERENCES asteroide(id_asteroide)
);

-- 12. INTERAÇÃO PLANETA–SATÉLITE
CREATE TABLE satelite (
  id_satelite SERIAL PRIMARY KEY,
  id_planeta INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);

CREATE TABLE sat_natural (
  id_sat_natural SERIAL PRIMARY KEY,
  id_satelite INT,
  massa_terra DOUBLE PRECISION,
  raio_km DOUBLE PRECISION,
  periodo_horas DECIMAL(6,2),
  descricao VARCHAR(255),
  FOREIGN KEY (id_satelite) REFERENCES satelite(id_satelite)
);

CREATE TABLE sat_artificial (
  id_sat_artificial SERIAL PRIMARY KEY,
  id_satelite INT NOT NULL,
  tamanho_m DECIMAL(6,2),
  objetivo VARCHAR(100),
  responsavel VARCHAR(50),
  status VARCHAR(20),
  FOREIGN KEY (id_satelite) REFERENCES satelite(id_satelite)
);

-- 13. ÓRBITA PLANETA
CREATE TABLE orbita_planeta (
  id_orbita_planeta_id SERIAL PRIMARY KEY,
  id_estrela INT NOT NULL,
  id_planeta INT NOT NULL,
  raio_km DOUBLE PRECISION CHECK (raio_km > 0),
  perihelio_km DOUBLE PRECISION CHECK (perihelio_km > 0),
  afelio_km DOUBLE PRECISION CHECK (afelio_km > 0),
  periodo_dias DECIMAL(8,2) CHECK (periodo_dias > 0),
  excentricidade DECIMAL(4,3) CHECK (excentricidade >= 0),
  FOREIGN KEY (id_estrela) REFERENCES estrela(id_estrela),
  FOREIGN KEY (id_planeta) REFERENCES planeta(id_planeta)
);