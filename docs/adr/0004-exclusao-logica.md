# ADR 0004 — Exclusão lógica para registros de rotina

- **Status:** Proposto
## Contexto
Histórico de compromissos e lembretes tem valor para o usuário e para a família.
## Problema
Evitar perda de histórico sem deixar dados excluídos acessíveis.
## Decisão
Usar `deleted_at` para compromissos e marcar revogações com `revoked_at`. Consultas padrão excluem registros marcados.
## Consequências
+ Histórico preservado.
- Consultas precisam filtrar registros excluídos.
