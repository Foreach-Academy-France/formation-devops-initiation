# TP2: CI/CD avec GitHub Actions

**Durée**: 30 minutes
**Difficulté**: ⭐⭐⭐☆☆
**Compétences**: C20 - Automatisation DevOps et intégration continue

---

## 🎯 Objectifs

À la fin de ce TP, vous serez capable de:
- ✅ Créer un workflow GitHub Actions complet
- ✅ Comprendre la syntaxe YAML des workflows
- ✅ Configurer des triggers (push, pull_request)
- ✅ Utiliser le caching pour optimiser les builds
- ✅ Créer des matrix builds (multi-version, multi-OS)
- ✅ Gérer les artifacts
- ✅ Ajouter un badge de statut CI

---

## 📋 Prérequis

- Compte GitHub créé et connecté
- Git installé et configuré
- Node.js installé (`node --version`)
- Éditeur de code (VS Code recommandé)

---

## 🚀 Étape 1: Setup du Projet GitHub (5 minutes)

### 1.1 Créer le repository sur GitHub

1. Aller sur https://github.com/new
2. **Repository name**: `tp-github-actions`
3. **Visibility**: Public
4. **Ne PAS** initialiser avec README
5. Cliquer sur **"Create repository"**

### 1.2 Cloner le starter kit

```bash
cd ~/Desktop
cp -r <chemin-vers-starter>/* tp-github-actions/
cd tp-github-actions
```

**OU si vous avez le starter kit dans ce dossier**:
```bash
cd ~/Desktop
cd tp-github-actions-starter
```

### 1.3 Vérifier le contenu

```bash
ls -la
```

Vous devez voir:
```
package.json
src/
  calculator.js
tests/
  calculator.test.js
```

### 1.4 Installer les dépendances

```bash
npm install
```

### 1.5 Tester localement

```bash
npm test
```

Vous devez voir: ✓ 2 tests passent (add, multiply)

### 1.6 Initialiser Git et pousser

```bash
git init
git branch -M main
git add .
git commit -m "feat: initial project setup with calculator and tests"

# Ajouter le remote (remplacer USERNAME par votre username GitHub)
git remote add origin https://github.com/USERNAME/tp-github-actions.git

# Pousser sur GitHub
git push -u origin main
```

### ✓ Point de Validation

- Aller sur `https://github.com/USERNAME/tp-github-actions`
- Vous devez voir vos fichiers
- Onglet "Actions" doit être visible (vide pour l'instant)

---

## 🔄 Étape 2: Créer un Workflow CI Basique (8 minutes)

### 2.1 Créer la structure des workflows

```bash
mkdir -p .github/workflows
```

### 2.2 Créer le fichier ci.yml

Créez `.github/workflows/ci.yml` avec ce contenu:

```yaml
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
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build application
        run: npm run build
```

### 2.3 Commit et push

```bash
git add .github/
git commit -m "ci: add basic GitHub Actions workflow"
git push
```

### 2.4 Vérifier l'exécution

1. Aller sur GitHub → Onglet **"Actions"**
2. Vous devez voir le workflow **"CI Pipeline"** en cours
3. Cliquer dessus pour voir les détails
4. Attendre que tous les steps passent au vert ✅

### ✓ Point de Validation

- Workflow s'exécute automatiquement
- Job "test" réussit (badge vert)
- Tous les steps sont verts
- Logs montrent: `✓ 2 tests passed`

---

## ⚡ Étape 3: Optimisation avec Cache et Artifacts (7 minutes)

### 3.1 Ajouter le caching de node_modules

Modifier `.github/workflows/ci.yml` pour ajouter le cache après le setup de Node.js:

```yaml
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      # ⬇️ AJOUTER CETTE SECTION
      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      - name: Install dependencies
        run: npm ci
```

### 3.2 Ajouter l'upload d'artifacts

Ajouter à la fin du job (après le build):

```yaml
      - name: Build application
        run: npm run build

      # ⬇️ AJOUTER CETTE SECTION
      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: dist/
          retention-days: 7
```

### 3.3 Commit et push

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add caching and artifacts upload"
git push
```

### 3.4 Observer l'optimisation

1. Aller dans Actions → Votre workflow
2. **Premier run**: Pas de cache (cache miss)
3. Cliquer sur "Re-run jobs"
4. **Deuxième run**: Cache hit! (plus rapide)

### ✓ Point de Validation

- Logs montrent `Cache restored from key: ...`
- Temps d'installation réduit (~30s → ~5s)
- Artifact "build-output" téléchargeable
- Job toujours au vert

---

## 🎯 Étape 4: Matrix Build - Multi-Version (10 minutes)

### 4.1 Ajouter une stratégie matrix

Modifier le job pour ajouter la section `strategy`:

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    # ⬇️ AJOUTER CETTE SECTION
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node: [18, 20, 22]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
```

### 4.2 Adapter le cache pour la matrix

Modifier la section cache:

```yaml
      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: node_modules
          key: ${{ runner.os }}-node${{ matrix.node }}-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node${{ matrix.node }}-
```

### 4.3 Adapter les artifacts pour la matrix

Modifier la section artifacts:

```yaml
      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-${{ matrix.os }}-node${{ matrix.node }}
          path: dist/
          retention-days: 7
```

### 4.4 Commit et push

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add matrix build for Node 18/20/22 on ubuntu/windows"
git push
```

### 4.5 Observer le matrix build

1. Aller dans Actions
2. Vous devez voir **6 jobs** s'exécuter en parallèle:
   - ubuntu-latest / Node 18
   - ubuntu-latest / Node 20
   - ubuntu-latest / Node 22
   - windows-latest / Node 18
   - windows-latest / Node 20
   - windows-latest / Node 22

### ✓ Point de Validation

- **6 jobs** s'exécutent en parallèle
- Tous les jobs réussissent (6 ✅)
- Cache fonctionne sur chaque combinaison
- 6 artifacts différents disponibles en téléchargement

---

## 🎖️ Étape 5 (BONUS): Badge et Documentation (5 minutes)

### 5.1 Ajouter un badge de statut

Modifier le `README.md` à la racine:

```bash
cat > README.md << 'EOF'
# Mon Projet DevOps

![CI Pipeline](https://github.com/USERNAME/tp-github-actions/workflows/CI%20Pipeline/badge.svg)

Formation M2 ESTD - ForEach Academy

## Tests

Ce projet utilise Vitest pour les tests automatisés.

```bash
npm test
```

## CI/CD

Le projet utilise GitHub Actions pour l'intégration continue:
- ✅ Tests automatiques sur Node 18, 20, 22
- ✅ Tests sur Ubuntu et Windows
- ✅ Cache des dépendances pour builds rapides
- ✅ Upload des artifacts de build
EOF
```

**N'oubliez pas de remplacer `USERNAME` par votre username GitHub!**

### 5.2 Commit et push

```bash
git add README.md
git commit -m "docs: add CI badge and documentation"
git push
```

### 5.3 Créer un second workflow pour le déploiement (Bonus avancé)

Créer `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Deploy to GitHub Pages
        run: echo "Déploiement simulé vers production"
```

```bash
git add .github/workflows/deploy.yml
git commit -m "ci: add deployment workflow triggered by tags"
git push
```

### ✓ Point de Validation

- Badge CI visible sur le README GitHub
- Badge montre le statut "passing" (vert)
- Workflow Deploy créé (se déclenche sur tags)

---

## 📊 Vérification Complète

### Checklist Finale

```bash
# Vérifier que tous les fichiers sont là
ls -la .github/workflows/

# Vérifier les workflows sur GitHub
# Aller sur: https://github.com/USERNAME/tp-github-actions/actions
```

Vous devriez avoir:
- ✅ Workflow "CI Pipeline" avec 6 jobs réussis
- ✅ Cache fonctionnel (logs montrent "Cache restored")
- ✅ 6 artifacts téléchargeables
- ✅ Badge CI dans le README
- ✅ (Bonus) Workflow "Deploy" créé

---

## 🎓 Concepts Clés Appris

### GitHub Actions - Architecture

```
Workflow (ci.yml)
  ↓
Jobs (test)
  ↓
Steps (checkout, setup, install, test)
  ↓
Actions (actions/checkout@v4, actions/setup-node@v4)
```

### Triggers (Events)

- `push`: Déclenché sur un push vers une branche
- `pull_request`: Déclenché sur une PR
- `schedule`: Déclenché par cron
- `workflow_dispatch`: Déclenchement manuel

### Strategy Matrix

Permet de tester sur plusieurs combinaisons:
```yaml
strategy:
  matrix:
    os: [ubuntu, windows, macos]
    node: [18, 20, 22]
# = 9 jobs (3 OS × 3 versions Node)
```

### Caching

- Accélère les builds (30s → 5s pour install)
- Clé basée sur hash du package-lock.json
- Invalide automatiquement si dépendances changent

### Artifacts

- Stocke les résultats de build
- Téléchargeables pendant 7 jours (configurable)
- Utilisables par d'autres jobs

---

## 🧪 Tests Avancés (Pour les Rapides)

### Test 1: Créer une Pull Request

```bash
git checkout -b feature/divide
```

Ajouter une fonction `divide` dans calculator.js et son test.

```bash
git commit -am "feat: add divide function"
git push -u origin feature/divide
```

Créer une PR sur GitHub → Le workflow CI doit s'exécuter automatiquement!

### Test 2: Simuler un échec de CI

Modifier `tests/calculator.test.js` pour qu'un test échoue:

```javascript
it('should add numbers', () => {
  expect(add(2, 3)).toBe(6); // ❌ Mauvais résultat attendu
});
```

Commit et push → Observer le workflow échouer et bloquer la PR.

### Test 3: Ajouter un job de linting

Créer un second job dans `ci.yml`:

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run lint

  test:
    needs: lint  # Ne s'exécute que si lint réussit
    # ... reste du job
```

---

## 🔗 Ressources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Matrix Strategy](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)
- [Caching Dependencies](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

---

## ✅ Checklist de Complétion

### Obligatoire (15 min)
- [ ] Repository GitHub créé et starter kit poussé
- [ ] Workflow CI basique fonctionnel
- [ ] Job s'exécute automatiquement sur push
- [ ] Tests passent dans le CI

### Optimisations (8 min)
- [ ] Cache configuré et fonctionnel
- [ ] Artifacts uploadés et téléchargeables
- [ ] Matrix build avec 6 jobs parallèles
- [ ] Tous les 6 jobs réussissent

### Bonus (7 min)
- [ ] Badge CI ajouté dans README
- [ ] Workflow Deploy créé (déclenché par tags)
- [ ] Documentation mise à jour
- [ ] Tests avancés réalisés (PR, échec simulé, linting)

---

## 💡 Trucs et Astuces

### Débugger un Workflow

```yaml
- name: Debug info
  run: |
    echo "OS: ${{ runner.os }}"
    echo "Node: ${{ matrix.node }}"
    echo "Event: ${{ github.event_name }}"
    echo "Branch: ${{ github.ref }}"
    ls -la
```

### Workflow local avec act

```bash
# Installer act (Docker requis)
# https://github.com/nektos/act

# Tester le workflow localement
act push
```

### Re-run un workflow

- Aller dans Actions
- Cliquer sur le run échoué
- Bouton "Re-run jobs" en haut à droite

---

## 📊 Métriques à Observer

### Temps d'Exécution

**Sans cache**:
- Install dependencies: ~30-45 secondes
- Run tests: ~5 secondes
- Build: ~3 secondes
- **Total**: ~45-60 secondes par job

**Avec cache**:
- Install dependencies: ~5-10 secondes (cache hit!)
- Run tests: ~5 secondes
- Build: ~3 secondes
- **Total**: ~15-20 secondes par job

**Gain**: ~70% de temps économisé avec le cache!

### Parallélisme

- Sans matrix: 1 job × 45s = **45 secondes**
- Avec matrix: 6 jobs en parallèle = **45 secondes aussi!**
- **Gain**: 6 fois plus de couverture pour le même temps

---

## 🏆 Critères de Réussite

Vous avez réussi le TP si:

1. ✅ Workflow CI s'exécute automatiquement sur chaque push
2. ✅ Tous les tests passent dans le CI
3. ✅ Cache fonctionne (visible dans les logs)
4. ✅ Matrix build avec 6 jobs parallèles réussit
5. ✅ Artifacts sont disponibles en téléchargement
6. ✅ Badge CI visible sur le README

**Score minimal**: 70/100 points (voir grille d'évaluation)

---

**Formateur**: Fabrice Claeys
**Formation**: M2 ESTD - Initiation DevOps
**ForEach Academy** - 2025
