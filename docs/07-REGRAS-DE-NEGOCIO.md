# 07 — Regras de negócio

| ID | Área | Regra |
|---|---|---|
| RN001 | Cadastro | Cada conta deve ter e-mail único e confirmado. |
| RN002 | Cadastro | Um perfil é criado automaticamente para cada conta, com papel "pessoa idosa" por padrão. |
| RN003 | Convites | Um convite tem validade e pode ser aceito uma única vez. |
| RN004 | Convites | Somente a pessoa idosa pode aprovar um vínculo familiar ou de cuidador. |
| RN005 | Permissões | Toda permissão é concedida explicitamente, por tipo de dado, e pode ser revogada a qualquer momento. |
| RN006 | Permissões | Ausência de permissão significa acesso negado. |
| RN007 | Permissões | A revogação tem efeito imediato no banco de dados (RLS). |
| RN008 | Compartilhamento | Compromissos só são visíveis a quem recebeu permissão de visualização deles. |
| RN009 | Compromissos | Um compromisso tem título, data e hora de início; hora de término é opcional. |
| RN010 | Compromissos | Exclusão de compromisso é lógica (marcada), para preservar histórico. |
| RN011 | Lembretes | Um lembrete pertence a um compromisso ou a um registro de medicamento. |
| RN012 | Lembretes | O sistema registra "visualizado" ou "confirmado pelo usuário"; nunca afirma ingestão ou execução comprovada. |
| RN013 | Medicamentos | O sistema não recomenda medicamentos, não prescreve doses e não altera tratamentos. Instruções devem vir de fonte autorizada, informada pelo usuário. |
| RN014 | Mensagens | Mensagens só podem ser trocadas entre vínculos aprovados. |
| RN015 | Memórias | Uma memória é privada por padrão; compartilhamento é explícito. |
| RN016 | Solicitações de ajuda | Uma solicitação notifica os contatos de confiança configurados; não substitui serviços de emergência. |
| RN017 | Auditoria | Acessos a dados sensíveis e alterações de permissão geram registro em `audit_logs`. |
| RN018 | Operações importantes | Exclusões, revogações e compartilhamentos exigem confirmação explícita, inclusive quando feitos por voz. |
