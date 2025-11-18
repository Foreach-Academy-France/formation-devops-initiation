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
  .stat {
    font-size: 36px;
    font-weight: bold;
    color: #dc2626;
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
# Module 3

## Git & Versioning

### 1h pour maîtriser le versioning et GitFlow
### (45min théorie + 15min TP)

---

## 📚 Ce que nous allons voir

1. **Pourquoi le versioning ?**
2. **Git : Les concepts de base**
3. **Commits, Branches, Tags**
4. **"Unique Source de Vérité"**
5. **GitFlow : Le workflow qui fonctionne**
6. **"As Code" : Tout dans Git**
7. **TP Pratique** (15min)

---

## 🤔 Pourquoi le versioning ?

### Le problème sans versioning :

```
projet-final.zip
projet-final-v2.zip
projet-final-v2-VRAIMENT-FINAL.zip
projet-final-v2-VRAIMENT-FINAL-corrige.zip
projet-final-v3-cette-fois-c-est-bon.zip
```

❌ Quel est le bon fichier ?
❌ Qui a modifié quoi ?
❌ Comment revenir en arrière ?

---

## ✅ Avec le versioning

### Une seule source, toute l'histoire :

<div style="background: #1e1e1e; color: #d4d4d4; padding: 20px; border-radius: 8px; font-family: 'Courier New', monospace; font-size: 16px; margin: 20px 0;">
  <div style="color: #569cd6;">$ git log --oneline</div>
  <div style="margin-top: 10px;">
    <span style="color: #ce9178;">a3f8b2c</span> <span style="color: #4ec9b0;">(HEAD -> main)</span> <span style="color: #dcdcaa;">Fix:</span> correction bug connexion<br>
    <span style="color: #ce9178;">e7d9a1f</span> <span style="color: #dcdcaa;">feat:</span> ajout authentification<br>
    <span style="color: #ce9178;">c4b5e8d</span> <span style="color: #dcdcaa;">docs:</span> mise à jour README<br>
    <span style="color: #ce9178;">9f2d7a3</span> <span style="color: #dcdcaa;">refactor:</span> nettoyage du code
  </div>
</div>

✅ Historique complet
✅ Qui a fait quoi, quand et pourquoi
✅ Possibilité de revenir en arrière

---

## 📖 Git : Qu'est-ce que c'est ?

### Système de contrôle de version **distribué**

Créé par **Linus Torvalds** en 2005 pour le développement du noyau Linux

**Caractéristiques :**
- **Distribué** : Chaque développeur a une copie complète
- **Rapide** : Opérations locales ultra-rapides
- **Fiable** : Intégrité cryptographique (SHA-1)
- **Open Source** : Gratuit et libre

---

## 🆚 Git vs autres systèmes

| Aspect | Git | SVN/CVS |
|--------|-----|---------|
| Architecture | Distribué | Centralisé |
| Vitesse | Très rapide | Plus lent |
| Branches | Légères | Lourdes |
| Offline | Oui | Non |
| Adoption | Standard industrie | Historique |

---

## 🎯 Les 3 concepts fondamentaux

### 1. **Commit** 📸
Un snapshot de votre code à un instant T

### 2. **Branch** 🌿
Une ligne de développement parallèle

### 3. **Tag** 🏷️
Un marqueur sur un commit spécifique (version)

---

## 📸 Le Commit

### Un commit c'est :

```bash
git commit -m "feat: ajout système de login"
```

- **Hash unique** : `a3f8b2c9d1e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8`
- **Auteur** : Fabrice Claeys <fabrice@example.com>
- **Date** : 2025-11-04 10:30:15
- **Message** : Description des changements
- **Contenu** : Tous les fichiers modifiés

---

## 📸 Anatomie d'un commit

```
commit a3f8b2c
Author: Fabrice Claeys <fabrice@example.com>
Date:   Mon Nov 4 10:30:15 2025 +0100

    feat: ajout système de login

    - Création du formulaire de connexion
    - Ajout de la validation côté serveur
    - Tests unitaires pour l'authentification

diff --git a/src/auth/login.ts b/src/auth/login.ts
new file mode 100644
index 0000000..abc1234
```

---

## ✍️ Bien écrire ses messages de commit

### Convention : Conventional Commits

```bash
<type>(<scope>): <description>

[corps optionnel]

[footer optionnel]
```

**Types courants :**
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `docs`: Documentation
- `refactor`: Refactoring (sans changement de comportement)
- `test`: Ajout/modification de tests

💡 **Alternative visuelle :** [Gitmoji](https://gitmoji.dev/) propose d'utiliser des emojis à la place des types texte (✨ feat, 🐛 fix, 📝 docs, ♻️ refactor, ✅ test)

---

## ✍️ Exemples de bons commits

```bash
✅ feat(auth): ajout du système de login OAuth2
✅ fix(api): correction du timeout sur /users
✅ docs(readme): mise à jour instructions installation
✅ refactor(database): migration vers PostgreSQL
✅ test(auth): ajout tests e2e pour login

❌ WIP
❌ fix bug
❌ modifications
❌ commit du vendredi soir
```

---

## 🌿 Les Branches

### Qu'est-ce qu'une branche ?

> Une branche est une ligne de développement **indépendante**

<div class="mermaid">
gitGraph
  commit id: "Initial"
  commit id: "Setup"
  branch feature
  checkout feature
  commit id: "Work 1"
  commit id: "Work 2"
  commit id: "Work 3"
  checkout main
  commit id: "Bugfix"
  merge feature
</div>

**Utilité :**
- Développer une fonctionnalité sans impacter `main`
- Expérimenter sans risque
- Isoler le travail en cours

---

## 🌿 Commandes de base

```bash
# Créer une branche
git branch feature/login

# Changer de branche
git checkout feature/login
# ou (version moderne)
git switch feature/login

# Créer ET changer en une commande
git checkout -b feature/login
# ou
git switch -c feature/login
```

---

## 🌿 Lister et supprimer des branches

```bash
# Lister toutes les branches
git branch -a

# Supprimer une branche locale
git branch -d feature/login

# Supprimer une branche distante
git push origin --delete feature/login

# Voir les branches fusionnées
git branch --merged
```

---

## 🔀 Merge : Fusionner des branches

### 2 types de merge :

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin: 20px 0;">
  <div>
    <p style="text-align: center; font-weight: bold; margin-bottom: 10px;">1. Fast-forward (simple)</p>
    <div class="mermaid">
gitGraph
  commit id: "C1"
  commit id: "C2"
  branch feature
  checkout feature
  commit id: "F1"
  commit id: "F2"
  checkout main
  merge feature
    </div>
  </div>

  <div>
    <p style="text-align: center; font-weight: bold; margin-bottom: 10px;">2. Merge commit (fusion)</p>
    <div class="mermaid">
gitGraph
  commit id: "C1"
  commit id: "C2"
  branch feature
  checkout feature
  commit id: "F1"
  commit id: "F2"
  commit id: "F3"
  checkout main
  commit id: "C3"
  merge feature
    </div>
  </div>
</div>

---

## 🔀 Commande merge

```bash
# Se positionner sur la branche cible
git checkout main

# Fusionner la branche feature
git merge feature/login

# En cas de conflit
git status              # Voir les conflits
# Résoudre manuellement les conflits
git add .
git commit              # Finaliser le merge
```

---

## 🏷️ Les Tags

### Marquer des versions importantes

```bash
# Créer un tag léger
git tag v1.0.0

# Créer un tag annoté (recommandé)
git tag -a v1.0.0 -m "Release 1.0.0 - Première version stable"

# Lister les tags
git tag

# Pusher les tags
git push origin v1.0.0
git push origin --tags  # Tous les tags
```

---

## 🏷️ Sémantique de version

### SemVer : Semantic Versioning

```
MAJOR.MINOR.PATCH
  2  .  3  .  1
```

- **MAJOR** : Changements incompatibles
- **MINOR** : Nouvelles fonctionnalités compatibles
- **PATCH** : Corrections de bugs

**Exemples :**
- `1.0.0` → `2.0.0` : Breaking changes
- `1.0.0` → `1.1.0` : Nouvelle feature
- `1.0.0` → `1.0.1` : Bug fix

---

## 🎯 Single Source of Truth

### L'unique source de vérité

<div class="highlight">Git = La référence absolue</div>

**Principe :**
- Le repository Git est **LA** source de vérité
- Tout le code **doit** être versionné
- Aucune modification en dehors de Git

**Conséquence :**
- Pas de fichiers qui traînent sur les bureaux
- Pas de "version sur ma machine"
- Traçabilité totale

---

## 📦 "As Code" : Tout dans Git

### Infrastructure as Code (IaC)

**Pas seulement le code applicatif !**

<div style="background: #1e1e1e; color: #d4d4d4; padding: 20px; border-radius: 8px; font-family: 'Courier New', monospace; font-size: 15px; margin: 20px 0;">
<table style="border: none; width: 100%;">
<tr><td style="border: none; color: #569cd6;">mon-projet/</td></tr>
<tr><td style="border: none;">├── src/</td><td style="border: none; color: #6a9955;"># Code application</td></tr>
<tr><td style="border: none;">├── tests/</td><td style="border: none; color: #6a9955;"># Tests</td></tr>
<tr><td style="border: none;">├── docs/</td><td style="border: none; color: #6a9955;"># Documentation</td></tr>
<tr><td style="border: none;">├── .github/workflows/</td><td style="border: none; color: #6a9955;"># CI/CD (GitHub Actions)</td></tr>
<tr><td style="border: none;">├── terraform/</td><td style="border: none; color: #6a9955;"># Infrastructure</td></tr>
<tr><td style="border: none;">├── ansible/</td><td style="border: none; color: #6a9955;"># Configuration</td></tr>
<tr><td style="border: none;">├── docker-compose.yml</td><td style="border: none; color: #6a9955;"># Containers</td></tr>
<tr><td style="border: none;">└── kubernetes/</td><td style="border: none; color: #6a9955;"># Orchestration</td></tr>
</table>
</div>

---

## 📦 Avantages du "As Code"

### Tout versionné = Tout reproductible

✅ **Versioning** : Historique de l'infrastructure
✅ **Review** : Code review aussi pour l'infra
✅ **Rollback** : Retour arrière facile
✅ **Documentation** : Le code EST la doc
✅ **Collaboration** : Travail d'équipe facilité
✅ **Automation** : CI/CD pour tout

---

## 🌊 GitFlow : Le workflow standard

### Créé par Vincent Driessen en 2010

Un modèle de branching pour gérer les releases

**5 types de branches :**
1. `main` (ou `master`)
2. `develop`
3. `feature/*`
4. `release/*`
5. `hotfix/*`

---

## 🌊 GitFlow : Structure

<div class="mermaid">
gitGraph
  commit id: "Initial"
  branch develop
  checkout develop
  commit id: "Setup"
  branch feature/login
  checkout feature/login
  commit id: "Login UI"
  commit id: "Auth API"
  checkout develop
  merge feature/login
  branch feature/profile
  checkout feature/profile
  commit id: "Profile view"
  commit id: "Edit profile"
  checkout develop
  merge feature/profile
  branch release/1.0
  checkout release/1.0
  commit id: "Fix tests"
  commit id: "Update docs"
  checkout main
  merge release/1.0 tag: "v1.0"
  checkout develop
  merge release/1.0
  commit id: "New feature"
  branch release/1.1
  checkout release/1.1
  commit id: "Prepare 1.1"
  checkout main
  merge release/1.1 tag: "v1.1"
</div>

---

## 🌊 GitFlow : Les branches principales

### 1. `main` (production)

- **Toujours stable**
- Contient uniquement le code en production
- Chaque commit = une release
- Taggé avec versions (v1.0.0, v1.1.0)

### 2. `develop` (développement)

- Branche d'intégration
- Contient les dernières features validées
- Point de départ pour les `feature/*`

---

## 🌊 GitFlow : Feature branches

### `feature/*` : Nouvelles fonctionnalités

```bash
# Créer une feature depuis develop
git checkout develop
git checkout -b feature/user-profile

# ... développement ...

# Fusionner dans develop
git checkout develop
git merge feature/user-profile
git branch -d feature/user-profile
```

**Convention de nommage :**
- `feature/user-authentication`
- `feature/payment-integration`

---

## 🌊 GitFlow : Release branches

### `release/*` : Préparation d'une release

```bash
# Créer une release depuis develop
git checkout develop
git checkout -b release/1.2.0

# ... corrections mineures, bump version ...

# Fusionner dans main ET develop
git checkout main
git merge release/1.2.0
git tag -a v1.2.0 -m "Release 1.2.0"

git checkout develop
git merge release/1.2.0
```

---

## 🌊 GitFlow : Hotfix branches

### `hotfix/*` : Corrections urgentes en production

```bash
# Créer un hotfix depuis main
git checkout main
git checkout -b hotfix/1.2.1

# ... correction du bug critique ...

# Fusionner dans main ET develop
git checkout main
git merge hotfix/1.2.1
git tag -a v1.2.1 -m "Hotfix 1.2.1"

git checkout develop
git merge hotfix/1.2.1
```

---

## 🌊 GitFlow : Résumé des flux

| Type | Origine | Destination | Durée |
|------|---------|-------------|-------|
| `feature/*` | `develop` | `develop` | Jours/Semaines |
| `release/*` | `develop` | `main` + `develop` | Jours |
| `hotfix/*` | `main` | `main` + `develop` | Heures |

---

## 🌊 GitFlow : Avantages

### Pourquoi utiliser GitFlow ?

✅ **Clarté** : Rôle de chaque branche bien défini
✅ **Releases contrôlées** : Process de release structuré
✅ **Hotfixes faciles** : Corrections urgentes isolées
✅ **Parallélisation** : Plusieurs features en parallèle
✅ **Standard** : Reconnu et documenté

---

## ⚠️ GitFlow : Limites

### Quand NE PAS utiliser GitFlow ?

❌ **Déploiement continu** : Trop complexe
❌ **Petites équipes** : Overhead inutile
❌ **Projets simples** : GitHub Flow suffit

**Alternatives :**
- **GitHub Flow** : Simple (main + feature branches)
- **Trunk-Based Development** : main only

---

## 🔀 GitHub Flow : Alternative simple

### Pour le déploiement continu

<div class="mermaid">
gitGraph
  commit id: "C1"
  branch feature/login
  checkout feature/login
  commit id: "Login"
  commit id: "Tests"
  checkout main
  merge feature/login
  commit id: "C2"
  branch feature/api
  checkout feature/api
  commit id: "API"
  commit id: "Docs"
  checkout main
  merge feature/api
  branch feature/ui
  checkout feature/ui
  commit id: "UI fix"
  checkout main
  merge feature/ui
</div>

**Règles :**
1. `main` est **toujours** déployable
2. Feature branches depuis `main`
3. Pull Request + Review
4. Merge → Deploy automatique

---

## 🛠️ Outils Git essentiels

### Commandes du quotidien

```bash
# Statut des fichiers
git status

# Ajouter des fichiers
git add .
git add src/auth/login.ts

# Commiter
git commit -m "feat: login page"

# Voir l'historique
git log --oneline --graph

# Voir les différences
git diff
```

---

## 🛠️ Outils Git (suite)

```bash
# Pousser sur le remote
git push origin feature/login

# Récupérer les changements
git pull origin develop

# Voir les branches distantes
git branch -r

# Cloner un repository
git clone https://github.com/user/projet.git
```

---

## 🔍 Git : Bonnes pratiques

### Les règles d'or

1. **Commit souvent** : Petits commits atomiques
2. **Messages clairs** : Suivre Conventional Commits
3. **Une feature = une branche**
4. **Pull avant push** : Éviter les conflits
5. **Review avant merge** : Pull Requests
6. **Ne jamais rebase main** : Dangereux !

---

## 🚫 Anti-patterns à éviter

### Ce qu'il ne faut PAS faire

❌ Commits énormes (100+ fichiers)
❌ Messages vagues ("fix", "update")
❌ Commit de credentials/secrets
❌ Commit de `node_modules/` ou binaires
❌ Force push sur `main`
❌ Développer directement sur `main`

---

## 🔐 Sécurité : .gitignore

### Ne jamais commiter :

```gitignore
# Credentials
.env
.env.local
config/secrets.json

# Dependencies
node_modules/
vendor/

# Build artifacts
dist/
build/
*.o
*.exe

# IDE
.vscode/
.idea/
```

---

## 📊 Git : Quelques statistiques

### L'écosystème Git en 2024

- <span class="stat">100M+</span> repositories sur GitHub
- <span class="stat">94%</span> des développeurs utilisent Git
- <span class="stat">1er</span> outil de versioning mondial
- Utilisé par tous les GAFAM

---

## 🎓 Récapitulatif

### Ce qu'il faut retenir

1. **Git** = Standard industrie pour le versioning
2. **Commit** = Snapshot du code
3. **Branch** = Ligne de développement parallèle
4. **GitFlow** = Workflow pour releases structurées
5. **As Code** = Tout versionner (code + infra)
6. **Single Source of Truth** = Git est la référence

---

## 💪 TP Pratique (15min)

### Exercice : Workflow GitFlow

**Objectif :** Simuler un workflow GitFlow complet

1. Créer un repository
2. Créer une branche `develop`
3. Créer une `feature/`
4. Merger dans `develop`
5. Créer une `release/`
6. Créer un tag `v1.0.0`
7. (Bonus) Simuler un `hotfix/`

**Instructions détaillées dans `/tp/tp1-git-gitflow/`**

---

## ❓ Questions ?

### Avant de passer au TP

- Git vs autres VCS ?
- Quand utiliser GitFlow vs GitHub Flow ?
- Comment gérer les merge conflicts ?
- Autres questions ?

---

<!-- _class: lead -->
# 🎯 TP Git/GitFlow

## 15 minutes

### Rendez-vous dans `/tp/tp1-git-gitflow/`

Bonne pratique ! 🚀
