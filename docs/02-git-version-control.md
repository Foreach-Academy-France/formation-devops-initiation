---
claude-context: true
type: course-material
date: 2025-11-04
course: M2 ESTD - Initiation DevOps
topic: Git et Systèmes de Contrôle de Version
tags:
  - devops
  - git
  - version-control
  - course-material
  - m2-estd
sources_count: 15
tools_used:
  - WebSearch
  - Ref.ai
---

# Git et les Systèmes de Contrôle de Version

**Document de cours - M2 ESTD DevOps**
*Historique, Architecture Technique, Workflows et Impact sur le DevOps Moderne*

---

## Table des Matières

1. [Histoire des Systèmes de Contrôle de Version](#1-histoire-des-systèmes-de-contrôle-de-version)
2. [La Crise BitKeeper et la Naissance de Git](#2-la-crise-bitkeeper-et-la-naissance-de-git)
3. [Architecture Technique de Git](#3-architecture-technique-de-git)
4. [Workflows et Bonnes Pratiques](#4-workflows-et-bonnes-pratiques)
5. [L'Écosystème Git](#5-lécosystème-git)
6. [Adoption et Impact sur l'Industrie](#6-adoption-et-impact-sur-lindustrie)
7. [Git comme Fondation du DevOps Moderne](#7-git-comme-fondation-du-devops-moderne)

---

## 1. Histoire des Systèmes de Contrôle de Version

### 1.1 Chronologie des VCS (1982-2005)

#### **1982 : RCS (Revision Control System)**

- **Créateur** : Walter F. Tichy, Université Purdue
- **Caractéristiques** :
  - Premier système de contrôle de version open source largement adopté
  - Écrit en C comme alternative à SCCS (propriétaire)
  - **Limitation majeure** : Un seul utilisateur à la fois, gestion fichier par fichier
  - **Innovation** : Utilisation des "reverse deltas" (stockage d'instructions d'édition plutôt que de révisions complètes)
- **Architecture** : Centralisée, fichier par fichier

```
┌─────────────┐
│   RCS       │
│  (1982)     │
│             │
│ • Fichier   │
│   unique    │
│ • 1 user    │
│ • Local     │
└─────────────┘
```

#### **1990 : CVS (Concurrent Versions System)**

- **Créateur** : Dick Grune (1986, puis développé dans les années 90)
- **Révolution** : Permet le travail **concurrent** de plusieurs développeurs
- **Caractéristiques** :
  - Construit au-dessus de RCS (front-end)
  - Introduction du concept de **repository** (dépôt centralisé)
  - Modèle de fusion (merge) au lieu du verrouillage de fichiers
  - **Premières fonctionnalités** : branching et tags symboliques
- **Limitations** :
  - Pas de commits atomiques (chaque fichier commité séparément)
  - Gestion des branches complexe et coûteuse
  - Difficultés avec les fichiers binaires

```
        ┌──────────────┐
        │  Repository  │
        │  (Serveur)   │
        └──────┬───────┘
               │
     ┌─────────┼─────────┐
     │         │         │
┌────▼───┐ ┌──▼────┐ ┌──▼────┐
│ User 1 │ │ User 2│ │ User 3│
│(Working│ │(Working│ │(Working
│  Copy) │ │  Copy) │ │  Copy)│
└────────┘ └───────┘ └───────┘
    CVS - Architecture Client/Serveur
```

#### **2000 : SVN (Subversion)**

- **Créateur** : CollabNet
- **Objectif** : "CVS fait bien" - corriger les défauts de CVS
- **Innovations majeures** :
  - ✅ **Commits atomiques** : toutes les modifications validées ensemble
  - ✅ Versionnement des répertoires (pas seulement les fichiers)
  - ✅ Meilleure gestion des fichiers binaires
  - ✅ Gestion améliorée du branching et merging
  - ✅ Architecture client/serveur robuste
  - ✅ Métadonnées versionnées
- **Adoption** : Devient le standard de facto vers 2006
- **Architecture** : Centralisée avec un serveur unique

**Limitations de SVN** (qui motiveront Git) :
- Les branches sont des **copies de répertoires** → coûteuses en espace et temps
- Merge complexe et source d'erreurs
- Opérations lentes car nécessitent la connexion au serveur
- Impossible de travailler hors ligne

#### **2005 : L'Année de la Révolution Distribuée**

Deux systèmes DVCS (Distributed Version Control Systems) naissent :
- **Git** (Linus Torvalds) - Avril 2005
- **Mercurial** (Matt Mackall) - Avril 2005

---

### 1.2 Comparaison : Centralisé vs Distribué

| Aspect | Centralisé (SVN) | Distribué (Git) |
|--------|------------------|-----------------|
| **Architecture** | Serveur unique, clients légers | Chaque clone = dépôt complet |
| **Travail hors ligne** | ❌ Impossible | ✅ Total |
| **Vitesse** | Lent (réseau requis) | Rapide (local) |
| **Branching** | Coûteux (copie répertoire) | Quasi-instantané (pointeur) |
| **Merging** | Complexe, erreurs fréquentes | Moteur de fusion avancé |
| **Backup** | Point de défaillance unique | Chaque clone = backup |
| **Flexibilité workflows** | Limitée | Infinie |

---

## 2. La Crise BitKeeper et la Naissance de Git

### 2.1 L'Ère BitKeeper (2002-2005)

#### Contexte pré-2002

De 1991 à 2002, le développement du noyau Linux utilisait un système archaïque :
- Les développeurs envoyaient des **patches par email** aux mailing lists
- Linus Torvalds appliquait **manuellement** les patches à son arbre source
- Aucun historique automatisé, aucune traçabilité
- Processus lent et source d'erreurs

#### Adoption controversée de BitKeeper

En **2002**, Linus Torvalds choisit **BitKeeper**, un système propriétaire développé par Larry McVoy (BitMover).

> "To everyone's shock and dismay, Linus chose BitKeeper, a closed-source commercial system, which was controversial because the Linux kernel was the most important open-source project at the time."

**Conditions de la licence gratuite** :
- Gratuit pour le développement du kernel Linux
- Mais interdiction de reverse engineering
- Dépendance à un outil propriétaire → tensions dans la communauté open-source

### 2.2 La Controverse de 2005

#### L'Incident Déclencheur

En **mars-avril 2005**, Andrew Tridgell (développeur Samba) crée **SourcePuller**, un outil capable de communiquer avec les dépôts BitKeeper.

**Réaction de BitMover** :
- Accusation de reverse engineering des protocoles BitKeeper
- Violation de la licence d'utilisation
- **Décision : révocation de la licence gratuite** pour la communauté Linux

**Conséquence** : Le 3 avril 2005, la communauté Linux perd accès à BitKeeper.

### 2.3 La Création de Git en 2 Semaines

#### Timeline de développement

| Date | Événement |
|------|-----------|
| **3 avril 2005** | Révocation licence BitKeeper |
| **6 avril 2005** | Linus Torvalds commence Git |
| **7 avril 2005** | Git peut se versionner lui-même |
| **18 avril 2005** | Premier merge de branches multiples |
| **16 juin 2005** | Kernel Linux 2.6.12 géré avec Git |
| **26 juillet 2005** | Junio Hamano prend la maintenance |
| **21 décembre 2005** | **Git 1.0** officiellement publié |

> **Linus Torvalds** : "The trick wasn't really so much the coding but coming up with how it organizes the data."

#### Motivations et Objectifs de Conception

**Citation de Linus** :
> "Git was designed to be efficient enough for a biggish project like Linux, and it was designed to do things that people considered 'hard' before git – because those are the things *I* do every day."

**Objectifs de design** :
1. **Performance** : Gérer des projets massifs (Linux kernel = ~20M lignes)
2. **Distribution** : Chaque développeur a un dépôt complet
3. **Intégrité** : Garantie cryptographique (SHA-1)
4. **Branching/Merging facile** : Opérations considérées "dures" dans les autres VCS
5. **Workflow non-linéaire** : Support naturel des workflows distribués

**Philosophie de Linus** :
> "Git actually has a simple design, with stable and reasonably well-documented data structures. In fact, I'm a huge proponent of designing your code around the data, rather than the other way around."

> "Bad programmers worry about the code. Good programmers worry about data structures and their relationships."

---

## 3. Architecture Technique de Git

### 3.1 Git comme Système de Fichiers Adressable par Contenu

#### Concept Fondamental

Git n'est **pas** un VCS traditionnel. C'est un **content-addressable filesystem** (système de fichiers adressable par contenu) avec une interface VCS construite par-dessus.

> **Linus Torvalds** : "I designed Git to be a user space file system, i.e. the infrastructure to hold files and directories. That ensured the efficiency and speed of Git."

#### Base de Données Clé-Valeur

Git fonctionne comme une **simple base de données clé-valeur** :

```
Contenu → [Hashing SHA-1] → Clé (40 caractères hexadécimaux)
```

**Exemple** :
```bash
$ echo "Hello, Git!" | git hash-object --stdin
47a013e660d408619d894b20806b1d5086aab03b

# Stockage dans .git/objects/
# .git/objects/47/a013e660d408619d894b20806b1d5086aab03b
#              ↑↑ ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
#              │  └── 38 caractères (nom du fichier)
#              └── 2 caractères (sous-répertoire)
```

### 3.2 Hachage SHA-1 (et Migration vers SHA-256)

#### SHA-1 : Le Fondement (2005-Présent)

**Caractéristiques** :
- **Algorithme** : Secure Hash Algorithm 1
- **Sortie** : 40 caractères hexadécimaux (160 bits)
- **Propriété** : Hash unique pour un contenu donné
- **Garantie** : Si hash identique → contenu identique (quasi-certitude)

**Calcul du hash** :
```
Contenu du fichier + Header Git → SHA-1 → Object ID
```

**Avantages** :
- ✅ Détection automatique de corruption
- ✅ Identification unique de chaque objet
- ✅ Vérification d'intégrité cryptographique

#### Migration vers SHA-256 (2020-En cours)

**Contexte sécurité** :
- 2017 : Google et CWI démontrent une collision SHA-1 pratique (SHAttered attack)
- Risque théorique : injection de code malveillant avec le même hash

**Chronologie** :
- **Octobre 2020** : Git 2.29 introduit `--object-format=sha256`
- **Septembre 2023** : Git 2.42.0 retire le label "expérimental"
- **2024** : Support SHA-256 dans GitLab Gitaly et Forgejo 7.0.0

**État actuel** :
- SHA-1 reste le défaut
- Pas encore d'interopérabilité SHA-1 ↔ SHA-256
- Migration progressive en cours

```bash
# Créer un nouveau dépôt avec SHA-256
$ git init --object-format=sha256
```

### 3.3 Les Trois Types d'Objets Primitifs

#### 1. **Blob** (Binary Large Object)

- Stocke le **contenu d'un fichier**
- Pas de métadonnées (nom, permissions, etc.)
- Hash basé uniquement sur le contenu

```
┌─────────────────┐
│      Blob       │
│                 │
│   File Content  │
│   (any type)    │
└─────────────────┘
```

#### 2. **Tree** (Arbre)

- Équivalent d'un **répertoire**
- Liste de pointeurs vers :
  - D'autres trees (sous-répertoires)
  - Des blobs (fichiers)
- Contient : nom, mode (permissions), hash de l'objet

```
┌────────────────────────────┐
│          Tree              │
├────────────────────────────┤
│ 100644 blob a3f2... README.md     │
│ 040000 tree b7e1... src/          │
│ 100755 blob c9d4... build.sh      │
└────────────────────────────┘
```

#### 3. **Commit** (Révision)

- Pointe vers un **tree** (snapshot du projet)
- Contient :
  - Hash du tree
  - Hash du/des parent(s) (commits précédents)
  - Auteur + Committer
  - Date
  - Message de commit

```
┌─────────────────────────────────┐
│           Commit                │
├─────────────────────────────────┤
│ tree:    f3a8b2c...             │
│ parent:  e7d9f1a...             │
│ author:  John <j@example.com>   │
│ date:    2025-11-04 10:30       │
│                                 │
│ feat: Add user authentication   │
└─────────────────────────────────┘
```

### 3.4 DAG (Directed Acyclic Graph)

#### Structure de l'Historique

Les commits forment un **graphe acyclique orienté (DAG)** :

- **Directed** : Les commits pointent vers leurs parents (direction temporelle)
- **Acyclic** : Impossible de créer une boucle (pas de cycle temporel)
- **Graph** : Structure non-linéaire (branches, merges)

```
         A---B---C  (main)
              \
               D---E  (feature)

Représentation DAG :
C → B → A
      ↘
        D → E

Chaque nœud = commit
Chaque flèche = relation parent
```

**Définition officielle Git** :
> "The commit objects form a directed acyclic graph, because they have parents (directed), and the graph of commit objects is acyclic (there is no chain which begins and ends with the same object)."

#### Implications du DAG

1. **Merges** : Un commit peut avoir plusieurs parents
2. **Branches** : Simplement des pointeurs vers des commits
3. **Reachability** : Tous les ancêtres d'un commit sont "accessibles"
4. **Garbage collection** : Les objets non accessibles peuvent être supprimés

```
Fast-forward merge :
    A---B---C (main)
         \
          D---E (feature)

    Après merge :
    A---B---C---D---E (main)

Merge commit :
    A---B---C (main)
         \   \
          D---E---M (merge commit)
                  M a 2 parents: C et E
```

### 3.5 Architecture Distribuée

#### Centralisée (SVN) vs Distribuée (Git)

**SVN - Architecture Centralisée** :
```
         ┌─────────────────┐
         │  Serveur Central│
         │  (Historique    │
         │   complet)      │
         └────────┬────────┘
                  │
      ┌───────────┼───────────┐
      │           │           │
┌─────▼────┐ ┌───▼─────┐ ┌───▼─────┐
│ Client 1 │ │Client 2 │ │Client 3 │
│(Working  │ │(Working │ │(Working │
│  Copy)   │ │  Copy)  │ │  Copy)  │
└──────────┘ └─────────┘ └─────────┘

• Clients = copies de travail uniquement
• Historique sur serveur uniquement
• Opérations réseau obligatoires
```

**Git - Architecture Distribuée** :
```
    ┌──────────────────┐
    │  Dépôt Central   │
    │  (GitHub/GitLab) │
    │  Full History    │
    └────────┬─────────┘
             │
    ┌────────┼────────┐
    │        │        │
┌───▼────┐ ┌▼──────┐ ┌▼──────┐
│Clone 1 │ │Clone 2│ │Clone 3│
│        │ │       │ │       │
│Full    │ │Full   │ │Full   │
│History │ │History│ │History│
└────────┘ └───────┘ └───────┘

• Chaque clone = dépôt complet
• Historique intégral local
• Travail offline total
• Synchronisation peer-to-peer possible
```

#### Avantages de la Distribution

1. **Performance** : Toutes les opérations sont locales (ultra-rapides)
2. **Résilience** : Chaque clone = backup complet
3. **Flexibilité** : Workflows variés (centralisé, feature-branch, fork, etc.)
4. **Offline** : Commit, branch, merge, log, diff sans réseau
5. **Sécurité** : Pas de point de défaillance unique

### 3.6 Pourquoi le Branching Git est Révolutionnaire

#### SVN : Branches = Copies de Répertoires

```
/trunk/          ← Développement principal
/branches/
  /feature-1/    ← COPIE complète du code
  /feature-2/    ← COPIE complète du code
```

**Problèmes** :
- ❌ Création lente (copie physique sur le serveur)
- ❌ Consomme beaucoup d'espace disque
- ❌ Merge complexe et source d'erreurs
- ❌ Nécessite connexion réseau

#### Git : Branches = Pointeurs Légers

```
┌────────────────────────────────┐
│        .git/refs/heads/        │
├────────────────────────────────┤
│ main    → a3f8b2c (commit)     │
│ feature → e7d9f1a (commit)     │
│ hotfix  → c9d4a6e (commit)     │
└────────────────────────────────┘

Une branche = 41 octets
(40 caractères SHA-1 + newline)
```

**Avantages** :
- ✅ Création **instantanée** (quelques millisecondes)
- ✅ Quasi-aucun espace disque
- ✅ Changement de branche ultra-rapide
- ✅ Merge intelligent (algorithme sophistiqué)
- ✅ Totalement local (offline)

**Performance** :
```bash
# SVN - Création de branche (sur réseau)
$ svn copy trunk branches/feature-xyz
# → 5-30 secondes selon taille du projet

# Git - Création de branche (local)
$ git branch feature-xyz
# → < 0.01 seconde
```

#### Moteur de Merge Avancé

Git utilise un algorithme de **three-way merge** avec analyse du DAG complet :

```
Common Ancestor (base)
        │
    ┌───┴───┐
    │       │
Branch A  Branch B
    │       │
    └───┬───┘
        │
    Merged Result
```

**Comparaison** :
- **SVN** : Analyse limitée, ne considère pas le DAG complet → conflits fréquents
- **Git** : Analyse du DAG complet, détection intelligente des changements → merges fluides

---

## 4. Workflows et Bonnes Pratiques

### 4.1 GitFlow (Vincent Driessen, 2010)

#### Origine et Contexte

**Créateur** : Vincent Driessen
**Publication** : 2010 (blog post "A successful Git branching model")
**Impact** : Standard de l'industrie pendant une décennie

#### Structure des Branches

GitFlow organise le développement autour de **5 types de branches** :

```
┌────────────────────────────────────────────────────┐
│                                                    │
│  main/master ──●────────────────●────────────●──  │ Production
│                 │                │            │    │
│                 │                │            │    │
│  hotfix ───────●│                │            │    │
│                ││                │            │    │
│  release ──────┼┼────●───────────●            │    │
│                │└────│───────────┘            │    │
│  develop ──●───┴─────●───────●───●────────────●──  │ Integration
│            │         │       │   │                 │
│  feature-A ●─────────●       │   │                 │
│                              │   │                 │
│  feature-B ──────────────────●───●                 │
│                                                    │
└────────────────────────────────────────────────────┘
```

#### Détail des Branches

| Type | Durée | Origine | Destination | Usage |
|------|-------|---------|-------------|-------|
| **main** | ∞ Permanente | - | - | Code en production, tags de version |
| **develop** | ∞ Permanente | main | - | Intégration du développement en cours |
| **feature/xxx** | Temporaire | develop | develop | Développement de nouvelles fonctionnalités |
| **release/x.y.z** | Temporaire | develop | develop + main | Préparation d'une release (tests, docs) |
| **hotfix/xxx** | Temporaire | main | develop + main | Correction urgente en production |

#### Workflow Type

```bash
# Démarrer une feature
$ git checkout develop
$ git checkout -b feature/user-auth

# Développement...
$ git add . && git commit -m "feat: Add login form"

# Merger dans develop
$ git checkout develop
$ git merge --no-ff feature/user-auth
$ git branch -d feature/user-auth

# Créer une release
$ git checkout -b release/1.2.0 develop
# Tests, corrections mineures, mise à jour version
$ git checkout main
$ git merge --no-ff release/1.2.0
$ git tag -a v1.2.0 -m "Version 1.2.0"
$ git checkout develop
$ git merge --no-ff release/1.2.0

# Hotfix urgent
$ git checkout -b hotfix/security-patch main
# Fix...
$ git checkout main
$ git merge --no-ff hotfix/security-patch
$ git tag -a v1.2.1
$ git checkout develop
$ git merge --no-ff hotfix/security-patch
```

#### Avantages et Limites

**✅ Avantages** :
- Structure claire et prévisible
- Séparation nette develop/production
- Support multi-versions (releases parallèles)
- Idéal pour : logiciels packagés, releases programmées

**❌ Limites** :
- Complexité élevée (5 types de branches)
- Maintenance lourde (branches long-lived)
- Ralentit le rythme de déploiement
- **Inadapté au CI/CD moderne**

**Note de Vincent Driessen (2020)** :
> "If your team is doing continuous delivery of software, I would suggest to adopt a much simpler workflow (like GitHub Flow) instead of trying to shoehorn GitFlow into your team."

### 4.2 GitHub Flow (GitHub, ~2011)

#### Philosophie : Simplicité et Déploiement Continu

**Créateur** : GitHub (Scott Chacon et équipe)
**Objectif** : Simplifier GitFlow pour le déploiement continu
**Principe** : "Anything in main is deployable"

#### Structure

```
     main ──●────────●────────●────────●──
            │        │        │        │
  feature-1 ●────────●        │        │
                     │        │        │
  feature-2 ─────────┼────────●────────●
                     │
                   Deploy  Deploy  Deploy
```

**2 types de branches uniquement** :
1. **main** : Toujours déployable, toujours stable
2. **feature branches** : Développement de fonctionnalités

#### Workflow

```bash
# 1. Créer une branche depuis main
$ git checkout main
$ git pull origin main
$ git checkout -b feature/add-comments

# 2. Développer et commiter régulièrement
$ git add .
$ git commit -m "feat: Add comment model"
$ git push -u origin feature/add-comments

# 3. Ouvrir une Pull Request sur GitHub
# → Code review, discussion, CI/CD automatique

# 4. Déployer depuis la branche (optionnel)
# → Tester en production-like

# 5. Merger dans main
# → Via l'interface GitHub après approbation

# 6. Déployer automatiquement depuis main
# → CI/CD déclenché sur push main
```

#### Règles d'Or

1. ✅ **main est toujours déployable**
2. ✅ Branches feature avec noms descriptifs
3. ✅ Push régulier pour feedback
4. ✅ Pull Requests pour code review
5. ✅ Tests automatiques (CI) avant merge
6. ✅ Déploiement immédiat après merge

**✅ Avantages** :
- Extrême simplicité (2 types de branches)
- Rythme de déploiement rapide
- Feedback continu via PRs
- Idéal pour CI/CD et SaaS

**❌ Limites** :
- Pas de support multi-versions
- Nécessite tests robustes et CI/CD
- Difficile pour releases programmées

**Idéal pour** :
- Startups et petites équipes
- Applications web (SaaS)
- Déploiement continu

### 4.3 Trunk-Based Development (TBD)

#### Philosophie : Intégration Maximale

**Principe** : Tout le monde commite sur **une seule branche** (trunk/main)

```
main ──●─●─●─●─●─●─●─●─●─●──
       │ │ │ │ │ │ │ │ │ │
       └─┴─┴─┴─┴─┴─┴─┴─┴─┴── Commits fréquents
         Tous les devs

Feature flags pour fonctionnalités incomplètes
```

#### Règles Strictes

1. **Durée maximale des branches** : **< 2 jours** (idéalement quelques heures)
2. **Feature flags** : Désactivation de code incomplet en production
3. **Tests exhaustifs** : Suite complète de tests unitaires + intégration
4. **CI/CD obligatoire** : Automatisation totale

#### Workflow

```bash
# Chaque matin : synchroniser
$ git checkout main
$ git pull --rebase origin main

# Feature branch courte
$ git checkout -b short-feature
# Développement rapide (< 1 jour)

# Intégration fréquente
$ git checkout main
$ git pull --rebase origin main
$ git merge short-feature
$ git push origin main

# Feature flag pour code incomplet
if (featureFlags.newCheckout) {
  // Nouveau code (en développement)
} else {
  // Ancien code (stable)
}
```

#### Comparaison avec GitHub Flow

| Aspect | GitHub Flow | Trunk-Based |
|--------|-------------|-------------|
| Branches feature | Jours/semaines | Heures/1-2 jours max |
| Merge frequency | Plusieurs/semaine | Plusieurs/jour |
| Feature flags | Optionnel | Obligatoire |
| Complexité | Simple | Très simple |
| Discipline requise | Moyenne | Très élevée |

**✅ Avantages** :
- Vitesse maximale de déploiement
- Réduction drastique des conflits de merge
- Feedback ultra-rapide
- Idéal pour CI/CD avancé

**❌ Limites** :
- Discipline d'équipe exceptionnelle requise
- Infrastructure CI/CD mature nécessaire
- Tests automatisés exhaustifs obligatoires

**Utilisé par** : Google, Facebook, Netflix (grandes équipes tech)

### 4.4 Conventional Commits

#### Spécification

**Standard** : [conventionalcommits.org](https://www.conventionalcommits.org/)
**Objectif** : Structure standardisée des messages de commit

#### Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Exemple** :
```
feat(auth): Add OAuth2 Google provider

Implement Google OAuth2 authentication flow using
passport.js. Users can now sign in with their
Google account.

Closes #142
BREAKING CHANGE: Environment variable GOOGLE_CLIENT_ID required
```

#### Types Standardisés

| Type | Description | Impact SemVer |
|------|-------------|---------------|
| **feat** | Nouvelle fonctionnalité | MINOR bump |
| **fix** | Correction de bug | PATCH bump |
| **docs** | Documentation uniquement | - |
| **style** | Formatage, whitespace | - |
| **refactor** | Refactoring sans changement fonctionnel | - |
| **perf** | Amélioration de performance | PATCH bump |
| **test** | Ajout/modification de tests | - |
| **build** | Système de build | - |
| **ci** | Configuration CI/CD | - |
| **chore** | Tâches diverses | - |
| **revert** | Annulation d'un commit précédent | - |
| **BREAKING CHANGE** | Changement incompatible | **MAJOR** bump |

#### Mapping avec Semantic Versioning

**SemVer** : `MAJOR.MINOR.PATCH` (ex: 2.4.1)

```
fix:     2.4.1 → 2.4.2 (PATCH)
feat:    2.4.1 → 2.5.0 (MINOR)
BREAKING: 2.4.1 → 3.0.0 (MAJOR)
```

**Automatisation** :
```bash
# semantic-release analyse les commits
$ npx semantic-release

# Détecte :
# - fix commits → PATCH
# - feat commits → MINOR
# - BREAKING CHANGE → MAJOR

# Génère automatiquement :
# - Nouvelle version
# - CHANGELOG.md
# - Git tag
# - GitHub Release
```

#### Outils

- **commitlint** : Validation des messages
- **semantic-release** : Versioning automatique
- **standard-version** : Alternative à semantic-release
- **commitizen** : CLI interactif pour commits

```bash
# Installation commitlint
$ npm install --save-dev @commitlint/{cli,config-conventional}

# .commitlintrc.json
{
  "extends": ["@commitlint/config-conventional"]
}

# Husky hook pour validation
$ npx husky add .husky/commit-msg 'npx commitlint --edit $1'
```

### 4.5 Semantic Versioning (SemVer)

#### Spécification

**Standard** : [semver.org](https://semver.org/)
**Format** : `MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]`

**Exemple** : `3.5.2-beta.1+20251104`

#### Règles de Versioning

```
MAJOR.MINOR.PATCH

2.4.1
│ │ │
│ │ └─ PATCH: Bug fixes (backward compatible)
│ └─── MINOR: New features (backward compatible)
└───── MAJOR: Breaking changes (incompatible API)
```

#### Incrémentation

| Changement | Version | Exemple |
|------------|---------|---------|
| Bug fix | 2.4.1 → 2.4.**2** | Correction d'un crash |
| New feature (compatible) | 2.4.1 → 2.**5**.0 | Nouvelle fonctionnalité optionnelle |
| Breaking change | 2.4.1 → **3**.0.0 | Modification d'API existante |

#### Pre-releases et Build Metadata

```
1.0.0-alpha < 1.0.0-alpha.1 < 1.0.0-beta < 1.0.0-rc.1 < 1.0.0

1.0.0+20251104 (metadata ignorée dans comparaison)
```

**Cycle de release typique** :
```
1.0.0-alpha.1    # Développement initial
1.0.0-alpha.2
1.0.0-beta.1     # Feature complete
1.0.0-rc.1       # Release candidate
1.0.0            # Production release
```

---

## 5. L'Écosystème Git

### 5.1 Les Plateformes d'Hébergement

#### **GitHub (2008)**

**Fondateurs** : Tom Preston-Werner, Chris Wanstrath, PJ Hyett
**Lancement** : Février 2008
**Acquisition** : Microsoft (2018) pour **7.5 milliards $**

**Innovations** :
- **Pull Requests** (23 février 2008) : révolutionne le code review
- Interface web intuitive pour Git
- Réseau social pour développeurs
- Actions (CI/CD intégré, 2019)

**Chiffres (2024-2025)** :
- **150 millions** de développeurs
- **1 milliard** de repositories
- **420 millions** de dépôts (dont 28M publics)
- **5 milliards** de contributions en 2024
- **90%** des Fortune 100 utilisent GitHub
- **1 milliard $** de revenus annuels récurrents

**Fonctionnalités clés** :
- GitHub Actions (CI/CD)
- GitHub Copilot (AI pair programming)
- GitHub Packages (registre de packages)
- GitHub Codespaces (dev environments)
- Security scanning automatique

#### **GitLab (2011)**

**Fondateurs** : Dmytro Zaporozhets, Valeriy Sizov (Ukraine)
**Lancement** : 2011
**Modèle** : Open-core (version CE gratuite + EE payante)

**Philosophie** : "The complete DevOps platform"

**Différenciation** :
- Plateforme DevOps **complète** (Git + CI/CD + Monitoring + Security)
- Self-hosted ou SaaS
- Licence open-source (MIT)
- Fonctionnalités DevSecOps intégrées

**Chiffres** :
- 30+ millions d'utilisateurs
- Plus grande entreprise 100% remote

**Avantages** :
- ✅ Tout-en-un (pas besoin d'outils tiers)
- ✅ Self-hosted (contrôle total)
- ✅ CI/CD intégré natif
- ✅ Meilleure intégration DevOps

#### **Bitbucket (2008 → Git en 2011)**

**Créateur** : Jesper Noehr
**Lancement** : 2008 (Mercurial uniquement)
**Acquisition** : Atlassian (2011)
**Migration Git** : Octobre 2011

**Positionnement** :
- Intégration native avec **Jira** (ticketing)
- Écosystème Atlassian (Confluence, Bamboo, Trello)
- Focus entreprises

**Avantages** :
- ✅ Intégration Jira exceptionnelle
- ✅ Pipelines CI/CD intégrés
- ✅ Tarification attractive (gratuit jusqu'à 5 users)

**Idéal pour** : Équipes déjà dans l'écosystème Atlassian

#### Comparaison

| Aspect | GitHub | GitLab | Bitbucket |
|--------|--------|--------|-----------|
| **Lancement** | 2008 | 2011 | 2008 (Git: 2011) |
| **Modèle** | SaaS | SaaS + Self-hosted | SaaS + Self-hosted |
| **CI/CD** | Actions (2019) | Natif (depuis début) | Pipelines |
| **Communauté** | Massive (150M) | Grande (30M) | Moyenne |
| **Open source** | Hosting only | Core open-source | Fermé |
| **Spécialité** | Social coding | DevOps complet | Intégration Atlassian |

### 5.2 L'Invention des Pull Requests (2008)

#### Révolution du Code Review

**Date** : 23 février 2008
**Contexte** : 3ème article du blog GitHub
**Impact** : Transforme le code review en pratique mainstream

#### Avant les Pull Requests

**Code review pré-2008** :
- ❌ Pratique ésotérique et rare
- ❌ Reviews en personne ou après coup
- ❌ Processus lourd et manuel
- ❌ Réservé aux grandes entreprises

**Méthodes alternatives** :
- Email de patches (mailing lists Linux)
- Outils spécialisés coûteux (Review Board, Crucible)
- Pas de code review du tout

#### Fonctionnement Initial (2008)

```
1. Fork du repository
2. Développement dans le fork
3. Message à l'owner avec lien vers fork
4. Owner merge manuellement
```

**Simple mais révolutionnaire** :
- ✅ Enveloppe un diff texte dans un workflow social
- ✅ Commentaires sur les lignes de code
- ✅ Discussions asynchrones
- ✅ Bouton "Merge" après approbation

#### Évolution des Pull Requests

**Ajouts progressifs** :
- **2011** : Inline comments (commentaires ligne par ligne)
- **2012** : Comparaison de branches améliorée
- **2013** : Merge automatique avec checks
- **2016** : Review states (Approve, Request changes)
- **2018** : Suggestions de code (apply from PR)
- **2019** : Draft PRs
- **2023** : Copilot suggestions in PRs

#### Impact sur l'Industrie

**Avant GitHub** (pré-2008) :
- Code review = luxe réservé à quelques équipes
- Contributions open-source complexes

**Après GitHub** (post-2008) :
- Code review = standard de l'industrie
- Contributions open-source démocratisées
- "Pull Request" devient un terme générique

**Chiffres** :
- Millions de PRs ouvertes quotidiennement
- Modèle copié par GitLab (Merge Requests), Bitbucket (Pull Requests)

**Citation** :
> "In 2008, GitHub's developers created a new kind of code review."

### 5.3 Git dans le DevOps

#### Chronologie DevOps

| Année | Événement |
|-------|-----------|
| **2008** | Première conférence "Agile Infrastructure" |
| **2009** | Terme "DevOps" inventé (Velocityconf) |
| **2010** | "Continuous Delivery" (Jez Humble) |
| **2013** | "The Phoenix Project" popularise DevOps |
| **2017** | **GitOps** terme inventé (Weaveworks) |

#### GitOps : Git comme Source de Vérité Unique

**Créateur** : Alexis Richardson (Weaveworks)
**Publication** : 2017 - "Operations by Pull Request"
**Définition** : Git = single source of truth pour l'infrastructure ET les applications

#### Principes GitOps

```
┌──────────────────────────────────────────┐
│         Git Repository                   │
│  (Source de vérité déclarative)          │
│                                          │
│  • Infrastructure as Code (Terraform)    │
│  • Kubernetes manifests (YAML)           │
│  • Application configs                   │
└──────────────┬───────────────────────────┘
               │
               │ Push/Merge
               ▼
┌──────────────────────────────────────────┐
│      CI/CD Pipeline                      │
│  • Tests automatiques                    │
│  • Validation                            │
│  • Build images                          │
└──────────────┬───────────────────────────┘
               │
               │ Deploy
               ▼
┌──────────────────────────────────────────┐
│    Kubernetes Cluster                    │
│                                          │
│  ┌────────────────┐                     │
│  │  GitOps Agent  │ (Flux/ArgoCD)       │
│  │  • Pull from Git                     │
│  │  • Compare desired vs actual state   │
│  │  • Auto-reconcile                    │
│  └────────────────┘                     │
└──────────────────────────────────────────┘
```

#### Les 4 Principes GitOps

1. **Déclaratif** : L'état souhaité du système décrit de manière déclarative (YAML, Terraform)
2. **Versionné et immuable** : L'état souhaité stocké dans Git (historique complet)
3. **Automatiquement récupérable** : Agents logiciels appliquent automatiquement l'état
4. **Continuellement réconcilié** : Détection et correction automatique des dérives

#### Outils GitOps

**Flux (Weaveworks)** :
```bash
# Installation Flux
$ flux bootstrap github \
  --owner=myorg \
  --repository=fleet-infra \
  --path=clusters/production

# Flux surveille le dépôt Git
# Applique automatiquement les changements
# Détecte les dérives et réconcilie
```

**ArgoCD (Intuit/CNCF)** :
- Interface Web pour visualisation
- Gestion multi-clusters
- RBAC avancé

**Avantages GitOps** :
- ✅ Audit trail complet (Git history)
- ✅ Rollback facile (git revert)
- ✅ Pull Requests pour changements infra
- ✅ Single source of truth
- ✅ Disaster recovery simplifié

#### Infrastructure as Code avec Git

**Terraform** :
```hcl
# main.tf - Versionné dans Git
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer"
  }
}
```

**Workflow IaC** :
```bash
# 1. Branche feature
$ git checkout -b infra/add-load-balancer

# 2. Modification Terraform
$ vim terraform/load-balancer.tf

# 3. Plan local
$ terraform plan

# 4. Commit + Push
$ git add . && git commit -m "feat(infra): Add ALB"
$ git push -u origin infra/add-load-balancer

# 5. Pull Request
# → Terraform plan automatique dans CI
# → Review par équipe
# → Approval requis

# 6. Merge → Apply automatique
$ git checkout main
$ git merge infra/add-load-balancer
# → CI/CD exécute terraform apply
```

**Avantages** :
- Code review pour changements infra
- Tests automatisés avant apply
- Historique des modifications
- Collaboration facilitée

---

## 6. Adoption et Impact sur l'Industrie

### 6.1 Statistiques de Marché

#### Part de Marché (2016-2025)

```
100%│                                    ╔════Git════╗
    │                               ╔════╝           ║
 90%│                          ╔════╝                ║
    │                     ╔════╝                     ║
 80%│                ╔════╝                          ║
    │           ╔════╝                               ║
 70%│      ╔════╝                                    ║
    │ ╔════╝                                         ║
    │╔╝  SVN                                         ║
    ├────────────────────────────────────────────────
    2012  2014  2016  2018  2020  2022  2024  2025

2016: Git 87.1% | SVN ~10%
2021: Git 95%   | SVN ~3%
2025: Git 93.87%| SVN <2%
```

**Sources** :
- Stack Overflow Developer Survey
- Eclipse Foundation Community Survey
- GitHub Octoverse Report

#### Croissance GitHub

| Métrique | 2018 | 2023 | 2025 |
|----------|------|------|------|
| **Développeurs** | 31M | 100M | 150M |
| **Repositories** | 100M | 372M | 1B+ |
| **Contributions/an** | - | - | 5B |
| **Fortune 100** | ~70% | 90% | 90% |

**Croissance géographique** :
- **Inde** : +28% en 2024 (18M développeurs)
- **Amérique du Nord** : 28% des utilisateurs globaux
- 1M nouveaux développeurs indiens tous les 3 mois

#### Outils Connexes

**GitHub Actions** (2019-2025) :
- **20,000+** actions dans le Marketplace
- **4 millions** de workflows/jour
- **+35%** d'adoption YoY

**GitHub Copilot** (2021-2025) :
- **44%** des développeurs l'utilisent régulièrement
- 2ème outil le plus utilisé (après Git lui-même)

### 6.2 Pourquoi Git a Vaincu SVN et Mercurial

#### Git vs SVN : Bataille Technique

**Avantages décisifs de Git** :

1. **Performance** :
   - SVN : Opérations réseau lentes
   - Git : Tout local, ultra-rapide

2. **Branching** :
   - SVN : Branches = copies coûteuses
   - Git : Branches = pointeurs légers

3. **Distribution** :
   - SVN : Dépendance serveur unique
   - Git : Chaque clone = backup

4. **Merge** :
   - SVN : Conflits fréquents, merge difficile
   - Git : Moteur de merge sophistiqué

5. **Open Source** :
   - SVN : Compatible mais moins adapté
   - Git : Conçu pour open source (Linux)

**Citation** :
> "The speed offered by Git is a large reason for its continued rise in popularity, but developers also appreciate Git's compatibility with open source community ideals like shared code and collaboration."

#### Git vs Mercurial : Bataille d'Écosystème

**Similitudes techniques** :
- Mercurial et Git lancés en 2005 (même mois!)
- Les deux distribués, performants
- Architectures conceptuellement proches

**Pourquoi Git a gagné** :

1. **Linux Kernel Effect** :
   > "GitHub gave git the good web UI and coherent couldn't beat the feature avalanche from Git contributors and the star power of its founder."
   - Linus Torvalds = star power
   - Linux = plus gros projet open source

2. **GitHub** :
   - Mercurial avait Bitbucket (Mercurial jusqu'en 2011)
   - GitHub a créé l'effet réseau massif
   - Interface web supérieure

3. **Communauté** :
   - Git : Communauté gigantesque
   - Mercurial : Plus petite, moins de ressources/tutos

4. **Écosystème** :
   - Git : Outils innombrables (GitHub Actions, Husky, etc.)
   - Mercurial : Écosystème limité

**Citation clé** :
> "Mercurial was more familiar to use because it was a bit like using subversion in a distributed fashion, but that fealty to the old ways may have hurt it as well."

**Ironie** : La facilité d'apprentissage de Mercurial l'a desservi (trop proche de SVN).

#### Exceptions : Où SVN/Mercurial Survivent

**Secteurs conservateurs** :
- Finance
- Santé
- Industries régulées

**Raisons** :
- ❌ Git inefficace avec repos gigantesques (100+ Go)
- ❌ Pas de contrôle d'accès granulaire (répertoire par répertoire)
- ❌ Difficultés avec fichiers binaires massifs
- ✅ SVN meilleur pour : contrôle d'accès fin, fichiers binaires, repos centralisés stricts

**Note** : Même Facebook (qui utilisait Mercurial à grande échelle) a migré vers Git.

### 6.3 Git comme Fondation du DevOps Moderne

#### Le Triptyque Moderne

```
┌─────────────────────────────────────────────────┐
│                                                 │
│   ┌─────────┐    ┌─────────┐    ┌─────────┐   │
│   │   Git   │───▶│ CI/CD   │───▶│  Cloud  │   │
│   │         │    │         │    │         │   │
│   │ Version │    │ Auto    │    │ Deploy  │   │
│   │ Control │    │ Build/  │    │ Infra   │   │
│   │         │    │ Test    │    │         │   │
│   └─────────┘    └─────────┘    └─────────┘   │
│        │              │              │         │
│        └──────────────┴──────────────┘         │
│              DevOps Pipeline                   │
│                                                 │
└─────────────────────────────────────────────────┘
```

#### Git dans la Chaîne DevOps

**Workflow Type** :
```
Developer
   │
   │ $ git commit
   │ $ git push
   ▼
┌──────────────┐
│ Git (GitHub) │
└──────┬───────┘
       │ Webhook
       ▼
┌──────────────┐
│   CI/CD      │ (GitHub Actions, GitLab CI, Jenkins)
│              │
│ • Run tests  │
│ • Build      │
│ • Security   │
└──────┬───────┘
       │ If tests pass
       ▼
┌──────────────┐
│ Artifact     │ (Docker Registry, npm, etc.)
│ Registry     │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Production   │ (Kubernetes, AWS, etc.)
│ Deployment   │
└──────────────┘
```

#### Pratiques DevOps Rendues Possibles par Git

1. **Continuous Integration (CI)** :
   - Chaque push → tests automatiques
   - Détection rapide des régressions
   - GitHub Actions, GitLab CI/CD

2. **Continuous Deployment (CD)** :
   - Merge → déploiement automatique
   - Rollback via git revert
   - Blue/Green deployments

3. **Infrastructure as Code (IaC)** :
   - Terraform, Kubernetes YAML versionnés
   - Code review pour infra
   - GitOps (Flux, ArgoCD)

4. **Collaboration** :
   - Pull Requests = collaboration asynchrone
   - Code review standardisé
   - Documentation dans le code

5. **Auditabilité** :
   - Historique complet des changements
   - Traçabilité code → production
   - Compliance facilitée

#### Métriques DevOps Facilitées par Git

**DORA Metrics** (DevOps Research and Assessment) :

1. **Deployment Frequency** :
   - Git + CI/CD = déploiements multiples/jour
   - Branching léger = intégration continue

2. **Lead Time for Changes** :
   - Commit → Production en minutes/heures
   - Git history = mesure précise

3. **Mean Time to Recovery (MTTR)** :
   - git revert = rollback instantané
   - Historique = debugging facilité

4. **Change Failure Rate** :
   - Code review via PRs = qualité
   - Tests automatiques avant merge

**Citation** :
> "Git enables the high-velocity, collaborative workflows that are fundamental to modern DevOps practices."

---

## 7. Conclusion : L'Héritage de Git

### 7.1 20 Ans Après (2005-2025)

#### Impact Mesurable

**Adoption universelle** :
- 93.87% de part de marché (2025)
- 150 millions de développeurs
- Quasi-standard de facto

**Transformation de l'industrie** :
- Open source démocratisé (GitHub)
- DevOps rendu possible (CI/CD)
- Collaboration asynchrone normalisée

**Innovation continues** :
- GitOps (2017)
- AI-powered workflows (Copilot)
- Migration SHA-256 (2020+)

### 7.2 Principes de Design Intemporels

**Philosophie de Linus Torvalds** :

1. **"Design around data, not code"**
   - Structures de données simples et stables
   - Code découle des données

2. **"Solve real problems"**
   - Git résout les problèmes du kernel Linux
   - Pas de features théoriques

3. **"Performance matters"**
   - Tout local = ultra-rapide
   - Scalabilité prouvée (20M+ lignes)

4. **"Trust nothing"**
   - Cryptographie (SHA-1 → SHA-256)
   - Détection automatique de corruption

### 7.3 Pourquoi Git Restera Dominant

**Effet réseau** :
- Plus Git est utilisé, plus il devient indispensable
- Écosystème gigantesque (outils, formations, documentation)
- Compétence universelle des développeurs

**Fondation technique solide** :
- Architecture distribuée = future-proof
- DAG = modèle mathématiquement robuste
- Extensibilité prouvée

**Intégration DevOps** :
- CI/CD natif
- GitOps en croissance
- Infrastructure as Code standardisé

### 7.4 L'Avenir : Tendances 2025+

**1. Migration SHA-256** :
- Sécurité renforcée
- Interopérabilité SHA-1/SHA-256 en cours

**2. AI Integration** :
- Copilot pour suggestions de code
- Auto-review de PRs
- Génération automatique de commits

**3. Scalabilité** :
- Git LFS (Large File Storage) mature
- Monorepos géants (Google-style)
- Partial clones et sparse checkouts

**4. GitOps Mainstream** :
- Kubernetes + GitOps = standard
- Multi-cloud management
- Security as Code

---

## Annexes

### A. Chronologie Complète

| Date | Événement |
|------|-----------|
| **1982** | RCS (Revision Control System) |
| **1990** | CVS (Concurrent Versions System) |
| **2000** | SVN (Subversion) par CollabNet |
| **2002** | Linux kernel adopte BitKeeper |
| **3 avril 2005** | Révocation licence BitKeeper |
| **6 avril 2005** | Linus démarre Git |
| **7 avril 2005** | Git se versionne lui-même |
| **16 juin 2005** | Linux 2.6.12 géré par Git |
| **26 juillet 2005** | Junio Hamano prend maintenance Git |
| **21 décembre 2005** | **Git 1.0** |
| **Février 2008** | **GitHub** lancé |
| **23 février 2008** | **Pull Requests** inventées |
| **2010** | **GitFlow** publié (Vincent Driessen) |
| **2011** | **GitLab** lancé |
| **2011** | Bitbucket adopte Git (abandonne Mercurial) |
| **2017** | **GitOps** terme inventé (Weaveworks) |
| **2018** | Microsoft acquiert GitHub (7.5B $) |
| **2019** | GitHub Actions (CI/CD) |
| **Octobre 2020** | Git 2.29 : Support SHA-256 |
| **2021** | GitHub Copilot (AI) |
| **2023** | Git 2.42 : SHA-256 non-expérimental |
| **2025** | 150M développeurs, 1B+ repos |

### B. Commandes Git Essentielles

#### Configuration
```bash
git config --global user.name "Votre Nom"
git config --global user.email "email@example.com"
```

#### Workflow de Base
```bash
# Initialiser un dépôt
git init

# Cloner un dépôt distant
git clone https://github.com/user/repo.git

# Statut
git status

# Ajouter au staging
git add fichier.txt
git add .

# Commiter
git commit -m "feat: Add user authentication"

# Pousser vers remote
git push origin main

# Récupérer depuis remote
git pull origin main
```

#### Branching
```bash
# Créer et basculer sur branche
git checkout -b feature/new-feature

# Lister branches
git branch -a

# Changer de branche
git checkout main

# Fusionner
git merge feature/new-feature

# Supprimer branche
git branch -d feature/new-feature
```

#### Historique
```bash
# Log complet
git log

# Log condensé
git log --oneline --graph --all

# Différences
git diff
git diff main..feature/branch
```

### C. Ressources et Références

#### Documentation Officielle
- **Git SCM** : https://git-scm.com/
- **Pro Git Book** : https://git-scm.com/book/en/v2 (gratuit)
- **Git Reference** : https://git-scm.com/docs

#### Standards
- **Conventional Commits** : https://www.conventionalcommits.org/
- **Semantic Versioning** : https://semver.org/
- **GitFlow** : https://nvie.com/posts/a-successful-git-branching-model/

#### Plateformes
- **GitHub** : https://github.com
- **GitLab** : https://gitlab.com
- **Bitbucket** : https://bitbucket.org

#### Articles Historiques
- Git Origin Story : https://www.linuxjournal.com/content/git-origin-story
- BitKeeper Controversy : https://graphite.dev/blog/bitkeeper-linux-story-of-git-creation
- Git at 20 (Interview Linus) : https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/

#### Outils
- **GitHub Desktop** : Interface graphique
- **GitKraken** : Client Git avancé
- **SourceTree** : Client Atlassian
- **lazygit** : Interface TUI (terminal)

---

## Glossaire

**Blob** : Objet Git stockant le contenu d'un fichier.

**Branch** : Pointeur mobile vers un commit, permettant une ligne de développement.

**Commit** : Snapshot du projet à un instant T, contenant tree, parent(s), auteur, message.

**DAG** : Directed Acyclic Graph - Structure de l'historique Git.

**HEAD** : Pointeur vers la branche courante (ou commit en detached HEAD).

**Merge** : Fusion de deux branches en créant un commit de merge.

**Pull Request (PR)** : Demande de fusion de code avec code review (GitHub/Bitbucket).

**Merge Request (MR)** : Équivalent de PR sur GitLab.

**Remote** : Dépôt distant (ex: origin sur GitHub).

**Repository** : Dépôt Git contenant objets, refs, et métadonnées.

**SHA-1** : Algorithme de hachage (160 bits) utilisé par Git pour identifier objets.

**Staging Area (Index)** : Zone intermédiaire avant commit.

**Tree** : Objet Git représentant un répertoire (liste de blobs/trees).

**Working Directory** : Répertoire de travail contenant fichiers checkoutés.

---

## Citations Notables

> "The trick wasn't really so much the coding but coming up with how it organizes the data."
> — **Linus Torvalds**, sur la création de Git

> "Bad programmers worry about the code. Good programmers worry about data structures and their relationships."
> — **Linus Torvalds**

> "Git was designed to be efficient enough for a biggish project like Linux, and it was designed to do things that people considered 'hard' before git – because those are the things *I* do every day."
> — **Linus Torvalds**

> "If your team is doing continuous delivery of software, I would suggest to adopt a much simpler workflow (like GitHub Flow) instead of trying to shoehorn GitFlow into your team."
> — **Vincent Driessen** (2020), créateur de GitFlow

> "In 2008, GitHub's developers created a new kind of code review."
> — Sur l'invention des Pull Requests

---

**Document préparé pour : M2 ESTD - Cours Initiation DevOps**
**Date : 4 novembre 2025**
**Sources : 15+ articles techniques, documentation officielle, statistiques 2024-2025**
