-- Seeds de demonstração com dados FICTÍCIOS.
-- Use somente em ambiente de desenvolvimento ou teste.
-- Requer usuários criados em auth.users com os UUIDs abaixo (ex.: via painel do Supabase).

insert into public.profiles (id, full_name, role) values
  ('00000000-0000-0000-0000-000000000001', 'Helena Exemplo', 'elder'),
  ('00000000-0000-0000-0000-000000000002', 'Carlos Exemplo', 'member');

insert into public.family_connections (id, elder_id, member_id, relation_type, status) values
  ('10000000-0000-0000-0000-000000000001',
   '00000000-0000-0000-0000-000000000001',
   '00000000-0000-0000-0000-000000000002', 'family', 'active');

insert into public.permissions (connection_id, scope) values
  ('10000000-0000-0000-0000-000000000001', 'appointments_read');

insert into public.appointments (owner_id, title, starts_at, notes) values
  ('00000000-0000-0000-0000-000000000001', 'Consulta de exemplo', '2026-12-01 10:00:00-03', 'Dado fictício');
