# ADR 0001 — Supabase como backend

- **Status:** Proposto
## Contexto
O projeto precisa de autenticação, banco relacional, armazenamento e tempo real, com equipe pequena.
## Problema
Escolher uma plataforma que ofereça esses recursos com controle de acesso no banco.
## Alternativas
1. Backend próprio (Node + PostgreSQL + autenticação própria).
2. Supabase (PostgreSQL + Auth + Storage + Realtime + RLS).
3. Firebase.
## Decisão
Adotar Supabase, com autorização aplicada por RLS no PostgreSQL.
## Consequências
+ Menos código de infraestrutura.
- Dependência de fornecedor; migração exigiria esforço.
- Requer disciplina em políticas RLS.
