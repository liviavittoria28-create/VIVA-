# 13 — Dicionário de dados

Convenções: `id uuid PK`, `created_at timestamptz`, `updated_at timestamptz`. Tabelas com dados pessoais têm RLS. Os tipos e constraints exatos estão nas migrations.

## profiles
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK, FK auth.users | Identificador do usuário |
| full_name | text | Nome exibido |
| role | text | `elder`, `member` ou `caregiver` (padrão `elder`) |
| font_size_pref | text | `normal`, `large`, `xlarge` |
| high_contrast | boolean | Preferência de contraste |

## family_connections
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| elder_id | uuid FK profiles | Pessoa idosa dona dos dados |
| member_id | uuid FK profiles | Familiar ou cuidador |
| relation_type | text | `family` ou `caregiver` |
| status | text | `pending`, `active`, `revoked` |
| revoked_at | timestamptz null | Data de revogação |

## connection_invitations
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| inviter_id | uuid FK profiles | Quem convidou |
| invitee_email | text | E-mail do convidado |
| token_hash | text | Hash do token de convite (nunca o token em texto puro) |
| expires_at | timestamptz | Validade |
| accepted_at | timestamptz null | Uso único |

## permissions
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| connection_id | uuid FK family_connections | Vínculo |
| scope | text | `appointments_read`, `messages`, `activities_write`, `memories_read`, `reminders_manage` |
| granted_at | timestamptz | |
| revoked_at | timestamptz null | Revogação |

## appointments
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| title | text not null | |
| starts_at | timestamptz not null | |
| ends_at | timestamptz null | Deve ser maior que `starts_at`, se informado |
| notes | text null | |
| deleted_at | timestamptz null | Exclusão lógica |

## reminders
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| appointment_id | uuid FK appointments null | |
| medication_record_id | uuid FK medication_records null | |
| remind_at | timestamptz | |
| status | text | `scheduled`, `seen`, `confirmed_by_user`, `dismissed` |

Constraint: exatamente um entre `appointment_id` e `medication_record_id` deve estar preenchido.

## medication_records
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| name | text | Nome informado pelo usuário ou fonte autorizada |
| schedule_note | text null | Horário informado; sem recomendação do sistema |
| source_note | text null | Origem da instrução (ex.: receita informada pelo usuário) |
| start_date | date | |
| end_date | date null | Opcional |

## reminder_confirmations
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| reminder_id | uuid FK reminders | |
| kind | text | `seen` ou `confirmed_by_user` |
| recorded_at | timestamptz | |

## messages
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| connection_id | uuid FK family_connections | Vínculo aprovado obrigatório |
| sender_id | uuid FK profiles | |
| body | text | Tamanho limitado por constraint |
| created_at | timestamptz | |

## trusted_contacts
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| name | text | |
| phone | text | |
| priority | smallint | Ordem de exibição |

## help_requests
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| status | text | `open`, `notified`, `closed` |
| message | text null | |
| created_at | timestamptz | |

Não há simulação de atendimento de emergência; o status "notified" só é usado quando há registro real de envio.

## memories
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| title | text | |
| story | text null | |
| memory_date | date null | Data especial |
| visibility | text | `private` (padrão) ou `shared` |

## memory_media
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| memory_id | uuid FK memories | |
| storage_path | text | Caminho no bucket privado |
| media_type | text | `photo` ou `audio` |

## activities
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| owner_id | uuid FK profiles | |
| name | text | Ex.: leitura, palavras cruzadas |
| category | text | |

## activity_records
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| activity_id | uuid FK activities | |
| recorded_by | uuid FK profiles | Pessoa idosa ou cuidador autorizado |
| note | text null | |
| recorded_at | timestamptz | |

## notification_preferences
| Coluna | Tipo | Descrição |
|---|---|---|
| owner_id | uuid PK, FK profiles | |
| browser_enabled | boolean | Padrão false; exige autorização do navegador |
| channel_messages | boolean | |

## notifications
| Coluna | Tipo | Descrição |
|---|---|---|
| id | uuid PK | |
| recipient_id | uuid FK profiles | |
| kind | text | `appointment`, `reminder`, `message`, `invitation`, `share` |
| read_at | timestamptz null | |
| created_at | timestamptz | |

## audit_logs
| Coluna | Tipo | Descrição |
|---|---|---|
| id | bigserial PK | |
| actor_id | uuid null | Quem executou |
| action | text | Ex.: `permission.revoked` |
| target_table | text | |
| target_id | uuid null | |
| created_at | timestamptz | Somente inserção; sem atualização ou exclusão pelo cliente |
