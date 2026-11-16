# 20 — Riscos e limitações

| ID | Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|---|
| R01 | Falha de RLS expõe dados | Média | Alto | Testes de isolamento obrigatórios |
| R02 | Uso indevido de convites | Média | Alto | Expiração, uso único, revogação |
| R03 | Mau entendimento de lembrete como confirmação médica | Média | Alto | Textos claros; sem afirmação de ingestão |
| R04 | Baixa usabilidade para público idoso | Média | Alto | Testes com participantes reais |
| R05 | Notificações não entregues em segundo plano | Alta | Médio | Limitações documentadas; sem promessa de entrega |
| R06 | Dependência de terceiros (Supabase, Render) | Baixa | Médio | Documentação de migração |
| R07 | Escopo excessivo para a equipe | Alta | Médio | Priorização MoSCoW |
| R08 | Dados de saúde mal protegidos | Média | Alto | Minimização, RLS, revisão jurídica |

## Limitações conhecidas
- Notificações de navegador podem não funcionar em segundo plano em alguns navegadores e PWAs.
- Web Speech API depende do navegador e pode não estar disponível.
- Nenhuma validação com usuários foi realizada.
