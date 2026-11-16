# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

## [Não lançado]

### Adicionado
- Documentação de engenharia completa em `docs/` (22 documentos) e ADRs 0001 a 0006.
- App de celular funcional em `app/viva-plus.html`, com `localStorage`:
  - Início, Rotina, Remédios, Ajuda, Memórias e Ajustes.
  - Letra grande e alto contraste; cópia e restauração de dados; apagar tudo.
- Migration inicial `database/migrations/0001_init.sql` (não aplicada ainda).
- Seeds fictícios em `database/seeds/`.

### Removido
- Esqueleto React + Vite não concluído, substituído pelo app em `app/` na fase 1.

### Pendente
- Integração com Supabase (Auth, banco, RLS aplicado e testado).
- Módulo família, mensagens e solicitações com permissões reais.
- Testes automatizados executados.
- Publicação em ambiente público.
