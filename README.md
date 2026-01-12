Project: axonaio
│
├── KV (secrets engine)
│   └── axonaio-kv-secrets/
│       ├── test/
│       │   └── backend
│       └── production/
│           └── backend
│
├── Policies
│   ├── axonaio-test-approle
│   └── axonaio-production-approle
│
├── AppRole auth mount
│   └── auth/axonaio/
│
├── AppRoles
│   ├── axonaio-test
│   │   ├── policy: axonaio-test-approle
│   │   ├── role_id
│   │   └── secret_ids
│   │
│   └── axonaio-production
│       ├── policy: axonaio-production-approle
│       ├── role_id
│       └── secret_ids
│
└── Humans (separate, already done)
    └── groups → policies → entities
