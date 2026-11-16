# 16 — Plano de testes

**Status:** planejado. Nenhum teste foi executado e nenhum teste está aprovado.

## Tipos

| Tipo | Escopo | Ferramenta prevista |
|---|---|---|
| Unitários | Funções puras em `utils/` e validações | Vitest |
| Integração | Serviços e consultas ao banco | Vitest + Supabase local |
| RLS | Isolamento entre usuários e permissões | Testes SQL/integração |
| Sistema | Fluxos ponta a ponta | Playwright |
| Aceitação | Histórias de [06-HISTORIAS-DE-USUARIO.md](06-HISTORIAS-DE-USUARIO.md) | Manual + automatizado |
| Segurança | OWASP ASVS, revisão de chaves | Revisão + ferramentas |
| Acessibilidade | WCAG 2.2 | axe + revisão manual |
| Responsividade | 320 px, tablet, desktop | Playwright |
| Usabilidade | Tarefas com participantes idosos | Protocolo com consentimento |

## Casos críticos de isolamento (RLS)
1. Usuário A não lê compromissos de B.
2. Familiar sem permissão não lê compromissos de B.
3. Revogação bloqueia acesso imediatamente.
4. Convite expirado não cria vínculo.
5. Convite usado não pode ser reutilizado.
6. Cliente anônimo não lê nenhuma tabela pessoal.

## Plano de usabilidade com pessoas idosas
- Recrutamento com consentimento livre e esclarecido.
- Tarefas: cadastro, criar compromisso, configurar lembrete, localizar contato, pedir ajuda.
- Registro: tempo, erros, dúvidas, dificuldades, sugestões.
- Não se considera a usabilidade validada antes da execução.

Matriz de rastreabilidade: [17-MATRIZ-DE-RASTREABILIDADE.md](17-MATRIZ-DE-RASTREABILIDADE.md).
