# 11 — Diagramas UML

## Sequência — Convite e aprovação de vínculo

```mermaid
sequenceDiagram
  actor Idoso
  actor Familiar
  participant App
  participant DB as PostgreSQL (RLS)
  Idoso->>App: Convida familiar (e-mail)
  App->>DB: INSERT connection_invitations
  Familiar->>App: Aceita convite
  App->>DB: UPDATE connection_invitations (aceito)
  Idoso->>App: Aprova vínculo
  App->>DB: INSERT family_connections + permissions
  DB-->>App: Vínculo ativo
```

## Atividades — Confirmação de lembrete

```mermaid
flowchart TD
  A[Lembrete dispara] --> B{Usuário visualizou?}
  B -- Sim --> C[Registrar visualização]
  B -- Não --> D[Manter pendente]
  C --> E{Usuário confirmou?}
  E -- Sim --> F[Registrar confirmação informada pelo usuário]
  E -- Não --> G[Fim]
```

## Classes — Núcleo de dados

```mermaid
classDiagram
  class Profile {
    +uuid id
    +text full_name
    +text role
  }
  class FamilyConnection {
    +uuid id
    +uuid elder_id
    +uuid member_id
    +text status
  }
  class Permission {
    +uuid id
    +uuid connection_id
    +text scope
  }
  class Appointment {
    +uuid id
    +uuid owner_id
    +text title
    +timestamptz starts_at
  }
  Profile "1" --> "*" Appointment
  Profile "1" --> "*" FamilyConnection
  FamilyConnection "1" --> "*" Permission
```

## Componentes e implantação

Ver [10-ARQUITETURA-C4.md](10-ARQUITETURA-C4.md).
