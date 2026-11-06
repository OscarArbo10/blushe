-- ================================================================
--  BLUSHE – Script SQL para Supabase
--  Ejecutar en: Supabase Dashboard → SQL Editor → New query
-- ================================================================

-- 1. TABLA DE PRODUCTOS
CREATE TABLE IF NOT EXISTS products (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT        NOT NULL,
  brand       TEXT        NOT NULL DEFAULT 'Blushe',
  price       INTEGER     NOT NULL,          -- precio en pesos COP (sin decimales)
  old_price   INTEGER     DEFAULT NULL,      -- precio tachado (opcional)
  category    TEXT        NOT NULL,          -- labios | ojos | rostro | cuidado | paletas | herramientas
  emoji       TEXT        NOT NULL DEFAULT '💄',
  badge       TEXT        DEFAULT NULL,      -- "Nuevo", "Oferta", "-20%", etc.
  stars       INTEGER     NOT NULL DEFAULT 5 CHECK (stars BETWEEN 1 AND 5),
  reviews     INTEGER     NOT NULL DEFAULT 0,
  description TEXT        DEFAULT NULL,
  active      BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. TRIGGER: actualiza updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_products_updated_at ON products;
CREATE TRIGGER trg_products_updated_at
  BEFORE UPDATE ON products
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 3. ROW LEVEL SECURITY
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Lectura pública (la tienda puede leer sin login)
CREATE POLICY "Lectura publica de productos"
  ON products FOR SELECT
  USING (active = TRUE);

-- Escritura solo para usuarios autenticados (admin)
CREATE POLICY "Solo admin puede insertar"
  ON products FOR INSERT
  TO authenticated
  WITH CHECK (TRUE);

CREATE POLICY "Solo admin puede actualizar"
  ON products FOR UPDATE
  TO authenticated
  USING (TRUE);

CREATE POLICY "Solo admin puede eliminar"
  ON products FOR DELETE
  TO authenticated
  USING (TRUE);

-- 4. DATOS DE EJEMPLO (24 productos)
INSERT INTO products (name, brand, price, old_price, category, emoji, badge, stars, reviews, description) VALUES
-- LABIOS
('Labial Líquido Matte',      'Blushe Pro',     28000, 35000, 'labios',       '💄', 'Oferta',    5, 128, 'Acabado aterciopelado de larga duración. 12 tonos disponibles.'),
('Lip Gloss Crystal',         'Blushe Glow',    22000, NULL,  'labios',       '✨', NULL,        4,  74, 'Brillo cristalino con partículas holográficas. Hidratante.'),
('Lápiz Delineador Labios',   'Blushe Pro',     15000, NULL,  'labios',       '🖊️', NULL,        5,  56, 'Delineado preciso y duradero. Compatible con todos los labiales.'),
('Bálsamo Labial Hidratante', 'Blushe Care',    12000, NULL,  'labios',       '🌸', NULL,        5, 203, 'Hidratación intensa con vitamina E y aceite de argán.'),
-- OJOS
('Máscara de Pestañas Volume','Blushe Pro',     32000, 40000, 'ojos',         '👁️', '-20%',      5, 156, 'Volumen extremo y efecto abanico. Fórmula waterproof.'),
('Eyeliner Waterproof',       'Blushe Pro',     18000, NULL,  'ojos',         '🖋️', NULL,        4,  89, 'Trazo fino y preciso. Resistente al agua y al sudor.'),
('Delineador Ojos Kohl',      'Blushe Classic', 14000, NULL,  'ojos',         '🌑', NULL,        5, 112, 'Pigmentación intensa. Ideal para look ahumado.'),
('Primer para Ojos',          'Blushe Pro',     25000, NULL,  'ojos',         '💫', NULL,        4,  43, 'Base perfecta para que las sombras duren todo el día.'),
-- ROSTRO
('Base Fluida 24H',           'Blushe Pro',     55000, 68000, 'rostro',       '🌟', 'Nuevo',     5, 230, 'Cobertura media-alta. SPF 15. 30 tonos para todos los tipos de piel.'),
('Polvo Compacto Traslúcido', 'Blushe Classic', 38000, NULL,  'rostro',       '✨', NULL,        4,  95, 'Fija el maquillaje y controla el brillo. Acabado satinado.'),
('Blush en Polvo Coral',      'Blushe Glow',    29000, NULL,  'rostro',       '🌺', NULL,        5, 167, 'Color vibrante coral con un toque dorado. Buildable.'),
('Contorno y Bronzer',        'Blushe Pro',     42000, NULL,  'rostro',       '🏆', 'Top Venta', 5, 315, 'Dúo perfecto para definir y broncear. Textura sedosa.'),
('Iluminador Holográfico',    'Blushe Glow',    35000, NULL,  'rostro',       '💎', NULL,        5, 188, 'Destellos multidimensionales para un acabado glow.'),
('Corrector Fluido',          'Blushe Pro',     31000, NULL,  'rostro',       '🌙', NULL,        4,  72, 'Cobertura total. Fórmula hidratante que no se cuartea.'),
-- CUIDADO
('Sérum Vitamina C',          'Blushe Care',    65000, 80000, 'cuidado',      '🍊', 'Bestseller',5, 421, 'Luminosidad y uniformidad desde la primera semana. 20% Vitamina C.'),
('Mascarilla de Colágeno',    'Blushe Care',    45000, NULL,  'cuidado',      '🌿', NULL,        5, 134, 'Rellena y reafirma la piel en 15 minutos. Para todo tipo de piel.'),
('Crema Hidratante SPF 50',   'Blushe Care',    58000, NULL,  'cuidado',      '☀️', NULL,        5, 276, 'Hidratación 72 horas + protección solar UVA/UVB. Sin rastro blanco.'),
('Desmaquillante Micelar',    'Blushe Care',    28000, NULL,  'cuidado',      '💧', NULL,        5, 198, 'Elimina maquillaje resistente sin frotar. Sin enjuague.'),
-- PALETAS
('Paleta Sombras Sunset',     'Blushe Artistry',75000, 95000, 'paletas',      '🎨', '-21%',      5, 347, '18 tonos cálidos: neutros, naranjas y rojos. Alta pigmentación.'),
('Paleta Mini Nude',          'Blushe Classic', 48000, NULL,  'paletas',      '🌰', NULL,        4,  89, '9 tonos nude perfectos para maquillaje diario y de noche.'),
('Paleta Glitter & Shine',    'Blushe Artistry',82000, NULL,  'paletas',      '🌈', 'Nuevo',     5, 156, '12 tonos metálicos y glitter prensado. Look fiesta garantizado.'),
-- HERRAMIENTAS
('Set de Brochas 12 piezas',  'Blushe Tools',   68000, NULL,  'herramientas', '🖌️', 'Set',       5, 412, 'Pelo sintético vegano. Mango ergonómico. Estuche incluido.'),
('Esponja Beauty Blender',    'Blushe Tools',   22000, NULL,  'herramientas', '🟡', NULL,        5, 289, 'Aplicación sin manchas. Usar húmeda para acabado airbrush.'),
('Rizador de Pestañas',       'Blushe Tools',   18000, NULL,  'herramientas', '🔮', NULL,        4, 134, 'Curvatura perfecta sin pellizcar. Almohadilla de silicona suave.');
