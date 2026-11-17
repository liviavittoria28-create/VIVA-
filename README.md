# VIVA+

> Tecnologia para viver melhor.

Plataforma de autonomia, rotina e conexão familiar para pessoas idosas, com espaço para familiares e cuidadores autorizados. O projeto é guiado por documentação de engenharia de software: requisitos, casos de uso, arquitetura, modelo de dados e LGPD.

**Autora:** [Lívia Vittoria](https://github.com/liviavittoria28-create) · **Fase atual:** 1 de 5 (app local, sem servidor)

<img src="docs/screenshots/inicio.jpg" alt="Tela inicial do VIVA+ no celular com o compromisso e o remédio do dia" width="300">

<sub>Captura com dados fictícios.</sub>

---

## Objetivo

Ajudar a pessoa idosa a organizar o próprio dia (compromissos, remédios, contatos de confiança e memórias) numa interface simples, com letra grande e alto contraste. Em fases futuras, a família poderá acompanhar essa rotina, mas só com permissão de quem é dono dos dados.

## Problema que resolve

Lembretes espalhados em papel, alarmes e grupos de mensagem geram esquecimento e dependência. Os apps de saúde e rotina costumam ser pequenos demais, complexos ou focados no cuidador. O VIVA+ coloca a pessoa idosa como protagonista: ela controla o que registra e quem pode ver.

## O que está implementado e o que está planejado

| Funcionalidade | Situação |
|---|---|
| Rotina: compromissos com data, hora e lembrete visual dentro do app | ✅ Implementado (fase 1) |
| Remédios: registro do que a pessoa informa e confirmação "tomei" | ✅ Implementado (fase 1) |
| Ajuda: contatos de confiança, ligação e registro de pedido de ajuda | ✅ Implementado (fase 1) |
| Memórias em texto | ✅ Implementado (fase 1) |
| Ajustes: tamanho da letra, alto contraste, cópia e restauração dos dados, apagar tudo | ✅ Implementado (fase 1) |
| Cadastro, login e recuperação de senha (Supabase Auth) | 🗓️ Planejado (fase 2) |
| Conexão familiar, convites e permissões revogáveis | 🗓️ Planejado (fase 3) |
| Mensagens, notificações no celular e fotos nas memórias | 🗓️ Planejado |
| Testes automatizados e validação com usuários | 🗓️ Planejado (fase 4) |

O VIVA+ **não** recomenda remédios, não define doses e não substitui serviços de emergência (ver [ADR 0005](docs/adr/0005-sem-recomendacao-de-medicamentos.md)).

## Tecnologias

| Camada | Fase 1 (atual) | Fases seguintes (planejado) |
|---|---|---|
| Interface | HTML, CSS e JavaScript em um único arquivo | React, TypeScript, Vite e PWA ([ADR 0003](docs/adr/0003-react-vite-pwa.md)) |
| Dados | `localStorage` do navegador ([ADR 0006](docs/adr/0006-fase-local-localstorage.md)) | Supabase: Auth, PostgreSQL e Storage ([ADR 0001](docs/adr/0001-supabase-como-backend.md)) |
| Autorização | — | Row Level Security ([ADR 0002](docs/adr/0002-rls-como-autorizacao.md)) |

## Acessibilidade

- Letra ajustável e modo de alto contraste.
- Botões grandes, com texto em vez de ícones soltos.
- Navegação fixa com cinco áreas: Início, Rotina, Remédios, Ajuda e Memórias.
- Diretrizes completas em [docs/15-ACESSIBILIDADE.md](docs/15-ACESSIBILIDADE.md).

## Arquitetura

```
Fase 1                         Fases 2 e 3 (planejado)
┌──────────────────────┐       ┌──────────────────────┐
│ viva-plus.html       │       │ PWA (React + Vite)   │
│ interface + lógica   │       └─────────┬────────────┘
│ localStorage         │                 │ supabase-js
└──────────────────────┘       ┌─────────▼────────────┐
                               │ Supabase Auth        │
                               │ PostgreSQL + RLS     │
                               │ Storage (fotos)      │
                               └──────────────────────┘
```

Detalhes em [docs/09-ARQUITETURA-ARC42.md](docs/09-ARQUITETURA-ARC42.md) e [docs/10-ARQUITETURA-C4.md](docs/10-ARQUITETURA-C4.md).

## Estrutura de pastas

```
app/                    app da fase 1 (viva-plus.html, arquivo único)
docs/                   documentação de engenharia
  01 a 22               visão, requisitos, casos de uso, arquitetura, dados, LGPD, testes
  adr/                  registros de decisão arquitetural (6 ADRs)
database/
  migrations/           esquema PostgreSQL/Supabase com RLS (0001_init.sql)
  seeds/                dados fictícios para desenvolvimento
tests/                  plano de testes
.env.example            variáveis da fase 2, sem segredos
```

## Como executar

**Fase 1 (app):** abra `app/viva-plus.html` no navegador do celular ou do computador. Não precisa de instalação nem de internet. No celular, use "Adicionar à tela inicial" para abrir como um app.

**Banco de dados (preparação da fase 2):**

1. Crie um projeto no Supabase.
2. Rode `database/migrations/0001_init.sql` no SQL Editor.
3. Para dados de exemplo, crie dois usuários no Auth com os UUIDs indicados em `database/seeds/001_demo_fictional.sql` e rode o seed.

### Variáveis de ambiente

Usadas a partir da fase 2. Copie `.env.example` para `.env`:

| Variável | Descrição |
|---|---|
| `VITE_SUPABASE_URL` | URL do projeto Supabase |
| `VITE_SUPABASE_ANON_KEY` | chave pública (anon) do projeto |
| `VITE_APP_ENV` | `development` ou `production` |
| `VITE_APP_NAME` | nome exibido no app |

## Banco de dados

O esquema `0001_init.sql` cria 18 tabelas (perfis, conexões familiares, convites, permissões, compromissos, lembretes, registros de remédios, pedidos de ajuda, memórias, mensagens, notificações, log de auditoria e outras), com **RLS ativado em todas** e 20 políticas de acesso. Modelo e dicionário de dados em [docs/12](docs/12-MODELO-DE-DADOS.md) e [docs/13](docs/13-DICIONARIO-DE-DADOS.md).

## Testes

Não há suíte de testes automatizados ainda. O plano está em [docs/16-PLANO-DE-TESTES.md](docs/16-PLANO-DE-TESTES.md).

Verificações manuais feitas em 17/11/2026:

- `0001_init.sql` aplicado sem erros num PostgreSQL 16 local com stub dos esquemas do Supabase: 18 tabelas, RLS em todas, 20 políticas.
- Seed aplicado sem erros, depois de criar os dois usuários de exemplo.
- App da fase 1 no Chrome em tela de celular (390 px): cadastro de compromisso, remédio, contato e memória; os dados permanecem após recarregar a página e o compromisso aparece no Início. Nenhum erro de JavaScript.

## Limitações conhecidas

- Os dados ficam só no aparelho e no navegador. Limpar os dados do navegador apaga o VIVA+.
- Não há login, família nem sincronização.
- Os lembretes aparecem só dentro do app, sem notificação do celular.
- O pedido de ajuda é registrado, mas não avisa os contatos.
- Memórias apenas em texto.

Lista completa em [docs/20-RISCOS-E-LIMITACOES.md](docs/20-RISCOS-E-LIMITACOES.md).

## Melhorias futuras

As fases 2 a 5 da tabela acima, com prioridade para autenticação, conexão familiar com permissões revogáveis e testes de RLS automatizados.

## Princípios

- A pessoa idosa é protagonista da própria rotina.
- Dados pessoais mínimos, que pertencem a quem os informa.
- Nenhuma recomendação médica.

## Contribuição e segurança

[CONTRIBUTING.md](CONTRIBUTING.md) · [SECURITY.md](SECURITY.md) · [CHANGELOG.md](CHANGELOG.md)

---

Desenvolvido por **Lívia Vittoria** · [Portfólio](https://liviavittoria28-create.github.io) · [LinkedIn](https://www.linkedin.com/in/livia-vittoria-732b8a430/)
