-- ================================================================
--  BLUSHE – Migración: Soporte multi-imagen para productos
--  Ejecutar en: Supabase Dashboard → SQL Editor → New query
--  ⚠️  Ejecutar DESPUÉS de haber corrido supabase-setup.sql
-- ================================================================

-- 1. Agregar columna 'images' (array JSON de URLs)
ALTER TABLE products ADD COLUMN IF NOT EXISTS images JSONB DEFAULT '[]'::jsonb;

-- 2. Migrar image_url existente al array images
UPDATE products
SET images = jsonb_build_array(image_url)
WHERE image_url IS NOT NULL
  AND image_url != ''
  AND (images IS NULL OR images = '[]'::jsonb);

-- 3. Índice para búsquedas en images (opcional, mejora rendimiento)
CREATE INDEX IF NOT EXISTS idx_products_images ON products USING gin (images);
