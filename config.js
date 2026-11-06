// ================================================================
//  BLUSHE – Configuración de Supabase
//  ⚠️  Reemplaza los valores con los de tu proyecto en Supabase
// ================================================================

const SUPABASE_URL  = 'https://iqweqloruoiwuvirhkzs.supabase.co';   // Project URL
const SUPABASE_KEY  = 'sb_publishable_hgCoaqZkEpbAws-By9GIug_U4g0HnKO';  // anon public key
const WHATSAPP_NUMBER = '573504330055';

// ================================================================
//  Valores por defecto de la página (se pueden editar desde el
//  panel admin → "Mi página"; lo guardado en Supabase tiene prioridad)
// ================================================================
const THEMES = {
  rosa:     { name: 'Rosa clásico', color: '#c2607f' },
  nude:     { name: 'Nude',         color: '#a87b5f' },
  berry:    { name: 'Berry',        color: '#9c2f5e' },
  lavanda:  { name: 'Lavanda',      color: '#8265b5' },
  coral:    { name: 'Coral',        color: '#e0654f' },
  dorado:   { name: 'Dorado',       color: '#b58a2f' }
};

const SITE_DEFAULTS = {
  theme: 'custom',
  page_size: 12,
  dark_toggle: true,
  hero_image: '',
  banners: [],
  show_category_cards: true,
  show_bestsellers: true,
  bestsellers_title: '⭐ Lo más vendido',
  category_order: [],
  facebook: '',
  tiktok: '',
  payment_methods: 'Transferencia, Nequi, Daviplata, Efectivo',
  site_name: 'blushe',
  logo_url: '',
  primary_color: '#c2607f',
  announcement: '🚚 Envío gratis en compras desde $50.000 · 💕 Pago fácil por WhatsApp',
  hero_tag: '✨ Nueva Colección',
  hero_title: 'Tu glow, tu esencia',
  hero_accent: 'tu Blushé.',
  hero_subtitle: 'Maquillaje premium que realza tu esencia. Descubre la colección que te hará brillar cada día.',
  hero_words: 'glow, esencia, brillo, estilo',
  hero_cta: 'Explorar Tienda 💄',
  products_title: 'Nuestros Productos',
  products_subtitle: 'productos premium para tu rutina de belleza',
  offers_title: '🔥 Ofertas del momento',
  promo_enabled: true,
  promo_title: '🎁 Oferta Especial',
  promo_text: 'Aprovecha los descuentos de la temporada en productos seleccionados.',
  testimonials_title: 'Lo que dicen nuestras clientas',
  testimonials_subtitle: 'Únete a las mujeres que confían en Blushe ❤️',
  testimonials: [
    { name: 'Valentina M.', avatar: '👩', text: 'El labial líquido es increíble, dura todo el día y el color es precioso.' },
    { name: 'Daniela R.', avatar: '👩‍🦱', text: 'La base de maquillaje me encantó, cobertura perfecta. La atención fue muy personalizada 💕' },
    { name: 'Sofía L.', avatar: '🧑‍🦰', text: 'Compré la paleta de sombras y quedé enamorada. Los colores son preciosos.' },
    { name: 'Camila T.', avatar: '👩‍🦳', text: 'Excelente calidad y precio. Me encanta que puedo pedir por WhatsApp.' }
  ],
  instagram_title: '📸 Síguenos en Instagram',
  instagram_text: 'Inspírate con nuestros looks y descubre las últimas tendencias',
  instagram_handle: 'blus.hebeauty',
  footer_slogan: 'Belleza auténtica para mujeres reales',
  footer_location: '📍 Colombia',
  whatsapp: WHATSAPP_NUMBER,
  shipping_cost: 0,
  free_shipping_min: 50000
};
