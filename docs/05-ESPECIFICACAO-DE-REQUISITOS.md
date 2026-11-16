# 05 — Especificação de requisitos

Formato baseado na ISO/IEC/IEEE 29148. Cada requisito possui identificador único.

## Requisitos funcionais

| ID | Nome | Ator | Prioridade | Status |
|---|---|---|---|---|
| RF001 | Cadastro de usuários | Visitante | Essencial | Planejado |
| RF002 | Autenticação | Usuário | Essencial | Planejado |
| RF003 | Recuperação de senha | Usuário | Essencial | Planejado |
| RF004 | Gerenciamento de perfil | Pessoa idosa | Essencial | Planejado |
| RF005 | Gerenciamento de compromissos | Pessoa idosa | Essencial | Planejado |
| RF006 | Configuração de lembretes | Pessoa idosa | Essencial | Planejado |
| RF007 | Histórico de lembretes | Pessoa idosa | Importante | Planejado |
| RF008 | Conexão familiar | Pessoa idosa, familiar | Essencial | Planejado |
| RF009 | Convites | Pessoa idosa, familiar | Essencial | Planejado |
| RF010 | Gerenciamento de permissões | Pessoa idosa | Essencial | Planejado |
| RF011 | Mensagens | Pessoa idosa, familiar | Importante | Planejado |
| RF012 | Contatos de confiança | Pessoa idosa | Essencial | Planejado |
| RF013 | Solicitação de ajuda | Pessoa idosa | Essencial | Planejado |
| RF014 | Memórias digitais | Pessoa idosa | Desejável | Planejado |
| RF015 | Galeria de fotografias | Pessoa idosa | Desejável | Planejado |
| RF016 | Atividades | Pessoa idosa, cuidador | Importante | Planejado |
| RF017 | Preferências de acessibilidade | Pessoa idosa | Essencial | Planejado |
| RF018 | Notificações | Usuário | Importante | Planejado |
| RF019 | Assistente por voz | Pessoa idosa | Desejável | Planejado |

### Critérios de aceitação (exemplos)

- **RF010:** a revogação de permissão deve impedir imediatamente o acesso do familiar ou cuidador aos dados revogados, verificado por teste de RLS.
- **RF013:** a solicitação de ajuda deve exibir os contatos de confiança e não deve simular atendimento de emergência.
- **RF006:** o lembrete deve registrar apenas "visualizado" ou "confirmado pelo usuário", nunca "ingestão comprovada".

## Requisitos não funcionais

| ID | Requisito | Critério mensurável |
|---|---|---|
| RNF001 | Usabilidade | Tarefas essenciais concluídas sem ajuda em teste com participantes (a medir) |
| RNF002 | Acessibilidade | WCAG 2.2 nível AA como alvo (a avaliar) |
| RNF003 | Segurança | Sem vulnerabilidades críticas em revisão OWASP ASVS (a avaliar) |
| RNF004 | Privacidade | Minimização de dados e consentimento registrado |
| RNF005 | Desempenho | Metas a definir após medição; nenhum valor foi inventado |
| RNF006 | Disponibilidade | Meta a definir com o provedor de hospedagem |
| RNF007 | Compatibilidade | Navegadores modernos em celular e desktop |
| RNF008 | Manutenibilidade | Código tipado, testes e documentação versionada |
| RNF009 | Responsividade | Layout utilizável de 320 px a desktop |
| RNF010 | Integridade dos dados | Chaves estrangeiras, constraints e transações |

## Requisitos fora do escopo inicial

Atendimento de emergência, integração com serviços de saúde, pagamentos e aplicativos nativos.
