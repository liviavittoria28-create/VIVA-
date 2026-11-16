# 18 — Implantação e operação

## Ambientes
- **Desenvolvimento:** projeto Supabase local ou de testes, dados fictícios.
- **Homologação:** projeto Supabase separado.
- **Produção:** a definir. Dados reais só com base legal e consentimento apropriados.

## Front-end
Build com `npm run build` (Vite) gera a pasta `dist/`. Publicação prevista como site estático no Render ou serviço equivalente.

## Banco de dados
1. Criar projeto no Supabase.
2. Aplicar migrations em ordem (`database/migrations/`).
3. Aplicar seeds apenas em ambientes de teste.
4. Configurar URLs de redirecionamento de autenticação.

## Variáveis
Ver `.env.example`. Nunca commitar `.env`.

## Backups e retenção
A definir. Documentar política de retenção antes de produção.

## Checklist antes de publicar
- [ ] RLS habilitado em todas as tabelas pessoais.
- [ ] Nenhuma chave privilegiada no front-end.
- [ ] Testes de isolamento executados e registrados.
- [ ] Textos revisados quanto a não recomendação de medicamentos.
- [ ] Endereço público verificado antes de divulgar.

Status atual: **não publicado**.
