-- ================================================================
--  BLUSHE – Migración: Soporte de Tonos y Variantes
--  Ejecutar en: Supabase Dashboard → SQL Editor → New query
-- ================================================================

-- 1. Agregar columna 'variants' a la tabla products
ALTER TABLE products ADD COLUMN IF NOT EXISTS variants JSONB DEFAULT '[]'::jsonb;

-- 2. Índice para rendimiento en consultas JSON
CREATE INDEX IF NOT EXISTS idx_products_variants ON products USING gin (variants);

-- 3. (Opcional) Ejemplo de tonos para los productos de ejemplo existentes
UPDATE products
SET variants = '[
  {"name": "01 Nude Cálido", "color": "#d89c7d"},
  {"name": "02 Rosa Vintage", "color": "#c76d7e"},
  {"name": "03 Rojo Pasión", "color": "#a82435"},
  {"name": "04 Berry Intenso", "color": "#6d1d36"}
]'::jsonb
WHERE category = 'labios' AND (variants IS NULL OR variants = '[]'::jsonb);

UPDATE products
SET variants = '[
  {"name": "01 Claro Ivory", "color": "#f3d3b8"},
  {"name": "02 Medio Natural", "color": "#e2b896"},
  {"name": "03 Canela Cálido", "color": "#c9956f"},
  {"name": "04 Moreno Dorado", "color": "#a6734c"}
]'::jsonb
WHERE category = 'rostro' AND name ILIKE '%base%' AND (variants IS NULL OR variants = '[]'::jsonb);
