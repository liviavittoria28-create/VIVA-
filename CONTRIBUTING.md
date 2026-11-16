# Como contribuir

1. Abra uma issue descrevendo a mudança antes de implementar.
2. Crie uma branch a partir de `main`: `feat/...`, `fix/...`, `docs/...`.
3. Commits descritivos no imperativo, por exemplo `feat: adiciona compromissos recorrentes`.
4. Mudanças de arquitetura exigem um ADR em `docs/adr/`.
5. Mudanças de banco exigem uma nova migration em `database/migrations/`. Nunca edite migrations já aplicadas.
6. Toda regra de acesso deve ter teste de RLS.
7. Não inclua dados pessoais reais em seeds, issues, screenshots ou logs.
8. Abra um pull request com a checklist de acessibilidade e privacidade preenchida.
