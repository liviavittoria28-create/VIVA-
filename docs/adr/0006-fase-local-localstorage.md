# ADR 0006 — Fase local com localStorage antes do Supabase

- **Status:** Aceito
## Contexto
A equipe precisa de um app funcional e utilizável agora, sem depender de configuração de backend, credenciais ou hospedagem.
## Problema
Entregar valor imediato sem comprometer a futura arquitetura com Supabase.
## Alternativas
1. Aguardar o backend completo com Supabase.
2. App web único com `localStorage`, sem dependências.
3. Stack React + Vite (esqueleto não concluído nesta fase).
## Decisão
Adotar o app HTML único em `app/` com `localStorage` como fase 1. O Supabase entra na fase 2, com migração dos dados e políticas RLS já definidas em `database/`.
## Consequências
+ Funciona imediatamente em qualquer celular.
+ Sem custo de infraestrutura nesta fase.
- Dados ficam só no aparelho; exige cópia manual.
- Sem família, login ou sincronização até a fase 2.
- Código de fase 1 precisará ser reescrito ou migrado para a stack final.
