-- Ejecuta este script en Supabase > SQL Editor

-- 1) Columnas nuevas en products
alter table products add column if not exists description text default '';
alter table products add column if not exists image_url text;

-- 2) Quién es administrador (el dueño)
create table if not exists admins (user_id uuid primary key references auth.users(id) on delete cascade);
alter table admins enable row level security;
drop policy if exists "admin ve su fila" on admins;
create policy "admin ve su fila" on admins for select to authenticated using (user_id = auth.uid());

create or replace function is_admin() returns boolean
language sql security definer stable set search_path = public as
$$ select exists (select 1 from admins where user_id = auth.uid()) $$;

-- 3) Permisos de products (si ya tenías otras policies, bórralas antes en Authentication > Policies)
alter table products enable row level security;
drop policy if exists "lectura publica" on products;
drop policy if exists "admin inserta" on products;
drop policy if exists "admin edita" on products;
drop policy if exists "admin borra" on products;
create policy "lectura publica" on products for select using (active = true or is_admin());
create policy "admin inserta" on products for insert to authenticated with check (is_admin());
create policy "admin edita" on products for update to authenticated using (is_admin()) with check (is_admin());
create policy "admin borra" on products for delete to authenticated using (is_admin());

-- 4) Bucket público para fotos de productos
insert into storage.buckets (id, name, public) values ('products', 'products', true) on conflict do nothing;
drop policy if exists "fotos publicas" on storage.objects;
drop policy if exists "admin sube fotos" on storage.objects;
drop policy if exists "admin edita fotos" on storage.objects;
drop policy if exists "admin borra fotos" on storage.objects;
create policy "fotos publicas" on storage.objects for select using (bucket_id = 'products');
create policy "admin sube fotos" on storage.objects for insert to authenticated with check (bucket_id = 'products' and is_admin());
create policy "admin edita fotos" on storage.objects for update to authenticated using (bucket_id = 'products' and is_admin());
create policy "admin borra fotos" on storage.objects for delete to authenticated using (bucket_id = 'products' and is_admin());

-- 5) Crea el usuario del dueño en Authentication > Users (email + contraseña)
--    y luego ejecuta esto con SU correo:
-- insert into admins (user_id) select id from auth.users where email = 'CORREO_DEL_DUENO@ejemplo.com';
