-- ================================================================
--  BLUSHE – Migración: Tabla de Categorías dinámicas
--  Ejecutar en: Supabase Dashboard → SQL Editor → New query
-- ================================================================

-- 1. Crear tabla de categorías
CREATE TABLE IF NOT EXISTS categories (
  id         BIGSERIAL PRIMARY KEY,
  name       TEXT NOT NULL,
  slug       TEXT NOT NULL UNIQUE,
  emoji      TEXT NOT NULL DEFAULT '✨',
  active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Row Level Security
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- Lectura pública para la tienda
DROP POLICY IF EXISTS "Lectura publica de categorias" ON categories;
CREATE POLICY "Lectura publica de categorias"
  ON categories FOR SELECT
  USING (active = TRUE);

-- Escritura para usuarios autenticados (admin)
DROP POLICY IF EXISTS "Solo admin puede insertar categorias" ON categories;
CREATE POLICY "Solo admin puede insertar categorias"
  ON categories FOR INSERT
  TO authenticated
  WITH CHECK (TRUE);

DROP POLICY IF EXISTS "Solo admin puede actualizar categorias" ON categories;
CREATE POLICY "Solo admin puede actualizar categorias"
  ON categories FOR UPDATE
  TO authenticated
  USING (TRUE);

DROP POLICY IF EXISTS "Solo admin puede eliminar categorias" ON categories;
CREATE POLICY "Solo admin puede eliminar categorias"
  ON categories FOR DELETE
  TO authenticated
  USING (TRUE);

-- 3. Categorías iniciales predeterminadas
INSERT INTO categories (name, slug, emoji) VALUES
  ('Labios',       'labios',       '💋'),
  ('Ojos',         'ojos',         '👁️'),
  ('Rostro',       'rostro',       '✨'),
  ('Cuidado',      'cuidado',      '🌿'),
  ('Paletas',      'paletas',      '🎨'),
  ('Herramientas', 'herramientas', '🖌️')
ON CONFLICT (slug) DO NOTHING;
