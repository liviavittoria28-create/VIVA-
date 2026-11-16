-- VIVA+ — migration 0001: esquema inicial
-- ATENÇÃO: script não executado em instância real até o momento.

create extension if not exists pgcrypto;

-- Perfis (1:1 com auth.users)
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null check (char_length(full_name) between 2 and 120),
  role text not null default 'elder' check (role in ('elder','member','caregiver')),
  font_size_pref text not null default 'normal' check (font_size_pref in ('normal','large','xlarge')),
  high_contrast boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.family_connections (
  id uuid primary key default gen_random_uuid(),
  elder_id uuid not null references public.profiles(id) on delete cascade,
  member_id uuid not null references public.profiles(id) on delete cascade,
  relation_type text not null check (relation_type in ('family','caregiver')),
  status text not null default 'pending' check (status in ('pending','active','revoked')),
  revoked_at timestamptz,
  created_at timestamptz not null default now(),
  constraint family_connections_distinct check (elder_id <> member_id),
  constraint family_connections_unique unique (elder_id, member_id),
  constraint family_connections_revoked_consistency check (
    (status = 'revoked') = (revoked_at is not null)
  )
);
create index family_connections_member_idx on public.family_connections(member_id);

create table public.connection_invitations (
  id uuid primary key default gen_random_uuid(),
  inviter_id uuid not null references public.profiles(id) on delete cascade,
  invitee_email text not null check (position('@' in invitee_email) > 1),
  token_hash text not null unique,
  expires_at timestamptz not null,
  accepted_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.permissions (
  id uuid primary key default gen_random_uuid(),
  connection_id uuid not null references public.family_connections(id) on delete cascade,
  scope text not null check (scope in ('appointments_read','messages','activities_write','memories_read','reminders_manage')),
  granted_at timestamptz not null default now(),
  revoked_at timestamptz,
  unique (connection_id, scope)
);

create table public.appointments (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 200),
  starts_at timestamptz not null,
  ends_at timestamptz,
  notes text,
  deleted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint appointments_end_after_start check (ends_at is null or ends_at > starts_at)
);
create index appointments_owner_starts_idx on public.appointments(owner_id, starts_at) where deleted_at is null;

create table public.medication_records (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 200),
  schedule_note text,
  source_note text,
  start_date date not null,
  end_date date,
  created_at timestamptz not null default now(),
  constraint medication_dates check (end_date is null or end_date >= start_date)
);

create table public.reminders (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  appointment_id uuid references public.appointments(id) on delete cascade,
  medication_record_id uuid references public.medication_records(id) on delete cascade,
  remind_at timestamptz not null,
  status text not null default 'scheduled' check (status in ('scheduled','seen','confirmed_by_user','dismissed')),
  created_at timestamptz not null default now(),
  constraint reminders_one_source check (
    (appointment_id is not null)::int + (medication_record_id is not null)::int = 1
  )
);
create index reminders_owner_remind_idx on public.reminders(owner_id, remind_at);

create table public.reminder_confirmations (
  id uuid primary key default gen_random_uuid(),
  reminder_id uuid not null references public.reminders(id) on delete cascade,
  kind text not null check (kind in ('seen','confirmed_by_user')),
  recorded_at timestamptz not null default now()
);

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  connection_id uuid not null references public.family_connections(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 2000),
  created_at timestamptz not null default now()
);
create index messages_connection_idx on public.messages(connection_id, created_at);

create table public.trusted_contacts (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 120),
  phone text not null check (char_length(phone) between 8 and 30),
  priority smallint not null default 1 check (priority between 1 and 10),
  created_at timestamptz not null default now()
);
create index trusted_contacts_owner_idx on public.trusted_contacts(owner_id);

create table public.help_requests (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  status text not null default 'open' check (status in ('open','notified','closed')),
  message text,
  created_at timestamptz not null default now()
);
create index help_requests_owner_idx on public.help_requests(owner_id, created_at);

create table public.memories (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 200),
  story text,
  memory_date date,
  visibility text not null default 'private' check (visibility in ('private','shared')),
  created_at timestamptz not null default now()
);

create table public.memory_media (
  id uuid primary key default gen_random_uuid(),
  memory_id uuid not null references public.memories(id) on delete cascade,
  storage_path text not null,
  media_type text not null check (media_type in ('photo','audio')),
  created_at timestamptz not null default now()
);

create table public.activities (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 120),
  category text,
  created_at timestamptz not null default now()
);

create table public.activity_records (
  id uuid primary key default gen_random_uuid(),
  activity_id uuid not null references public.activities(id) on delete cascade,
  recorded_by uuid not null references public.profiles(id) on delete cascade,
  note text,
  recorded_at timestamptz not null default now()
);

create table public.notification_preferences (
  owner_id uuid primary key references public.profiles(id) on delete cascade,
  browser_enabled boolean not null default false,
  channel_messages boolean not null default true
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  recipient_id uuid not null references public.profiles(id) on delete cascade,
  kind text not null check (kind in ('appointment','reminder','message','invitation','share')),
  read_at timestamptz,
  created_at timestamptz not null default now()
);
create index notifications_recipient_idx on public.notifications(recipient_id, created_at);

create table public.audit_logs (
  id bigint generated always as identity primary key,
  actor_id uuid,
  action text not null,
  target_table text not null,
  target_id uuid,
  created_at timestamptz not null default now()
);

-- Função de autorização: vínculo ativo e permissão não revogada
create or replace function public.has_permission(p_owner uuid, p_scope text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.family_connections fc
    join public.permissions p on p.connection_id = fc.id
    where fc.elder_id = p_owner
      and fc.member_id = auth.uid()
      and fc.status = 'active'
      and p.scope = p_scope
      and p.revoked_at is null
  );
$$;

-- RLS
alter table public.profiles enable row level security;
alter table public.family_connections enable row level security;
alter table public.connection_invitations enable row level security;
alter table public.permissions enable row level security;
alter table public.appointments enable row level security;
alter table public.medication_records enable row level security;
alter table public.reminders enable row level security;
alter table public.reminder_confirmations enable row level security;
alter table public.messages enable row level security;
alter table public.trusted_contacts enable row level security;
alter table public.help_requests enable row level security;
alter table public.memories enable row level security;
alter table public.memory_media enable row level security;
alter table public.activities enable row level security;
alter table public.activity_records enable row level security;
alter table public.notification_preferences enable row level security;
alter table public.notifications enable row level security;
alter table public.audit_logs enable row level security;

-- Perfis: cada usuário lê e edita o próprio perfil
create policy profiles_self_select on public.profiles for select using (id = auth.uid());
create policy profiles_self_update on public.profiles for update using (id = auth.uid()) with check (id = auth.uid());

-- Dono: acesso total aos próprios dados
create policy appointments_owner_all on public.appointments for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy appointments_member_read on public.appointments for select
  using (public.has_permission(owner_id, 'appointments_read') and deleted_at is null);

create policy medication_owner_all on public.medication_records for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy reminders_owner_all on public.reminders for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy trusted_contacts_owner_all on public.trusted_contacts for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy help_requests_owner_all on public.help_requests for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy memories_owner_all on public.memories for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy activities_owner_all on public.activities for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy notification_prefs_owner_all on public.notification_preferences for all
  using (owner_id = auth.uid()) with check (owner_id = auth.uid());

create policy notifications_recipient on public.notifications for select
  using (recipient_id = auth.uid());
create policy notifications_recipient_update on public.notifications for update
  using (recipient_id = auth.uid()) with check (recipient_id = auth.uid());

-- Vínculos: visíveis às duas partes; alteração somente pela pessoa idosa
create policy family_connections_parties_select on public.family_connections for select
  using (elder_id = auth.uid() or member_id = auth.uid());
create policy family_connections_elder_manage on public.family_connections for all
  using (elder_id = auth.uid()) with check (elder_id = auth.uid());

create policy permissions_elder_manage on public.permissions for all
  using (exists (select 1 from public.family_connections fc
                 where fc.id = connection_id and fc.elder_id = auth.uid()))
  with check (exists (select 1 from public.family_connections fc
                 where fc.id = connection_id and fc.elder_id = auth.uid()));

-- Mensagens: apenas entre vínculos ativos das duas partes
create policy messages_parties_select on public.messages for select
  using (exists (select 1 from public.family_connections fc
                 where fc.id = connection_id and fc.status = 'active'
                   and (fc.elder_id = auth.uid() or fc.member_id = auth.uid())));
create policy messages_parties_insert on public.messages for insert
  with check (sender_id = auth.uid() and exists (
    select 1 from public.family_connections fc
    where fc.id = connection_id and fc.status = 'active'
      and (fc.elder_id = auth.uid() or fc.member_id = auth.uid())));

-- Registros de auditoria: somente inserção pelo cliente autenticado; sem leitura geral
create policy audit_logs_insert_own on public.audit_logs for insert
  with check (actor_id = auth.uid());

-- Convites: somente quem convidou
create policy invitations_inviter on public.connection_invitations for all
  using (inviter_id = auth.uid()) with check (inviter_id = auth.uid());

-- Observação: políticas de reminder_confirmations, activity_records e memory_media
-- devem ser detalhadas na migration 0002, após validação de escopos e testes RLS.
