# Troubleshooting - TP2: GitHub Actions

Guide de dépannage pour résoudre les erreurs courantes avec GitHub Actions.

---

## 🔴 Erreurs de Configuration GitHub

### Erreur: `remote: Repository not found`

**Cause**: L'URL du repository est incorrecte ou vous n'avez pas les droits.

**Solution**:
```bash
# Vérifier le remote
git remote -v

# Corriger l'URL (remplacer USERNAME)
git remote set-url origin https://github.com/USERNAME/tp-github-actions.git

# Ou avec SSH
git remote set-url origin git@github.com:USERNAME/tp-github-actions.git
```

---

### Erreur: `Authentication failed`

**Cause**: Vos credentials GitHub ne sont pas configurés.

**Solution**:

**Option 1 - Personal Access Token** (Recommandé):
1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token (classic)
3. Sélectionner scopes: `repo`, `workflow`
4. Copier le token
5. Utiliser comme mot de passe lors du push

**Option 2 - SSH**:
```bash
# Générer une clé SSH si vous n'en avez pas
ssh-keygen -t ed25519 -C "votre.email@example.com"

# Copier la clé publique
cat ~/.ssh/id_ed25519.pub

# Ajouter sur GitHub: Settings → SSH keys → New SSH key
# Puis utiliser git remote avec SSH (voir ci-dessus)
```

---

## 🟠 Erreurs de Syntaxe YAML

### Erreur: `Invalid workflow file`

**Cause**: Erreur de syntaxe dans le fichier YAML (souvent indentation).

**Symptômes**:
- Workflow n'apparaît pas dans l'onglet Actions
- Message d'erreur sur GitHub

**Solution**:
```bash
# Vérifier l'indentation (2 espaces, PAS de tabs)
# YAML est très strict sur l'indentation!
```

**Structure correcte**:
```yaml
name: CI Pipeline    # Pas d'indentation

on:                  # Pas d'indentation
  push:              # 2 espaces
    branches:        # 4 espaces
      - main         # 6 espaces (liste)

jobs:                # Pas d'indentation
  test:              # 2 espaces
    runs-on: ubuntu  # 4 espaces
    steps:           # 4 espaces
      - uses: ...    # 6 espaces (liste)
```

**Outils de validation**:
- [YAML Lint Online](http://www.yamllint.com/)
- VS Code avec extension "YAML" (Red Hat)

---

### Erreur: `Unexpected value 'strategy'`

**Cause**: `strategy` est mal placé ou mal indenté.

**Mauvais**:
```yaml
jobs:
  test:
    runs-on: ubuntu
    steps:
      strategy:  # ❌ Mauvais placement
```

**Bon**:
```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:  # ✅ Au niveau du job
      matrix:
        os: [ubuntu-latest]
    steps:
      # ...
```

---

## 🟡 Erreurs d'Exécution de Workflow

### Erreur: `Process completed with exit code 1`

**Cause**: Une commande dans le workflow a échoué (tests, build, etc.).

**Solution**:
1. Cliquer sur le job échoué
2. Cliquer sur le step qui a échoué (marqué en rouge)
3. Lire les logs pour identifier l'erreur
4. Corriger localement:
   ```bash
   # Reproduire l'erreur en local
   npm test

   # Corriger le code
   # ...

   # Vérifier que ça marche
   npm test

   # Commit et push
   git commit -am "fix: resolve failing tests"
   git push
   ```

---

### Erreur: `npm ERR! code ENOENT` ou `npm ERR! enoent`

**Cause**: `package-lock.json` manquant ou dépendances non installées.

**Solution**:
```bash
# Générer package-lock.json localement
npm install

# Commit le package-lock.json
git add package-lock.json
git commit -m "chore: add package-lock.json"
git push
```

**Dans le workflow, toujours utiliser `npm ci` au lieu de `npm install`**:
```yaml
- run: npm ci  # ✅ Utilise package-lock.json (reproductible)
# PAS npm install  # ❌ Peut installer des versions différentes
```

---

### Erreur: `Error: Dependencies lock file is not found`

**Cause**: Le setup-node avec cache cherche package-lock.json qui n'existe pas.

**Solution**:

**Option 1**: Ne pas utiliser le cache intégré de setup-node:
```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    # Pas de cache: true
```

**Option 2**: Utiliser actions/cache séparément (recommandé):
```yaml
- uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

---

## 🔵 Erreurs de Cache

### Erreur: Cache ne fonctionne pas (toujours "Cache miss")

**Cause**: La clé de cache change à chaque run.

**Solution**: Vérifier que la clé utilise un hash stable:

**Mauvais**:
```yaml
key: cache-${{ github.run_number }}  # ❌ Change à chaque run
```

**Bon**:
```yaml
key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
# ✅ Change seulement si package-lock.json change
```

---

### Astuce: Forcer l'invalidation du cache

Si le cache est corrompu ou périmé:

```bash
# Modifier une dépendance pour changer le hash
npm install --save-dev some-package
git commit -am "chore: update dependencies"
git push
```

Ou supprimer le cache manuellement:
- Settings → Actions → Caches → Delete

---

## 🟢 Erreurs de Matrix Build

### Erreur: `Matrix must define at least one vector`

**Cause**: Matrix vide ou mal configurée.

**Mauvais**:
```yaml
strategy:
  matrix:  # ❌ Vide
```

**Bon**:
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [18, 20, 22]
```

---

### Certains jobs du matrix échouent

**Exemple**: Windows échoue mais Ubuntu réussit.

**Solution**:
1. Identifier les différences OS-spécifiques dans les logs
2. Utiliser des conditions pour adapter les commandes:

```yaml
- name: Install dependencies
  run: npm ci
  if: runner.os != 'Windows'

- name: Install dependencies (Windows)
  run: npm ci
  if: runner.os == 'Windows'
  shell: cmd
```

Ou ignorer les échecs d'un OS spécifique:
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
  fail-fast: false  # Continue même si un job échoue
```

---

## 🟣 Erreurs de Permissions

### Erreur: `Resource not accessible by integration`

**Cause**: Le workflow n'a pas les permissions nécessaires.

**Solution**: Ajouter les permissions au job:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      issues: write
      pull-requests: write

    steps:
      # ...
```

---

### Erreur: `refusing to allow a Personal Access Token to create a workflow`

**Cause**: GitHub bloque la création de workflows via PAT par sécurité.

**Solution**: Donner le scope `workflow` au Personal Access Token:
- GitHub → Settings → Developer settings → Personal access tokens
- Cocher `workflow`
- Regénérer le token

---

## 🟤 Erreurs de Dépendances

### Erreur: `Cannot find module 'vitest'`

**Cause**: Vitest pas installé ou pas dans package.json.

**Solution**:
```bash
# Installer Vitest localement
npm install --save-dev vitest

# Vérifier package.json
cat package.json

# Commit package.json ET package-lock.json
git add package.json package-lock.json
git commit -m "chore: add vitest dependency"
git push
```

---

### Erreur: `npm ERR! missing script: build`

**Cause**: Script "build" manquant dans package.json.

**Solution**: Ajouter le script dans `package.json`:

```json
{
  "scripts": {
    "test": "vitest run",
    "build": "echo 'Building...' && mkdir -p dist && touch dist/index.html"
  }
}
```

Ou retirer le step "Build" du workflow si pas nécessaire.

---

## 🔧 Commandes de Dépannage

### Vérifier la syntaxe YAML localement

```bash
# Avec yamllint (installer via pip ou apt)
yamllint .github/workflows/ci.yml

# Avec yq (installer via apt)
yq eval .github/workflows/ci.yml
```

### Tester localement avec act

```bash
# Installer act: https://github.com/nektos/act
# Nécessite Docker

# Lister les workflows
act -l

# Exécuter le workflow push
act push

# Exécuter un job spécifique
act -j test
```

### Inspecter les variables GitHub Actions

Ajouter ce step pour débugger:

```yaml
- name: Debug context
  run: |
    echo "Event: ${{ github.event_name }}"
    echo "Ref: ${{ github.ref }}"
    echo "SHA: ${{ github.sha }}"
    echo "Runner OS: ${{ runner.os }}"
    echo "Matrix OS: ${{ matrix.os }}"
    echo "Matrix Node: ${{ matrix.node }}"
```

---

## 🆘 Situations Courantes

### Le workflow ne se déclenche pas

**Checklist**:
- [ ] Fichier dans `.github/workflows/` (pas `github/workflows/`)
- [ ] Extension `.yml` ou `.yaml`
- [ ] Syntaxe YAML valide
- [ ] Push effectué sur GitHub
- [ ] Triggers correspondent (branche, event)

**Commandes de vérification**:
```bash
# Vérifier le chemin
ls -la .github/workflows/

# Vérifier que c'est commité
git status

# Vérifier le contenu
cat .github/workflows/ci.yml
```

---

### Le workflow s'exécute mais n'apparaît pas dans l'onglet Actions

**Cause**: Onglet Actions désactivé dans les settings du repo.

**Solution**:
- Repository Settings → Actions → General
- **Allow all actions and reusable workflows**

---

### Tests passent localement mais échouent dans CI

**Causes possibles**:

1. **Différences d'environnement**:
   ```yaml
   # Ajouter des steps de debug
   - name: Debug environment
     run: |
       node --version
       npm --version
       pwd
       ls -la
   ```

2. **Timezone différente**:
   ```yaml
   - name: Set timezone
     run: echo "TZ=Europe/Paris" >> $GITHUB_ENV
   ```

3. **Variables d'environnement manquantes**:
   ```yaml
   env:
     NODE_ENV: test
     CI: true
   ```

---

## 📚 Aide-Mémoire GitHub Actions

### Syntaxe de Base

```yaml
name: Nom du Workflow

on: [push, pull_request]  # Triggers

jobs:
  job_id:
    runs-on: ubuntu-latest

    steps:
      - name: Nom du step
        uses: action/name@version  # Utilise une action

      - name: Autre step
        run: command  # Exécute une commande
```

### Contextes Utiles

```yaml
${{ github.repository }}      # owner/repo
${{ github.ref }}            # refs/heads/main
${{ github.sha }}            # commit SHA
${{ github.actor }}          # Username qui a déclenché
${{ runner.os }}             # Linux, Windows, macOS
${{ matrix.variable }}       # Variable de matrix
```

### Actions Essentielles

```yaml
# Checkout code
- uses: actions/checkout@v4

# Setup Node.js
- uses: actions/setup-node@v4
  with:
    node-version: '20'

# Cache
- uses: actions/cache@v3
  with:
    path: path/to/cache
    key: unique-key

# Upload artifacts
- uses: actions/upload-artifact@v3
  with:
    name: artifact-name
    path: path/to/files

# Download artifacts (autre job)
- uses: actions/download-artifact@v3
  with:
    name: artifact-name
```

---

## 🔗 Ressources de Dépannage

- [GitHub Actions Troubleshooting](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/troubleshooting-workflows)
- [GitHub Actions Status](https://www.githubstatus.com/) - Vérifier si GitHub a des problèmes
- [GitHub Community Forum](https://github.community/c/code-to-cloud/github-actions)
- [Stack Overflow - GitHub Actions](https://stackoverflow.com/questions/tagged/github-actions)

---

## 💡 Conseils Généraux

1. **Lire les logs attentivement**: L'erreur est souvent claire
2. **Tester localement d'abord**: `npm test` doit passer avant le push
3. **Utiliser act pour débugger**: Reproduit l'environnement CI localement
4. **YAML = indentation stricte**: Utiliser 2 espaces, jamais de tabs
5. **Commit package-lock.json**: Nécessaire pour `npm ci`
6. **Secrets ≠ Variables**: Secrets pour données sensibles, variables pour configs
7. **Caching = clé stable**: Hash de package-lock.json, pas de timestamp

---

## 🚨 Checklist si Rien ne Fonctionne

1. [ ] Repository est bien public (ou vous avez GitHub Actions activé pour privé)
2. [ ] Fichier est dans `.github/workflows/ci.yml` (chemin exact)
3. [ ] Syntaxe YAML valide (tester avec yamllint ou YAML validator online)
4. [ ] Fichier commité et poussé sur GitHub
5. [ ] Actions activées dans Settings → Actions
6. [ ] Tests passent localement (`npm test`)
7. [ ] package-lock.json commité
8. [ ] Branche correspond au trigger (`main`, `develop`, etc.)

Si tout est coché et ça ne marche toujours pas → **Appeler le formateur!**

---

## 📞 Obtenir de l'Aide

### Dans les Logs GitHub

Les logs montrent:
- ✅ Étapes réussies (en vert)
- ❌ Étapes échouées (en rouge)
- ⏱️ Durée de chaque étape
- 📝 Output complet de chaque commande

**Cliquez sur les chevrons `>` pour déplier les détails.**

### Messages d'Erreur Utiles

GitHub Actions donne souvent la solution dans l'erreur:
```
Run npm ci
npm ERR! code ENOENT
npm ERR! syscall open
npm ERR! path /home/runner/work/repo/repo/package-lock.json
npm ERR! errno -2
```
→ Solution claire: `package-lock.json` manquant!

---

## 🎯 Dépannage par Symptôme

| Symptôme | Cause Probable | Solution |
|----------|----------------|----------|
| Workflow n'apparaît pas | Syntaxe YAML invalide | Valider YAML |
| Workflow ne se déclenche pas | Trigger ne correspond pas | Vérifier `on:` |
| "npm ERR! code ENOENT" | package-lock manquant | Commit package-lock.json |
| Tests échouent | Code bugué | Tester localement d'abord |
| Cache ne fonctionne pas | Clé de cache instable | Utiliser hash de package-lock |
| Permission denied | Manque permissions | Ajouter `permissions:` au job |
| Cannot create workflow | PAT sans scope workflow | Régénérer token avec scope |

---

**En cas de blocage persistant, n'hésitez pas à demander de l'aide! C'est normal d'avoir des erreurs en apprenant GitHub Actions.**
