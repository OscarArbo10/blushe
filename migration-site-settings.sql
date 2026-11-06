-- ================================================================
--  BLUSHE – Migración: Ajustes editables de la página + descuentos
--  Ejecutar en: Supabase Dashboard → SQL Editor → New query
--  (es seguro ejecutarlo más de una vez)
-- ================================================================

-- 1. Descuento por producto (porcentaje). price = precio final, old_price = precio original
ALTER TABLE products ADD COLUMN IF NOT EXISTS discount_percent INTEGER DEFAULT NULL
  CHECK (discount_percent IS NULL OR (discount_percent >= 0 AND discount_percent <= 95));

-- Productos que ya tenían precio tachado: calcula su % automáticamente
UPDATE products
SET discount_percent = ROUND((1 - price::numeric / old_price) * 100)
WHERE old_price IS NOT NULL AND old_price > price AND discount_percent IS NULL;

-- 2. Tabla de ajustes del sitio (una sola fila, id = 1)
CREATE TABLE IF NOT EXISTS site_settings (
  id         INTEGER PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  settings   JSONB NOT NULL DEFAULT '{}'::jsonb,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO site_settings (id, settings) VALUES (1, '{}'::jsonb) ON CONFLICT (id) DO NOTHING;

ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Lectura publica de ajustes" ON site_settings;
CREATE POLICY "Lectura publica de ajustes" ON site_settings FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Admin inserta ajustes" ON site_settings;
CREATE POLICY "Admin inserta ajustes" ON site_settings FOR INSERT TO authenticated WITH CHECK (TRUE);

DROP POLICY IF EXISTS "Admin actualiza ajustes" ON site_settings;
CREATE POLICY "Admin actualiza ajustes" ON site_settings FOR UPDATE TO authenticated USING (TRUE) WITH CHECK (TRUE);

-- 3. El logo se guarda en el bucket público 'products' (carpeta site/), que ya existe.
