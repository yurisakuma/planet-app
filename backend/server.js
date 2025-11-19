import express from 'express';
import cors from 'cors';
import pool from './database.js';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.get('/api/planets', async (req, res) => {
  try {
    const { search, minMass, maxMass, planetType } = req.query;
    
    let query = `
      SELECT 
        p.*,
        e.nome as estrela_nome,
        g.nome as galaxia_nome,
        u.nome as universo_nome,
        CASE 
          WHEN gas.id_planeta IS NOT NULL THEN 'Gasoso'
          WHEN roc.id_planeta IS NOT NULL THEN 'Rochoso' 
          WHEN ana.id_planeta IS NOT NULL THEN 'Anão'
          ELSE 'Desconhecido'
        END as tipo_planeta
      FROM planeta p
      JOIN orbita_estrela oe ON p.id_orbita_estrela = oe.id_orbita_estrela
      JOIN estrela e ON oe.id_estrela = e.id_estrela
      JOIN galaxia g ON e.id_galaxia = g.id_galaxia
      JOIN universo u ON g.id_universo = u.id_universo
      LEFT JOIN gasoso gas ON p.id_planeta = gas.id_planeta
      LEFT JOIN rochoso roc ON p.id_planeta = roc.id_planeta
      LEFT JOIN anao ana ON p.id_planeta = ana.id_planeta
      WHERE 1=1
    `;
    
    const params = [];
    let paramCount = 0;

    if (search) {
      paramCount++;
      query += ` AND (p.nome ILIKE $${paramCount} OR e.nome ILIKE $${paramCount})`;
      params.push(`%${search}%`);
    }

    if (minMass) {
      paramCount++;
      query += ` AND p.massa_terra >= $${paramCount}`;
      params.push(parseFloat(minMass));
    }

    if (maxMass) {
      paramCount++;
      query += ` AND p.massa_terra <= $${paramCount}`;
      params.push(parseFloat(maxMass));
    }

    if (planetType && planetType !== 'all') {
      paramCount++;
      if (planetType === 'gasoso') {
        query += ` AND gas.id_planeta IS NOT NULL`;
      } else if (planetType === 'rochoso') {
        query += ` AND roc.id_planeta IS NOT NULL`;
      } else if (planetType === 'anao') {
        query += ` AND ana.id_planeta IS NOT NULL`;
      }
    }

    query += ` ORDER BY p.nome`;
    
    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching planets:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/api/orbits', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT oe.id_orbita_estrela, e.nome as estrela_nome, oe.raio_km
      FROM orbita_estrela oe
      JOIN estrela e ON oe.id_estrela = e.id_estrela
      ORDER BY e.nome
    `);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching orbits:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/planets', async (req, res) => {
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    const { 
      nome, 
      massa_terra, 
      raio_km, 
      gravidade_m_s2, 
      distancia_anos_luz, 
      id_orbita_estrela,
      tipo_planeta,
      temperatura_atmosfera,
      velocidade_ventos,
      topografia,
      vulcanismo,
      temperatura_superficie,
      presencia_agua_liquida,
      campo_magnetico,
      criovulcanismo,
      albedo,
      gelo_volatil
    } = req.body;

    const planetResult = await client.query(
      `INSERT INTO planeta (id_orbita_estrela, nome, massa_terra, raio_km, gravidade_m_s2, distancia_anos_luz) 
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING id_planeta`,
      [id_orbita_estrela, nome, massa_terra, raio_km, gravidade_m_s2, distancia_anos_luz]
    );

    const planetId = planetResult.rows[0].id_planeta;

    if (tipo_planeta === 'gasoso' && temperatura_atmosfera && velocidade_ventos) {
      await client.query(
        `INSERT INTO gasoso (id_planeta, temperatura_atmosfera, velocidade_ventos) VALUES ($1, $2, $3)`,
        [planetId, temperatura_atmosfera, velocidade_ventos]
      );
    } else if (tipo_planeta === 'rochoso') {
      await client.query(
        `INSERT INTO rochoso (id_planeta, topografia, vulcanismo, temperatura_superficie, presencia_agua_liquida, campo_magnetico) 
         VALUES ($1, $2, $3, $4, $5, $6)`,
        [planetId, topografia, vulcanismo, temperatura_superficie, presencia_agua_liquida, campo_magnetico]
      );
    } else if (tipo_planeta === 'anao' && criovulcanismo && albedo !== undefined) {
      await client.query(
        `INSERT INTO anao (id_planeta, criovulcanismo, albedo, gelo_volatil) VALUES ($1, $2, $3, $4)`,
        [planetId, criovulcanismo, albedo, gelo_volatil || false]
      );
    }

    await client.query('COMMIT');
    res.status(201).json({ message: 'Planet created successfully', id: planetId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating planet:', error);
    res.status(500).json({ error: 'Internal server error' });
  } finally {
    client.release();
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});