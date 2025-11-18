---
marp: true
theme: uncover
paginate: true
footer: M2 ESTD - Gestion de projet Agile et DevOps | ForEach Academy
style: |
  section {
    font-size: 20px;
    padding: 40px 50px;
  }
  h1 {
    font-size: 36px;
    color: #2563eb;
    margin: 0 0 15px 0;
  }
  h2 {
    font-size: 28px;
    color: #1e40af;
    margin: 0 0 12px 0;
  }
  h3 {
    font-size: 24px;
    color: #3b82f6;
    margin: 0 0 10px 0;
  }
  code {
    font-size: 18px;
    background: #f3f4f6;
    padding: 1px 4px;
    border-radius: 4px;
  }
  .highlight {
    background: linear-gradient(120deg, #fbbf24 0%, #f59e0b 100%);
    padding: 2px 6px;
    border-radius: 4px;
    color: white;
    font-weight: bold;
  }
  table {
    font-size: 16px;
  }
  blockquote {
    border-left: 4px solid #3b82f6;
    padding-left: 15px;
    font-style: italic;
    color: #4b5563;
    margin: 10px 0;
    font-size: 18px;
  }
  ul {
    margin: 10px 0;
    padding-left: 25px;
  }
  li {
    margin-bottom: 5px;
    line-height: 1.3;
  }
  pre {
    font-size: 14px;
    padding: 8px;
    margin: 10px 0;
  }
---

<!-- Mermaid support -->
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true, theme: 'default' });
</script>

<!-- _class: lead -->

# Module 5
## CI/CD avec GitHub Actions

**Formation DevOps - M2 ESTD Architecte Web**
ForEach Academy | Novembre 2025

---

## 📋 Plan du module (1h15)

1. **Concepts CI/CD** (20min)
   - Continuous Integration vs Delivery vs Deployment
   - Histoire et évolution
   - Anatomie d'un pipeline

2. **GitHub Actions** (30min)
   - Architecture (Workflows, Jobs, Steps, Actions)
   - Syntaxe YAML
   - Triggers et events
   - Runners et environnements

3. **Pratique Avancée** (25min)
   - Secrets et sécurité
   - Artifacts et caching
   - Matrix builds
   - Workflows réutilisables

---

<!-- _class: lead -->

# 1. Concepts CI/CD

---

## L'Integration Hell (années 90)

**Problème classique avant la CI** :

<div style="display: flex; justify-content: center; align-items: center; gap: 30px; margin: 30px 0; background: #f5f5f5; padding: 30px; border-radius: 10px;">
  <div style="display: flex; flex-direction: column; gap: 15px;">
    <div style="padding: 8px 15px; background: #3b82f6; color: white; border-radius: 5px; font-weight: bold;">Développeur A</div>
    <div style="padding: 8px 15px; background: #3b82f6; color: white; border-radius: 5px; font-weight: bold;">Développeur B</div>
    <div style="padding: 8px 15px; background: #3b82f6; color: white; border-radius: 5px; font-weight: bold;">Développeur C</div>
  </div>
  <div style="font-size: 36px;">→</div>
  <div style="text-align: center; padding: 15px; background: #fbbf24; border-radius: 8px; font-weight: bold;">
    Merge manuel<br>
    <span style="font-size: 14px;">(une fois par semaine)</span>
  </div>
  <div style="font-size: 36px;">→</div>
  <div style="text-align: center; padding: 15px; background: #e53e3e; color: white; border-radius: 8px; font-weight: bold;">
    ⚠️ CONFLITS ⚠️<br>
    <span style="font-size: 14px;">Bug marathon<br>(2-3 jours perdus)</span>
  </div>
</div>

**Symptômes** :
- 😱 Merge party le vendredi soir
- 🐛 Des centaines de conflits à résoudre
- 💥 "It works on my machine!"
- 📅 Releases tous les 6 mois

---

## La Solution : Continuous Integration (2001)

**Principe** : Intégrer le code **plusieurs fois par jour** automatiquement.

**Pratiques clés** (Extreme Programming) :
1. ✅ Commit fréquent sur la branche principale
2. ✅ Build automatique à chaque commit
3. ✅ Tests automatiques
4. ✅ Fix immédiat si le build casse
5. ✅ Tout le monde voit le statut du build

**Bénéfice** : Détection précoce des problèmes (shift-left).

---

## CI vs CD vs Continuous Deployment

```
Continuous Integration (CI)
   │ Merge → Build → Test
   ▼
Continuous Delivery (CD)
   │ + Package → Deploy automatique en STAGING
   │              Deploy MANUEL en PRODUCTION
   ▼
Continuous Deployment
   │ Tout automatique jusqu'en PRODUCTION
   └─> Déploiement automatique si tests ✅
```

---

## CI vs CD vs Continuous Deployment (tableau)

| Aspect | **CI** | **Continuous Delivery** | **Continuous Deployment** |
|--------|--------|------------------------|---------------------------|
| **Automatisation** | Build + Test | Build + Test + Deploy staging | Build + Test + Deploy prod |
| **Production** | Manuel | Manuel | Automatique |
| **Fréquence** | Plusieurs/jour | Plusieurs/jour | Plusieurs/jour |
| **Validation** | Tests auto | Tests + Humain | Tests auto uniquement |
| **Risque** | Faible | Moyen | Plus élevé |

**Exemples** :
- **CD** : GitHub, Microsoft, Slack (déploiement manuel validé)
- **Continuous Deployment** : Netflix (4000 déploiements/jour), Etsy (50/jour)

---

## Timeline CI/CD

```
2001  ─ Extreme Programming (Kent Beck, Martin Fowler)
       │  "Integrate continuously"
       │
2005  ─ Hudson (Kohsuke Kawaguchi, Sun Microsystems)
       │  Premier serveur CI open source populaire
       │
2011  ─ Jenkins (fork de Hudson)
       │  Standard de facto pendant 10 ans
       │
2011  ─ Travis CI
       │  Premier "CI as a Service" (gratuit pour OSS)
       │
2013  ─ Circle CI
       │  Concurrence Travis avec Docker support
       │
2019  ─ GitHub Actions 🚀
       │  Game changer : intégré à GitHub
       │
2024  ─ 4 millions de workflows/jour sur GitHub Actions
```

---

## Anatomie d'un Pipeline CI/CD

```
┌──────────────────────────────────────────────────────────┐
│                     PIPELINE CI/CD                        │
└──────────────────────────────────────────────────────────┘

[1. Checkout]  ─┬─> Clone du repo
                │
[2. Install]   ─┼─> npm install / pip install
                │
[3. Lint]      ─┼─> ESLint / Prettier
                │
[4. Test]      ─┼─> Vitest / pytest (parallèle)
                │   ├─ Unit tests
                │   └─ Integration tests
                │
[5. Build]     ─┼─> vite build / docker build
                │
[6. Upload]    ─┼─> Artifact (Docker image, bundle.js)
                │
[7. Deploy]    ─┴─> Staging → (manuel) → Production
```

---

<!-- _class: lead -->

# 2. GitHub Actions

---

## Pourquoi GitHub Actions ?

**Avant GitHub Actions** (Travis CI, Circle CI) :
- ❌ Configuration externe (.travis.yml sur un autre service)
- ❌ Synchronisation GitHub ↔ CI service
- ❌ Secrets dupliqués
- ❌ Coût supplémentaire

**Avec GitHub Actions** :
- ✅ **Intégré nativement** à GitHub
- ✅ Configuration dans `.github/workflows/*.yml`
- ✅ Secrets centralisés
- ✅ **Gratuit** : 2000 minutes/mois (public repos illimité)
- ✅ **Marketplace** : 20,000+ actions prêtes à l'emploi

---

## Architecture GitHub Actions

```
Repository
  └─ .github/workflows/
      ├─ ci.yml          ← WORKFLOW (fichier YAML)
      └─ deploy.yml
                            │
                            ▼
                    ┌──────────────┐
                    │   WORKFLOW   │  Fichier YAML décrivant l'automatisation
                    └──────┬───────┘
                           │
                    on: [push, ...]  ← EVENTS (triggers)
                           │
                    ┌──────▼───────┐
                    │     JOBS     │  Ensemble de steps (parallèles ou séquentiels)
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │    STEPS     │  Actions individuelles (run: ou uses:)
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │   ACTIONS    │  Code réutilisable (Marketplace ou custom)
                    └──────────────┘
```

---

## Workflow basique

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

---

## Events (Triggers)

**Triggers principaux** :

| Event | Description | Exemple |
|-------|-------------|---------|
| `push` | Commit poussé | `on: push` |
| `pull_request` | PR ouverte/mise à jour | `on: pull_request` |
| `schedule` | Cron job | `on: schedule: cron: '0 0 * * *'` |
| `workflow_dispatch` | Déclenchement manuel | Bouton "Run workflow" |
| `release` | Release publiée | `on: release: types: [published]` |
| `issues` | Issue créée/modifiée | `on: issues` |

**40+ events disponibles** : voir [documentation GitHub](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)

---

## Filtres d'events

```yaml
on:
  push:
    branches:
      - main
      - 'releases/**'  # releases/v1, releases/v2, etc.
    tags:
      - 'v*.*.*'       # v1.0.0, v2.1.3, etc.
    paths:
      - 'src/**'       # Uniquement si fichiers dans src/ changent
      - '!docs/**'     # Exclure docs/

  pull_request:
    types:
      - opened
      - synchronize    # Nouveau commit sur la PR
      - reopened
```

---

## Jobs : Parallèles vs Séquentiels

### Parallèles (par défaut)

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps: [...]

  test:
    runs-on: ubuntu-latest  # ⚡ S'exécute en PARALLÈLE avec lint
    steps: [...]
```

### Séquentiels (avec needs)

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps: [...]

  deploy:
    needs: test              # ⏳ Attend que test finisse
    runs-on: ubuntu-latest
    steps: [...]
```

---

## Steps : run vs uses

**`run`** : Commande shell

```yaml
steps:
  - name: Install dependencies
    run: npm install

  - name: Run tests
    run: npm test
```

**`uses`** : Action du Marketplace

```yaml
steps:
  - name: Checkout code
    uses: actions/checkout@v4

  - name: Setup Node
    uses: actions/setup-node@v4
    with:
      node-version: '20'
```

---

## Runners

**GitHub-hosted runners** (machines virtuelles fournies par GitHub) :

| Runner | OS | Specs (2024) | Label |
|--------|----|--------------| ------|
| Ubuntu | Linux | 4 cores, 16 GB RAM | `ubuntu-latest` |
| Windows | Windows Server | 4 cores, 16 GB RAM | `windows-latest` |
| macOS | macOS | 4 cores, 14 GB RAM | `macos-latest` |

**Minutes incluses** :
- ✅ **Repos publics** : Illimité
- 💰 **Repos privés** : 2000 min/mois (Free), 3000 min (Pro)

**Self-hosted runners** : Vos propres machines (gratuit, configuration avancée)

---

## Matrix Strategy (Multi-OS, Multi-Version)

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20, 22]
        # Génère 9 jobs (3 OS × 3 versions)

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}

      - run: npm install
      - run: npm test
```

**Résultat** : 9 jobs s'exécutent en **parallèle** ⚡

---

## Matrix avec include/exclude

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [18, 20]
    # 4 jobs par défaut

    include:
      # Ajouter une config spécifique
      - os: macos-latest
        node-version: 20

    exclude:
      # Retirer Windows + Node 18 (problème connu)
      - os: windows-latest
        node-version: 18

# Résultat : 4 jobs (ubuntu 18/20, windows 20, macos 20)
```

---

<!-- _class: lead -->

# 3. Pratique Avancée

---

## Secrets et Variables

**Secrets** (données sensibles, chiffrées) :
- API keys, tokens, passwords
- Stockés dans Settings → Secrets and variables → Actions

```yaml
steps:
  - name: Deploy to Vercel
    env:
      VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
    run: vercel deploy --prod
```

**Variables** (non-sensibles, en clair) :
```yaml
env:
  NODE_ENV: production
  API_URL: ${{ vars.API_URL }}
```

---

## Niveaux de secrets

```
Organization Secrets
  ├─ Partagés entre tous les repos
  │
Repository Secrets
  ├─ Spécifiques à un repo
  │
Environment Secrets
  └─ Spécifiques à un environnement (staging, prod)
```

**Best practice** : Utiliser **Environment Secrets** pour isoler staging/prod.

```yaml
jobs:
  deploy:
    environment: production  # Requiert approbation manuelle
    steps:
      - run: deploy.sh
        env:
          API_KEY: ${{ secrets.API_KEY }}  # Secret de l'env production
```

---

## OIDC (OpenID Connect) - Authentification moderne

**Problème des secrets** :
- ❌ Fuite potentielle
- ❌ Rotation manuelle
- ❌ Long-lived tokens

**Solution OIDC** :
- ✅ Tokens **temporaires** (15 min)
- ✅ Pas de secret stocké
- ✅ Rotation automatique

```yaml
jobs:
  deploy:
    permissions:
      id-token: write  # Requis pour OIDC
      contents: read

    steps:
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsRole
          aws-region: eu-west-1
```

---

## Artifacts - Partager des fichiers entre jobs

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

      - name: Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: dist-files
          path: dist/
          retention-days: 7  # Supprimé après 7 jours

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Download build artifact
        uses: actions/download-artifact@v4
        with:
          name: dist-files
          path: dist/

      - run: deploy.sh dist/
```

---

## Caching - Accélérer les builds

**Sans cache** : `npm install` prend 2-3 minutes à chaque build.

**Avec cache** : 10-15 secondes ! 🚀

```yaml
steps:
  - uses: actions/checkout@v4

  - name: Setup Node.js
    uses: actions/setup-node@v4
    with:
      node-version: '20'
      cache: 'npm'  # Cache automatique de node_modules/

  - run: npm install  # Utilise le cache si package-lock.json inchangé
  - run: npm test
```

**Cache manuel** :
```yaml
- name: Cache dependencies
  uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

---

## Optimisations de performance

| Technique | Gain de temps | Exemple |
|-----------|---------------|---------|
| **Caching npm** | 70-80% | `cache: 'npm'` |
| **Caching pip** | 60-70% | `cache: 'pip'` |
| **Parallélisation** | 50-60% | Matrix strategy |
| **Artifacts** | 30-40% | Partage entre jobs |
| **Docker layer caching** | 80-90% | `docker/build-push-action` |

**Avant optimisation** : 10 minutes
**Après optimisation** : 2-3 minutes ⚡

---

## Reusable Workflows

**Problème** : Duplication du code YAML entre repos.

**Solution** : Workflows réutilisables.

```yaml
# .github/workflows/reusable-test.yml (repo central)
name: Reusable Test Workflow

on:
  workflow_call:
    inputs:
      node-version:
        required: false
        type: string
        default: '20'

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      - run: npm install
      - run: npm test
```

---

## Utiliser un Reusable Workflow

```yaml
# .github/workflows/ci.yml (repo projet)
name: CI

on: [push, pull_request]

jobs:
  test:
    uses: my-org/workflows/.github/workflows/reusable-test.yml@main
    with:
      node-version: '22'
```

**Bénéfices** :
- ✅ DRY (Don't Repeat Yourself)
- ✅ Maintenance centralisée
- ✅ Standards d'équipe

---

## Permissions GITHUB_TOKEN

**Par défaut** : `GITHUB_TOKEN` a des permissions larges.

**Best practice** : **Principe du moindre privilège** (least privilege).

```yaml
jobs:
  deploy:
    permissions:
      contents: read        # Lire le code
      pull-requests: write  # Commenter les PRs
      id-token: write       # OIDC (AWS/Azure/GCP)

    steps: [...]
```

**Permissions disponibles** :
- `contents`, `issues`, `pull-requests`, `packages`, `deployments`, `actions`, `checks`, `statuses`, `discussions`, etc.

---

## GitHub Actions Marketplace

**20,000+ actions disponibles** :

**Top actions** :
- `actions/checkout@v4` - Clone le repo
- `actions/setup-node@v4` - Setup Node.js
- `docker/build-push-action@v5` - Build et push Docker
- `aws-actions/configure-aws-credentials@v4` - AWS auth
- `codecov/codecov-action@v4` - Upload code coverage

**Recherche** : https://github.com/marketplace?type=actions

**Vérifier avant utilisation** :
- ✅ Nombre d'étoiles
- ✅ Dernière mise à jour
- ✅ Maintenu par GitHub ou organisation reconnue

---

## Exemple complet - Pipeline de production

```yaml
name: Production Deployment

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm test
      - run: npm run lint

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: dist
          path: dist/
```

---

## Exemple complet (suite)

```yaml
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: production  # Requiert approbation manuelle
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/download-artifact@v4
        with:
          name: dist
          path: dist/

      - name: Configure AWS Credentials (OIDC)
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActions
          aws-region: eu-west-1

      - name: Deploy to S3
        run: |
          aws s3 sync dist/ s3://my-bucket/ --delete
          aws cloudfront create-invalidation --distribution-id EXYZ --paths "/*"
```

---

## Debugging GitHub Actions

**Techniques** :

1. **Enable debug logging** :
   - Repository Settings → Secrets → Add `ACTIONS_STEP_DEBUG` = `true`
   - Logs ultra-détaillés

2. **Step summaries** :
   ```yaml
   - run: echo "### Test Results ✅" >> $GITHUB_STEP_SUMMARY
   ```

3. **act** (run workflows localement) :
   ```bash
   brew install act
   act push
   ```

4. **Re-run with debug** : Bouton dans l'UI GitHub Actions

---

## Best Practices GitHub Actions

1. **Sécurité** :
   - ✅ Pin actions par SHA (`uses: actions/checkout@8e5e7e5...`)
   - ✅ Utiliser OIDC au lieu de secrets long-lived
   - ✅ Least privilege permissions

2. **Performance** :
   - ✅ Cache dependencies
   - ✅ Paralléliser avec matrix
   - ✅ Artifacts entre jobs (éviter re-build)

3. **Maintenance** :
   - ✅ Reusable workflows pour DRY
   - ✅ Dependabot pour mettre à jour les actions
   - ✅ Documentation inline (commentaires YAML)

---

## Comparaison GitHub Actions vs autres CI/CD

| Critère | **GitHub Actions** | **GitLab CI** | **Jenkins** | **Circle CI** |
|---------|-------------------|---------------|-------------|---------------|
| **Intégration** | Native GitHub | Native GitLab | Externe | Externe |
| **Config** | YAML | YAML | Groovy/YAML | YAML |
| **Marketplace** | 20k+ actions | Limité | Plugins | Limité |
| **Gratuit (privé)** | 2000 min/mois | 400 min/mois | Illimité (self-hosted) | 6000 min/mois |
| **Self-hosted** | ✅ | ✅ | ✅ (standard) | ✅ |
| **Courbe apprentissage** | Facile | Facile | Difficile | Moyenne |

**Recommandation** : GitHub Actions si vous êtes sur GitHub (évident !).

---

<!-- _class: lead -->

# 🎯 TP Pratique (30min)

## Créer un Pipeline CI/CD Complet

---

## Objectifs du TP

**Créer un workflow GitHub Actions pour** :

1. ✅ Déclencher sur `push` et `pull_request`
2. ✅ Installer les dépendances (avec cache)
3. ✅ Linter le code (ESLint)
4. ✅ Exécuter les tests (Vitest)
5. ✅ Builder l'application
6. ✅ Uploader les artifacts
7. ✅ (Bonus) Matrix strategy multi-OS

**Durée** : 30 minutes
**Support** : [Lien vers repo starter]

---

## Récapitulatif Module 5

**Concepts CI/CD** :
- CI = Build + Test automatiques
- Continuous Delivery = + Deploy staging (manuel prod)
- Continuous Deployment = Tout automatique

**GitHub Actions** :
- Architecture : Workflows → Jobs → Steps → Actions
- Triggers : push, pull_request, schedule, workflow_dispatch
- Runners : GitHub-hosted (gratuit 2000 min) ou self-hosted

**Avancé** :
- Secrets (repository, environment, organization)
- OIDC pour authentification temporaire
- Artifacts et Caching (gains 70-80%)
- Reusable workflows pour DRY

---

<!-- _class: lead -->

# Questions ?

**Module 5 : CI/CD avec GitHub Actions**

---

## 📚 Ressources Complémentaires

### Documentation
- **GitHub Actions Docs** : https://docs.github.com/en/actions
- **Marketplace** : https://github.com/marketplace?type=actions
- **Awesome Actions** : https://github.com/sdras/awesome-actions

### Outils
- **act** : Run workflows locally - https://github.com/nektos/act
- **actionlint** : Lint GitHub Actions workflows

### Articles
- **"GitHub Actions in Action"** - GitHub Blog
- **"CI/CD Best Practices"** - Martin Fowler

### Document de recherche
- **cicd-github-actions-complet.md** (27,000+ mots, 3 parties fusionnées)

---

<!-- _class: lead -->

# Prochaine étape

## Module 6
### Docker & Conteneurisation

*Pause ☕ 15 minutes*
