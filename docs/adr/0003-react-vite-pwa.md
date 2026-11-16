# ADR 0003 — React, TypeScript, Vite e PWA

- **Status:** Proposto (fase 2). Na fase 1, ver ADR 0006.
## Contexto
Aplicação web responsiva, acessível e instalável no celular.
## Problema
Escolher stack de front-end com bom ecossistema e baixa complexidade de build.
## Alternativas
1. Next.js.
2. React + Vite.
3. Aplicativo nativo.
## Decisão
React + TypeScript + Vite, com PWA. Aplicativos nativos ficam fora do escopo inicial.
## Consequências
+ Build rápido e simples.
- Sem renderização no servidor; SEO não é requisito.
