# 10 — Modelo C4

## Nível 1 — Contexto do sistema

```mermaid
C4Context
  Person(idoso, "Pessoa idosa", "Protagonista da rotina")
  Person(familiar, "Familiar", "Acompanha com autorização")
  Person(cuidador, "Cuidador autorizado", "Auxilia com permissão")
  System(viva, "VIVA+", "Rotina, família, memórias e ajuda")
  System_Ext(supabase, "Supabase", "Auth, PostgreSQL, Storage, Realtime")
  Rel(idoso, viva, "Usa")
  Rel(familiar, viva, "Usa")
  Rel(cuidador, viva, "Usa")
  Rel(viva, supabase, "Lê e grava dados")
```

## Nível 2 — Containers

```mermaid
flowchart TB
  subgraph Navegador
    SPA[SPA React/TypeScript + PWA]
  end
  subgraph Supabase
    AUTH[Supabase Auth]
    API[PostgREST / API]
    DB[(PostgreSQL com RLS)]
    STG[Storage privado]
    RT[Realtime]
  end
  SPA --> AUTH
  SPA --> API --> DB
  SPA --> STG
  SPA --> RT
```

## Nível 3 — Componentes (front-end)

Componentes previstos: `AgendaPage`, `LembretesPage`, `FamiliaPage`, `AjudaPage`, `MemoriasPage`, `AssistentePorVoz`, `AuthProvider`, `PreferenciasAcessibilidadeProvider`, serviços por domínio (`appointmentsService`, `familyService`, etc.).

## Nível 4 — Implantação

Ver [18-IMPLANTACAO-E-OPERACAO.md](18-IMPLANTACAO-E-OPERACAO.md).
