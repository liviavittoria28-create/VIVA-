# ADR 0002 — Autorização no banco com RLS

- **Status:** Proposto
## Contexto
A interface não é barreira de segurança; qualquer cliente pode chamar a API diretamente.
## Problema
Garantir que um usuário não acesse dados privados de outro.
## Alternativas
1. Verificar apenas no front-end.
2. Camada de API própria com verificações.
3. RLS no PostgreSQL com função `has_permission`.
## Decisão
Usar RLS como mecanismo principal de autorização, com testes de isolamento.
## Consequências
+ Proteção independente do cliente.
- Políticas precisam de testes contínuos.
