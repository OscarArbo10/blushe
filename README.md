# 🌸 Blushe – Tienda de Maquillaje

Sitio web de la tienda **Blushe** listo para producción.

## 📁 Archivos
- `index.html` — Tienda completa con categorías dinámicas, galería multi-imagen y WhatsApp
- `login.html` — Página dedicada de inicio de sesión para el administrador
- `admin.html` — Panel de administración (productos, gestión de categorías, multi-imagen)
- `config.js` — Configuración de Supabase y WhatsApp
- `netlify.toml` — Configuración de Netlify (headers de seguridad + redirect)
- `supabase-setup.sql` — Script SQL principal con tablas, RLS y storage
- `migration-multi-images.sql` — Migración para soporte multi-imagen
- `migration-categories.sql` — Migración para soporte de categorías dinámicas

## 🚀 Cómo subir a Netlify

### Opción 1 – Drag & Drop (más fácil)
1. Ve a **[netlify.com](https://netlify.com)** e inicia sesión
2. En el Dashboard haz clic en **"Add new site" → "Deploy manually"**
3. **Arrastra la carpeta `blushe-netlify`** al área de drop
4. ¡Listo! En segundos tendrás una URL tipo `blushe-xxxx.netlify.app`

### Opción 2 – Netlify CLI
```bash
npm install -g netlify-cli
netlify login
netlify deploy --prod --dir .
```

## ⚙️ Personalización antes de subir
Edita en `index.html` la línea:
```js
const WHATSAPP_NUMBER = '573504330055';
```
Y el handle de Instagram:
```html
<span class="instagram-handle">📷 @blushe.store</span>
```

- `migration-site-settings.sql` - Ajustes editables de la pagina (nombre, logo, eslóganes) + descuento por producto. Ejecutar una vez en Supabase > SQL Editor.
