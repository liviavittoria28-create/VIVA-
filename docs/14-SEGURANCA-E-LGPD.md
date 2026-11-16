# 14 — Segurança e LGPD

> Este documento organiza controles e boas práticas. **Não afirma conformidade formal** com a LGPD nem certificação de segurança; isso exige avaliação apropriada, incluindo análise jurídica.

## Autenticação
Supabase Auth com e-mail e senha. Recuperação de senha por link enviado ao e-mail cadastrado. Sessões com expiração gerenciada pelo Supabase.

## Autorização
Autorização aplicada no PostgreSQL com RLS. Acesso padrão negado. Função SQL `has_permission(owner uuid, scope text)` verifica vínculo ativo e permissão não revogada.

## Controle de acesso por perfil
- Pessoa idosa: acesso total aos próprios dados.
- Familiar e cuidador: somente o que o escopo permitir.

## Privacidade e minimização
Coletar apenas o necessário. Dados de saúde são tratados como sensíveis; o sistema registra o que o usuário informa, sem inferências.

## Consentimento
Convites e permissões são explícitos. Revogação é possível a qualquer momento.

## Direitos do titular
Previsão de funcionalidades para consulta, correção, exportação e solicitação de exclusão de dados. Status: **a implementar**.

## Compartilhamento e revogação
Revogação marca `revoked_at` e bloqueia acesso pelas políticas RLS, com registro em `audit_logs`.

## Logs e auditoria
`audit_logs` é append-only para o cliente. Não registrar senhas, tokens ou conteúdo sensível em logs de aplicação.

## Segurança de arquivos
Bucket de Storage privado. Acesso por URL assinada de curta duração. Validação de tipo e tamanho no upload.

## Gerenciamento de sessões
Tokens não são armazenados em texto puro em logs. Logout encerra a sessão no cliente.

## Ameaças e mitigações (resumo)

| Ameaça | Mitigação |
|---|---|
| Acesso cruzado entre usuários | RLS + testes automatizados de isolamento |
| Vazamento de chave privilegiada | `service_role` apenas no servidor; `.env.example` sem segredos |
| Injeção SQL | Consultas parametrizadas via cliente Supabase |
| XSS | Escape padrão do React; sem `dangerouslySetInnerHTML` com dados de usuário |
| Convite reutilizado | Uso único e expiração |
| Phishing de recuperação de senha | Mensagens claras; orientação ao usuário |

Referências: OWASP ASVS e OWASP Top 10.
