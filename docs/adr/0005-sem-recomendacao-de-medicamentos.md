# ADR 0005 — Sem recomendação ou prescrição de medicamentos

- **Status:** Aceito
## Contexto
O módulo de medicamentos pode induzir dependência ou erro se parecer orientação médica.
## Problema
Evitar que o sistema recomende, prescreva ou altere tratamentos.
## Decisão
O sistema apenas armazena o que o usuário informa, agenda lembretes e registra visualização ou confirmação informada pelo próprio usuário.
## Consequências
+ Menor risco clínico e regulatório.
- Funcionalidade mais limitada que um aplicativo de saúde.
