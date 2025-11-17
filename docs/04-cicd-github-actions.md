---
claude-context: true
type: research
date: 2025-11-05
research_type: technical
course_module: Module 5 - CI/CD & GitHub Actions
tags:
  - research
  - ci-cd
  - github-actions
  - devops
  - enseignement
related_projects:
  - Cours Initiation DevOps
keywords:
  - CI/CD
  - GitHub Actions
  - Continuous Integration
  - Continuous Delivery
  - DevOps
  - Jenkins
  - Travis CI
sources_count: 10
tools_used:
  - WebSearch
  - Multiple DevOps sources
---

# CI/CD & GitHub Actions : Histoire, Concepts et Pratiques
## Document de Recherche pour M2 Expert en Stratégie et Transformation Digitale

**Partie 1 : Introduction et Histoire de l'Intégration Continue**

---

## Table des Matières (Partie 1)

1. [Introduction : La Révolution DevOps](#introduction)
2. [Histoire de l'Intégration Continue](#histoire-ci)
   - [Avant la CI : Le Chaos des Années 90](#avant-ci)
   - [Extreme Programming et la Naissance de la CI (1996-2000)](#xp-et-ci)
   - [L'Ère Pionnière : Hudson/Jenkins (2004-2011)](#hudson-jenkins)
   - [CI as a Service : Travis CI et CircleCI (2011)](#ci-as-service)
   - [L'Écosystème se Diversifie (2011-2019)](#diversification)
   - [GitHub Actions : Le Game Changer (2019-2025)](#github-actions)
3. [Timeline Visuelle](#timeline)
4. [Glossaire FR/EN (Partie 1)](#glossaire-partie-1)

---

## Introduction : La Révolution DevOps {#introduction}

### Le Contexte : Pourquoi CI/CD ?

Dans le développement logiciel moderne, la capacité à **livrer rapidement et de manière fiable** est devenue un avantage compétitif majeur. Les entreprises qui réussissent aujourd'hui ne sont plus celles qui écrivent le plus de code, mais celles qui peuvent **déployer en production plusieurs fois par jour** tout en maintenant la qualité et la stabilité.

Cette transformation est rendue possible par **CI/CD** - un ensemble de pratiques et d'outils qui automatisent le cycle de développement logiciel, de l'écriture du code à sa mise en production.

### Les Chiffres Qui Parlent (2024-2025)

- **4 millions de workflows GitHub Actions** exécutés quotidiennement (+35% d'adoption annuelle)
- **20,000+ actions** disponibles sur le GitHub Actions Marketplace (doublement en un an)
- **30% des 5,000 repositories les plus populaires** utilisent GitHub Actions
- **150 millions de développeurs** utilisent GitHub dans le monde
- Marché du Continuous Delivery : **3,67 milliards USD en 2023**, croissance de **19,2% par an**

### L'Objectif de ce Document

Ce document de recherche vise à vous fournir une **compréhension approfondie** de l'évolution historique, des concepts fondamentaux et des pratiques modernes du CI/CD, avec un focus particulier sur **GitHub Actions** - l'outil qui a démocratisé l'automatisation pour des millions de développeurs.

Vous découvrirez :
- Comment nous sommes passés de déploiements manuels catastrophiques à des pipelines automatisés sophistiqués
- Les concepts théoriques qui sous-tendent CI/CD
- Comment GitHub Actions a changé la donne en 2019
- Les patterns et best practices utilisés en production aujourd'hui

---

## Histoire de l'Intégration Continue {#histoire-ci}

### Avant la CI : Le Chaos des Années 90 {#avant-ci}

#### Le Problème : "Integration Hell"

Dans les années 1990, le développement logiciel suivait généralement un modèle en cascade (**Waterfall**) avec des cycles de développement longs de plusieurs mois, voire années. Les équipes travaillaient sur des **branches de code isolées** pendant des semaines ou des mois avant de tenter d'intégrer leur travail.

Cette approche créait ce qu'on appelait l'**"Integration Hell"** (l'enfer de l'intégration) :

```
┌─────────────────────────────────────────────────────────────┐
│  SCÉNARIO TYPIQUE ANNÉES 90                                 │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Semaine 1-8  : Développement isolé sur branches séparées   │
│                 Équipe A → Feature X                         │
│                 Équipe B → Feature Y                         │
│                 Équipe C → Refactoring Z                     │
│                                                              │
│  Semaine 9    : "INTEGRATION WEEK" 😱                       │
│                 - 500+ conflits de merge                     │
│                 - Tests qui échouent massivement             │
│                 - Code incompatible entre équipes            │
│                 - Bugs découverts tardivement                │
│                                                              │
│  Semaine 10-12: Correction des bugs d'intégration           │
│                                                              │
│  Résultat     : Release retardée de plusieurs mois          │
└─────────────────────────────────────────────────────────────┘
```

#### Les Symptômes de l'Integration Hell

1. **Conflits de merge massifs** : Des centaines de fichiers modifiés différemment
2. **Régression invisible** : Bugs introduits par l'interaction entre modules
3. **"It works on my machine"** : Code fonctionnel localement mais pas en intégration
4. **Feedback tardif** : Problèmes découverts après des semaines de développement
5. **Stress et overtime** : Équipes en crise mode pendant les phases d'intégration

#### Les Outils de l'Époque

Les outils disponibles étaient rudimentaires :

- **CVS (Concurrent Versions System, 1990)** : Système de versioning central, pas de support pour les branches complexes
- **Make (1976)** : Outil de build Unix, configuration manuelle complexe
- **Scripts shell personnalisés** : Chaque entreprise réinventait la roue
- **Tests manuels** : QA teams testaient manuellement pendant des semaines

**Il n'existait pas de solution automatisée pour :**
- Compiler le code automatiquement après chaque commit
- Exécuter les tests automatiquement
- Détecter les problèmes d'intégration rapidement
- Fournir un feedback immédiat aux développeurs

---

### Extreme Programming et la Naissance de la CI (1996-2000) {#xp-et-ci}

#### Le Contexte : Chrysler C3 Project (1996)

L'histoire de l'Intégration Continue moderne commence avec le **Chrysler Comprehensive Compensation System (C3)**, un projet de refonte du système de paie de Chrysler.

En **1996**, Kent Beck est appelé pour sauver ce projet en difficulté. Il y introduit une nouvelle méthodologie qu'il développait depuis les années 1980-90 dans la communauté Smalltalk : **Extreme Programming (XP)**.

Sur ce projet, Kent Beck travaille avec **Martin Fowler** et **Ron Jeffries**, qui deviendront des figures majeures du mouvement Agile.

#### Les 12 Pratiques d'Extreme Programming (1999)

En **1999**, Kent Beck, Ward Cunningham et Ron Jeffries formalisent Extreme Programming avec ses **12 pratiques fondamentales** :

1. **Planning Game** (Planification itérative)
2. **Small Releases** (Releases fréquentes)
3. **Metaphor** (Métaphore système)
4. **Simple Design** (Design simple)
5. **Testing** (Tests continus)
6. **Refactoring** (Refactoring constant)
7. **Pair Programming** (Programmation en binôme)
8. **Collective Ownership** (Propriété collective du code)
9. **→ Continuous Integration** ← **LA RÉVOLUTION**
10. **40-Hour Week** (Rythme soutenable)
11. **On-Site Customer** (Client sur site)
12. **Coding Standards** (Standards de code)

#### La Définition Originale de CI par Martin Fowler

En **2000**, Martin Fowler publie un article fondateur qui définit l'Intégration Continue :

> **"Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day."**
>
> — Martin Fowler, 2000

**Les principes clés :**

1. **Intégrations fréquentes** : Au minimum quotidiennement (idéalement plusieurs fois par jour)
2. **Build automatisé** : Chaque intégration déclenche un build automatique
3. **Tests automatisés** : Le build inclut l'exécution de tests
4. **Feedback rapide** : Les développeurs sont notifiés immédiatement en cas d'échec
5. **Fix immédiat** : Les problèmes d'intégration sont résolus dans les 10 minutes

#### Le Manifeste de CI : Les Pratiques Fondamentales

Martin Fowler établit les **pratiques essentielles** de l'Intégration Continue :

```yaml
Pratiques de CI (Martin Fowler, 2000-2006):
  ✓ Maintain a Single Source Repository
    "Un seul repository central pour tout le code"

  ✓ Automate the Build
    "Un seul commande doit builder tout le projet"

  ✓ Make Your Build Self-Testing
    "Les tests font partie intégrante du build"

  ✓ Everyone Commits To the Mainline Every Day
    "Intégration quotidienne minimum sur la branche principale"

  ✓ Every Commit Should Build the Mainline on an Integration Machine
    "Chaque commit déclenche un build sur une machine dédiée"

  ✓ Fix Broken Builds Immediately
    "Priorité absolue : réparer le build cassé"

  ✓ Keep the Build Fast
    "Build rapide pour feedback immédiat (< 10 minutes)"

  ✓ Test in a Clone of the Production Environment
    "Tests dans un environnement identique à la production"

  ✓ Make it Easy for Anyone to Get the Latest Executable
    "Accès facile à la dernière version buildée"

  ✓ Everyone can see what's happening
    "Transparence totale sur l'état du build"

  ✓ Automate Deployment
    "Déploiement automatisé vers les environnements"
```

#### L'Impact de la Culture Smalltalk

La communauté **Smalltalk** des années 1980-90 a joué un rôle crucial dans l'émergence de ces pratiques :

- **Refactoring** : Renommage et restructuration constants du code
- **Continuous Integration** : Intégration fréquente
- **Constant Testing** : Tests en continu
- **Close Customer Involvement** : Collaboration étroite avec le client

Cette culture a produit Kent Beck, Ward Cunningham, et a influencé Martin Fowler, posant les bases de l'Agile moderne.

#### La Limitation : Pas d'Outils Dédiés

**Problème majeur** : En 1996-2000, il n'existait **aucun outil dédié** pour l'Intégration Continue.

Les équipes XP devaient :
- Écrire des **scripts personnalisés** pour automatiser les builds
- Créer des **systèmes de notification** maison (emails, feux tricolores physiques)
- Maintenir des **serveurs d'intégration** configurés manuellement
- Utiliser des **outils généralistes** (Make, Ant, cron jobs)

La CI était un **concept révolutionnaire** mais son adoption restait **limitée aux équipes pionnières** capables de construire leur propre infrastructure.

---

### L'Ère Pionnière : Hudson/Jenkins (2004-2011) {#hudson-jenkins}

#### CruiseControl : Le Premier Outil CI Dédié (2001)

Avant Hudson, **CruiseControl** (2001) a été le premier serveur CI open-source populaire, développé par des praticiens de ThoughtWorks (où travaillait Martin Fowler).

**Limitations de CruiseControl :**
- Configuration XML complexe et verbeuse
- Interface utilisateur rudimentaire
- Pas de gestion flexible des jobs
- Difficile à étendre

#### Hudson : La Naissance (2004-2005)

**Contexte :** Kohsuke Kawaguchi, développeur chez **Sun Microsystems**, en a assez de casser le build de l'équipe Java Platform. Il veut automatiser le processus test-build pour détecter les échecs rapidement.

**Timeline :**
- **3 octobre 2004** : Premier commit CVS de Hudson
- **7 février 2005** : Release de Hudson 1.0
- **Mai 2008** : Hudson gagne le **Duke's Choice Award** à la conférence JavaOne

#### Pourquoi Hudson a Révolutionné la CI

**1. Interface Utilisateur Supérieure**

Hudson a introduit une **UI web intuitive** qui rendait la CI accessible :

```
┌──────────────────────────────────────────────────────────────┐
│  HUDSON DASHBOARD                                            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  🔵 Project A    [============================] ✓ Success   │
│  🔴 Project B    [=============X              ] ✗ Failed    │
│  🟡 Project C    [==============~             ] ⚠ Unstable  │
│                                                              │
│  Weather Icons: ☀️ = Stable, 🌤️ = Mostly Stable, ⛈️ = Unstable │
│  Build Trend Graphs                                          │
│  Test Results History                                        │
└──────────────────────────────────────────────────────────────┘
```

**Innovations :**
- **Weather icons** : Métaphore visuelle de la santé du projet
- **Build trends** : Graphiques d'évolution
- **One-click configuration** : Configuration via formulaires web
- **Real-time feedback** : Statut en temps réel

**2. Architecture Plugin Extensible**

Hudson a introduit une **architecture plugin** qui permettait à la communauté d'étendre les fonctionnalités :

```java
// Exemple de plugin Hudson (architecture simplifiée)
public class MyPlugin extends Plugin {
    @Override
    public void start() throws Exception {
        // Plugin initialization
    }
}

public class MyBuilder extends Builder {
    @Override
    public boolean perform(Build build, Launcher launcher,
                          BuildListener listener) {
        // Custom build step
        return true;
    }
}
```

**Avantages :**
- Extensibilité sans modifier le core
- Écosystème communautaire
- Support de multiples SCM, build tools, notification systems

**3. Scheduling Flexible**

Hudson permettait de déclencher les builds de multiples façons :
- **Poll SCM** : Vérification périodique du repository
- **Post-commit hooks** : Déclenchement immédiat après commit
- **Scheduled builds** : Builds nocturnes (nightly builds)
- **Manual trigger** : Déclenchement manuel
- **Upstream/downstream** : Chaînage de jobs

#### La Domination du Marché (2008-2010)

**Fin des années 2000**, Hudson devient le **leader incontesté** du CI :

- Adoption massive dans l'écosystème Java
- Communauté active contribuant des plugins
- Dépassement de CruiseControl en popularité
- Support de multiples langages (Java, PHP, Ruby, Python, .NET)

#### L'Acquisition Oracle et le Fork (2010-2011)

**Le Drame :**

1. **2010** : Oracle acquiert Sun Microsystems
2. **Décembre 2010** : Tensions entre Oracle et la communauté Hudson
   - Oracle revendique la propriété du nom "Hudson"
   - Oracle soumet une demande de trademark
   - Désaccords sur la gouvernance du projet

3. **29 janvier 2011** : **LE FORK**
   - Vote communautaire : **214 voix pour, 14 contre**
   - Le projet est renommé **Jenkins**
   - Kohsuke Kawaguchi mène le fork
   - La majorité de la communauté suit Jenkins

#### Jenkins : L'Âge d'Or (2011-2019)

Après le fork, **Jenkins** devient le standard de facto de l'industrie :

**Statistiques :**
- **1,800+ plugins** développés
- Adoption par des milliers d'entreprises (Google, Netflix, LinkedIn, eBay)
- Support de tous les langages et plateformes
- Intégration avec tous les outils DevOps majeurs

**Architecture Jenkins Pipeline (2016)** :

```groovy
// Jenkinsfile - Pipeline as Code (2016)
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh './deploy.sh'
            }
        }
    }

    post {
        failure {
            mail to: 'team@example.com',
                 subject: "Build Failed: ${env.JOB_NAME}",
                 body: "Check console output at ${env.BUILD_URL}"
        }
    }
}
```

**Innovation Pipeline as Code (2016)** :
- Pipelines définis en code (Groovy DSL)
- Versionnés avec le code source
- Réutilisables et composables
- Support de pipelines complexes multi-étapes

#### L'Héritage Hudson/Jenkins

**Impact durable :**

✅ **Démocratisation de la CI** : Rendu accessible aux équipes de toutes tailles
✅ **Écosystème plugin** : Modèle repris par tous les outils modernes
✅ **Pipeline as Code** : Concept devenu standard de l'industrie
✅ **Open Source** : Modèle communautaire robuste

❌ **Limitations qui deviendront apparentes :**
- Interface vieillissante (UI des années 2000)
- Configuration complexe pour les pipelines avancés
- Nécessité d'auto-hébergement (self-hosted)
- Maintenance lourde (serveurs, plugins, upgrades)
- Sécurité : CVEs régulières dans Jenkins et ses plugins

---

### CI as a Service : Travis CI et CircleCI (2011) {#ci-as-service}

#### Le Changement de Paradigme : Le Cloud

**2011** marque un tournant : le **cloud computing** devient mainstream.

**Contexte technologique :**
- **AWS** (2006) mature et s'étend
- **GitHub** (2008) devient la plateforme dominante pour l'open source
- **Heroku** (2007) popularise le Platform-as-a-Service (PaaS)

**L'opportunité :** Pourquoi auto-héberger un serveur Jenkins quand on peut avoir CI "as a Service" ?

#### Travis CI : Le Pionnier du CI-as-a-Service (2011)

**Fondation :** Travis CI est fondé à **Berlin, Allemagne** en **2011**.

**La Proposition de Valeur Révolutionnaire :**

```
JENKINS (2005-2011)                    TRAVIS CI (2011)
─────────────────────                  ────────────────
❌ Installer Jenkins                   ✅ Gratuit pour l'open source
❌ Configurer un serveur               ✅ Zéro configuration serveur
❌ Maintenir les updates               ✅ Toujours à jour
❌ Installer des plugins               ✅ Intégration GitHub native
❌ Configuration UI complexe           ✅ Configuration via .travis.yml
❌ Gérer la capacité                   ✅ Scaling automatique
```

**Le Fichier .travis.yml : La Révolution Configuration-as-Code**

Travis CI introduit le concept de **configuration CI versionnée avec le code** :

```yaml
# .travis.yml - Configuration simple et lisible
language: ruby
rvm:
  - 2.0.0
  - 1.9.3
  - jruby-19mode

script:
  - bundle exec rake test

notifications:
  email:
    - dev@example.com
```

**Pourquoi c'était révolutionnaire :**

1. **Versioning** : La configuration CI est versionnée avec le code
2. **Portabilité** : Fork le repo = fork la config CI
3. **Review** : Changements CI soumis en Pull Request
4. **Lisibilité** : YAML plus accessible que Groovy/XML
5. **Explicite** : Toutes les dépendances déclarées dans le fichier

#### L'Intégration GitHub : Le Game Changer

**L'Innovation Majeure :** Intégration native et transparente avec GitHub

**Le Workflow Travis CI :**

```
┌─────────────────────────────────────────────────────────────┐
│  WORKFLOW TRAVIS CI + GITHUB (2011)                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Développeur pousse du code sur GitHub                   │
│     git push origin feature-branch                           │
│                                                              │
│  2. GitHub Webhook notifie Travis CI                         │
│     POST https://api.travis-ci.com/hooks                     │
│                                                              │
│  3. Travis CI clone le repo et lit .travis.yml               │
│     git clone https://github.com/user/repo.git               │
│                                                              │
│  4. Travis CI exécute le build dans un container             │
│     [Container Ubuntu] → install deps → run tests            │
│                                                              │
│  5. Travis CI reporte le statut à GitHub                     │
│     ✅ All checks passed                                     │
│     ❌ Some checks failed                                    │
│                                                              │
│  6. Badge status visible sur le README                       │
│     [![Build Status](travis-ci.com/badge.svg)]               │
└─────────────────────────────────────────────────────────────┘
```

**Fonctionnalités clés :**
- **Status checks** sur les Pull Requests
- **Badges** visuels dans les READMEs
- **Build matrix** : tester plusieurs versions en parallèle
- **Notifications** : email, Slack, IRC

#### CircleCI : Le Concurrent Performant (2011)

**CircleCI** est également fondé en **2011** (même année que Travis CI).

**Positionnement différenciant :**

1. **Performance** : Focus sur la vitesse d'exécution
   - Parallélisation intelligente
   - Caching agressif des dépendances
   - Builds plus rapides que Travis

2. **Docker-First** (2014) :
   - **Premier CI à supporter Docker containers** nativement
   - Permet d'utiliser n'importe quelle image Docker
   - Environnements reproductibles

3. **Configuration via config.yml** :

```yaml
# .circleci/config.yml
version: 2.1

jobs:
  build:
    docker:
      - image: cimg/node:18.0
    steps:
      - checkout
      - restore_cache:
          keys:
            - v1-dependencies-{{ checksum "package-lock.json" }}
      - run: npm install
      - save_cache:
          paths:
            - node_modules
          key: v1-dependencies-{{ checksum "package-lock.json" }}
      - run: npm test

workflows:
  version: 2
  build_and_test:
    jobs:
      - build
```

**Innovations CircleCI :**
- **Workflows** : Orchestration de jobs complexes
- **Orbs** : Packages réutilisables de configuration
- **Insights** : Analytics détaillées des builds

#### L'Impact de Travis CI et CircleCI

**Adoption Massive (2013-2016) :**

Selon les données historiques, **l'adoption CI a explosé à partir de 2013** :
- Courbe d'adoption en forte croissance
- Travis CI devient le standard pour l'open source GitHub
- CircleCI capte le marché entreprise avec ses performances

**Changements Culturels :**

1. **CI devient la norme** : Attendue sur tout projet open source
2. **Status badges partout** : Indicateur de qualité du projet
3. **Green build = good** : Culture du build qui ne casse jamais
4. **Configuration-as-Code** : Standard adopté par tous les nouveaux outils

**Modèle Économique :**

```
FREE TIER (Open Source)          PAID TIER (Privé)
───────────────────────           ─────────────────
✅ Builds illimités                $69/mois : 1 container
✅ Projets publics                 $129/mois : 2 containers
✅ Communauté                      $249/mois : 5 containers
                                   Support prioritaire
```

#### Les Limites qui Apparaîtront

**Problèmes émergents (2016-2019) :**

1. **Coût pour les projets privés** : Devient cher à l'échelle
2. **Vendor lock-in** : Dépendance à un service externe
3. **Quotas limités** : Minutes de build limitées
4. **Configuration parfois complexe** : YAML peut devenir verbeux
5. **Manque d'intégration deep avec GitHub** : Toujours un outil externe

**Controverse Travis CI (2020) :**
- Changement brutal du modèle de pricing
- Suppression du tier gratuit généreux pour l'open source
- Migration massive vers GitHub Actions et alternatives

---

### L'Écosystème se Diversifie (2011-2019) {#diversification}

#### GitLab CI/CD : L'Intégration Totale (2011-2014)

**GitLab** est lancé en **2011** (même année que Travis et Circle).

**Évolution :**
- **2011** : GitLab comme alternative self-hosted à GitHub
- **2012** : Introduction de GitLab CI (séparé)
- **2015** : **GitLab CI intégré nativement** dans GitLab 8.0
- **2016** : Concept de **DevOps Platform complète**

**La Vision GitLab : "The DevOps Platform"**

```
┌────────────────────────────────────────────────────────────┐
│  GITLAB : PLATEFORME DEVOPS COMPLÈTE                       │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Plan          → Issues, Boards, Roadmaps                  │
│  Create        → Source Code Management, Merge Requests    │
│  Verify        → CI/CD Pipeline, Testing                   │
│  Package       → Container Registry, Package Registry      │
│  Secure        → SAST, DAST, Dependency Scanning           │
│  Release       → Continuous Delivery, Feature Flags        │
│  Configure     → Auto DevOps, Infrastructure as Code       │
│  Monitor       → Metrics, Logging, Tracing                 │
│  Protect       → Security Dashboard, Compliance            │
│                                                            │
│  🎯 UNE SEULE APPLICATION POUR TOUT LE CYCLE DEVOPS        │
└────────────────────────────────────────────────────────────┘
```

**Configuration .gitlab-ci.yml :**

```yaml
# .gitlab-ci.yml - Configuration GitLab CI
stages:
  - build
  - test
  - deploy

variables:
  POSTGRES_DB: test_db
  POSTGRES_USER: runner
  POSTGRES_PASSWORD: ""

build_job:
  stage: build
  image: node:18
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/

test_job:
  stage: test
  image: node:18
  services:
    - postgres:14
  script:
    - npm test
  coverage: '/Coverage: \d+\.\d+%/'

deploy_production:
  stage: deploy
  script:
    - ./deploy.sh production
  only:
    - main
  environment:
    name: production
    url: https://example.com
```

**Avantages GitLab CI :**
- ✅ **Intégration native** : CI/CD inclus, pas d'outil externe
- ✅ **Self-hosted option** : Contrôle total
- ✅ **GitLab Runners** : Auto-scalable, multi-OS
- ✅ **Auto DevOps** : Configuration zero pour projets standards
- ✅ **Security scanning** : SAST, DAST, dependency scanning intégrés

**Free Tier GitLab (2024) :**
- 400 minutes CI/CD gratuites/mois
- Container Registry illimité
- Security scans (8 types)

#### Atlassian Bamboo : La Solution Entreprise (2007)

**Bamboo** par Atlassian (créateurs de Jira, Confluence) lancé en **2007**.

**Positionnement :**
- Solution **entreprise** payante
- Intégration profonde avec **Jira** et **Bitbucket**
- License perpétuelle (self-hosted)
- Orienté grandes organisations

**Avantages :**
- Support commercial entreprise
- Intégration Atlassian ecosystem
- Build permissions granulaires
- Dedicated agents

**Inconvénient :**
-  $$$ Coûteux (à partir de $1,200/an)
- Moins populaire que Jenkins dans l'open source
- Courbe d'apprentissage

#### Azure DevOps / TFS : L'Écosystème Microsoft (2005-2018)

**Évolution :**
- **2005** : Team Foundation Server (TFS)
- **2010** : Team Foundation Build
- **2018** : Renommé **Azure DevOps**
- **2019** : Azure Pipelines avec free tier GitHub

**Azure Pipelines (2018) :**

```yaml
# azure-pipelines.yml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Build
    jobs:
      - job: BuildJob
        steps:
          - task: NodeTool@0
            inputs:
              versionSpec: '18.x'
          - script: |
              npm install
              npm run build
            displayName: 'Build application'

  - stage: Test
    jobs:
      - job: TestJob
        steps:
          - script: npm test
            displayName: 'Run tests'
```

**Avantages Azure DevOps :**
- Intégration profonde avec écosystème Microsoft (.NET, Visual Studio)
- **10 parallel jobs gratuits** pour l'open source
- Multi-cloud (Azure, AWS, GCP)
- Windows, Linux, macOS runners

#### Autres Acteurs Notables (2015-2019)

**TeamCity** (JetBrains, 2006)
- IDE-like experience
- Excellent pour les projets Java/Kotlin
- 3 build agents gratuits
- Intégration IntelliJ IDEA

**Drone** (2014)
- Open source, written in Go
- Container-native (Docker-first)
- Configuration simple en YAML
- Self-hosted ou cloud

**Buildkite** (2013)
- Hybrid model : UI cloud + runners self-hosted
- Scaling illimité (vos propres machines)
- Focus performance

**Codefresh** (2014)
- Kubernetes-native CI/CD
- Container-first approach
- Helm charts support

#### Le Paysage CI/CD en 2018-2019 : Maturité et Fragmentation

**État du marché avant GitHub Actions :**

```
LEADERS                      CHALLENGERS               NICHES
────────                     ───────────               ──────
Jenkins (35-40% marché)      GitLab CI                 Drone
Travis CI (open source)      Azure Pipelines           Buildkite
CircleCI (startups)          AWS CodeBuild             Codefresh
                             Bamboo (entreprise)       TeamCity
```

**Problèmes de l'écosystème :**

1. **Fragmentation** : Trop d'outils, configurations non portables
2. **Complexité** : Courbe d'apprentissage pour chaque outil
3. **Coût** : Pricing compliqué, cher à l'échelle
4. **Intégration** : CI toujours séparée du code repository
5. **Vendor lock-in** : Migration difficile entre outils

**Le marché est mûr pour une disruption...**

---

### GitHub Actions : Le Game Changer (2019-2025) {#github-actions}

#### Le Contexte : GitHub Domine le Marché (2019)

**Position de GitHub en 2019 :**
- **100+ millions de repositories**
- **40+ millions de développeurs**
- **Plateforme dominante** pour l'open source
- **Propriété Microsoft** (acquisition 2018 pour $7.5B)

**Le Problème :** GitHub est "juste" un Git hosting.
- Pour CI/CD → Travis, Circle, GitLab CI (outils externes)
- Pour project management → Jira, Linear (outils externes)
- Pour déploiement → Heroku, Netlify, Vercel (outils externes)

**L'Opportunité :** Et si GitHub devenait une **plateforme complète** ?

#### L'Annonce : GitHub Universe 2019

**Novembre 2019** : GitHub Actions devient **publiquement disponible** pour tous.

**La Promesse :**

> **"Automate your workflow from idea to production"**
>
> — GitHub Actions tagline

**La Vision :**
- **CI/CD natif** dans GitHub, pas d'outil externe
- **Gratuit** pour l'open source (unlimited minutes)
- **Free tier généreux** pour le privé (2,000 minutes Linux/mois)
- **Marketplace d'actions** réutilisables
- **Workflow-as-Code** avec YAML
- **Événements GitHub natifs** (issues, PRs, releases, etc.)

#### L'Architecture Révolutionnaire

**Concept : Workflows → Jobs → Steps → Actions**

```
┌───────────────────────────────────────────────────────────────┐
│  ARCHITECTURE GITHUB ACTIONS                                  │
├───────────────────────────────────────────────────────────────┤
│                                                               │
│  WORKFLOW (.github/workflows/ci.yml)                          │
│  ├─ Déclenché par events (push, PR, schedule, manual...)     │
│  │                                                            │
│  ├─ JOB 1: Build                                              │
│  │  ├─ Runs on: ubuntu-latest                                │
│  │  ├─ STEP 1: Checkout code (Action)                        │
│  │  ├─ STEP 2: Setup Node.js (Action)                        │
│  │  ├─ STEP 3: npm install (Script)                          │
│  │  └─ STEP 4: npm build (Script)                            │
│  │                                                            │
│  ├─ JOB 2: Test (parallel avec Build)                         │
│  │  ├─ Runs on: ubuntu-latest                                │
│  │  ├─ STEP 1: Checkout code                                 │
│  │  ├─ STEP 2: Run tests                                     │
│  │  └─ STEP 3: Upload coverage                               │
│  │                                                            │
│  └─ JOB 3: Deploy (dépend de Build + Test)                    │
│     ├─ Runs on: ubuntu-latest                                │
│     ├─ STEP 1: Deploy to Vercel (Action)                     │
│     └─ STEP 2: Notify Slack (Action)                         │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

**Exemple Workflow de Base :**

```yaml
# .github/workflows/ci.yml
name: CI

# Trigger sur push et PR
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Action de la marketplace
      - uses: actions/checkout@v4

      # Action avec paramètres
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      # Scripts shell
      - run: npm ci
      - run: npm run build
      - run: npm test

      # Upload d'artefacts
      - uses: actions/upload-artifact@v4
        with:
          name: dist
          path: dist/
```

#### Les Innovations Majeures

**1. GitHub Events Natifs**

GitHub Actions peut réagir à **TOUS les événements GitHub** (pas seulement push/PR) :

```yaml
on:
  # Code events
  push:
  pull_request:
  pull_request_review:

  # Issue events
  issues:
    types: [opened, labeled]
  issue_comment:

  # Release events
  release:
    types: [published]

  # Project events
  project_card:
  milestone:

  # Repository events
  fork:
  star:
  watch:

  # Scheduled (cron)
  schedule:
    - cron: '0 0 * * *'

  # Manual dispatch
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        default: 'staging'
```

**Use cases révolutionnaires :**
- Auto-label PRs basé sur les fichiers modifiés
- Envoyer un message de bienvenue aux nouveaux contributors
- Créer une release automatiquement quand on merge sur main
- Fermer les issues stale après 30 jours

**2. Marketplace : Écosystème d'Actions Réutilisables**

**Novembre 2019** : Launch avec quelques centaines d'actions
**2024** : **10,000+ actions** publiées
**2025** : **20,000+ actions** disponibles

**Actions Officielles GitHub :**

```yaml
# Checkout code
- uses: actions/checkout@v4

# Setup languages
- uses: actions/setup-node@v4
- uses: actions/setup-python@v5
- uses: actions/setup-java@v4
- uses: actions/setup-go@v5

# Artifacts
- uses: actions/upload-artifact@v4
- uses: actions/download-artifact@v4

# Caching
- uses: actions/cache@v4

# GitHub CLI
- uses: actions/github-script@v7
```

**Actions Tierces Populaires (2024-2025) :**

```yaml
# Deployment
- uses: vercel/actions/deploy@v2
- uses: cloudflare/pages-action@v1
- uses: aws-actions/amazon-ecs-deploy-task-definition@v1

# Code Quality
- uses: codecov/codecov-action@v4
- uses: sonarqube/sonarqube-scan-action@v2

# Docker
- uses: docker/build-push-action@v5
- uses: docker/login-action@v3

# Notifications
- uses: slackapi/slack-github-action@v1
- uses: 8398a7/action-slack@v3
```

**3. Matrix Builds : Test Partout**

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [16, 18, 20]
        include:
          - os: ubuntu-latest
            node: 20
            experimental: true

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: npm test
```

**Résultat :** **9 builds en parallèle** (3 OS × 3 Node versions) + 1 expérimental = 10 jobs

**4. Secrets Management Intégré**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Secrets stockés dans GitHub Settings
      - name: Deploy to production
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: ./deploy.sh
```

**Sécurité :**
- Secrets chiffrés dans GitHub
- Jamais exposés dans les logs
- Scoped par repository/organization/environment
- Support OIDC (OpenID Connect) pour AWS/Azure/GCP sans credentials

#### L'Adoption Explosive (2019-2025)

**2020** : Adoption rapide, migration depuis Travis CI (qui change son pricing)

**2021** :
- **Reusable Workflows** (Novembre 2021) : Game changer pour les monorepos
- Actions shareable en interne (Janvier 2022)

**2022-2023** : Consolidation
- Larger runners (jusqu'à 64 cores, 256GB RAM)
- Support ARM64
- Required workflows pour les organisations

**2024** : Maturité
- **4 millions de workflows/jour** (+35% YoY)
- **30% des top 5,000 repos** utilisent GitHub Actions
- **20,000+ actions** sur le Marketplace

**2025** : Standard de l'industrie
- Migration massive depuis Jenkins/Travis/Circle
- Adoption entreprise à grande échelle
- Innovations continues (GPU runners, etc.)

#### Statistiques d'Adoption 2024-2025

**Croissance :**
- **+35% d'adoption année après année**
- **Doublement du Marketplace** en un an (10k → 20k actions)
- **41% de croissance annuelle** des outils CI dans le Marketplace GitHub

**Pricing (2025) :**

```
FREE TIER (Public repos)
─────────────────────────
✅ Unlimited minutes
✅ Unlimited concurrent jobs
✅ Linux, Windows, macOS runners

FREE TIER (Private repos)
──────────────────────────
✅ 2,000 minutes Linux/mois
✅ 1,000 minutes macOS/mois (10x multiplier)
✅ 500 minutes Windows/mois (2x multiplier)

PAID TIERS
──────────
• $4/mois : +3,000 minutes
• $21/mois : +15,000 minutes
• $40/mois : +50,000 minutes
• Larger runners : $0.008/minute (2-core)
```

**Impact Financier :**
- **$30 millions** de transactions sur GitHub Marketplace
- Monétisation croissante des workflows custom
- Entreprises payant pour advanced features

#### Pourquoi GitHub Actions a Gagné

**Comparaison avec la concurrence (2024-2025) :**

| Critère | GitHub Actions | GitLab CI | Jenkins | CircleCI |
|---------|----------------|-----------|---------|----------|
| **Setup** | ✅ Zéro config | ✅ Intégré | ❌ Self-hosted | ⚠️ Compte externe |
| **Free Tier** | ✅ 2,000 min | ⚠️ 400 min | ✅ Gratuit | ⚠️ Limité |
| **GitHub Integration** | ✅✅ Native | ⚠️ Via OAuth | ❌ Webhooks | ⚠️ OAuth |
| **Marketplace** | ✅ 20,000+ | ⚠️ Limité | ⚠️ Plugins | ⚠️ Orbs |
| **Maintenance** | ✅ Zero | ✅ Zero (cloud) | ❌ Heavy | ✅ Zero |
| **Flexibility** | ✅✅ High | ✅ High | ✅✅ Max | ✅ Medium |
| **Security** | ✅ OIDC, Secrets | ✅ Vault | ⚠️ Plugins | ✅ Good |
| **Multi-OS** | ✅ Lin/Win/Mac | ✅ Runners | ✅ Agents | ✅ Yes |

**Les Raisons du Succès :**

1. **Zero Friction** : Si vous êtes sur GitHub, GitHub Actions est déjà là
2. **Free Tier Généreux** : 2,000 minutes suffisent pour beaucoup de projets
3. **Marketplace** : Résout 90% des cas d'usage avec des actions toutes faites
4. **Events Rich** : Automation au-delà du CI/CD (issues, releases, etc.)
5. **Developer Experience** : Configuration simple, docs excellentes
6. **Microsoft Backing** : Investissement massif, feature velocity élevée
7. **Migration Facile** : Depuis Travis/Circle avec des outils d'import

#### Les Limitations (2025)

**Même si dominant, GitHub Actions a des limites :**

❌ **Vendor Lock-in GitHub** : Si pas sur GitHub, pas d'Actions
❌ **Coût à l'échelle** : Peut devenir cher pour grandes équipes (minutes)
❌ **Debugging difficile** : Pas d'exécution locale native (besoin de `act`)
❌ **Customization limitée** : Moins flexible que Jenkins pour cas edge
❌ **Performance** : Parfois plus lent que CircleCI ou Buildkite
❌ **Concurrency limits** : Quotas sur jobs parallèles

**Cas où choisir autre chose :**
- **Jenkins** : Besoin de customisation maximale, compliance stricte
- **GitLab CI** : Écosystème GitLab, besoin de DevSecOps intégré
- **CircleCI** : Performance critique, caching avancé
- **Buildkite** : Scaling massif avec vos propres runners

---

## Timeline Visuelle : L'Évolution de la CI/CD {#timeline}

```
═══════════════════════════════════════════════════════════════════════════
                     TIMELINE CI/CD (1990-2025)
═══════════════════════════════════════════════════════════════════════════

1990-2000 : L'ÈRE PRÉ-CI
───────────────────────────────────────────────────────────────────────────
📅 1990    │ CVS (Concurrent Versions System)
📅 1996    │ 🌟 Chrysler C3 Project - Kent Beck introduit XP
📅 1999    │ 🌟 Extreme Programming formalisé (Beck, Fowler, Jeffries)
📅 2000    │ 🌟 Martin Fowler publie "Continuous Integration"
           │ SVN (Subversion) released
───────────────────────────────────────────────────────────────────────────

2000-2010 : NAISSANCE DES OUTILS CI
───────────────────────────────────────────────────────────────────────────
📅 2001    │ CruiseControl - Premier serveur CI open source
📅 2004    │ 🚀 Hudson - Premier commit (Kohsuke Kawaguchi, Sun)
📅 2005    │ 🚀 Hudson 1.0 released (7 février)
           │ Git created (Linus Torvalds)
📅 2006    │ TeamCity (JetBrains) launched
           │ AWS launched (cloud computing begins)
📅 2007    │ Bamboo (Atlassian) launched
📅 2008    │ 🏆 Hudson wins Duke's Choice Award
           │ GitHub launched
───────────────────────────────────────────────────────────────────────────

2010-2019 : L'ÈRE DU CI-AS-A-SERVICE
───────────────────────────────────────────────────────────────────────────
📅 2010    │ Oracle acquires Sun Microsystems
📅 2011    │ 💥 Jenkins fork from Hudson (29 janvier)
           │ 🚀 Travis CI founded (Berlin) - CI as a Service
           │ 🚀 CircleCI founded - Performance focus
           │ 🚀 GitLab launched
📅 2013    │ 📈 CI adoption begins rising sharply
           │ Drone (container-native CI)
           │ Buildkite launched
📅 2014    │ 🐳 Docker becomes mainstream
           │ CircleCI - First to support Docker
           │ Codefresh (Kubernetes-native)
📅 2015    │ 🚀 GitLab CI integrated natively
📅 2016    │ 🔧 Jenkins Pipeline as Code (Jenkinsfile)
           │ GitLab positions as "DevOps Platform"
📅 2018    │ 🔷 Microsoft acquires GitHub ($7.5B)
           │ Azure DevOps launched
───────────────────────────────────────────────────────────────────────────

2019-2025 : L'ÈRE GITHUB ACTIONS
───────────────────────────────────────────────────────────────────────────
📅 Nov 2019│ 🎯 GITHUB ACTIONS PUBLIC RELEASE
           │ - Free for open source
           │ - 2,000 minutes/month for private
           │ - Marketplace with hundreds of actions
📅 2020    │ 💥 Travis CI pricing change → mass migration
           │ GitHub Actions rapid adoption
📅 Nov 2021│ 🔧 Reusable Workflows released
📅 Jan 2022│ 🔧 Internal action sharing (private marketplace)
📅 2023    │ Larger runners (64 cores, 256GB RAM)
           │ ARM64 support
📅 Mid 2024│ 🏆 Marketplace passes 10,000 actions
           │ 4 million workflows/day (+35% YoY)
📅 2025    │ 🏆 20,000+ actions in Marketplace
           │ 30% of top 5,000 repos use GitHub Actions
           │ Standard de facto de l'industrie
═══════════════════════════════════════════════════════════════════════════

LÉGENDE :
🌟 = Concept/Pratique majeure
🚀 = Outil/Plateforme lancé
💥 = Événement disruptif
🔧 = Feature majeure
🏆 = Milestone adoption
📈 = Croissance marché
🐳 = Technologie enabler
🔷 = Acquisition stratégique
🎯 = Game changer
```

---

## Glossaire FR/EN (Partie 1) {#glossaire-partie-1}

### Concepts Fondamentaux

| Français | English | Définition |
|----------|---------|------------|
| **Intégration Continue** | **Continuous Integration (CI)** | Pratique de développement où les membres d'une équipe intègrent leur travail fréquemment (au moins quotidiennement), chaque intégration étant vérifiée par un build automatisé incluant des tests. |
| **Livraison Continue** | **Continuous Delivery (CD)** | Extension de CI où le code est toujours dans un état déployable. Le déploiement en production nécessite une approbation manuelle. |
| **Déploiement Continu** | **Continuous Deployment** | Extension de Continuous Delivery où chaque changement qui passe les tests automatisés est automatiquement déployé en production sans intervention humaine. |
| **Pipeline** | **Pipeline** | Séquence automatisée d'étapes (build, test, deploy) exécutées pour transformer le code source en application déployée. |
| **Build** | **Build** | Processus de transformation du code source en artefacts exécutables (compilation, bundling, packaging). |
| **Artefact de Build** | **Build Artifact** | Fichier résultant du processus de build (binaire, package, container image, bundle JavaScript, etc.). |

### Terminologie XP et CI Historique

| Français | English | Définition |
|----------|---------|------------|
| **Enfer d'Intégration** | **Integration Hell** | Situation où l'intégration de code développé en isolation pendant des semaines/mois cause d'énormes conflits et bugs. |
| **Programmation Extrême** | **Extreme Programming (XP)** | Méthodologie agile créée par Kent Beck en 1996 incluant CI comme pratique fondamentale. |
| **"Ça marche sur ma machine"** | **"It works on my machine"** | Expression ironique décrivant le code qui fonctionne localement mais échoue en intégration/production. |
| **Refactoring** | **Refactoring** | Restructuration du code sans changer son comportement externe, pratique fondamentale de XP. |
| **Propriété Collective** | **Collective Ownership** | Pratique XP où toute l'équipe est responsable de tout le code. |

### Architecture CI/CD

| Français | English | Définition |
|----------|---------|------------|
| **Serveur CI** | **CI Server** | Serveur dédié à l'exécution des builds automatisés (ex: Jenkins, Hudson). |
| **Runner / Agent** | **Runner / Agent** | Machine/container qui exécute les jobs de CI/CD (ex: GitHub-hosted runner, self-hosted runner). |
| **Workflow** | **Workflow** | Dans GitHub Actions : fichier YAML définissant l'automatisation complète (events → jobs → steps). |
| **Job** | **Job** | Ensemble d'étapes (steps) exécutées sur le même runner. |
| **Step / Étape** | **Step** | Plus petite unité de travail : soit un script shell, soit une action. |
| **Action** | **Action** | Dans GitHub Actions : unité réutilisable de code effectuant une tâche (ex: checkout, setup-node). |

### Outils et Plateformes

| Français | English | Définition |
|----------|---------|------------|
| **CI en tant que Service** | **CI as a Service** | Modèle où le serveur CI est hébergé dans le cloud par un fournisseur (ex: Travis CI, CircleCI). |
| **Auto-hébergé** | **Self-Hosted** | Infrastructure CI/CD gérée et hébergée par l'organisation (ex: Jenkins on-premise). |
| **Marketplace** | **Marketplace** | Catalogue d'actions/plugins réutilisables (ex: GitHub Actions Marketplace). |
| **Webhook** | **Webhook** | HTTP callback qui notifie un système externe d'un événement (ex: GitHub → Travis CI). |

### Configuration

| Français | English | Définition |
|----------|---------|------------|
| **Pipeline en tant que Code** | **Pipeline as Code** | Pratique de définir les pipelines CI/CD dans des fichiers versionnés avec le code (ex: Jenkinsfile, .travis.yml, .github/workflows/). |
| **YAML** | **YAML** | Format de configuration human-readable utilisé par GitHub Actions, GitLab CI, CircleCI. |
| **Matrice de Build** | **Build Matrix** | Configuration permettant de tester contre plusieurs versions/OS en parallèle. |
| **Badge de Statut** | **Status Badge** | Image affichée dans le README indiquant l'état du build (✅ passing, ❌ failing). |

### Événements GitHub Actions

| Français | English | Définition |
|----------|---------|------------|
| **Déclencheur** | **Trigger** | Événement qui lance un workflow (push, pull_request, schedule, etc.). |
| **Push** | **Push** | Événement git push vers le repository. |
| **Pull Request** | **Pull Request** | Événement d'ouverture/modification d'une PR. |
| **Planification** | **Schedule** | Déclenchement périodique via syntaxe cron. |
| **Dispatch Manuel** | **Workflow Dispatch** | Déclenchement manuel via l'UI GitHub ou API. |

### Concepts Agile/DevOps

| Français | English | Définition |
|----------|---------|------------|
| **Feedback Rapide** | **Fast Feedback** | Principe de recevoir des retours sur la qualité du code en minutes, pas en jours. |
| **Intégration Fréquente** | **Frequent Integration** | Pratique de merger sur la branche principale au moins quotidiennement. |
| **Branche Principale** | **Mainline / Main Branch** | Branche principale du repository (main, master). |
| **Build Vert** | **Green Build** | Build qui passe tous les tests avec succès. |
| **Casser le Build** | **Break the Build** | Introduire un commit qui fait échouer le build ou les tests. |

---

## Références et Sources (Partie 1)

### Articles Fondateurs

1. **Martin Fowler - Continuous Integration (2000)**
   - https://martinfowler.com/articles/continuousIntegration.html
   - Article fondateur définissant la CI moderne

2. **Kent Beck - Extreme Programming Explained (1999)**
   - Livre introduisant les 12 pratiques XP dont CI

3. **Martin Fowler - Extreme Programming (bliki)**
   - https://martinfowler.com/bliki/ExtremeProgramming.html

### Histoire des Outils

4. **A Brief History of DevOps, Part III: Automated Testing and Continuous Integration (CircleCI)**
   - https://circleci.com/blog/a-brief-history-of-devops-part-iii-automated-testing-and-continuous-integration/

5. **The Evolution of Jenkins Versions: A Journey Through CI/CD History**
   - https://karandeepsingh.ca/posts/jenkins-versions-evolution-journey/

6. **Hudson is Retiring. The End of a Jenkins' Story (Medium)**
   - https://medium.com/swlh/hudson-is-retiring-the-end-of-a-jenkins-story-9cee866135ab

7. **A Brief History of CI/CD Tooling (Medium)**
   - https://medium.com/@DiggerHQ/a-brief-history-of-ci-cd-tooling-5a67c2638f3a

### GitHub Actions

8. **GitHub Actions Documentation**
   - https://docs.github.com/en/actions

9. **GitHub Blog - 100 million developers and counting**
   - https://github.blog/news-insights/company-news/100-million-developers-and-counting/

10. **Lessons Learned from Enterprise Usage of GitHub Actions (InfoQ)**
    - https://www.infoq.com/articles/enterprise-github-actions/

### Statistiques 2024-2025

11. **GitHub Statistics 2025: Data That Changes Dev Work (SQ Magazine)**
    - https://sqmagazine.co.uk/github-statistics/

12. **GitHub Actions: The Impact on the Pull Request Process (Empirical Software Engineering)**
    - https://link.springer.com/article/10.1007/s10664-023-10369-w

### Comparaisons Outils

13. **Continuous Integration vs. Delivery vs. Deployment (Atlassian)**
    - https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment

14. **GitHub Actions vs Jenkins (2025) (Northflank)**
    - https://northflank.com/blog/github-actions-vs-jenkins

---

**📄 FIN DE LA PARTIE 1**

Cette première partie a couvert l'introduction et l'histoire complète de l'Intégration Continue, des années 90 chaotiques jusqu'à l'émergence de GitHub Actions en 2019-2025.

**📋 PROCHAINES PARTIES À VENIR :**

**Partie 2** : Concepts Fondamentaux CI/CD
- CI vs CD vs Continuous Deployment (détaillé)
- Anatomie d'un Pipeline
- Build Artifacts expliqués
- Environnements (dev, staging, prod)
- Feature Flags et Progressive Rollout

**Partie 3** : GitHub Actions en Profondeur
- Architecture détaillée
- Syntaxe YAML complète
- Triggers et événements
- Runners (hosted vs self-hosted)
- Secrets et sécurité
- Matrix builds
- Artifacts et caching
- Conditions et expressions

**Partie 4** : Marketplace, Patterns et Best Practices
- GitHub Actions Marketplace
- Workflows typiques
- Patterns avancés
- Best practices sécurité et performance
- Comparaisons avec autres outils

Demandez-moi quand vous êtes prêt pour la **Partie 2** !
---
# Claude Context
claude-context: true
type: research

# Metadata
date: 2025-11-05
research_type: technical
course_module: Module 5 - CI/CD & GitHub Actions

# Organization
tags:
  - research
  - ci-cd
  - github-actions
  - devops
  - enseignement
  - deployment-strategies
  - artifacts
related_projects:
  - Cours Initiation DevOps

# Research Scope
keywords: [CI/CD, Continuous Delivery, Continuous Deployment, Build Artifacts, Deployment Strategies, Feature Flags, Blue-Green, Canary]
sources_count: 25
tools_used:
  - WebSearch
  - Multiple DevOps sources
---

# CI/CD & GitHub Actions : Concepts Fondamentaux et Pratiques
## Document de Recherche pour M2 Expert en Stratégie et Transformation Digitale

**Partie 2 : Concepts Fondamentaux et Architecture des Pipelines**

---

## Table des Matières (Partie 2)

1. [Concepts Fondamentaux Expliqués en Détail](#concepts-fondamentaux)
   - [Continuous Integration (CI) : Définition Précise](#continuous-integration)
   - [Continuous Delivery (CD) : Déploiement Manuel en Prod](#continuous-delivery)
   - [Continuous Deployment : Automatisation Totale](#continuous-deployment)
   - [Comparaison et Choix de la Bonne Approche](#comparaison-ci-cd)
2. [Anatomie d'un Pipeline CI/CD](#anatomie-pipeline)
   - [Les Étapes Typiques d'un Pipeline](#etapes-pipeline)
   - [Jobs et Steps : Organisation du Travail](#jobs-steps)
   - [Parallélisation vs Séquentialité](#parallelisation)
   - [Diagramme d'un Pipeline Complet](#diagramme-pipeline)
3. [Build Artifacts Expliqués](#build-artifacts)
   - [Qu'est-ce qu'un Artifact ?](#definition-artifact)
   - [Types d'Artifacts](#types-artifacts)
   - [Stockage et Versioning](#stockage-versioning)
   - [Promotion d'Artifacts entre Environnements](#promotion-artifacts)
4. [Environnements de Déploiement](#environnements)
   - [Development, Staging, Production](#dev-staging-prod)
   - [Preview Environments (Vercel, Netlify)](#preview-environments)
   - [Stratégies de Déploiement Avancées](#strategies-deployment)
5. [Feature Flags et Progressive Rollout](#feature-flags)
   - [Qu'est-ce qu'un Feature Flag ?](#definition-feature-flag)
   - [Outils : LaunchDarkly, Unleash, Flagsmith](#outils-feature-flags)
   - [Stratégies de Rollout Progressif](#rollout-progressif)
   - [A/B Testing vs Feature Flags](#ab-testing-vs-flags)
   - [Kill Switch en Production](#kill-switch)
6. [Glossaire FR/EN (Partie 2)](#glossaire-partie-2)
7. [Références et Sources](#references-partie-2)

---

## 1. Concepts Fondamentaux Expliqués en Détail {#concepts-fondamentaux}

### Continuous Integration (CI) : Définition Précise {#continuous-integration}

#### Qu'est-ce que l'Intégration Continue ?

**Définition formelle** (Martin Fowler, 2000-2006) :

> **Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible.**

**En français :**

L'Intégration Continue est une pratique de développement logiciel où les membres d'une équipe intègrent leur travail fréquemment (au minimum quotidiennement, idéalement plusieurs fois par jour). Chaque intégration est vérifiée par un build automatisé incluant des tests pour détecter les erreurs d'intégration le plus rapidement possible.

#### Les Principes Fondamentaux de la CI

**1. Intégration Fréquente sur la Branche Principale**

```
ANTI-PATTERN : Feature Branches Long-Lived
─────────────────────────────────────────────
main      ──●────────────────────────────●─────────────────────
            │                            │
feature-X   └──●──●──●──●──●──●──●──●──●─┘  (3 semaines)
               ↑
        "Integration Hell" après 3 semaines


PATTERN CI : Short-Lived Branches (< 24h)
──────────────────────────────────────────
main      ──●──●──●──●──●──●──●──●──●──●──●─────────────
            │  │  │  │  │  │  │  │  │  │  │
features    └──┘  └──┘  └──┘  └──┘  └──┘  └──┘

         Intégration quotidienne = feedback rapide
```

**Pratique :** Chaque développeur merge sur `main` **au moins une fois par jour**, idéalement plusieurs fois.

**Bénéfices :**
- ✅ Conflits de merge minimes (changements petits et fréquents)
- ✅ Problèmes détectés rapidement (pas après 3 semaines)
- ✅ Code toujours proche d'un état stable
- ✅ Équipe synchronisée sur l'état actuel du code

**2. Build Automatisé à Chaque Commit**

Chaque fois qu'un développeur pousse du code, un **build automatique** se déclenche :

```yaml
# Exemple GitHub Actions - Trigger automatique
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'

      # Build automatique
      - run: npm ci
      - run: npm run build
      - run: npm test
```

**Ce qui se passe :**

```
Developer pushes code
        ↓
GitHub webhook triggered
        ↓
CI server starts build
        ↓
┌─────────────────────────────┐
│  1. Checkout code           │
│  2. Install dependencies    │
│  3. Compile/transpile       │
│  4. Run unit tests          │
│  5. Run integration tests   │
│  6. Generate coverage       │
│  7. Run linters             │
└─────────────────────────────┘
        ↓
✅ Success → Green build
❌ Failure → Red build, alert team
```

**3. Build Self-Testing**

Le build **inclut automatiquement l'exécution des tests** :

```javascript
// package.json
{
  "scripts": {
    "build": "tsc && webpack --mode production",
    "test": "jest --coverage",
    "test:unit": "jest --testPathPattern=unit",
    "test:integration": "jest --testPathPattern=integration",
    "lint": "eslint src/",
    "type-check": "tsc --noEmit"
  }
}
```

**Pipeline CI typique :**

```
npm ci (install exact dependencies)
   ↓
npm run lint (code quality)
   ↓
npm run type-check (TypeScript validation)
   ↓
npm run test:unit (fast tests)
   ↓
npm run test:integration (slower tests)
   ↓
npm run build (production build)
   ↓
✅ All passed → Artifact ready
```

**4. Feedback Rapide (< 10 minutes)**

**Règle d'or de Martin Fowler :** Le build doit être **rapide** (< 10 minutes idéalement).

**Pourquoi ?**
- Si le build prend 2 heures → Les développeurs ne l'attendent pas
- Si le build prend 5 minutes → Les développeurs peuvent corriger immédiatement

**Techniques d'optimisation :**

```yaml
# Caching des dépendances
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

# Test seulement les fichiers modifiés (en dev)
- run: npm test -- --onlyChanged

# Parallélisation des tests
- run: npm test -- --maxWorkers=4
```

**5. Fix Broken Builds Immediately**

**Règle absolue :** Si le build casse, **priorité absolue = le réparer**.

```
Build Status: ❌ FAILED

WRONG RESPONSE:
Developer: "Je vais finir ma feature d'abord"
           "C'est pas mon problème"
           "Je fixerai ça demain"

RIGHT RESPONSE:
Developer: ⚠️ STOP ALL WORK
           🔧 Fix the build NOW
           ✅ Green build restored
           ➡️ Then resume feature work
```

**Culture du "Green Build" :**
- Le build doit rester vert (passing) 99% du temps
- Build rouge = urgence de l'équipe entière
- Si fix impossible rapidement → `git revert` du commit problématique

#### Bénéfices de la CI

**1. Détection Précoce des Bugs**

```
WITHOUT CI:
Code → Develop 3 weeks → Integration → 💥 Discover bugs
                                          ↑
                                    Costly to fix

WITH CI:
Code → Push → CI (5 min) → 💥 Discover bugs
                            ↑
                       Cheap to fix immediately
```

**2. Réduction de l'Integration Hell**

Intégrer **quotidiennement** vs **mensuellement** :

```
Monthly Integration:
- 200 commits to merge
- 1,000 lines changed
- 50 files in conflict
- 3 days to resolve
- High risk of regression

Daily Integration:
- 5-10 commits to merge
- 100 lines changed
- 1-2 files in conflict
- 10 minutes to resolve
- Low risk
```

**3. Code Toujours Déployable**

Avec CI, la branche `main` est **toujours dans un état déployable** :

```
main branch status:
  ✅ All tests passing
  ✅ Builds successfully
  ✅ No known critical bugs
  ✅ Can deploy to production anytime
```

**4. Confiance de l'Équipe**

```
Without CI:
Developer: "I hope my code works when integrated 🤞"
           "I'm afraid to merge"

With CI:
Developer: "CI validated my code ✅"
           "I'm confident to merge"
```

#### Statistiques CI (2024-2025)

**Impact de la CI sur les équipes :**

- **23% réduction** des échecs de déploiement (source : Netflix AI-powered CI)
- **31% build times plus rapides** avec optimisations ML
- **4,000 déploiements/jour** chez Netflix grâce à CI/CD mature
- **50 déploiements/jour** chez Etsy avec Continuous Deployment

**Adoption :**
- **85%+** des équipes de développement modernes utilisent la CI
- **4 millions** de workflows GitHub Actions/jour
- **Croissance de 35% YoY** de l'adoption de GitHub Actions

---

### Continuous Delivery (CD) : Déploiement Manuel en Prod {#continuous-delivery}

#### Qu'est-ce que la Continuous Delivery ?

**Définition :**

> **Continuous Delivery is the ability to get changes of all types—including new features, configuration changes, bug fixes and experiments—into production, or into the hands of users, safely and quickly in a sustainable way.**
>
> — Jez Humble, "Continuous Delivery" (2010)

**En pratique :**

Continuous Delivery **étend la CI** en automatisant **tout le chemin vers la production**, mais conserve une **approbation manuelle** pour le déploiement final en production.

```
┌─────────────────────────────────────────────────────────────┐
│  CONTINUOUS DELIVERY PIPELINE                               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Code Push                                                  │
│      ↓                                                      │
│  [AUTOMATED] Build                                          │
│      ↓                                                      │
│  [AUTOMATED] Unit Tests                                     │
│      ↓                                                      │
│  [AUTOMATED] Integration Tests                              │
│      ↓                                                      │
│  [AUTOMATED] Deploy to DEV                                  │
│      ↓                                                      │
│  [AUTOMATED] Deploy to STAGING                              │
│      ↓                                                      │
│  [AUTOMATED] Run E2E Tests on Staging                       │
│      ↓                                                      │
│  [MANUAL] 👤 Approve Production Deployment                  │
│      ↓                                                      │
│  [AUTOMATED] Deploy to PRODUCTION                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Point clé :** Le code est **toujours prêt** à être déployé en production, mais l'équipe **choisit quand** le déployer.

#### Les Principes de Continuous Delivery

**1. Code Toujours Deployable**

À tout moment, la branche `main` peut être déployée en production :

```yaml
# GitHub Actions - CD Pipeline
name: CD

on:
  push:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci
      - run: npm test
      - run: npm run build

      # Upload artifact
      - uses: actions/upload-artifact@v4
        with:
          name: production-build
          path: dist/

  deploy-staging:
    needs: build-and-test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: production-build

      # Déploiement automatique sur staging
      - name: Deploy to Staging
        run: |
          aws s3 sync dist/ s3://staging-bucket/
          aws cloudfront create-invalidation --distribution-id ${{ secrets.STAGING_CF_ID }}

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest

    # ⚠️ APPROBATION MANUELLE REQUISE
    environment:
      name: production
      url: https://example.com

    steps:
      - uses: actions/download-artifact@v4
        with:
          name: production-build

      # Déploiement en production APRÈS approbation
      - name: Deploy to Production
        run: |
          aws s3 sync dist/ s3://production-bucket/
          aws cloudfront create-invalidation --distribution-id ${{ secrets.PROD_CF_ID }}
```

**Workflow :**

```
1. Developer merges PR to main
        ↓
2. [AUTO] Build + Tests
        ↓
3. [AUTO] Deploy to Staging
        ↓
4. [AUTO] Run E2E tests on Staging
        ↓
5. 👤 Product Owner reviews on Staging
        ↓
6. 👤 Product Owner clicks "Approve" in GitHub
        ↓
7. [AUTO] Deploy to Production
```

**2. Automatisation Complète du Deployment Pipeline**

Tout est automatisé **sauf** la décision finale :

```
┌──────────────────────────────────────────────────┐
│  AUTOMATED                                       │
├──────────────────────────────────────────────────┤
│  ✅ Build                                        │
│  ✅ Test                                         │
│  ✅ Code quality checks                          │
│  ✅ Security scans                               │
│  ✅ Deploy to DEV                                │
│  ✅ Deploy to STAGING                            │
│  ✅ Smoke tests                                  │
│  ✅ Performance tests                            │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│  MANUAL GATE                                     │
├──────────────────────────────────────────────────┤
│  👤 Business approval                            │
│  👤 Timing decision                              │
│  👤 Go/No-Go decision                            │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│  AUTOMATED (after approval)                      │
├──────────────────────────────────────────────────┤
│  ✅ Deploy to PRODUCTION                         │
│  ✅ Health checks                                │
│  ✅ Rollback if needed                           │
└──────────────────────────────────────────────────┘
```

**3. Build Once, Deploy Many**

**Principe fondamental :** On **build une seule fois**, puis on **déploie le même artifact** partout.

```
┌─────────────────────────────────────────────────────────┐
│  BUILD ONCE, DEPLOY MANY                                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  [BUILD]                                                │
│  Source Code → Compile → app.v1.2.3.jar                 │
│                              ↓                          │
│                        [ARTIFACT]                       │
│                              ├───→ DEV                  │
│                              ├───→ QA                   │
│                              ├───→ STAGING              │
│                              └───→ PRODUCTION           │
│                                                         │
│  ✅ SAME BINARY everywhere                              │
│  ✅ ONLY CONFIG changes                                 │
└─────────────────────────────────────────────────────────┘
```

**Anti-Pattern (à éviter) :**

```
❌ WRONG: Rebuild in each environment
   Source → Build DEV → deploy DEV
   Source → Build STAGING → deploy STAGING
   Source → Build PROD → deploy PROD

   Problems:
   - Different binaries in each env
   - "Works in staging but not in prod"
   - Wasted build time
```

**Right Pattern :**

```
✅ RIGHT: Build once, promote artifact
   Source → Build ONCE → artifact v1.2.3
                           ↓
                      artifact registry
                           ↓
                   ┌───────┼───────┐
                   ↓       ↓       ↓
                  DEV   STAGING  PROD

   Benefits:
   ✅ Exact same binary tested and deployed
   ✅ Fast promotion (no rebuild)
   ✅ Confidence: "Tested in staging = will work in prod"
```

#### Quand Utiliser Continuous Delivery ?

**Continuous Delivery est adapté quand :**

✅ **Déploiements nécessitent coordination business**
- Release marketing (annonces, campagnes)
- Coordination avec partenaires
- Événements planifiés (Black Friday, etc.)

✅ **Réglementations strictes**
- Finance : approbations compliance
- Santé : validations réglementaires
- Secteurs régulés nécessitant audits

✅ **Équipes distribuées / fuseaux horaires**
- Déploiements pendant heures de bureau
- Support disponible en cas de problème

✅ **Applications legacy critiques**
- Migration progressive vers automation
- Besoin de validation manuelle finale

**Exemple Workflow Entreprise :**

```
Monday 9am:
  - Dev team merges features to main
  - [AUTO] CI/CD pipeline to staging
  - QA team tests on staging all day

Monday 5pm:
  - Product Owner reviews staging
  - Validates features meet requirements

Tuesday 10am:
  - [MANUAL] Product Owner approves production deployment
  - [AUTO] Deploy to production
  - [AUTO] Monitor metrics
  - Team on standby for issues
```

#### Exemples d'Entreprises Utilisant Continuous Delivery

**Secteur Finance :**
- **Goldman Sachs** : CD avec approbations réglementaires
- **PayPal** : Déploiements coordonnés, approbations multiples

**Secteur E-commerce :**
- **Amazon** : CD pour certains services critiques (mix avec Continuous Deployment)
- **Walmart** : Déploiements planifiés, évite heures de pointe

**Secteur Entreprise :**
- **Salesforce** : Releases majeures planifiées 3x/an
- **Microsoft** : Mix de CD et Continuous Deployment selon services

---

### Continuous Deployment : Automatisation Totale {#continuous-deployment}

#### Qu'est-ce que le Continuous Deployment ?

**Définition :**

> **Continuous Deployment is the practice of automatically deploying every change that passes all stages of the production pipeline to production, with no human intervention.**

**En français :**

Continuous Deployment est la pratique de déployer **automatiquement** en production **chaque changement** qui passe toutes les étapes du pipeline, **sans intervention humaine**.

```
┌─────────────────────────────────────────────────────────────┐
│  CONTINUOUS DEPLOYMENT PIPELINE                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Code Push                                                  │
│      ↓                                                      │
│  [AUTOMATED] Build                                          │
│      ↓                                                      │
│  [AUTOMATED] Unit Tests                                     │
│      ↓                                                      │
│  [AUTOMATED] Integration Tests                              │
│      ↓                                                      │
│  [AUTOMATED] Deploy to DEV                                  │
│      ↓                                                      │
│  [AUTOMATED] Deploy to STAGING                              │
│      ↓                                                      │
│  [AUTOMATED] Run E2E Tests on Staging                       │
│      ↓                                                      │
│  [AUTOMATED] Security Scans                                 │
│      ↓                                                      │
│  [AUTOMATED] Performance Tests                              │
│      ↓                                                      │
│  [AUTOMATED] ✅ All Checks Passed                           │
│      ↓                                                      │
│  [AUTOMATED] 🚀 DEPLOY TO PRODUCTION                        │
│      ↓                                                      │
│  [AUTOMATED] Health Checks                                  │
│      ↓                                                      │
│  [AUTOMATED] Monitor Metrics                                │
│      ↓                                                      │
│  [AUTOMATED] Auto-Rollback if Issues                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Point clé :** **ZÉRO INTERVENTION HUMAINE** entre le merge et la production.

#### Les Principes du Continuous Deployment

**1. Confiance Totale dans les Tests Automatisés**

Continuous Deployment nécessite une **couverture de tests exhaustive** :

```
Test Pyramid pour Continuous Deployment:

         /\
        /E2E\         ← 10% : End-to-End UI tests
       /──────\
      /  INT   \      ← 30% : Integration/API tests
     /──────────\
    /   UNIT     \    ← 60% : Unit tests (fast, isolated)
   /──────────────\

CRITICAL: High code coverage (>80%)
          Fast feedback (<10 min)
          Reliable (no flaky tests)
```

**Exemple de couverture nécessaire :**

```javascript
// Exemple de tests exhaustifs pour Continuous Deployment

// 1. UNIT TESTS (fast, isolated)
describe('UserService', () => {
  it('should create user with valid data', () => {
    const user = createUser({ email: 'test@example.com' });
    expect(user).toBeDefined();
    expect(user.email).toBe('test@example.com');
  });

  it('should throw error with invalid email', () => {
    expect(() => createUser({ email: 'invalid' }))
      .toThrow('Invalid email');
  });

  it('should hash password', () => {
    const user = createUser({ password: 'secret' });
    expect(user.password).not.toBe('secret');
    expect(user.password).toMatch(/^\$2[aby]\$/);
  });
});

// 2. INTEGRATION TESTS (with DB, APIs)
describe('User API Integration', () => {
  it('POST /users should create user in database', async () => {
    const response = await request(app)
      .post('/users')
      .send({ email: 'test@example.com', password: 'secret' });

    expect(response.status).toBe(201);

    const userInDb = await db.users.findOne({ email: 'test@example.com' });
    expect(userInDb).toBeDefined();
  });

  it('should not create duplicate users', async () => {
    await createUser({ email: 'test@example.com' });

    const response = await request(app)
      .post('/users')
      .send({ email: 'test@example.com', password: 'secret' });

    expect(response.status).toBe(409);
  });
});

// 3. E2E TESTS (full user journey)
describe('User Registration Flow', () => {
  it('should allow complete signup flow', async () => {
    await page.goto('/signup');
    await page.fill('[name=email]', 'test@example.com');
    await page.fill('[name=password]', 'SecureP@ss123');
    await page.click('button[type=submit]');

    await expect(page).toHaveURL('/dashboard');
    await expect(page.locator('.welcome-message'))
      .toContainText('Welcome');
  });
});
```

**2. Automated Quality Gates**

Chaque étape du pipeline est une **quality gate** automatisée :

```yaml
# Pipeline avec Quality Gates
name: Continuous Deployment

on:
  push:
    branches: [ main ]

jobs:
  quality-gates:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # GATE 1: Code Quality
      - name: Lint
        run: npm run lint

      - name: Type Check
        run: npm run type-check

      # GATE 2: Security
      - name: Security Scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      # GATE 3: Tests
      - name: Unit Tests
        run: npm run test:unit

      - name: Integration Tests
        run: npm run test:integration

      # GATE 4: Coverage
      - name: Coverage Check
        run: |
          npm run test:coverage
          # Fail if coverage < 80%
          npx nyc check-coverage --lines 80 --functions 80 --branches 80

  deploy-production:
    needs: quality-gates
    runs-on: ubuntu-latest
    steps:
      # ✅ All gates passed → AUTO DEPLOY
      - name: Deploy to Production
        run: |
          echo "🚀 Deploying to production..."
          ./deploy-production.sh

      # GATE 5: Health Checks
      - name: Verify Deployment
        run: |
          curl -f https://api.example.com/health || exit 1

      # GATE 6: Smoke Tests
      - name: Production Smoke Tests
        run: npm run test:smoke -- --env=production
```

**3. Automated Rollback**

Si un problème est détecté en production, **rollback automatique** :

```yaml
# Automated Rollback on Failure
- name: Deploy with Auto-Rollback
  id: deploy
  run: |
    # Deploy new version
    kubectl set image deployment/app app=myapp:${{ github.sha }}
    kubectl rollout status deployment/app --timeout=5m

- name: Health Check
  id: health
  run: |
    sleep 30
    curl -f https://api.example.com/health || exit 1

- name: Monitor Error Rate
  id: monitor
  run: |
    # Check error rate from monitoring
    ERROR_RATE=$(curl -s https://monitoring.example.com/api/error-rate)
    if (( $(echo "$ERROR_RATE > 1.0" | bc -l) )); then
      echo "❌ Error rate too high: $ERROR_RATE%"
      exit 1
    fi

- name: Auto Rollback on Failure
  if: failure()
  run: |
    echo "⚠️ Deployment failed, rolling back..."
    kubectl rollout undo deployment/app
    kubectl rollout status deployment/app
```

**4. Progressive Rollout (Canary)**

Déploiement progressif automatisé pour réduire les risques :

```
┌──────────────────────────────────────────────────┐
│  PROGRESSIVE ROLLOUT (Automated)                 │
├──────────────────────────────────────────────────┤
│                                                  │
│  1. Deploy to 5% of traffic                     │
│     Monitor for 10 minutes                      │
│     ✅ No errors → Continue                     │
│                                                  │
│  2. Deploy to 25% of traffic                    │
│     Monitor for 15 minutes                      │
│     ✅ No errors → Continue                     │
│                                                  │
│  3. Deploy to 50% of traffic                    │
│     Monitor for 20 minutes                      │
│     ✅ No errors → Continue                     │
│                                                  │
│  4. Deploy to 100% of traffic                   │
│     Mission complete 🎉                          │
│                                                  │
│  If ANY step fails:                             │
│     ⚠️ Auto-rollback to previous version        │
│                                                  │
└──────────────────────────────────────────────────┘
```

#### Exemples d'Entreprises Utilisant Continuous Deployment

**Netflix** : Le Champion du Continuous Deployment

```
NETFLIX DEPLOYMENT STATS (2024):
- 4,000 deployments per day
- 23% reduction in deployment failures (AI-powered)
- 31% faster build times
- Zero-downtime deployments
```

**Netflix Architecture :**
- **Spinnaker** : Orchestration des déploiements
- **AI/ML** : Prédiction des échecs, scoring de risque
- **Canary Analysis** : Monitoring automatisé
- **Chaos Engineering** : Tests de résilience continus

**Etsy** : 50 Déploiements/Jour

```
ETSY CONTINUOUS DEPLOYMENT:
- Up to 50 deploys/day
- Engineers deploy their own code
- Feature flags for gradual rollout
- Automated monitoring and rollback
```

**Facebook/Meta** : Continuous Deployment à Échelle Massive

```
META DEPLOYMENT:
- Thousands of deploys per day
- Multi-datacenter deployments
- Progressive rollout with gating
- Automated testing at scale (50,000+ tests)
```

**Autres Entreprises :**
- **Microsoft** (certains services Azure)
- **Atlassian** (Jira Cloud, Confluence)
- **IBM** (services cloud)
- **Adobe** (Creative Cloud services)
- **Tesla** (software updates)

#### Quand Utiliser Continuous Deployment ?

**Continuous Deployment est adapté quand :**

✅ **Produit SaaS / Web Apps**
- Contrôle total de l'infrastructure
- Mises à jour transparentes pour users
- Pas de contraintes de versioning

✅ **Culture DevOps mature**
- Équipe expérimentée
- Confiance dans les tests
- Monitoring robuste

✅ **Feedback rapide nécessaire**
- Startups en croissance
- A/B testing fréquent
- Itération rapide sur features

✅ **Pas de contraintes réglementaires fortes**
- Pas de validations manuelles obligatoires
- Flexibilité de déploiement

**Continuous Deployment N'EST PAS adapté quand :**

❌ **Applications mobiles**
- App Store review process
- Users ne mettent pas à jour immédiatement
- Fragmentation des versions

❌ **Software embarqué / IoT**
- Mise à jour risquée (bricking)
- Connectivité limitée
- Validation hardware nécessaire

❌ **Secteurs fortement régulés**
- Finance : validations compliance
- Santé : certifications médicales
- Aviation : safety critical systems

❌ **Applications desktop**
- Users contrôlent les mises à jour
- Compatibilité OS complexe

---

### Comparaison et Choix de la Bonne Approche {#comparaison-ci-cd}

#### Tableau Comparatif

| Critère | CI Only | Continuous Delivery | Continuous Deployment |
|---------|---------|---------------------|----------------------|
| **Automatisation** | Build + Test | Build + Test + Deploy (staging) | Build + Test + Deploy (production) |
| **Déploiement Production** | 100% Manuel | Manuel (avec 1-click) | 100% Automatique |
| **Fréquence Déploiements** | Hebdomadaire/Mensuel | Quotidien/Hebdomadaire | Multiple fois/jour |
| **Intervention Humaine** | Build + Deploy manuels | Approbation finale | Aucune |
| **Feedback Loop** | Hours to days | Minutes to hours | Minutes |
| **Risk per Deploy** | Haut (gros batch) | Moyen | Faible (petits changements) |
| **Complexité Setup** | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Coverage Tests Requis** | 40-60% | 60-80% | 80-95% |
| **Monitoring Requis** | Basic | Good | Excellent |
| **Team Maturity** | Junior-Mid | Mid-Senior | Senior/Expert |

#### Diagramme Visuel : CI vs CD vs Continuous Deployment

```
═══════════════════════════════════════════════════════════════════════════════
                  CONTINUOUS INTEGRATION (CI)
═══════════════════════════════════════════════════════════════════════════════

Developer → Commit → [AUTO] Build → [AUTO] Test → ✅ Green Build
                                                         ↓
                                                   [MANUAL] Deploy
                                                         ↓
                                                    Production

Automation Level: ████░░░░░░ 40%
Deploy Frequency: 1x/week to 1x/month

───────────────────────────────────────────────────────────────────────────────
                  CONTINUOUS DELIVERY (CD)
═══════════════════════════════════════════════════════════════════────════════

Developer → Commit → [AUTO] Build → [AUTO] Test → [AUTO] Deploy Dev
                                                         ↓
                                                   [AUTO] Deploy Staging
                                                         ↓
                                                   [AUTO] E2E Tests
                                                         ↓
                                                   [MANUAL] 👤 Approve
                                                         ↓
                                                   [AUTO] Deploy Prod
                                                         ↓
                                                    Production

Automation Level: ████████░░ 80%
Deploy Frequency: 1x/day to few times/week

───────────────────────────────────────────────────────────────────────────────
                  CONTINUOUS DEPLOYMENT
═══════════════════════════════════════════════════════════════════════════════

Developer → Commit → [AUTO] Build → [AUTO] Test → [AUTO] Deploy Dev
                                                         ↓
                                                   [AUTO] Deploy Staging
                                                         ↓
                                                   [AUTO] E2E Tests
                                                         ↓
                                                   [AUTO] Security Scan
                                                         ↓
                                                   [AUTO] ✅ Quality Gates
                                                         ↓
                                                   [AUTO] Deploy Prod
                                                         ↓
                                                   [AUTO] Health Checks
                                                         ↓
                                                   [AUTO] Monitor Metrics
                                                         ↓
                                                    Production
                                                         ↓
                                              [AUTO] Rollback if issues

Automation Level: ██████████ 100%
Deploy Frequency: Multiple times per day (10-100+)
```

#### Choix de l'Approche : Arbre de Décision

```
START: Choisir votre approche CI/CD
   |
   ├─ Q1: Avez-vous des tests automatisés ?
   |  ├─ NON → ⚠️ Commencez par implémenter CI + Tests
   |  └─ OUI → Continue ↓
   |
   ├─ Q2: Votre code est-il toujours en état déployable ?
   |  ├─ NON → ⚠️ Focus sur CI first (green builds)
   |  └─ OUI → Continue ↓
   |
   ├─ Q3: Type d'application ?
   |  ├─ Mobile App → ❌ Pas Continuous Deployment (App Store)
   |  ├─ Desktop → ❌ Pas Continuous Deployment
   |  ├─ Embedded/IoT → ❌ Pas Continuous Deployment
   |  └─ Web/SaaS → Continue ↓
   |
   ├─ Q4: Secteur régulé ? (Finance, Santé, Aéro)
   |  ├─ OUI → ✅ Continuous Delivery (approbations requises)
   |  └─ NON → Continue ↓
   |
   ├─ Q5: Coverage de tests ?
   |  ├─ < 60% → ✅ Continuous Delivery (pas assez de tests)
   |  ├─ 60-80% → ✅ Continuous Delivery ou Continuous Deployment
   |  └─ > 80% → Continue ↓
   |
   ├─ Q6: Maturité équipe DevOps ?
   |  ├─ Junior → ✅ Continuous Delivery
   |  ├─ Mid → ✅ Continuous Delivery ou Continuous Deployment
   |  └─ Senior → Continue ↓
   |
   ├─ Q7: Monitoring et observabilité robustes ?
   |  ├─ NON → ✅ Continuous Delivery (improve monitoring first)
   |  └─ OUI → Continue ↓
   |
   └─ Q8: Besoin de coordination business/marketing ?
      ├─ OUI → ✅ Continuous Delivery (timed releases)
      └─ NON → ✅ CONTINUOUS DEPLOYMENT 🚀
```

#### Migration Progressive

**Chemin recommandé pour atteindre Continuous Deployment :**

```
┌────────────────────────────────────────────────────────────┐
│  MATURITY MODEL: Path to Continuous Deployment            │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  LEVEL 1: Manual Everything (Week/Month deploys)          │
│  ────────────────────────────────────────────────          │
│  • Manual builds                                           │
│  • Manual tests                                            │
│  • Manual deployments                                      │
│  • No automation                                           │
│                                                            │
│           ↓ Add automated builds & tests                   │
│                                                            │
│  LEVEL 2: Continuous Integration (Daily integrations)     │
│  ────────────────────────────────────────────────          │
│  • ✅ Automated builds on commit                           │
│  • ✅ Automated unit tests                                 │
│  • ✅ Basic coverage (40-60%)                              │
│  • ⚠️ Manual deployments                                   │
│                                                            │
│           ↓ Add deployment automation                      │
│                                                            │
│  LEVEL 3: Continuous Delivery (Weekly deploys)            │
│  ────────────────────────────────────────────────          │
│  • ✅ Automated builds                                     │
│  • ✅ Automated tests (unit + integration)                 │
│  • ✅ Good coverage (60-80%)                               │
│  • ✅ Auto deploy to staging                               │
│  • ✅ One-click deploy to production                       │
│  • ⚠️ Manual approval for production                       │
│                                                            │
│           ↓ Remove manual gate + add monitoring            │
│                                                            │
│  LEVEL 4: Continuous Deployment (Multiple/day)            │
│  ────────────────────────────────────────────────          │
│  • ✅ Automated builds                                     │
│  • ✅ Comprehensive tests (unit + int + e2e)               │
│  • ✅ Excellent coverage (80-95%)                          │
│  • ✅ Auto deploy to staging                               │
│  • ✅ Auto deploy to production                            │
│  • ✅ Automated rollback                                   │
│  • ✅ Robust monitoring & alerting                         │
│  • ✅ Feature flags for gradual rollout                    │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

**Timeline typique :**
- **CI** → **Continuous Delivery** : 3-6 mois
- **Continuous Delivery** → **Continuous Deployment** : 6-12 mois
- Total : **1-2 ans** pour une équipe mature

---

## 2. Anatomie d'un Pipeline CI/CD {#anatomie-pipeline}

### Les Étapes Typiques d'un Pipeline {#etapes-pipeline}

Un pipeline CI/CD moderne suit généralement ce pattern :

```
┌────────────────────────────────────────────────────────────────────────┐
│  PIPELINE CI/CD COMPLET                                                │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  1️⃣  SOURCE                                                            │
│      ├─ Checkout code from Git                                         │
│      ├─ Fetch dependencies metadata                                    │
│      └─ Setup build environment                                        │
│                                                                        │
│  2️⃣  INSTALL                                                           │
│      ├─ Install dependencies (npm, pip, maven...)                      │
│      ├─ Cache dependencies for speed                                   │
│      └─ Verify dependency integrity                                    │
│                                                                        │
│  3️⃣  LINT & FORMAT                                                     │
│      ├─ Code style checks (ESLint, Prettier)                           │
│      ├─ Type checking (TypeScript, mypy)                               │
│      └─ Static analysis (SonarQube)                                    │
│                                                                        │
│  4️⃣  TEST                                                              │
│      ├─ Unit tests (fast, isolated)                                    │
│      ├─ Integration tests (with dependencies)                          │
│      ├─ Coverage reports                                               │
│      └─ Contract tests (API contracts)                                 │
│                                                                        │
│  5️⃣  SECURITY SCAN                                                     │
│      ├─ Dependency vulnerabilities (Snyk, Dependabot)                  │
│      ├─ SAST (Static Application Security Testing)                     │
│      ├─ Secrets detection (GitGuardian)                                │
│      └─ License compliance                                             │
│                                                                        │
│  6️⃣  BUILD                                                             │
│      ├─ Compile code (TypeScript, Java, Go...)                         │
│      ├─ Bundle assets (Webpack, Vite, Rollup)                          │
│      ├─ Optimize images, compress                                      │
│      └─ Create production artifact                                     │
│                                                                        │
│  7️⃣  PACKAGE                                                           │
│      ├─ Create Docker image                                            │
│      ├─ Tag with version                                               │
│      ├─ Sign artifact                                                  │
│      └─ Push to registry                                               │
│                                                                        │
│  8️⃣  DEPLOY (Environments)                                             │
│      ├─ DEV         → Auto deploy, latest code                         │
│      ├─ STAGING     → Auto deploy, pre-production testing              │
│      ├─ PRODUCTION  → Auto or manual, with approvals                   │
│      └─ Rollback capability at each stage                              │
│                                                                        │
│  9️⃣  VERIFY                                                            │
│      ├─ Smoke tests (basic functionality)                              │
│      ├─ E2E tests (full user journeys)                                 │
│      ├─ Performance tests (load, stress)                               │
│      └─ Health checks                                                  │
│                                                                        │
│  🔟 MONITOR                                                             │
│      ├─ Application metrics (errors, latency)                          │
│      ├─ Infrastructure metrics (CPU, memory)                           │
│      ├─ User analytics                                                 │
│      └─ Alerts & notifications                                         │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

#### Exemple Concret : Pipeline GitHub Actions

```yaml
# .github/workflows/complete-pipeline.yml
name: Complete CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  NODE_VERSION: '18'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  # ═══════════════════════════════════════════
  # 1️⃣ SOURCE + INSTALL + LINT
  # ═══════════════════════════════════════════
  quality:
    name: Code Quality Checks
    runs-on: ubuntu-latest

    steps:
      # Checkout code
      - name: 📥 Checkout
        uses: actions/checkout@v4

      # Setup Node.js
      - name: 🔧 Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      # Install dependencies
      - name: 📦 Install dependencies
        run: npm ci

      # Lint
      - name: 🔍 Lint code
        run: npm run lint

      # Type check
      - name: 🔍 Type check
        run: npm run type-check

      # Format check
      - name: 🔍 Format check
        run: npm run format:check

  # ═══════════════════════════════════════════
  # 4️⃣ TEST
  # ═══════════════════════════════════════════
  test:
    name: Run Tests
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node: [16, 18, 20]

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
          cache: 'npm'

      - run: npm ci

      # Unit tests
      - name: 🧪 Unit tests
        run: npm run test:unit

      # Integration tests
      - name: 🧪 Integration tests
        run: npm run test:integration

      # Coverage
      - name: 📊 Generate coverage
        run: npm run test:coverage

      - name: 📤 Upload coverage
        uses: codecov/codecov-action@v4
        with:
          file: ./coverage/coverage-final.json

  # ═══════════════════════════════════════════
  # 5️⃣ SECURITY SCAN
  # ═══════════════════════════════════════════
  security:
    name: Security Scan
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      # Dependency vulnerabilities
      - name: 🔒 Run Snyk Security Scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      # Secrets detection
      - name: 🔒 GitGuardian scan
        uses: GitGuardian/ggshield-action@v1
        env:
          GITGUARDIAN_API_KEY: ${{ secrets.GITGUARDIAN_API_KEY }}

  # ═══════════════════════════════════════════
  # 6️⃣ BUILD
  # ═══════════════════════════════════════════
  build:
    name: Build Application
    needs: [quality, test, security]
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - run: npm ci

      # Build production
      - name: 🏗️ Build production
        run: npm run build
        env:
          NODE_ENV: production

      # Upload artifact
      - name: 📤 Upload build artifact
        uses: actions/upload-artifact@v4
        with:
          name: production-build
          path: dist/
          retention-days: 30

  # ═══════════════════════════════════════════
  # 7️⃣ PACKAGE (Docker)
  # ═══════════════════════════════════════════
  docker:
    name: Build Docker Image
    needs: build
    runs-on: ubuntu-latest

    permissions:
      contents: read
      packages: write

    steps:
      - uses: actions/checkout@v4

      - name: 🐳 Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: 🔑 Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: 📦 Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha

      - name: 🏗️ Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # ═══════════════════════════════════════════
  # 8️⃣ DEPLOY - DEV
  # ═══════════════════════════════════════════
  deploy-dev:
    name: Deploy to Development
    needs: docker
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'

    environment:
      name: development
      url: https://dev.example.com

    steps:
      - name: 🚀 Deploy to Dev
        run: |
          echo "Deploying to development..."
          # Deploy script here

  # ═══════════════════════════════════════════
  # 8️⃣ DEPLOY - STAGING
  # ═══════════════════════════════════════════
  deploy-staging:
    name: Deploy to Staging
    needs: docker
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    environment:
      name: staging
      url: https://staging.example.com

    steps:
      - name: 🚀 Deploy to Staging
        run: |
          echo "Deploying to staging..."
          # Deploy script here

  # ═══════════════════════════════════════════
  # 9️⃣ VERIFY - E2E Tests
  # ═══════════════════════════════════════════
  e2e-tests:
    name: E2E Tests on Staging
    needs: deploy-staging
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: 🧪 Run E2E tests
        uses: cypress-io/github-action@v6
        with:
          config: baseUrl=https://staging.example.com

      - name: 📤 Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: cypress-videos
          path: cypress/videos

  # ═══════════════════════════════════════════
  # 8️⃣ DEPLOY - PRODUCTION
  # ═══════════════════════════════════════════
  deploy-production:
    name: Deploy to Production
    needs: e2e-tests
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    environment:
      name: production
      url: https://example.com

    steps:
      - name: 🚀 Deploy to Production
        run: |
          echo "Deploying to production..."
          # Deploy script here

      - name: ✅ Verify deployment
        run: |
          curl -f https://example.com/health || exit 1
```

---

### Jobs et Steps : Organisation du Travail {#jobs-steps}

#### Comprendre la Hiérarchie : Workflow → Job → Step → Action

```
┌─────────────────────────────────────────────────────────────┐
│  WORKFLOW (.github/workflows/ci.yml)                        │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  JOB 1: Build                                         │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │  STEP 1: Checkout code                          │  │  │
│  │  │    uses: actions/checkout@v4                    │  │  │
│  │  │           ↑                                      │  │  │
│  │  │         ACTION (reusable)                        │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │  STEP 2: Install dependencies                   │  │  │
│  │  │    run: npm ci                                  │  │  │
│  │  │         ↑                                        │  │  │
│  │  │      SCRIPT                                      │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  JOB 2: Test (runs in parallel with Build)           │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │  STEP 1: Run tests                              │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  JOB 3: Deploy (waits for Build + Test)              │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │  STEP 1: Deploy to production                   │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

#### Définitions

**Workflow** :
- Fichier YAML dans `.github/workflows/`
- Déclenché par des événements (push, PR, schedule...)
- Contient un ou plusieurs jobs

**Job** :
- Ensemble de steps exécutés sur le même runner
- Peut s'exécuter en parallèle avec d'autres jobs
- Peut dépendre d'autres jobs (`needs:`)

**Step** :
- Plus petite unité d'exécution
- Soit une **action** (réutilisable), soit un **script** (run:)
- S'exécute séquentiellement dans un job

**Action** :
- Composant réutilisable (du Marketplace ou custom)
- Utilisé avec `uses:`

---

### Parallélisation vs Séquentialité {#parallelisation}

#### Jobs en Parallèle (Default)

**Par défaut, les jobs s'exécutent en parallèle** :

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test

  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
```

**Exécution :**

```
Timeline:
0s ────────────────────────────────────────────────────→
   ├─ [lint]  ──────────────────✅ (30s)
   ├─ [test]  ────────────────────────────✅ (45s)
   └─ [build] ──────────────────────────────────✅ (50s)

Total time: 50s (slowest job)
```

**Avantage :** Speed! 3 jobs en 50s au lieu de 125s (30+45+50)

#### Jobs Séquentiels (avec `needs`)

**Utiliser `needs:` pour créer des dépendances** :

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: dist
          path: dist/

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test

  deploy:
    needs: [build, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: dist
      - run: ./deploy.sh
```

**Exécution :**

```
Timeline:
0s ────────────────────────────────────────────────────────────→
   [build]  ──────────────────✅
                              ↓
                          [test] ──────────────✅
                                                ↓
                                           [deploy] ──────✅

Total time: 50s + 45s + 20s = 115s
```

**Exemple : Pipeline Complexe**

```yaml
jobs:
  # Phase 1: Quality checks (parallel)
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run lint

  typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run type-check

  # Phase 2: Tests (after quality, parallel)
  unit-tests:
    needs: [lint, typecheck]
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:unit

  integration-tests:
    needs: [lint, typecheck]
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:integration

  # Phase 3: Build (after tests)
  build:
    needs: [unit-tests, integration-tests]
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

  # Phase 4: Deploy (after build)
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: ./deploy.sh
```

**Visualization :**

```
           ┌─────────┐
           │  START  │
           └────┬────┘
                │
        ┌───────┴───────┐
        │               │
   ┌────▼────┐    ┌────▼────┐
   │  lint   │    │typecheck│
   └────┬────┘    └────┬────┘
        │               │
        └───────┬───────┘
                │
        ┌───────┴───────┐
        │               │
   ┌────▼────┐    ┌────▼─────────┐
   │  unit   │    │ integration  │
   │  tests  │    │    tests     │
   └────┬────┘    └────┬─────────┘
        │               │
        └───────┬───────┘
                │
           ┌────▼────┐
           │  build  │
           └────┬────┘
                │
           ┌────▼────┐
           │ deploy  │
           └─────────┘
```

#### Matrix Strategy : Parallélisation Massive

**Tester sur plusieurs versions/OS en parallèle** :

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [16, 18, 20]

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: npm test
```

**Résultat : 9 jobs en parallèle !**

```
Matrix expansion:
├─ ubuntu-latest  + node 16  ──────✅
├─ ubuntu-latest  + node 18  ──────✅
├─ ubuntu-latest  + node 20  ──────✅
├─ windows-latest + node 16  ──────✅
├─ windows-latest + node 18  ──────✅
├─ windows-latest + node 20  ──────✅
├─ macos-latest   + node 16  ──────✅
├─ macos-latest   + node 18  ──────✅
└─ macos-latest   + node 20  ──────✅

Total: 9 jobs running in parallel
```

---

### Diagramme d'un Pipeline Complet {#diagramme-pipeline}

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                     COMPLETE CI/CD PIPELINE                               ║
╚═══════════════════════════════════════════════════════════════════════════╝

   GIT PUSH
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 1: CODE QUALITY (Parallel)                       [Duration: 2min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐                │
│  │   Lint   │  │TypeCheck │  │  Format  │  │  Audit   │                │
│  │ ESLint   │  │    tsc   │  │ Prettier │  │npm audit │                │
│  └────✅────┘  └────✅────┘  └────✅────┘  └────✅────┘                │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 2: SECURITY (Parallel)                           [Duration: 3min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │
│  │ Dependencies │  │     SAST     │  │   Secrets    │                  │
│  │  Snyk/Dep    │  │  SonarQube   │  │ GitGuardian  │                  │
│  └──────✅──────┘  └──────✅──────┘  └──────✅──────┘                  │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 3: TESTS (Parallel)                              [Duration: 5min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │
│  │  Unit Tests  │  │ Integration  │  │  Contract    │                  │
│  │   Jest       │  │    Tests     │  │   Tests      │                  │
│  │ (Coverage)   │  │  (with DB)   │  │   (Pact)     │                  │
│  └──────✅──────┘  └──────✅──────┘  └──────✅──────┘                  │
│                                                                          │
│  Matrix: Node 16, 18, 20 × Ubuntu, Windows, macOS = 9 jobs             │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 4: BUILD & PACKAGE                               [Duration: 4min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  1. Compile TypeScript → JavaScript                          │       │
│  │  2. Bundle with Webpack/Vite                                 │       │
│  │  3. Optimize assets (images, CSS)                            │       │
│  │  4. Create production build → dist/                          │       │
│  │  5. Build Docker image                                       │       │
│  │  6. Tag: myapp:sha-abc123, myapp:v1.2.3                      │       │
│  │  7. Push to GitHub Container Registry                        │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                ✅                                        │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 5: DEPLOY - DEV                                  [Duration: 1min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  [AUTO] Deploy to Development                                │       │
│  │         URL: https://dev.example.com                         │       │
│  │         Environment variables: DEV config                    │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                ✅                                        │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 6: DEPLOY - STAGING                              [Duration: 2min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  [AUTO] Deploy to Staging                                    │       │
│  │         URL: https://staging.example.com                     │       │
│  │         Environment variables: STAGING config                │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                ✅                                        │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 7: VERIFY STAGING                                [Duration: 8min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                  │
│  │ Smoke Tests  │  │  E2E Tests   │  │  Perf Tests  │                  │
│  │  (Health)    │  │  (Cypress)   │  │   (k6.io)    │                  │
│  └──────✅──────┘  └──────✅──────┘  └──────✅──────┘                  │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 8: APPROVE PRODUCTION                                            │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │                                                              │       │
│  │                  👤 MANUAL APPROVAL                          │       │
│  │                                                              │       │
│  │         Product Owner reviews staging                       │       │
│  │         Clicks "Approve deployment" in GitHub                │       │
│  │                                                              │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                                                          │
│  [Continuous Delivery] ← Manual gate here                               │
│  [Continuous Deployment] ← Skip manual gate, auto-deploy                │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 9: DEPLOY - PRODUCTION                           [Duration: 5min]│
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  [AUTO] Blue-Green Deployment                                │       │
│  │         1. Deploy to Green environment                       │       │
│  │         2. Run health checks                                 │       │
│  │         3. Switch traffic: Blue → Green                      │       │
│  │         4. Monitor metrics for 10 minutes                    │       │
│  │         5. Keep Blue standby for rollback                    │       │
│  │                                                              │       │
│  │         URL: https://example.com                             │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                ✅                                        │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 10: MONITOR & VERIFY                                             │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────────────┐       │
│  │  • Health endpoint checks every 30s                          │       │
│  │  • Monitor error rate (< 1%)                                 │       │
│  │  • Monitor latency (p95 < 500ms)                             │       │
│  │  • Monitor CPU/Memory usage                                  │       │
│  │  • Alert if thresholds exceeded                              │       │
│  │  • Auto-rollback if critical issues                          │       │
│  └──────────────────────────────────────────────────────────────┘       │
│                                                                          │
│  Tools: Datadog, Grafana, Prometheus, Sentry                            │
└─────────────────────────────────────────────────────────────────────────┘
      │
      ▼
   ✅ SUCCESS

Total Pipeline Duration:
- Fast path (no manual approval): ~22 minutes
- With manual approval: Depends on review time
```

---

## 3. Build Artifacts Expliqués {#build-artifacts}

### Qu'est-ce qu'un Artifact ? {#definition-artifact}

**Définition :**

Un **artifact** (artefact en français) est le **résultat tangible** du processus de build. C'est le fichier ou ensemble de fichiers **déployable** qui contient votre application compilée et prête à être exécutée.

```
┌────────────────────────────────────────────────────────┐
│  SOURCE CODE → BUILD PROCESS → ARTIFACT                │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Input:                                                │
│  ├─ src/                                               │
│  ├─ package.json                                       │
│  ├─ tsconfig.json                                      │
│  └─ ...                                                │
│                                                        │
│       ↓ npm run build                                  │
│                                                        │
│  Output (Artifact):                                    │
│  ├─ dist/                                              │
│  │  ├─ index.js        (compiled, bundled)            │
│  │  ├─ styles.css      (minified)                     │
│  │  └─ assets/         (optimized images)             │
│  └─ artifact.tar.gz     (packaged)                     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

**Caractéristiques d'un Artifact :**

✅ **Immutable** : Une fois créé, ne change jamais
✅ **Versionné** : Tagged avec version (v1.2.3, sha-abc123)
✅ **Déployable** : Prêt à être exécuté sans modification
✅ **Reproductible** : Même code source = même artifact
✅ **Stocké** : Conservé dans un artifact repository

---

### Types d'Artifacts {#types-artifacts}

#### 1. JAR Files (Java)

```bash
# Build process
mvn clean package

# Artifact produced
target/myapp-1.2.3.jar

# Deployment
java -jar myapp-1.2.3.jar
```

**Contenu d'un JAR :**
- `.class` files (compiled bytecode)
- Resources (properties, XML, etc.)
- Dependencies (in fat JAR)
- META-INF/MANIFEST.MF

#### 2. Docker Images

```dockerfile
# Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY dist/ ./dist/
CMD ["node", "dist/index.js"]

# Build
docker build -t myapp:1.2.3 .

# Artifact
# Image ID: sha256:abc123...
# Size: 150MB
# Layers: 8

# Deployment
docker run -p 3000:3000 myapp:1.2.3
```

**Avantages Docker Images :**
- ✅ Contient app + runtime + dépendances
- ✅ Portable (même image partout)
- ✅ Isolé (containerization)
- ✅ Versionné via tags

#### 3. npm Packages

```bash
# Build
npm run build  # TypeScript → JavaScript

# Package
npm pack  # Creates mypackage-1.2.3.tgz

# Publish to registry
npm publish

# Artifact structure
mypackage-1.2.3.tgz
├─ package.json
├─ dist/
│  ├─ index.js
│  ├─ index.d.ts  (TypeScript definitions)
│  └─ ...
└─ README.md
```

#### 4. Binary Executables (Go, Rust, C++)

```bash
# Go build
go build -o myapp-linux-amd64 main.go
go build -o myapp-darwin-arm64 main.go
go build -o myapp-windows-amd64.exe main.go

# Artifacts
myapp-linux-amd64      # 8.5 MB
myapp-darwin-arm64     # 8.3 MB
myapp-windows-amd64.exe # 8.7 MB

# Deployment
chmod +x myapp-linux-amd64
./myapp-linux-amd64
```

#### 5. Static Web Assets

```bash
# Build
npm run build  # Vite/Webpack/Next.js

# Artifact (dist folder)
dist/
├─ index.html
├─ assets/
│  ├─ index-abc123.js      # Bundled JS with hash
│  ├─ index-def456.css     # Bundled CSS with hash
│  └─ logo-789xyz.png      # Optimized images
└─ favicon.ico

# Deployment (to CDN)
aws s3 sync dist/ s3://mybucket/
```

**Content hashing :**
```
index-[contenthash].js
      └─ abc123 (hash of file content)

If content changes → new hash → new filename
→ Cache busting automatique
```

#### 6. Python Wheels

```bash
# Build
python setup.py bdist_wheel

# Artifact
dist/mypackage-1.2.3-py3-none-any.whl

# Publish
twine upload dist/*

# Install
pip install mypackage==1.2.3
```

#### Comparaison des Types d'Artifacts

| Type | Size | Portability | Deploy Speed | Use Case |
|------|------|-------------|--------------|----------|
| **JAR** | 20-50MB | ☁️ Needs JVM | Fast | Java apps |
| **Docker Image** | 100-500MB | ✅ Excellent | Medium | Microservices |
| **npm Package** | 1-10MB | ✅ Node.js | Very Fast | Libraries, CLIs |
| **Binary** | 5-20MB | ⚠️ OS-specific | Very Fast | CLIs, services |
| **Static Assets** | 1-50MB | ✅ Excellent | Very Fast | SPAs, websites |
| **Python Wheel** | 1-10MB | ✅ Python | Fast | Libraries, apps |

---

### Stockage et Versioning {#stockage-versioning}

#### Artifact Repositories

**Pourquoi un Artifact Repository ?**

```
❌ WITHOUT ARTIFACT REPOSITORY:
   - Artifacts stockés localement
   - Pas de version history
   - Difficile de rollback
   - Pas de traçabilité

✅ WITH ARTIFACT REPOSITORY:
   - Stockage centralisé
   - Version history complète
   - Rollback facile (deploy v1.2.2)
   - Traçabilité: qui a build quoi, quand
   - Scanning de sécurité
   - Access control
```

#### Solutions d'Artifact Repository

**1. JFrog Artifactory**

```yaml
# Artifactory structure
artifactory/
├─ docker-local/
│  └─ myapp/
│     ├─ 1.0.0/
│     ├─ 1.1.0/
│     └─ 1.2.3/
├─ npm-local/
│  └─ @myorg/mypackage/
│     ├─ 1.0.0.tgz
│     ├─ 1.1.0.tgz
│     └─ 1.2.3.tgz
└─ maven-local/
   └─ com/example/myapp/
      ├─ 1.0.0/myapp-1.0.0.jar
      └─ 1.2.3/myapp-1.2.3.jar
```

**Features :**
- ✅ Multi-format (Docker, npm, Maven, PyPI, etc.)
- ✅ Build info metadata
- ✅ Promotion entre repositories
- ✅ Security scanning (Xray)
- ✅ Access control (RBAC)
- ✅ High availability

**2. Sonatype Nexus**

```yaml
# Nexus repositories
nexus/
├─ docker-hosted/
├─ docker-proxy/ (cache DockerHub)
├─ npm-hosted/
├─ npm-proxy/ (cache npmjs.org)
├─ maven-releases/
└─ maven-snapshots/
```

**Features :**
- ✅ 30+ package formats
- ✅ Repository proxying (cache)
- ✅ Cleanup policies
- ✅ Security vulnerability detection
- ✅ Cost-effective
- ✅ Fine-grained access control

**3. GitHub Packages**

```yaml
# .github/workflows/publish.yml
- name: Publish to GitHub Packages
  run: |
    echo "@myorg:registry=https://npm.pkg.github.com" > .npmrc
    npm publish

# Access
npm install @myorg/mypackage
```

**GitHub Container Registry (GHCR) :**

```bash
# Push Docker image
docker build -t ghcr.io/myorg/myapp:1.2.3 .
echo ${{ secrets.GITHUB_TOKEN }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
docker push ghcr.io/myorg/myapp:1.2.3

# Pull
docker pull ghcr.io/myorg/myapp:1.2.3
```

**4. Cloud-Native Solutions**

- **AWS ECR** (Elastic Container Registry) : Docker images
- **AWS S3** : Generic artifacts
- **Azure Container Registry**
- **Google Artifact Registry**

#### Semantic Versioning

**Artifacts doivent suivre Semantic Versioning (SemVer) :**

```
VERSION = MAJOR.MINOR.PATCH

Example: 1.2.3
         │ │ │
         │ │ └─ PATCH: Bug fixes (backward compatible)
         │ └─── MINOR: New features (backward compatible)
         └───── MAJOR: Breaking changes

1.0.0 → Initial release
1.1.0 → Add new feature (compatible)
1.1.1 → Bug fix (compatible)
1.2.0 → Add another feature (compatible)
2.0.0 → Breaking change (incompatible API)
```

**Pre-release versions :**

```
1.2.3-alpha.1   # Alpha release
1.2.3-beta.2    # Beta release
1.2.3-rc.1      # Release candidate
```

**Build metadata :**

```
1.2.3+build.123      # Build number
1.2.3+sha.abc123     # Git commit SHA
1.2.3+20250105       # Date
```

#### Tagging Strategy

**Docker Image Tagging :**

```bash
# Multiple tags for same image
docker tag myapp:build-123 myapp:1.2.3
docker tag myapp:build-123 myapp:1.2
docker tag myapp:build-123 myapp:1
docker tag myapp:build-123 myapp:latest

# Push all tags
docker push myapp:1.2.3
docker push myapp:1.2
docker push myapp:1
docker push myapp:latest
```

**Tag strategy :**

```
myapp:1.2.3        ← Specific version (immutable)
myapp:1.2          ← Minor version (updated with patches)
myapp:1            ← Major version (updated with minors)
myapp:latest       ← Latest stable (updated with releases)
myapp:main         ← Latest from main branch
myapp:sha-abc123   ← Git commit SHA
```

---

### Promotion d'Artifacts entre Environnements {#promotion-artifacts}

#### Principe : Build Once, Deploy Many

**CORE PRINCIPLE** : Build une seule fois, promote le même artifact.

```
┌─────────────────────────────────────────────────────────────┐
│  ARTIFACT PROMOTION FLOW                                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  [BUILD]                                                    │
│  Source Code → Build → myapp:1.2.3                          │
│                            │                                │
│                            ↓                                │
│                    [ARTIFACT REGISTRY]                      │
│                            │                                │
│                ┌───────────┼───────────┐                    │
│                │           │           │                    │
│                ↓           ↓           ↓                    │
│            [DEV]       [STAGING]    [PROD]                  │
│                                                             │
│  ✅ SAME binary deployed everywhere                         │
│  ✅ ONLY config/env vars change                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Pourquoi c'est important ?**

```
❌ ANTI-PATTERN: Rebuild in each environment

   main → [BUILD DEV] → myapp-dev.jar → Deploy DEV
   main → [BUILD STAGING] → myapp-staging.jar → Deploy STAGING
   main → [BUILD PROD] → myapp-prod.jar → Deploy PROD

   Problems:
   - Different binaries (compiler version, dependencies, etc.)
   - "Works in staging but not in prod" syndrome
   - Wasted build time (3x builds)
   - Can't rollback reliably

✅ PATTERN: Build once, promote

   main → [BUILD ONCE] → myapp-1.2.3.jar
                            ↓
                     [ARTIFACT REGISTRY]
                            ↓
                   ┌────────┼────────┐
                   ↓        ↓        ↓
                 DEV    STAGING    PROD

   Benefits:
   ✅ Exact same binary tested and deployed
   ✅ Fast promotion (no rebuild)
   ✅ Confident: "Tested in staging = will work in prod"
   ✅ Easy rollback (redeploy previous version)
```

#### Workflow de Promotion

**Exemple GitHub Actions :**

```yaml
name: Build and Promote Artifact

on:
  push:
    branches: [ main ]

jobs:
  # 1️⃣ BUILD (once)
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}

    steps:
      - uses: actions/checkout@v4

      # Generate version
      - name: Generate version
        id: version
        run: |
          VERSION="1.2.${{ github.run_number }}"
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      # Build
      - run: npm ci
      - run: npm run build

      # Build Docker image
      - name: Build Docker image
        run: |
          docker build -t myapp:${{ steps.version.outputs.version }} .
          docker tag myapp:${{ steps.version.outputs.version }} \
                     ghcr.io/myorg/myapp:${{ steps.version.outputs.version }}

      # Push to registry
      - name: Push to GHCR
        run: |
          echo ${{ secrets.GITHUB_TOKEN }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
          docker push ghcr.io/myorg/myapp:${{ steps.version.outputs.version }}

  # 2️⃣ PROMOTE to DEV
  deploy-dev:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.example.com

    steps:
      - name: Deploy to DEV
        env:
          VERSION: ${{ needs.build.outputs.version }}
        run: |
          # Pull artifact from registry
          docker pull ghcr.io/myorg/myapp:$VERSION

          # Deploy (same artifact!)
          kubectl set image deployment/myapp \
            myapp=ghcr.io/myorg/myapp:$VERSION \
            --namespace=dev

  # 3️⃣ PROMOTE to STAGING
  deploy-staging:
    needs: [build, deploy-dev]
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.example.com

    steps:
      - name: Deploy to STAGING
        env:
          VERSION: ${{ needs.build.outputs.version }}
        run: |
          # Pull SAME artifact
          docker pull ghcr.io/myorg/myapp:$VERSION

          # Deploy (same artifact!)
          kubectl set image deployment/myapp \
            myapp=ghcr.io/myorg/myapp:$VERSION \
            --namespace=staging

  # 4️⃣ PROMOTE to PRODUCTION
  deploy-production:
    needs: [build, deploy-staging]
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://example.com

    steps:
      - name: Deploy to PRODUCTION
        env:
          VERSION: ${{ needs.build.outputs.version }}
        run: |
          # Pull SAME artifact
          docker pull ghcr.io/myorg/myapp:$VERSION

          # Deploy (same artifact!)
          kubectl set image deployment/myapp \
            myapp=ghcr.io/myorg/myapp:$VERSION \
            --namespace=production
```

#### Configuration Management

**Artifacts = code, Config = environment-specific**

```
┌──────────────────────────────────────────────────────────┐
│  ARTIFACT (Same everywhere)                              │
├──────────────────────────────────────────────────────────┤
│  myapp:1.2.3                                             │
│  └─ Application code (immutable)                         │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│  CONFIG (Different per environment)                      │
├──────────────────────────────────────────────────────────┤
│  DEV:                                                    │
│  ├─ DATABASE_URL=dev-db.example.com                      │
│  ├─ API_KEY=dev_key_123                                  │
│  └─ LOG_LEVEL=debug                                      │
│                                                          │
│  STAGING:                                                │
│  ├─ DATABASE_URL=staging-db.example.com                  │
│  ├─ API_KEY=staging_key_456                              │
│  └─ LOG_LEVEL=info                                       │
│                                                          │
│  PRODUCTION:                                             │
│  ├─ DATABASE_URL=prod-db.example.com                     │
│  ├─ API_KEY=prod_key_789                                 │
│  └─ LOG_LEVEL=warn                                       │
└──────────────────────────────────────────────────────────┘
```

**12-Factor App : Config in Environment Variables**

```javascript
// Application code (in artifact)
const config = {
  database: process.env.DATABASE_URL,
  apiKey: process.env.API_KEY,
  logLevel: process.env.LOG_LEVEL || 'info'
};

// DEV deployment
docker run -e DATABASE_URL=dev-db.example.com \
           -e API_KEY=dev_key_123 \
           -e LOG_LEVEL=debug \
           myapp:1.2.3

// PROD deployment (SAME IMAGE!)
docker run -e DATABASE_URL=prod-db.example.com \
           -e API_KEY=prod_key_789 \
           -e LOG_LEVEL=warn \
           myapp:1.2.3
```

#### Artifact Metadata et Traçabilité

**Build Info :**

```json
{
  "artifact": "myapp:1.2.3",
  "build": {
    "number": "123",
    "timestamp": "2025-01-05T10:30:00Z",
    "git": {
      "commit": "abc123def456",
      "branch": "main",
      "author": "developer@example.com"
    }
  },
  "tests": {
    "unit": "1,234 passed",
    "integration": "56 passed",
    "coverage": "87%"
  },
  "security": {
    "vulnerabilities": "0 high, 2 medium",
    "scanned": true
  },
  "promoted_to": [
    {
      "environment": "dev",
      "timestamp": "2025-01-05T10:35:00Z"
    },
    {
      "environment": "staging",
      "timestamp": "2025-01-05T11:00:00Z"
    },
    {
      "environment": "production",
      "timestamp": "2025-01-05T14:00:00Z",
      "approved_by": "product-owner@example.com"
    }
  ]
}
```

---

## 4. Environnements de Déploiement {#environnements}

### Development, Staging, Production {#dev-staging-prod}

#### L'Architecture 3-Tier Classique

```
┌────────────────────────────────────────────────────────────────────────┐
│  CLASSIC 3-TIER DEPLOYMENT ENVIRONMENTS                                │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  1️⃣  DEVELOPMENT (DEV)                                                 │
│  ────────────────────────────────────────────────────────────         │
│  Purpose:        Active development and feature testing                │
│  Stability:      Low (frequently broken)                               │
│  Data:           Fake/test data                                        │
│  Deploy:         Automatic on every commit to develop branch           │
│  Access:         Developers only                                       │
│  Infrastructure: Minimal (single server, shared DB)                    │
│  Monitoring:     Basic logs                                            │
│                                                                        │
│  URL: https://dev.example.com                                          │
│  Deployed: 20+ times/day                                               │
│                                                                        │
│  ─────────────────────────────────────────────────────────────────    │
│                                                                        │
│  2️⃣  STAGING (QA/PRE-PROD)                                             │
│  ────────────────────────────────────────────────────────────         │
│  Purpose:        Pre-production validation and QA testing              │
│  Stability:      Medium-High (mostly stable)                           │
│  Data:           Production-like data (anonymized)                     │
│  Deploy:         Automatic after main branch merge                     │
│  Access:         Developers, QA, Product Owners                        │
│  Infrastructure: Production-like (scaled down)                         │
│  Monitoring:     Full monitoring + alerting                            │
│                                                                        │
│  URL: https://staging.example.com                                      │
│  Deployed: 5-10 times/day                                              │
│                                                                        │
│  Tests:                                                                │
│  ✅ E2E tests (Cypress, Playwright)                                    │
│  ✅ Performance tests (k6, JMeter)                                     │
│  ✅ Security scans (DAST)                                              │
│  ✅ Manual QA testing                                                  │
│                                                                        │
│  ─────────────────────────────────────────────────────────────────    │
│                                                                        │
│  3️⃣  PRODUCTION (PROD)                                                 │
│  ────────────────────────────────────────────────────────────         │
│  Purpose:        Live environment serving real users                   │
│  Stability:      Very High (always stable)                             │
│  Data:           Real user data                                        │
│  Deploy:         Manual approval OR automatic (CD)                     │
│  Access:         All users                                             │
│  Infrastructure: Full production scale (load balancers, replicas)      │
│  Monitoring:     Complete observability + on-call alerts               │
│                                                                        │
│  URL: https://example.com                                              │
│  Deployed: 1-10 times/day (depending on CD maturity)                   │
│                                                                        │
│  Requirements:                                                         │
│  ✅ Zero downtime deployments                                          │
│  ✅ Rollback capability                                                │
│  ✅ Blue-Green or Canary deployment                                    │
│  ✅ Full monitoring and observability                                  │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

#### Configuration par Environnement

**Exemple : Node.js Application**

```javascript
// config/environments.js
const environments = {
  development: {
    api: {
      baseUrl: 'https://api-dev.example.com',
      timeout: 30000,
      debug: true
    },
    database: {
      host: 'dev-db.example.com',
      name: 'myapp_dev',
      poolSize: 5
    },
    cache: {
      enabled: false
    },
    logging: {
      level: 'debug',
      pretty: true
    },
    features: {
      newFeatureX: true,  // Enable experimental features
      betaFeatureY: true
    }
  },

  staging: {
    api: {
      baseUrl: 'https://api-staging.example.com',
      timeout: 10000,
      debug: false
    },
    database: {
      host: 'staging-db.example.com',
      name: 'myapp_staging',
      poolSize: 10
    },
    cache: {
      enabled: true,
      ttl: 300
    },
    logging: {
      level: 'info',
      pretty: false
    },
    features: {
      newFeatureX: true,  // Test in staging before prod
      betaFeatureY: false
    }
  },

  production: {
    api: {
      baseUrl: 'https://api.example.com',
      timeout: 5000,
      debug: false
    },
    database: {
      host: 'prod-db-cluster.example.com',
      name: 'myapp_production',
      poolSize: 50,
      replication: {
        enabled: true,
        readReplicas: 3
      }
    },
    cache: {
      enabled: true,
      ttl: 3600,
      redis: {
        cluster: true,
        nodes: ['redis-1', 'redis-2', 'redis-3']
      }
    },
    logging: {
      level: 'warn',
      pretty: false,
      datadog: {
        enabled: true,
        apiKey: process.env.DATADOG_API_KEY
      }
    },
    features: {
      newFeatureX: false,  // Disabled in prod (not ready)
      betaFeatureY: false
    }
  }
};

// Load config based on NODE_ENV
const env = process.env.NODE_ENV || 'development';
module.exports = environments[env];
```

#### Infrastructure as Code : Terraform

```hcl
# terraform/environments/dev/main.tf
module "app" {
  source = "../../modules/app"

  environment = "dev"
  instance_count = 1
  instance_type = "t3.small"

  database = {
    instance_class = "db.t3.micro"
    allocated_storage = 20
    multi_az = false
  }

  autoscaling = {
    min_size = 1
    max_size = 2
  }
}

# terraform/environments/staging/main.tf
module "app" {
  source = "../../modules/app"

  environment = "staging"
  instance_count = 2
  instance_type = "t3.medium"

  database = {
    instance_class = "db.t3.small"
    allocated_storage = 100
    multi_az = true
  }

  autoscaling = {
    min_size = 2
    max_size = 5
  }
}

# terraform/environments/production/main.tf
module "app" {
  source = "../../modules/app"

  environment = "production"
  instance_count = 5
  instance_type = "t3.large"

  database = {
    instance_class = "db.r5.xlarge"
    allocated_storage = 500
    multi_az = true
    read_replicas = 3
  }

  autoscaling = {
    min_size = 5
    max_size = 20
  }

  cdn = {
    enabled = true
    price_class = "PriceClass_All"
  }
}
```

---

### Preview Environments (Vercel, Netlify) {#preview-environments}

#### Qu'est-ce qu'un Preview Environment ?

**Definition :**

Un **Preview Environment** (ou **Deploy Preview**) est un environnement éphémère créé automatiquement pour **chaque Pull Request**. Il permet de tester les changements dans un environnement isolé avant de merger.

```
┌────────────────────────────────────────────────────────────────────┐
│  PREVIEW ENVIRONMENTS WORKFLOW                                     │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  Developer creates PR #123                                         │
│      ↓                                                             │
│  [AUTO] Preview Deploy Triggered                                   │
│      ↓                                                             │
│  Build app → Deploy to preview URL                                 │
│      ↓                                                             │
│  https://pr-123-myapp.vercel.app                                   │
│      ↓                                                             │
│  Comment on PR with URL                                            │
│  ┌──────────────────────────────────────────────┐                 │
│  │ 🚀 Preview deployed!                         │                 │
│  │ ✅ Build successful                          │                 │
│  │ 🔗 https://pr-123-myapp.vercel.app            │                 │
│  │                                              │                 │
│  │ Test your changes before merging!            │                 │
│  └──────────────────────────────────────────────┘                 │
│      ↓                                                             │
│  Team reviews changes on preview URL                               │
│      ↓                                                             │
│  PR merged → Preview environment deleted                           │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

#### Vercel Preview Deployments

**Configuration automatique :**

```bash
# Vercel détecte automatiquement le framework
# Pas de config nécessaire pour Next.js, Vite, etc.

# vercel.json (optional customization)
{
  "git": {
    "deploymentEnabled": {
      "main": true,
      "develop": true
    }
  },
  "github": {
    "enabled": true,
    "autoAlias": true,
    "silent": false,
    "autoJobCancelation": true
  },
  "buildCommand": "npm run build",
  "outputDirectory": "dist"
}
```

**Workflow Vercel :**

```
PR opened/updated
      ↓
[AUTO] Vercel Build
      ├─ Install dependencies
      ├─ Run build
      ├─ Optimize assets
      └─ Deploy to Edge Network
      ↓
Preview URL generated
      https://myapp-git-feature-branch-username.vercel.app
      ↓
Comment posted on PR
      ✅ Deployed to Vercel
      🔗 Preview: https://myapp-git-feature-branch...
      📊 Build time: 45s
      📦 Size: 1.2 MB
```

**Custom Environments :**

```javascript
// vercel.json - Custom environments
{
  "env": {
    "API_URL": "https://api.example.com",
    "ANALYTICS_ID": "UA-12345"
  },
  "build": {
    "env": {
      "NEXT_PUBLIC_ENV": "preview"
    }
  }
}
```

**Vercel Features :**
- ✅ **Automatic HTTPS** : Every preview has SSL
- ✅ **Edge Network** : Global CDN distribution
- ✅ **Environment Variables** : Preview-specific vars
- ✅ **Custom Domains** : Can map to staging subdomain
- ✅ **Concurrent Builds** : Multiple PRs → Multiple previews
- ✅ **Auto-cleanup** : Deleted after PR merged/closed

#### Netlify Deploy Previews

**Configuration :**

```toml
# netlify.toml
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"
  NPM_VERSION = "9"

# Deploy contexts
[context.production]
  command = "npm run build:production"

[context.deploy-preview]
  command = "npm run build:preview"

[context.branch-deploy]
  command = "npm run build:branch"

# Redirect rules for SPA
[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

**Netlify Features :**
- ✅ **Deploy Previews** : Automatic for every PR
- ✅ **Branch Deploys** : Auto-deploy non-main branches
- ✅ **Split Testing** : A/B test between branches
- ✅ **Forms** : Built-in form handling
- ✅ **Functions** : Serverless functions support
- ✅ **Analytics** : Built-in analytics

**Workflow Example :**

```yaml
# .github/workflows/netlify.yml
name: Netlify Deploy Preview

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  deploy-preview:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: '18'

      - run: npm ci
      - run: npm run build

      - name: Deploy to Netlify
        uses: netlify/actions/cli@master
        with:
          args: deploy --dir=dist --message="PR #${{ github.event.pull_request.number }}"
        env:
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
```

#### Comparaison Preview Environments

| Feature | Vercel | Netlify | GitHub Pages | Cloudflare Pages |
|---------|--------|---------|--------------|------------------|
| **Auto Deploy PRs** | ✅ | ✅ | ❌ | ✅ |
| **Custom Domains** | ✅ | ✅ | ✅ | ✅ |
| **HTTPS** | ✅ Auto | ✅ Auto | ✅ Auto | ✅ Auto |
| **Serverless Functions** | ✅ | ✅ | ❌ | ✅ |
| **Edge Network** | ✅ Global | ✅ Global | ❌ | ✅ 275+ cities |
| **Build Minutes (Free)** | 6,000/mo | 300/mo | Unlimited | 500/mo |
| **Team Collaboration** | ✅ | ✅ | Limited | ✅ |
| **Environment Variables** | ✅ | ✅ | ❌ | ✅ |
| **Analytics** | ✅ Paid | ✅ Built-in | ❌ | ✅ Free |
| **A/B Testing** | ❌ | ✅ | ❌ | ❌ |

---

### Stratégies de Déploiement Avancées {#strategies-deployment}

#### 1. Blue-Green Deployment

**Concept :**

Deux environnements de production identiques : **Blue** (actif) et **Green** (idle). On déploie la nouvelle version sur Green, puis on switch le traffic instantanément.

```
┌─────────────────────────────────────────────────────────────────────┐
│  BLUE-GREEN DEPLOYMENT                                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  STEP 1: Initial State                                              │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┐                                     │
│                │              │                                     │
│         [BLUE v1.0]      [GREEN idle]                               │
│         100% traffic      0% traffic                                │
│         3 instances       0 instances                               │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 2: Deploy to Green                                            │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┬──────────────┐                      │
│                │              │              │                      │
│         [BLUE v1.0]      [GREEN v1.1] ← Deploying                   │
│         100% traffic      0% traffic                                │
│         3 instances       3 instances (new version)                 │
│                                                                     │
│         Serving users     Testing new version                       │
│                           - Health checks                           │
│                           - Smoke tests                             │
│                           - Validation                              │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 3: Switch Traffic (Instant)                                   │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┬──────────────┐                      │
│                │              │              │                      │
│         [BLUE v1.0]      [GREEN v1.1] ← NOW ACTIVE                  │
│         0% traffic        100% traffic                              │
│         3 instances       3 instances                               │
│         (standby)         (serving users)                           │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 4: Monitor & Rollback Ready                                   │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│  GREEN v1.1 serving traffic                                         │
│  ├─ Monitor error rate                                              │
│  ├─ Monitor latency                                                 │
│  └─ Monitor user complaints                                         │
│                                                                     │
│  If issues detected:                                                │
│  → Switch back to BLUE v1.0 (instant rollback)                      │
│                                                                     │
│  If stable (24h+):                                                  │
│  → Decommission BLUE                                                │
│  → GREEN becomes new BLUE                                           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Exemple Kubernetes :**

```yaml
# blue-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-blue
  labels:
    app: myapp
    version: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: myapp
        image: myapp:1.0.0
        ports:
        - containerPort: 3000

---
# green-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-green
  labels:
    app: myapp
    version: green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: green
  template:
    metadata:
      labels:
        app: myapp
        version: green
    spec:
      containers:
      - name: myapp
        image: myapp:1.1.0  # NEW VERSION
        ports:
        - containerPort: 3000

---
# service.yaml - Switch traffic by changing selector
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp
    version: blue  # Change to "green" to switch traffic
  ports:
  - port: 80
    targetPort: 3000
```

**Script de déploiement :**

```bash
#!/bin/bash
# blue-green-deploy.sh

echo "🚀 Starting Blue-Green Deployment"

# 1. Deploy Green
kubectl apply -f green-deployment.yaml
echo "✅ Green deployment created"

# 2. Wait for Green to be ready
kubectl rollout status deployment/myapp-green
echo "✅ Green deployment ready"

# 3. Run smoke tests on Green
echo "🧪 Running smoke tests..."
kubectl run smoke-test --rm -i --restart=Never --image=curlimages/curl -- \
  curl -f http://myapp-green:3000/health || exit 1
echo "✅ Smoke tests passed"

# 4. Switch traffic to Green
kubectl patch service myapp -p '{"spec":{"selector":{"version":"green"}}}'
echo "🔄 Traffic switched to Green"

# 5. Monitor for 5 minutes
echo "👀 Monitoring for 5 minutes..."
sleep 300

# 6. Check metrics
ERROR_RATE=$(curl -s http://prometheus/api/v1/query?query=error_rate | jq .data.result[0].value[1])
if (( $(echo "$ERROR_RATE > 0.05" | bc -l) )); then
  echo "❌ High error rate detected! Rolling back..."
  kubectl patch service myapp -p '{"spec":{"selector":{"version":"blue"}}}'
  echo "⏪ Rolled back to Blue"
  exit 1
fi

echo "✅ Deployment successful!"
echo "🗑️  Blue deployment can be removed after 24h"
```

**Avantages Blue-Green :**
- ✅ **Zero downtime** : Switch instantané
- ✅ **Rollback instantané** : Re-switch to Blue
- ✅ **Testing en prod** : Green peut être testé avant switch
- ✅ **Simple** : Facile à comprendre et implémenter

**Inconvénients :**
- ❌ **Coût** : Double infrastructure (2x resources)
- ❌ **Database migrations** : Complexe avec schema changes
- ❌ **Stateful apps** : Difficile avec sessions/state

---

#### 2. Canary Deployment

**Concept :**

Déploiement progressif : On route d'abord un **petit pourcentage** du traffic (5%) vers la nouvelle version, puis on augmente graduellement si tout va bien.

```
┌─────────────────────────────────────────────────────────────────────┐
│  CANARY DEPLOYMENT                                                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  PHASE 1: 5% Canary                                                 │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┬──────────────┐                      │
│                95%            5%             │                      │
│                │              │              │                      │
│         [STABLE v1.0]    [CANARY v1.1]                              │
│         3 instances      1 instance                                 │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  PHASE 2: Monitor 5% (10-15 minutes)                                │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│  Metrics to watch:                                                  │
│  ├─ Error rate: Canary vs Stable                                   │
│  │  Canary: 0.5%  ✅                                                │
│  │  Stable: 0.4%  ✅ (within threshold)                             │
│  │                                                                  │
│  ├─ Latency p95: Canary vs Stable                                  │
│  │  Canary: 280ms ✅                                                │
│  │  Stable: 250ms ✅ (acceptable)                                   │
│  │                                                                  │
│  └─ CPU/Memory: No spikes ✅                                        │
│                                                                     │
│  Decision: ✅ Proceed to next phase                                 │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  PHASE 3: 25% Canary                                                │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┬──────────────┐                      │
│                75%            25%            │                      │
│                │              │              │                      │
│         [STABLE v1.0]    [CANARY v1.1]                              │
│         3 instances      1 instance                                 │
│                                                                     │
│  Monitor for 15 minutes... ✅                                       │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  PHASE 4: 50% Canary                                                │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┬──────────────┐                      │
│                50%            50%            │                      │
│                │              │              │                      │
│         [STABLE v1.0]    [CANARY v1.1]                              │
│         2 instances      2 instances                                │
│                                                                     │
│  Monitor for 20 minutes... ✅                                       │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  PHASE 5: 100% Canary                                               │
│  ────────────────────────────────────────────────────────          │
│                                                                     │
│          LOAD BALANCER                                              │
│                │                                                    │
│                ├──────────────┐                                     │
│                100%           │                                     │
│                │              │                                     │
│         [NEW STABLE v1.1]   [OLD v1.0 removed]                      │
│         4 instances                                                 │
│                                                                     │
│  ✅ DEPLOYMENT COMPLETE                                             │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  ROLLBACK SCENARIO:                                                 │
│  If at ANY phase metrics are bad:                                   │
│  ❌ Error rate spike detected at 25% phase                          │
│  → Immediately route 100% to STABLE                                 │
│  → Terminate CANARY instances                                       │
│  → Investigate issue                                                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Exemple avec Flagger (Kubernetes) :**

```yaml
# canary.yaml
apiVersion: flagger.app/v1beta1
kind: Canary
metadata:
  name: myapp
  namespace: production
spec:
  # Target deployment
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp

  # Service
  service:
    port: 80
    targetPort: 3000

  # Canary analysis
  analysis:
    # Schedule interval
    interval: 1m

    # Max traffic percentage routed to canary
    threshold: 5

    # Max number of failed checks before rollback
    maxWeight: 50

    # Canary increment step
    stepWeight: 5

    # Metrics
    metrics:
    - name: request-success-rate
      thresholdRange:
        min: 99
      interval: 1m

    - name: request-duration
      thresholdRange:
        max: 500
      interval: 1m

    # Webhooks for custom checks
    webhooks:
    - name: load-test
      url: http://flagger-loadtester/
      timeout: 5s
      metadata:
        cmd: "hey -z 1m -q 10 -c 2 http://myapp/"
```

**Progressive Rollout Timeline :**

```
Time   Traffic Split              Action
────   ─────────────              ──────
0:00   0% canary                  Deploy canary v1.1
0:01   5% canary, 95% stable      Monitor metrics
0:02   5% canary                  ✅ Metrics OK → Proceed
0:03   10% canary, 90% stable     Monitor metrics
0:04   10% canary                 ✅ Metrics OK → Proceed
0:05   15% canary, 85% stable     Monitor metrics
0:06   15% canary                 ✅ Metrics OK → Proceed
...
0:20   50% canary, 50% stable     Monitor metrics
0:21   50% canary                 ✅ Metrics OK → Proceed
...
0:30   100% canary                ✅ Promote canary to stable
0:31   100% new stable v1.1       Terminate old v1.0
```

**Avantages Canary :**
- ✅ **Lowest risk** : Problèmes impactent peu d'users
- ✅ **Observability** : Compare metrics en temps réel
- ✅ **Automated rollback** : Détection automatique de problèmes
- ✅ **Cost-effective** : Pas besoin de doubler infra

**Inconvénients :**
- ❌ **Complexité** : Nécessite routing sophistiqué
- ❌ **Temps** : Déploiement plus long (30min-1h)
- ❌ **Monitoring requis** : Need robust observability

---

#### 3. Rolling Deployment

**Concept :**

Mise à jour **progressive** des instances, une par une ou par petits groupes, sans downtime.

```
┌─────────────────────────────────────────────────────────────────────┐
│  ROLLING DEPLOYMENT (4 instances)                                   │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  INITIAL STATE                                                      │
│  ────────────────────────────────────────────────────────          │
│  [v1.0] [v1.0] [v1.0] [v1.0]                                        │
│   ✅     ✅     ✅     ✅     = 4 instances serving traffic          │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 1: Update first instance                                      │
│  ────────────────────────────────────────────────────────          │
│  [v1.1] [v1.0] [v1.0] [v1.0]                                        │
│   🔄     ✅     ✅     ✅     = 1 updating, 3 serving                │
│                                                                     │
│  Wait for health check... ✅                                        │
│                                                                     │
│  [v1.1] [v1.0] [v1.0] [v1.0]                                        │
│   ✅     ✅     ✅     ✅     = 4 serving (1 new, 3 old)             │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 2: Update second instance                                     │
│  ────────────────────────────────────────────────────────          │
│  [v1.1] [v1.1] [v1.0] [v1.0]                                        │
│   ✅     🔄     ✅     ✅     = 1 updating, 3 serving                │
│                                                                     │
│  Wait for health check... ✅                                        │
│                                                                     │
│  [v1.1] [v1.1] [v1.0] [v1.0]                                        │
│   ✅     ✅     ✅     ✅     = 4 serving (2 new, 2 old)             │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 3: Update third instance                                      │
│  ────────────────────────────────────────────────────────          │
│  [v1.1] [v1.1] [v1.1] [v1.0]                                        │
│   ✅     ✅     🔄     ✅     = 1 updating, 3 serving                │
│                                                                     │
│  Wait for health check... ✅                                        │
│                                                                     │
│  [v1.1] [v1.1] [v1.1] [v1.0]                                        │
│   ✅     ✅     ✅     ✅     = 4 serving (3 new, 1 old)             │
│                                                                     │
│  ─────────────────────────────────────────────────────────────     │
│                                                                     │
│  STEP 4: Update fourth instance                                     │
│  ────────────────────────────────────────────────────────          │
│  [v1.1] [v1.1] [v1.1] [v1.1]                                        │
│   ✅     ✅     ✅     🔄     = 1 updating, 3 serving                │
│                                                                     │
│  Wait for health check... ✅                                        │
│                                                                     │
│  [v1.1] [v1.1] [v1.1] [v1.1]                                        │
│   ✅     ✅     ✅     ✅     = 4 serving (all new)                  │
│                                                                     │
│  ✅ ROLLING DEPLOYMENT COMPLETE                                     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Kubernetes Rolling Update :**

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 4

  # Rolling update strategy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # Max 1 extra pod during update
      maxUnavailable: 1  # Max 1 pod can be unavailable

  selector:
    matchLabels:
      app: myapp

  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:1.1.0  # NEW VERSION
        ports:
        - containerPort: 3000

        # Health checks
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10

        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
```

**Deploy et monitoring :**

```bash
# Deploy
kubectl apply -f deployment.yaml

# Watch rollout
kubectl rollout status deployment/myapp

# Output:
# Waiting for deployment "myapp" rollout to finish: 1 out of 4 new replicas have been updated...
# Waiting for deployment "myapp" rollout to finish: 1 old replicas are pending termination...
# Waiting for deployment "myapp" rollout to finish: 2 of 4 updated replicas are available...
# Waiting for deployment "myapp" rollout to finish: 3 of 4 updated replicas are available...
# deployment "myapp" successfully rolled out

# Rollback if needed
kubectl rollout undo deployment/myapp

# Pause rollout (if issues detected)
kubectl rollout pause deployment/myapp

# Resume
kubectl rollout resume deployment/myapp
```

**Avantages Rolling :**
- ✅ **Zero downtime** : Toujours des instances disponibles
- ✅ **Simple** : Native Kubernetes/Docker Swarm
- ✅ **Automatic** : Gestion automatique par orchestrator
- ✅ **Cost-effective** : Pas besoin d'infra supplémentaire

**Inconvénients :**
- ❌ **Mixed versions** : Ancienne et nouvelle versions coexistent
- ❌ **Slower rollback** : Doit roller back toutes les instances
- ❌ **Stateful apps** : Difficile avec databases

---

#### Comparaison des Stratégies

| Critère | Blue-Green | Canary | Rolling |
|---------|------------|--------|---------|
| **Downtime** | ✅ Zero | ✅ Zero | ✅ Zero |
| **Rollback Speed** | ⚡ Instant | ⚡ Instant | 🐌 Slow |
| **Cost** | 💰💰 High (2x) | 💰 Medium | 💰 Low |
| **Risk** | ⚠️ Medium | ✅ Very Low | ⚠️ Medium |
| **Complexity** | 📘 Simple | 📕 Complex | 📗 Medium |
| **Testing in Prod** | ✅ Yes (Green) | ✅ Yes (Canary) | ❌ No |
| **Traffic Control** | All-or-nothing | Gradual % | N/A |
| **Database Changes** | ❌ Difficult | ❌ Difficult | ⚠️ Possible |
| **Use Case** | Critical apps | High-risk changes | Standard deploys |

**Recommandations :**

```
Use Blue-Green when:
✅ Need instant rollback
✅ Can afford double infrastructure
✅ Want to test full production load on new version
✅ Database changes are backward compatible

Use Canary when:
✅ Want lowest risk (test on small % first)
✅ Have robust monitoring
✅ Can tolerate gradual rollout (30min-1h)
✅ Cost-sensitive (don't want 2x infra)

Use Rolling when:
✅ Standard deployments
✅ Cost-sensitive
✅ Application is stateless
✅ Can tolerate mixed versions temporarily
```

---

## 5. Feature Flags et Progressive Rollout {#feature-flags}

### Qu'est-ce qu'un Feature Flag ? {#definition-feature-flag}

**Définition :**

Un **Feature Flag** (ou Feature Toggle) est un mécanisme qui permet d'**activer ou désactiver des fonctionnalités en production sans déployer de nouveau code**.

```
┌────────────────────────────────────────────────────────────────────┐
│  FEATURE FLAG CONCEPT                                              │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  WITHOUT Feature Flags:                                            │
│  ───────────────────────────────────────────────────────          │
│                                                                    │
│  New Feature → Deploy to Production → Available to ALL users      │
│                                                                    │
│  Problem: Can't easily rollback without redeployment              │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  WITH Feature Flags:                                               │
│  ───────────────────────────────────────────────────────          │
│                                                                    │
│  New Feature (wrapped in flag) → Deploy to Production             │
│                                    ↓                               │
│                            Flag = OFF (default)                    │
│                                    ↓                               │
│                         Feature is invisible to users              │
│                                    ↓                               │
│                Toggle flag ON for 5% of users                      │
│                                    ↓                               │
│                Monitor metrics for issues                          │
│                                    ↓                               │
│               ✅ No issues → Increase to 25%                       │
│               ❌ Issues → Toggle OFF instantly                     │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

**Code Example :**

```javascript
// Without Feature Flag (❌ Risky)
function renderDashboard() {
  return (
    <div>
      <Sidebar />
      <NewComplexFeature />  {/* Can't disable without redeployment */}
      <Content />
    </div>
  );
}

// With Feature Flag (✅ Safe)
import { useFeatureFlag } from '@launchdarkly/react-client-sdk';

function renderDashboard() {
  const showNewFeature = useFeatureFlag('new-complex-feature', false);

  return (
    <div>
      <Sidebar />
      {showNewFeature && <NewComplexFeature />}  {/* Can toggle instantly */}
      <Content />
    </div>
  );
}
```

**Types de Feature Flags :**

```
1. RELEASE FLAGS (Temporary)
   ────────────────────────────
   Purpose: Decouple deployment from release
   Lifespan: Short (days to weeks)
   Example: "Enable new checkout flow"

   Timeline:
   Week 1: Deploy with flag OFF
   Week 2: Enable for 10% users
   Week 3: Enable for 100% users
   Week 4: Remove flag from code

2. EXPERIMENT FLAGS (Temporary)
   ────────────────────────────
   Purpose: A/B testing
   Lifespan: Short (duration of experiment)
   Example: "Show blue CTA button vs green CTA button"

   Timeline:
   Week 1-2: 50% see blue, 50% see green
   Week 3: Analyze results → Winner: green
   Week 4: 100% green, remove flag

3. OPS FLAGS (Long-lived)
   ────────────────────────────
   Purpose: Operational control
   Lifespan: Permanent
   Example: "Enable premium features"

   Use cases:
   - Kill switch for heavy features
   - Graceful degradation under load
   - Circuit breaker

4. PERMISSION FLAGS (Long-lived)
   ────────────────────────────
   Purpose: User/org-specific features
   Lifespan: Permanent
   Example: "Enable admin dashboard"

   Use cases:
   - Premium features
   - Beta access
   - Role-based access
```

---

### Outils : LaunchDarkly, Unleash, Flagsmith {#outils-feature-flags}

#### 1. LaunchDarkly

**Le Leader du marché** - Enterprise-grade feature management

```javascript
// LaunchDarkly Client Setup
import { LDClient, initialize } from '@launchdarkly/node-server-sdk';

const client = initialize(process.env.LAUNCHDARKLY_SDK_KEY);

await client.waitForInitialization();

// Simple flag
const showNewFeature = await client.variation(
  'new-checkout-flow',
  user,
  false  // default value
);

if (showNewFeature) {
  renderNewCheckout();
} else {
  renderOldCheckout();
}

// Progressive rollout
const user = {
  key: 'user-123',
  email: 'user@example.com',
  custom: {
    plan: 'premium',
    country: 'US'
  }
};

const showPremiumFeature = await client.variation(
  'premium-analytics',
  user,
  false
);
```

**LaunchDarkly Features :**
- ✅ **Targeting** : User segments, % rollouts
- ✅ **Analytics** : Flag usage metrics
- ✅ **Workflows** : Scheduled rollouts
- ✅ **Experimentation** : A/B testing built-in
- ✅ **Governance** : Approvals, audit log
- ✅ **SDKs** : 25+ languages
- ✅ **Scale** : 20 trillion flag evaluations/day

**Pricing :** $$$$ (Enterprise-focused)
- Starter: $10/seat/month
- Pro: $20/seat/month
- Enterprise: Custom

#### 2. Unleash

**Open Source Alternative** - Self-hosted or cloud

```javascript
// Unleash Client Setup
import { initialize, isEnabled } from 'unleash-client';

const unleash = initialize({
  url: 'https://unleash.example.com/api/',
  appName: 'my-app',
  customHeaders: {
    Authorization: process.env.UNLEASH_API_KEY
  }
});

unleash.on('ready', () => {
  // Check flag
  if (isEnabled('new-feature')) {
    console.log('✅ Feature enabled');
  }

  // With context
  const context = {
    userId: '123',
    properties: {
      plan: 'premium'
    }
  };

  if (isEnabled('premium-feature', context)) {
    renderPremiumFeature();
  }
});
```

**Unleash Features :**
- ✅ **Open Source** : Self-host for free
- ✅ **Strategies** : Gradual rollout, user targeting
- ✅ **Variants** : A/B/n testing
- ✅ **SDKs** : 15+ languages
- ✅ **UI** : Admin dashboard
- ✅ **API** : Full REST API

**Pricing :**
- Open Source: FREE (self-hosted)
- Pro (cloud): $80/month
- Enterprise: Custom

#### 3. Flagsmith

**Open Source + Cloud** - Developer-friendly

```javascript
// Flagsmith Client Setup
import flagsmith from 'flagsmith';

await flagsmith.init({
  environmentID: process.env.FLAGSMITH_ENV_ID
});

// Get flag value
const enabled = flagsmith.hasFeature('new_dashboard');

if (enabled) {
  renderNewDashboard();
}

// Get flag value with config
const dashboardConfig = flagsmith.getValue('dashboard_config');
// Returns: { theme: 'dark', layout: 'grid' }

// User-specific flags
await flagsmith.identify('user-123', {
  email: 'user@example.com',
  plan: 'premium'
});

const hasPremium = flagsmith.hasFeature('premium_features');
```

**Flagsmith Features :**
- ✅ **Open Source** : MIT licensed
- ✅ **Remote Config** : JSON values, not just booleans
- ✅ **Segments** : User targeting
- ✅ **A/B Testing** : Multi-variate flags
- ✅ **SDKs** : 10+ languages
- ✅ **Webhooks** : Flag change notifications

**Pricing :**
- Open Source: FREE
- Startup (cloud): $45/month
- Scale-up: $200/month

---

### Stratégies de Rollout Progressif {#rollout-progressif}

#### Progressive Rollout Pattern

```
┌────────────────────────────────────────────────────────────────────┐
│  PROGRESSIVE ROLLOUT TIMELINE                                      │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  Day 1: Internal Testing (0.1% - Team only)                        │
│  ────────────────────────────────────────────────────────          │
│  Target: Engineering team + QA                                     │
│  Metrics: Basic functionality, crash rate                          │
│  ✅ Pass → Continue                                                │
│  ❌ Fail → Fix bugs, restart from Day 1                            │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  Day 2: Alpha Users (1% - Early adopters)                          │
│  ────────────────────────────────────────────────────────          │
│  Target: Power users who opted-in to beta program                  │
│  Metrics: Error rate, latency, user feedback                       │
│  Monitor: 24 hours                                                 │
│  ✅ Error rate < 1%, feedback positive → Continue                  │
│  ❌ Issues detected → Rollback to 0%, fix                          │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  Day 3-4: Small Cohort (5%)                                        │
│  ────────────────────────────────────────────────────────          │
│  Target: Random 5% of user base                                    │
│  Metrics: Full metrics suite                                       │
│  ├─ Error rate vs baseline                                         │
│  ├─ Latency p50, p95, p99                                          │
│  ├─ Conversion rate (if e-commerce)                                │
│  └─ User engagement metrics                                        │
│  Monitor: 48 hours                                                 │
│  ✅ All metrics within thresholds → Continue                       │
│  ❌ Any metric regressed → Rollback, investigate                   │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  Day 5-6: Medium Rollout (25%)                                     │
│  ────────────────────────────────────────────────────────          │
│  Target: 25% of users                                              │
│  Metrics: Same as 5% + business metrics                            │
│  Monitor: 48 hours with on-call rotation                           │
│  ✅ Metrics stable → Continue                                      │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  Day 7-8: Majority Rollout (50%)                                   │
│  ────────────────────────────────────────────────────────          │
│  Target: 50% of users                                              │
│  Metrics: Full observability                                       │
│  Monitor: 48 hours                                                 │
│  ✅ No issues → Prepare for full rollout                           │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  Day 9: Full Rollout (100%)                                        │
│  ────────────────────────────────────────────────────────          │
│  Target: All users                                                 │
│  Monitor: 7 days with alerting                                     │
│  ✅ Stable for 7 days → Remove flag from code (cleanup)            │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

**Automated Progressive Rollout :**

```javascript
// automated-rollout.js
const flagsmith = require('flagsmith');

async function progressiveRollout(featureName) {
  const schedule = [
    { day: 1, percentage: 0.1, duration: '24h', target: 'internal' },
    { day: 2, percentage: 1, duration: '24h', target: 'alpha' },
    { day: 3, percentage: 5, duration: '48h', target: 'random' },
    { day: 5, percentage: 25, duration: '48h', target: 'random' },
    { day: 7, percentage: 50, duration: '48h', target: 'random' },
    { day: 9, percentage: 100, duration: '7d', target: 'all' }
  ];

  for (const phase of schedule) {
    console.log(`Day ${phase.day}: Rolling out to ${phase.percentage}%`);

    // Update flag percentage
    await updateFlagPercentage(featureName, phase.percentage, phase.target);

    // Monitor metrics
    const metrics = await monitorMetrics(phase.duration);

    if (metrics.errorRate > THRESHOLD_ERROR_RATE) {
      console.error('❌ Error rate too high! Rolling back...');
      await updateFlagPercentage(featureName, 0);
      throw new Error('Rollout failed due to high error rate');
    }

    if (metrics.latencyP95 > THRESHOLD_LATENCY) {
      console.error('❌ Latency too high! Rolling back...');
      await updateFlagPercentage(featureName, 0);
      throw new Error('Rollout failed due to high latency');
    }

    console.log(`✅ Phase ${phase.day} successful`);
  }

  console.log('✅ Full rollout complete!');
}

// Usage
progressiveRollout('new-checkout-flow');
```

---

### A/B Testing vs Feature Flags {#ab-testing-vs-flags}

#### Différences Fondamentales

```
┌────────────────────────────────────────────────────────────────────┐
│  FEATURE FLAGS vs A/B TESTING                                      │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  FEATURE FLAGS                                                      │
│  ──────────────                                                    │
│  Purpose: Control feature availability                             │
│  Goal: Safe rollout, kill switch                                   │
│  Duration: Temporary (release flags) or permanent (ops flags)      │
│  Variants: Typically ON/OFF (boolean)                              │
│  Metrics: Error rate, latency, crashes                             │
│  Decision: Technical (is it stable?)                               │
│                                                                    │
│  Example:                                                          │
│  ┌──────────────────────────────────────────┐                     │
│  │ Feature: New Dashboard                   │                     │
│  │                                          │                     │
│  │ Week 1: 10% of users → Monitor errors   │                     │
│  │ Week 2: 50% of users → Still stable     │                     │
│  │ Week 3: 100% of users → Full rollout    │                     │
│  │                                          │                     │
│  │ Decision: Is it working correctly?       │                     │
│  └──────────────────────────────────────────┘                     │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  A/B TESTING                                                        │
│  ───────────                                                       │
│  Purpose: Compare different variants                               │
│  Goal: Find best performing version                                │
│  Duration: Fixed experiment duration (2-4 weeks)                   │
│  Variants: A vs B vs C (multiple options)                          │
│  Metrics: Business metrics (conversion, revenue, engagement)       │
│  Decision: Business (which performs better?)                       │
│                                                                    │
│  Example:                                                          │
│  ┌──────────────────────────────────────────┐                     │
│  │ Experiment: CTA Button Color             │                     │
│  │                                          │                     │
│  │ Variant A (50%): Blue button             │                     │
│  │ Variant B (50%): Green button            │                     │
│  │                                          │                     │
│  │ Metrics after 2 weeks:                   │                     │
│  │ - Blue: 3.2% conversion                  │                     │
│  │ - Green: 3.8% conversion ← Winner!       │                     │
│  │                                          │                     │
│  │ Decision: Which converts better?         │                     │
│  └──────────────────────────────────────────┘                     │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

#### Utiliser les Deux Ensemble

```javascript
// Combined: Feature Flag + A/B Test

// 1. Feature Flag to control rollout
const experimentEnabled = useFeatureFlag('cta-button-experiment', false);

if (!experimentEnabled) {
  // Experiment not started yet
  return <BlueButton />;  // Default
}

// 2. A/B Test to compare variants
const variant = useABTest('cta-button-color', {
  variants: ['blue', 'green', 'red'],
  weights: [33, 33, 34]  // Equal distribution
});

// 3. Track metrics
trackEvent('button_shown', { variant });

// 4. Render variant
if (variant === 'blue') {
  return <BlueButton onClick={() => trackConversion('blue')} />;
} else if (variant === 'green') {
  return <GreenButton onClick={() => trackConversion('green')} />;
} else {
  return <RedButton onClick={() => trackConversion('red')} />;
}

// After experiment (2 weeks):
// Results: Green converted best (3.8% vs 3.2% vs 3.0%)
// Decision:
// 1. Set feature flag to 100%
// 2. Hardcode green button
// 3. Remove experiment code
```

---

### Kill Switch en Production {#kill-switch}

**Définition :**

Un **Kill Switch** est un feature flag utilisé comme **interrupteur d'urgence** pour désactiver instantanément une fonctionnalité problématique en production.

#### Use Cases de Kill Switch

```
┌────────────────────────────────────────────────────────────────────┐
│  KILL SWITCH USE CASES                                             │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  1️⃣  PERFORMANCE ISSUES                                            │
│  ────────────────────────────────────────────────────────          │
│  Scenario: New recommendation engine causes DB overload            │
│                                                                    │
│  Without Kill Switch:                                              │
│  ❌ Entire site down                                               │
│  ❌ Need emergency deployment to remove feature                    │
│  ❌ 30min downtime                                                 │
│                                                                    │
│  With Kill Switch:                                                 │
│  ✅ Toggle 'recommendations' flag OFF                              │
│  ✅ Site recovers instantly                                        │
│  ✅ Fix issue in dev, redeploy properly                            │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  2️⃣  CRITICAL BUGS                                                 │
│  ────────────────────────────────────────────────────────          │
│  Scenario: Payment processing bug charging users twice             │
│                                                                    │
│  Action:                                                           │
│  1. Detect issue via monitoring                                    │
│  2. Toggle 'new-payment-flow' flag OFF immediately                 │
│  3. Site falls back to old (working) payment system                │
│  4. Refund affected users                                          │
│  5. Fix bug in staging                                             │
│  6. Re-enable flag with fix                                        │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  3️⃣  GRACEFUL DEGRADATION (High Load)                              │
│  ────────────────────────────────────────────────────────          │
│  Scenario: Black Friday traffic spike                              │
│                                                                    │
│  Kill Switches:                                                    │
│  ┌─────────────────────────────────────────┐                      │
│  │ Priority 1 (Always ON):                 │                      │
│  │  ✅ Product browsing                    │                      │
│  │  ✅ Shopping cart                       │                      │
│  │  ✅ Checkout                            │                      │
│  │                                         │                      │
│  │ Priority 2 (Disable under high load):  │                      │
│  │  ⚠️ Recommendations                     │                      │
│  │  ⚠️ Related products                    │                      │
│  │  ⚠️ Personalization                     │                      │
│  │                                         │                      │
│  │ Priority 3 (Disable first):             │                      │
│  │  ⛔ Social media feeds                  │                      │
│  │  ⛔ Review comments                     │                      │
│  │  ⛔ Live chat                           │                      │
│  └─────────────────────────────────────────┘                      │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  4️⃣  SECURITY INCIDENTS                                            │
│  ────────────────────────────────────────────────────────          │
│  Scenario: Security vulnerability discovered in API                │
│                                                                    │
│  Action:                                                           │
│  1. Security team notified                                         │
│  2. Toggle 'public-api-v2' flag OFF                                │
│  3. API v2 instantly disabled                                      │
│  4. Users automatically fall back to v1                            │
│  5. Patch vulnerability                                            │
│  6. Re-enable after security audit                                 │
│                                                                    │
│  ─────────────────────────────────────────────────────────────    │
│                                                                    │
│  5️⃣  AI/ML MODEL ISSUES                                            │
│  ────────────────────────────────────────────────────────          │
│  Scenario: ML model generating biased/offensive content            │
│                                                                    │
│  Automated Kill Switch:                                            │
│  ┌─────────────────────────────────────────┐                      │
│  │ Monitor AI outputs                      │                      │
│  │    ↓                                    │                      │
│  │ Detect offensive content spike          │                      │
│  │    ↓                                    │                      │
│  │ Auto-toggle 'ai-content-generation' OFF │                      │
│  │    ↓                                    │                      │
│  │ Fallback to human moderation            │                      │
│  │    ↓                                    │                      │
│  │ Alert ML team                           │                      │
│  └─────────────────────────────────────────┘                      │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

#### Implementation d'un Kill Switch

```javascript
// kill-switch.js
import { getFeatureFlag } from './feature-flags';
import { logger } from './logger';
import { metrics } from './metrics';

class FeatureKillSwitch {
  constructor(featureName, fallback) {
    this.featureName = featureName;
    this.fallback = fallback;
    this.enabled = true;
  }

  async execute(newImplementation) {
    // Check if feature is enabled
    this.enabled = await getFeatureFlag(this.featureName, true);

    if (!this.enabled) {
      logger.warn(`🛑 Kill switch activated for ${this.featureName}`);
      metrics.increment('killswitch.triggered', {
        feature: this.featureName
      });

      // Use fallback (old implementation)
      return this.fallback();
    }

    try {
      // Execute new implementation
      return await newImplementation();

    } catch (error) {
      logger.error(`❌ ${this.featureName} failed, using fallback`, error);
      metrics.increment('killswitch.fallback', {
        feature: this.featureName
      });

      // Automatic fallback on error
      return this.fallback();
    }
  }
}

// Usage Example: Recommendations
const recommendationKillSwitch = new FeatureKillSwitch(
  'product-recommendations',
  async () => {
    // Fallback: Simple bestsellers
    return await db.products.find({ bestseller: true }).limit(10);
  }
);

async function getRecommendations(userId) {
  return await recommendationKillSwitch.execute(async () => {
    // New implementation: AI-powered recommendations
    const recommendations = await mlModel.predict(userId);

    // Additional safety check
    if (recommendations.length === 0) {
      throw new Error('ML model returned empty results');
    }

    return recommendations;
  });
}

// Monitoring & Auto Kill Switch
async function monitorFeature(featureName, thresholds) {
  setInterval(async () => {
    const metrics = await getMetrics(featureName);

    // Auto-disable if error rate too high
    if (metrics.errorRate > thresholds.maxErrorRate) {
      logger.error(`🚨 Auto kill switch: ${featureName} error rate too high`);
      await setFeatureFlag(featureName, false);
      await notifyOncall({
        alert: 'KILL_SWITCH_TRIGGERED',
        feature: featureName,
        reason: 'High error rate',
        errorRate: metrics.errorRate
      });
    }

    // Auto-disable if latency too high
    if (metrics.latencyP95 > thresholds.maxLatency) {
      logger.error(`🚨 Auto kill switch: ${featureName} latency too high`);
      await setFeatureFlag(featureName, false);
      await notifyOncall({
        alert: 'KILL_SWITCH_TRIGGERED',
        feature: featureName,
        reason: 'High latency',
        latencyP95: metrics.latencyP95
      });
    }
  }, 60000);  // Check every minute
}

// Start monitoring
monitorFeature('product-recommendations', {
  maxErrorRate: 0.05,  // 5%
  maxLatency: 1000     // 1 second
});
```

---

## 6. Glossaire FR/EN (Partie 2) {#glossaire-partie-2}

### Concepts CI/CD

| Français | English | Définition |
|----------|---------|------------|
| **Livraison Continue** | **Continuous Delivery** | Pratique où le code est toujours dans un état déployable, avec approbation manuelle pour la production. |
| **Déploiement Continu** | **Continuous Deployment** | Extension de CD où chaque changement validé est automatiquement déployé en production sans intervention humaine. |
| **Build Once Deploy Many** | **Build Once Deploy Many** | Principe de builder une seule fois et déployer le même artifact dans tous les environnements. |

### Artifacts

| Français | English | Définition |
|----------|---------|------------|
| **Artefact de Build** | **Build Artifact** | Fichier résultant du build (JAR, Docker image, npm package, binaire). |
| **Registry d'Artefacts** | **Artifact Registry** | Repository centralisé pour stocker et versionner les artifacts (JFrog, Nexus, GHCR). |
| **Promotion d'Artifact** | **Artifact Promotion** | Déplacement d'un artifact d'un environnement à un autre (dev → staging → prod). |
| **Versioning Sémantique** | **Semantic Versioning** | Schéma de versioning MAJOR.MINOR.PATCH (ex: 1.2.3). |
| **Image Docker** | **Docker Image** | Artifact containerisé contenant app + runtime + dépendances. |
| **Tag** | **Tag** | Étiquette identifiant une version d'artifact (v1.2.3, latest, sha-abc123). |

### Environnements

| Français | English | Définition |
|----------|---------|------------|
| **Développement** | **Development (DEV)** | Environnement pour développement actif, instable, données de test. |
| **Staging / Pré-production** | **Staging / Pre-production** | Environnement miroir de production pour tests QA, données anonymisées. |
| **Production** | **Production (PROD)** | Environnement live servant les vrais utilisateurs. |
| **Preview Environment** | **Preview Environment** | Environnement éphémère créé automatiquement pour chaque PR. |
| **Environment Variables** | **Environment Variables** | Variables de configuration spécifiques à chaque environnement. |

### Stratégies de Déploiement

| Français | English | Définition |
|----------|---------|------------|
| **Déploiement Blue-Green** | **Blue-Green Deployment** | Deux environnements identiques (Blue actif, Green idle), switch instantané du traffic. |
| **Déploiement Canary** | **Canary Deployment** | Déploiement progressif : 5% → 25% → 50% → 100% du traffic vers nouvelle version. |
| **Déploiement Rolling** | **Rolling Deployment** | Mise à jour progressive des instances une par une sans downtime. |
| **Zero Downtime Deployment** | **Zero Downtime Deployment** | Déploiement sans interruption de service. |
| **Rollback** | **Rollback** | Retour à la version précédente en cas de problème. |
| **Health Check** | **Health Check** | Vérification automatique que l'application fonctionne correctement. |
| **Smoke Test** | **Smoke Test** | Tests basiques après déploiement pour vérifier fonctionnalités critiques. |

### Feature Flags

| Français | English | Définition |
|----------|---------|------------|
| **Feature Flag / Toggle** | **Feature Flag / Toggle** | Mécanisme pour activer/désactiver des fonctionnalités sans redéploiement. |
| **Kill Switch** | **Kill Switch** | Feature flag utilisé comme interrupteur d'urgence pour désactiver une fonctionnalité problématique. |
| **Rollout Progressif** | **Progressive Rollout** | Activation graduelle d'une feature (1% → 5% → 25% → 100%). |
| **Ciblage d'Utilisateurs** | **User Targeting** | Activer features pour segments spécifiques d'utilisateurs. |
| **Test A/B** | **A/B Test** | Comparaison de deux variants (A vs B) pour mesurer performance. |
| **Dégradation Gracieuse** | **Graceful Degradation** | Désactivation de features non-critiques sous forte charge. |

### Monitoring & Observability

| Français | English | Définition |
|----------|---------|------------|
| **Observabilité** | **Observability** | Capacité à comprendre l'état interne d'un système via ses outputs (logs, metrics, traces). |
| **Métriques** | **Metrics** | Mesures quantitatives (latency, error rate, throughput). |
| **Taux d'Erreur** | **Error Rate** | Pourcentage de requêtes en erreur. |
| **Latence** | **Latency** | Temps de réponse (souvent exprimé en p50, p95, p99). |
| **p95 / p99** | **p95 / p99** | 95ème/99ème percentile de latence (95%/99% des requêtes plus rapides que cette valeur). |
| **Alerte** | **Alert** | Notification automatique en cas de dépassement de seuil. |

---

## 7. Références et Sources (Partie 2) {#references-partie-2}

### Continuous Delivery & Deployment

15. **Continuous Delivery vs Continuous Deployment (Atlassian)**
    - https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment

16. **Continuous Deployment: A Comprehensive Guide (Plural.sh, 2024)**
    - https://www.plural.sh/blog/what-is-continuous-deployment/

17. **Continuous Delivery vs Deployment Explained (Harness)**
    - https://www.harness.io/blog/continuous-delivery-vs-continuous-deployment

18. **Continuous Delivery vs. Deployment (Puppet)**
    - https://www.puppet.com/blog/continuous-delivery-vs-deployment

### Artifacts & Repositories

19. **9 Best Practices for Artifact Management (JFrog)**
    - https://media.jfrog.com/wp-content/uploads/2023/12/03200725/9-Best-Practices-for-Artifact-Management_Ebook.pdf

20. **Code Promotion vs Artifact Promotion (HackerNoon)**
    - https://hackernoon.com/deployment-choice-code-promotion-vs-artifact-promotion

21. **JFrog Artifactory vs Sonatype Nexus Comparison**
    - https://www.sonatype.com/compare/sonatype-nexus-versus-jfrog-artifactory

### Deployment Strategies

22. **Blue-Green and Canary Deployments Explained (Harness)**
    - https://www.harness.io/blog/blue-green-canary-deployment-strategies

23. **When to use canary vs. blue/green vs. rolling deployment (TechTarget)**
    - https://www.techtarget.com/searchitoperations/answer/When-to-use-canary-vs-blue-green-vs-rolling-deployment

24. **Canary vs blue-green deployment (CircleCI)**
    - https://circleci.com/blog/canary-vs-blue-green-downtime/

25. **Load balancing for deployment strategies (CNCF)**
    - https://www.cncf.io/blog/2022/05/09/load-balancing-for-blue-green-rolling-and-canary-deployment/

### Feature Flags

26. **What are feature flags? (Optimizely)**
    - https://www.optimizely.com/optimization-glossary/feature-flags/

27. **Feature Toggles (Martin Fowler)**
    - https://martinfowler.com/articles/feature-toggles.html

28. **Feature Flag, Rollout or A/B test? (Optimizely)**
    - https://www.optimizely.com/insights/blog/feature-flags-vs-ab-testing/

29. **What is a kill switch in software development? (Unleash)**
    - https://www.getunleash.io/blog/kill-switches-best-practice

30. **LaunchDarkly Progressive Rollouts Documentation**
    - https://docs.launchdarkly.com/home/releases/progressive-rollouts

### Preview Environments

31. **Managing Multiple Deployment Environments (Vercel & Netlify)**
    - https://trillionclues.medium.com/multiple-deployment-environment-pipeline-on-vercel-and-netlify-cec6375e71c2

32. **How to set up staging environment on Vercel**
    - https://vercel.com/guides/set-up-a-staging-environment-on-vercel

33. **Vercel Environments Documentation**
    - https://vercel.com/docs/deployments/environments

### GitHub Actions Specifics

34. **Running GitHub Actions in Parallel and Sequentially (Medium)**
    - https://medium.com/@nickjabs/running-github-actions-in-parallel-and-sequentially-b338e4a46bf5

35. **Parallel Execution in GitHub Actions using Job Matrix**
    - https://documentation.provar.com/documentation/devops/continuous-integration/github-actions/parallel-execution-in-github-actions-using-job-matrix/

36. **How to Run Jobs in Parallel with GitHub Actions (CICube)**
    - https://cicube.io/blog/run-parallel-jobs-github-actions/

### Case Studies

37. **Netflix Tech Stack CI/CD Pipeline (Medium)**
    - https://manitechy.medium.com/netflix-tech-stack-ci-cd-pipeline-e174ccdd3432

38. **Spotify CI migration to 4x Faster Pipelines (Medium)**
    - https://medium.com/@dmosyan/spotify-ci-migration-to-achieve-4-x-faster-pipelines-cd8835685982

39. **AI-Powered CI/CD: ML Optimizing Build Pipelines (2024)**
    - https://medium.com/@Iyanudavid/ai-powered-ci-cd-how-machine-learning-is-optimizing-build-pipelines-c5642d058472

---

**📄 FIN DE LA PARTIE 2**

Cette deuxième partie a couvert en profondeur :
- ✅ **Concepts fondamentaux CI/CD** : Différences entre CI, Continuous Delivery, et Continuous Deployment
- ✅ **Anatomie d'un pipeline complet** : De la source au monitoring
- ✅ **Build artifacts** : Types, stockage, versioning, promotion
- ✅ **Environnements** : Dev, Staging, Production, Preview environments
- ✅ **Stratégies de déploiement** : Blue-Green, Canary, Rolling
- ✅ **Feature flags** : Rollout progressif, A/B testing, kill switches

**📋 PROCHAINE PARTIE À VENIR :**

**Partie 3** : GitHub Actions en Profondeur
- Architecture détaillée
- Syntaxe YAML complète
- Triggers et événements avancés
- Runners (hosted vs self-hosted)
- Secrets et sécurité OIDC
- Matrix builds avancés
- Artifacts, caching, et optimisations
- Conditions, expressions, et contexts
- Reusable workflows
- Custom actions

Demandez-moi quand vous êtes prêt pour la **Partie 3** !
# Module 5 : CI/CD & GitHub Actions - Partie 3
## Deep Dive Technique : Maîtriser GitHub Actions

---

## Table des matières

1. [Architecture GitHub Actions en Détail](#1-architecture-github-actions-en-détail)
2. [Syntaxe YAML Complète](#2-syntaxe-yaml-complète)
3. [Runners en Profondeur](#3-runners-en-profondeur)
4. [Secrets et Sécurité](#4-secrets-et-sécurité)
5. [Artifacts et Caching](#5-artifacts-et-caching)
6. [Reusable Workflows](#6-reusable-workflows)
7. [Custom Actions](#7-custom-actions)

---

## 1. Architecture GitHub Actions en Détail

### 1.1 Vue d'ensemble de l'architecture

GitHub Actions est une plateforme d'automatisation événementielle qui s'articule autour de cinq composants principaux :

```
┌─────────────────────────────────────────────────────────────────┐
│                        GITHUB REPOSITORY                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  .github/workflows/                                              │
│  ├── ci.yml          ← Workflow Files (YAML)                    │
│  ├── deploy.yml                                                  │
│  └── release.yml                                                 │
│                                                                  │
│  EVENTS (Triggers)                                               │
│  ├── push                    ┌──────────────────────────┐       │
│  ├── pull_request            │   WORKFLOW EXECUTION     │       │
│  ├── schedule                │                          │       │
│  ├── workflow_dispatch  ────→│  Job 1 (Runner A)        │       │
│  └── workflow_call           │  ├── Step 1              │       │
│                              │  ├── Step 2 (Action)     │       │
│                              │  └── Step 3              │       │
│                              │                          │       │
│                              │  Job 2 (Runner B)        │       │
│                              │  ├── Step 1              │       │
│                              │  └── Step 2 (Action)     │       │
│                              │                          │       │
│                              │  Job 3 (Runner C)        │       │
│                              │  └── needs: [job1, job2] │       │
│                              └──────────────────────────┘       │
│                                                                  │
│  RUNNERS                                                         │
│  ├── GitHub-hosted (Ubuntu, Windows, macOS)                     │
│  └── Self-hosted (Custom infrastructure)                        │
│                                                                  │
│  ACTIONS (Marketplace / Custom)                                  │
│  ├── actions/checkout@v4                                         │
│  ├── actions/setup-node@v4                                       │
│  └── custom-org/deploy-action@v1                                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 Workflows : Les fichiers `.github/workflows/*.yml`

Un workflow est un processus automatisé configurable défini par un fichier YAML placé dans le répertoire `.github/workflows/` de votre repository.

**Caractéristiques clés :**
- Déclenché par des événements (push, PR, schedule, etc.)
- Contient un ou plusieurs jobs
- Chaque job s'exécute sur un runner
- Les workflows peuvent s'appeler entre eux (reusable workflows)

**Structure de base :**

```yaml
# .github/workflows/example.yml
name: CI Workflow                    # Nom affiché dans l'UI GitHub

on:                                   # Événements déclencheurs
  push:
    branches: [main, develop]
  pull_request:
  workflow_dispatch:                  # Déclenchement manuel

env:                                  # Variables d'environnement globales
  NODE_VERSION: '20'

jobs:                                 # Définition des jobs
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm test
```

### 1.3 Events/Triggers : Catalogue complet

GitHub Actions supporte plus de 40 types d'événements. Voici les plus importants :

#### **Events basés sur le code**

```yaml
on:
  # 1. Push events (commits)
  push:
    branches:
      - main
      - 'releases/**'               # Wildcard support
    tags:
      - 'v*'                         # Tags commençant par "v"
    paths:
      - 'src/**'                     # Filtre sur les chemins modifiés
      - '!docs/**'                   # Exclure docs/

  # 2. Pull Request events
  pull_request:
    types:
      - opened                       # PR créée
      - synchronize                  # Nouveaux commits
      - reopened                     # PR réouverte
      - ready_for_review             # Sortie de draft
    branches:
      - main
      - 'release/**'
    paths-ignore:
      - '**.md'                      # Ignorer les changements MD

  # 3. Pull Request Review
  pull_request_review:
    types:
      - submitted                    # Review soumise
      - edited

  # 4. Issue events
  issues:
    types:
      - opened
      - labeled
      - assigned

  # 5. Release events
  release:
    types:
      - published                    # Release publiée
      - created
```

#### **Events temporels (Scheduled)**

```yaml
on:
  schedule:
    # Syntaxe cron POSIX
    - cron: '0 2 * * *'              # Tous les jours à 2h UTC
    - cron: '0 */6 * * *'            # Toutes les 6 heures
    - cron: '0 0 * * 1'              # Tous les lundis à minuit

# ⚠️ Attention :
# - Timezone : UTC uniquement
# - Minimum : 5 minutes d'intervalle
# - Peut avoir jusqu'à ~10min de délai
# - Désactivé après 60 jours d'inactivité du repo
```

#### **Events manuels et workflows**

```yaml
on:
  # 1. Déclenchement manuel (bouton "Run workflow" dans UI)
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        type: choice
        options:
          - dev
          - staging
          - production
        default: 'dev'
      debug_enabled:
        description: 'Enable debug mode'
        required: false
        type: boolean
      version:
        description: 'Version to deploy'
        required: true
        type: string

  # 2. Appelé par un autre workflow (reusable)
  workflow_call:
    inputs:
      config-path:
        required: true
        type: string
    secrets:
      token:
        required: true
    outputs:
      result:
        description: "Build result"
        value: ${{ jobs.build.outputs.result }}

  # 3. Déclenché à la fin d'un autre workflow
  workflow_run:
    workflows:
      - "CI Pipeline"
    types:
      - completed
    branches:
      - main
```

#### **Events webhook (GitHub Apps)**

```yaml
on:
  # Commentaires
  issue_comment:
    types: [created, edited, deleted]

  # Déploiements
  deployment:
  deployment_status:

  # Repository events
  fork:
  watch:
  star:

  # Branch protection
  check_run:
    types: [created, rerequested, completed]

  check_suite:
    types: [completed, requested, rerequested]
```

### 1.4 Jobs : Parallèles vs Séquentiels

Les jobs sont les unités d'exécution d'un workflow. Par défaut, **ils s'exécutent en parallèle**.

#### **Jobs parallèles (par défaut)**

```yaml
jobs:
  # Ces 3 jobs s'exécutent simultanément
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test

  integration-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run test:integration

  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run lint
```

**Avantages :**
- ✅ Temps d'exécution réduit (parallélisation)
- ✅ Isolation des erreurs (un job échoué n'affecte pas les autres)
- ✅ Runners multiples = ressources additionnelles

**Timeline :**
```
0s    10s   20s   30s   40s
├─────┴─────┴─────┴─────┤
│ unit-tests            │ ✓ (25s)
├───────────────────────┤
│ integration-tests     │ ✓ (30s)
├───────────────────────┤
│ lint                  │ ✓ (15s)
└───────────────────────┘
Total: 30s (plus long job)
```

#### **Jobs séquentiels avec `needs`**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: dist/

  test:
    needs: build                    # Attend que "build" soit terminé
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with:
          name: build-output
          path: dist/
      - run: npm test

  deploy:
    needs: test                     # Attend que "test" soit terminé
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

**Timeline :**
```
0s    10s   20s   30s   40s   50s   60s
├─────┴─────┴─────┴─────┴─────┴─────┤
│ build     │ ✓ (15s)
            ├───────────────┤
            │ test          │ ✓ (20s)
                            ├───────┤
                            │ deploy│ ✓ (10s)
└───────────────────────────────────┘
Total: 45s (somme des durées)
```

#### **Dépendances multiples**

```yaml
jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  integration-tests:
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:integration

  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:e2e

  deploy:
    # Attend que tous les tests soient terminés
    needs: [unit-tests, integration-tests, e2e-tests]
    runs-on: ubuntu-latest
    steps:
      - run: echo "All tests passed!"
```

**Timeline :**
```
0s    10s   20s   30s   40s   50s
├─────┴─────┴─────┴─────┴─────┤
│ unit-tests        │ ✓ (20s)
├───────────────────┤
│ integration-tests │ ✓ (25s)
├───────────────────────────┤
│ e2e-tests                 │ ✓ (35s)
                            ├────┤
                            │deploy│ ✓ (5s)
└────────────────────────────────┘
Total: 40s (35s + 5s)
```

### 1.5 Steps : Anatomie complète

Les steps sont les commandes individuelles exécutées dans un job. Ils s'exécutent **toujours séquentiellement**.

#### **Types de steps**

```yaml
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      # 1. Action du marketplace (uses)
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          submodules: true

      # 2. Commande shell (run)
      - name: Run tests
        run: npm test

      # 3. Commande multi-ligne
      - name: Build and package
        run: |
          npm run build
          npm pack
          ls -la *.tgz

      # 4. Step avec condition
      - name: Deploy to production
        if: github.ref == 'refs/heads/main'
        run: npm run deploy

      # 5. Step avec variables d'environnement
      - name: Run with env
        env:
          API_KEY: ${{ secrets.API_KEY }}
          DEBUG: true
        run: node deploy.js

      # 6. Step avec working directory
      - name: Build frontend
        working-directory: ./frontend
        run: npm run build

      # 7. Step avec timeout
      - name: Run long task
        timeout-minutes: 10
        run: npm run long-task

      # 8. Step avec continue-on-error
      - name: Optional linting
        continue-on-error: true
        run: npm run lint

      # 9. Step avec outputs
      - name: Set output
        id: vars
        run: |
          echo "sha_short=$(git rev-parse --short HEAD)" >> $GITHUB_OUTPUT
          echo "version=$(cat package.json | jq -r '.version')" >> $GITHUB_OUTPUT

      # 10. Utiliser les outputs d'un step précédent
      - name: Use outputs
        run: |
          echo "Short SHA: ${{ steps.vars.outputs.sha_short }}"
          echo "Version: ${{ steps.vars.outputs.version }}"
```

#### **Contexte d'exécution des steps**

```yaml
jobs:
  demo:
    runs-on: ubuntu-latest
    defaults:
      run:
        shell: bash                  # Shell par défaut pour tous les steps
        working-directory: ./app     # Working dir par défaut

    steps:
      - name: Default context
        run: pwd                     # Affiche ./app

      - name: Override shell
        shell: python                # Override le shell pour ce step
        run: |
          import os
          print(os.getcwd())

      - name: Override working-directory
        working-directory: ./scripts # Override le working-dir pour ce step
        run: pwd                     # Affiche ./scripts
```

### 1.6 Actions : Marketplace, Custom, Composite

Les actions sont des **blocs de code réutilisables** qui encapsulent de la logique complexe.

#### **Types d'actions**

| Type | Description | Exemple |
|------|-------------|---------|
| **JavaScript Action** | Code Node.js exécuté directement | `actions/checkout` |
| **Docker Container Action** | Image Docker avec logique custom | `docker://alpine:latest` |
| **Composite Action** | Combinaison de plusieurs steps | Actions locales `./.github/actions/` |

#### **Actions du Marketplace**

```yaml
steps:
  # 1. Checkout repository
  - uses: actions/checkout@v4
    with:
      fetch-depth: 0              # Fetch all history
      submodules: recursive       # Include submodules

  # 2. Setup Node.js
  - uses: actions/setup-node@v4
    with:
      node-version: '20'
      cache: 'npm'                # Auto-cache node_modules

  # 3. Setup Python
  - uses: actions/setup-python@v5
    with:
      python-version: '3.11'
      cache: 'pip'

  # 4. Cache dependencies
  - uses: actions/cache@v4
    with:
      path: |
        ~/.npm
        ~/.cache
      key: ${{ runner.os }}-deps-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-deps-

  # 5. Upload artifacts
  - uses: actions/upload-artifact@v4
    with:
      name: build-output
      path: dist/
      retention-days: 7

  # 6. Download artifacts
  - uses: actions/download-artifact@v4
    with:
      name: build-output
      path: dist/
```

#### **Versioning des actions**

```yaml
steps:
  # ✅ RECOMMANDÉ : Version majeure (tag)
  - uses: actions/checkout@v4

  # ⚠️ Acceptable : Version mineure
  - uses: actions/checkout@v4.2.0

  # 🔒 Maximum sécurité : SHA commit
  - uses: actions/checkout@8f4b7f84864484a7bf31766abe9204da3cbe65b3

  # ❌ À ÉVITER : Branch (instable)
  - uses: actions/checkout@main
```

**Pourquoi éviter les branches ?**
- ❌ Peut casser sans préavis (breaking changes)
- ❌ Pas de garantie de stabilité
- ❌ Difficile à debugger (version exacte inconnue)

**Recommandation :** Utilisez les **tags de version majeure** (v4, v5) pour bénéficier des patches de sécurité tout en maintenant la compatibilité.

### 1.7 Runners : GitHub-hosted vs Self-hosted

Les runners sont les machines qui exécutent vos workflows.

#### **Architecture des runners**

```
┌──────────────────────────────────────────────────────────────┐
│                      GITHUB ACTIONS                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Workflow Triggered                                          │
│        │                                                      │
│        ├─→ Queue Job                                         │
│        │                                                      │
│        └─→ Find Available Runner                             │
│                   │                                           │
│                   ├─→ GitHub-hosted Runner                   │
│                   │   ├── Ubuntu (ubuntu-latest)             │
│                   │   ├── Windows (windows-latest)           │
│                   │   └── macOS (macos-latest)               │
│                   │                                           │
│                   └─→ Self-hosted Runner                     │
│                       ├── On-premise servers                 │
│                       ├── Cloud VMs (AWS, Azure, GCP)        │
│                       └── Kubernetes pods                    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

#### **GitHub-hosted runners : Spécifications**

| Label | OS | CPU | RAM | Stockage | Notes |
|-------|-----|-----|-----|----------|-------|
| `ubuntu-latest` | Ubuntu 22.04 | 4 cores | 16 GB | 14 GB SSD | **Recommandé** (plus rapide) |
| `ubuntu-22.04` | Ubuntu 22.04 | 4 cores | 16 GB | 14 GB SSD | Version fixe |
| `ubuntu-20.04` | Ubuntu 20.04 | 4 cores | 16 GB | 14 GB SSD | Legacy support |
| `windows-latest` | Windows Server 2022 | 4 cores | 16 GB | 14 GB SSD | Builds .NET, PowerShell |
| `windows-2019` | Windows Server 2019 | 4 cores | 16 GB | 14 GB SSD | Legacy support |
| `macos-latest` | macOS 14 (Sonoma) | 3 cores | 14 GB | 14 GB SSD | Apple Silicon (M1) |
| `macos-13` | macOS 13 (Ventura) | 4 cores | 14 GB | 14 GB SSD | Intel |
| `macos-12` | macOS 12 (Monterey) | 3 cores | 14 GB | 14 GB SSD | Intel |

**🆕 Nouveautés 2024 :**
- **GPU runners** : T4 GPU pour ML/AI workloads
- **ubuntu-slim** : 2 vCPU (pour jobs simples, moins cher)
- **Larger runners** : jusqu'à 64 cores / 256 GB RAM (Enterprise)

#### **Logiciels préinstallés**

Les runners GitHub-hosted incluent de nombreux outils :

```yaml
# Ubuntu runners incluent (entre autres) :
- Docker
- docker-compose
- kubectl, helm
- Node.js (14, 16, 18, 20)
- Python (3.7, 3.8, 3.9, 3.10, 3.11)
- Java (8, 11, 17, 21)
- Go
- Rust
- PHP
- Ruby
- .NET SDK
- Terraform
- AWS CLI, Azure CLI, GCP CLI
- Git LFS
- Ansible
- etc.
```

**Liste complète :** https://github.com/actions/runner-images

---

## 2. Syntaxe YAML Complète

### 2.1 Structure de base commentée

```yaml
# Nom du workflow (affiché dans l'UI GitHub Actions)
name: Production CI/CD Pipeline

# Nom custom pour chaque run (peut utiliser des expressions)
run-name: Deploy to ${{ inputs.environment }} by @${{ github.actor }}

# Événements déclencheurs
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options: [dev, staging, production]

# Permissions du GITHUB_TOKEN (principe du moindre privilège)
permissions:
  contents: read          # Lire le code
  issues: write           # Écrire des issues
  pull-requests: write    # Commenter les PRs

# Variables d'environnement globales (disponibles dans tous les jobs)
env:
  NODE_VERSION: '20'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

# Configuration de concurrence (annuler les runs en cours)
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

# Valeurs par défaut pour tous les jobs
defaults:
  run:
    shell: bash
    working-directory: ./app

# Définition des jobs
jobs:
  build:
    name: Build Application              # Nom affiché dans l'UI
    runs-on: ubuntu-latest                # Type de runner
    timeout-minutes: 15                   # Timeout global du job

    # Permissions spécifiques à ce job (override global)
    permissions:
      contents: read
      packages: write

    # Variables d'environnement spécifiques au job
    env:
      BUILD_ENV: production

    # Environment GitHub (avec protection rules)
    environment:
      name: production
      url: https://example.com

    # Outputs du job (disponibles dans les autres jobs)
    outputs:
      version: ${{ steps.version.outputs.version }}
      sha: ${{ steps.version.outputs.sha }}

    # Steps du job (exécutés séquentiellement)
    steps:
      # Step 1 : Checkout du code
      - name: Checkout repository
        id: checkout                      # ID unique du step
        uses: actions/checkout@v4         # Action à utiliser
        with:                             # Inputs de l'action
          fetch-depth: 0
          submodules: recursive

      # Step 2 : Setup Node.js
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      # Step 3 : Install dependencies
      - name: Install dependencies
        run: npm ci                       # Commande shell
        env:                              # Env vars spécifiques au step
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}

      # Step 4 : Build
      - name: Build application
        run: npm run build
        timeout-minutes: 5                # Timeout du step

      # Step 5 : Extract version
      - name: Extract version
        id: version                       # ID pour référencer les outputs
        run: |
          echo "version=$(jq -r '.version' package.json)" >> $GITHUB_OUTPUT
          echo "sha=$(git rev-parse --short HEAD)" >> $GITHUB_OUTPUT

      # Step 6 : Upload artifact
      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ steps.version.outputs.version }}
          path: dist/
          retention-days: 7

  test:
    name: Run Tests
    needs: build                          # Attend que "build" soit terminé
    runs-on: ubuntu-latest

    # Matrix strategy (exécute le job pour chaque combinaison)
    strategy:
      matrix:
        node-version: [18, 20]
        os: [ubuntu-latest, windows-latest]
      fail-fast: false                    # Continue même si un job échoue
      max-parallel: 4                     # Maximum de jobs parallèles

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-${{ needs.build.outputs.version }}
          path: dist/

      - name: Run tests
        run: npm test

  deploy:
    name: Deploy to Production
    needs: [build, test]                  # Attend build ET test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'   # Condition : seulement sur main

    environment:
      name: production
      url: https://prod.example.com

    steps:
      - name: Deploy
        run: echo "Deploying version ${{ needs.build.outputs.version }}"
```

### 2.2 Triggers avancés : Filtres et conditions

#### **Filtres de branches**

```yaml
on:
  push:
    branches:
      - main                    # Exact match
      - develop
      - 'releases/**'           # Wildcard : releases/v1, releases/v2, etc.
      - 'feature/*'             # Wildcard : feature/login, feature/api, etc.
      - '!hotfix/**'            # Négation : exclure hotfix/*

    branches-ignore:
      - 'experimental/**'       # Alternative à la négation
```

#### **Filtres de tags**

```yaml
on:
  push:
    tags:
      - 'v*'                    # v1, v2, v1.0.0, etc.
      - 'v[0-9]+.[0-9]+.[0-9]+' # v1.0.0, v2.1.3 (semantic versioning)
      - '!v*-beta'              # Exclure les tags beta
```

#### **Filtres de chemins (paths)**

```yaml
on:
  push:
    paths:
      - 'src/**'                # Trigger si changements dans src/
      - 'package.json'          # Trigger si package.json modifié
      - '**.js'                 # Tous les fichiers .js

  pull_request:
    paths-ignore:
      - 'docs/**'               # Ignorer si seulement docs/ modifié
      - '**.md'                 # Ignorer les fichiers markdown
      - '.github/**'            # Ignorer les configs GitHub
```

**⚠️ Important :** Les filtres `paths` et `paths-ignore` sont **mutuellement exclusifs**.

#### **Filtres d'activity types**

```yaml
on:
  pull_request:
    types:
      - opened                  # PR créée
      - synchronize             # Nouveaux commits pushés
      - reopened                # PR réouverte
      - ready_for_review        # Draft → Ready
      - labeled                 # Label ajouté
      - unlabeled               # Label retiré
      - assigned                # Assigné

  issues:
    types:
      - opened
      - labeled
      - assigned

  release:
    types:
      - published               # Release publiée
      - created                 # Release créée (draft ou non)
      - released                # Release finalisée
```

#### **Combinaison de filtres**

```yaml
on:
  push:
    branches:
      - main
      - 'releases/**'
    paths:
      - 'src/**'
      - 'package.json'
    tags-ignore:
      - 'v*-beta'

# Ce workflow se déclenche si :
# - Push sur main OU releases/*
# - ET changements dans src/ ou package.json
# - ET tag NE commence PAS par v*-beta
```

### 2.3 Matrix Strategy : Multi-OS, Multi-version

La matrix strategy permet d'exécuter un job sur plusieurs configurations en parallèle.

#### **Matrix simple**

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20]

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test

# Génère 6 jobs :
# - ubuntu-latest + node 18
# - ubuntu-latest + node 20
# - windows-latest + node 18
# - windows-latest + node 20
# - macos-latest + node 18
# - macos-latest + node 20
```

#### **Matrix avec `include` : Ajout de configurations**

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [18, 20]
    include:
      # Ajouter une configuration spécifique
      - os: macos-latest
        node-version: 20
        experimental: true

      # Ajouter des variables à des combinaisons existantes
      - os: ubuntu-latest
        node-version: 20
        build-type: optimized
        cache-key: ubuntu-20-opt

# Génère 5 jobs :
# 1. ubuntu-latest + node 18
# 2. ubuntu-latest + node 20 (+ build-type: optimized)
# 3. windows-latest + node 18
# 4. windows-latest + node 20
# 5. macos-latest + node 20 (+ experimental: true)
```

**Utilisation des variables ajoutées :**

```yaml
steps:
  - name: Build
    if: matrix.build-type == 'optimized'
    run: npm run build:optimized

  - name: Cache dependencies
    uses: actions/cache@v4
    with:
      path: ~/.npm
      key: ${{ matrix.cache-key || 'default' }}-${{ hashFiles('**/package-lock.json') }}
```

#### **Matrix avec `exclude` : Retrait de configurations**

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    node-version: [18, 20]
    architecture: [x64, arm64]
    exclude:
      # Windows ne supporte pas ARM64 dans notre cas
      - os: windows-latest
        architecture: arm64

      # macOS + node 18 pose problème
      - os: macos-latest
        node-version: 18

      # Ubuntu + ARM64 + node 18 : combinaison non testée
      - os: ubuntu-latest
        node-version: 18
        architecture: arm64

# Génère 18 - 4 = 14 jobs
# Total possible : 3 OS × 2 node × 2 arch = 12 jobs
# Exclus : 4 configurations
```

#### **Cas d'usage réel : Multi-plateforme avec optimisations**

```yaml
jobs:
  build-and-test:
    name: Build on ${{ matrix.os }} - Node ${{ matrix.node-version }}
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: false              # Ne pas arrêter si un job échoue
      max-parallel: 6               # Limiter à 6 jobs simultanés
      matrix:
        os:
          - ubuntu-latest
          - windows-latest
          - macos-latest
        node-version:
          - 18
          - 20
        include:
          # Ubuntu 20 : Build optimisé pour production
          - os: ubuntu-latest
            node-version: 20
            build-command: npm run build:prod
            artifact-name: linux-production

          # Windows : Support Node 16 (clients legacy)
          - os: windows-latest
            node-version: 16
            build-command: npm run build
            artifact-name: windows-legacy

          # macOS : Build universel (x64 + ARM64)
          - os: macos-latest
            node-version: 20
            build-command: npm run build:universal
            artifact-name: macos-universal

        exclude:
          # Exclure macOS + Node 18 (problèmes de compatibilité)
          - os: macos-latest
            node-version: 18

          # Exclure Windows + Node 18 (pas de valeur ajoutée)
          - os: windows-latest
            node-version: 18

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: ${{ matrix.build-command || 'npm run build' }}

      - name: Test
        run: npm test

      - name: Upload artifacts
        if: matrix.artifact-name
        uses: actions/upload-artifact@v4
        with:
          name: ${{ matrix.artifact-name }}
          path: dist/
```

### 2.4 Conditions : If expressions

Les conditions permettent d'exécuter des jobs ou steps conditionnellement.

#### **Syntaxe des conditions**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    # Condition au niveau du job
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'

    steps:
      - name: Deploy to staging
        # Condition au niveau du step
        if: contains(github.ref, 'develop')
        run: deploy-staging.sh

      - name: Deploy to production
        if: github.ref == 'refs/heads/main'
        run: deploy-production.sh
```

#### **Fonctions utiles dans les conditions**

| Fonction | Description | Exemple |
|----------|-------------|---------|
| `contains()` | Vérifie si une chaîne contient une sous-chaîne | `contains(github.ref, 'feature/')` |
| `startsWith()` | Vérifie si une chaîne commence par | `startsWith(github.ref, 'refs/tags/v')` |
| `endsWith()` | Vérifie si une chaîne finit par | `endsWith(matrix.os, 'latest')` |
| `success()` | Step/job précédent réussi | `if: success()` |
| `failure()` | Step/job précédent échoué | `if: failure()` |
| `always()` | Toujours exécuter | `if: always()` |
| `cancelled()` | Workflow annulé | `if: cancelled()` |
| `fromJSON()` | Parser du JSON | `fromJSON(env.CONFIG).env` |
| `toJSON()` | Convertir en JSON | `toJSON(github.event)` |
| `hashFiles()` | Hash de fichiers | `hashFiles('**/package-lock.json')` |

#### **Exemples pratiques**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build
        run: npm run build

      # Exécuter seulement si build a réussi
      - name: Test
        if: success()
        run: npm test

      # Exécuter seulement si test a échoué
      - name: Upload test logs
        if: failure()
        uses: actions/upload-artifact@v4
        with:
          name: test-logs
          path: logs/

      # Toujours exécuter (même si steps précédents échouent)
      - name: Cleanup
        if: always()
        run: rm -rf tmp/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    # Conditions multiples avec opérateurs logiques
    if: |
      github.event_name == 'push' &&
      (github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/tags/v')) &&
      !contains(github.event.head_commit.message, '[skip ci]')

    steps:
      - name: Deploy
        run: echo "Deploying..."
```

#### **Conditions sur matrix**

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        experimental: [false]
        include:
          - os: ubuntu-latest
            experimental: true

    runs-on: ${{ matrix.os }}

    # Continue même si job expérimental échoue
    continue-on-error: ${{ matrix.experimental }}

    steps:
      - name: Run experimental tests
        if: matrix.experimental
        run: npm run test:experimental
```

### 2.5 Expressions et Contextes

GitHub Actions fournit plusieurs contextes pour accéder aux données pendant l'exécution.

#### **Contextes principaux**

| Contexte | Description | Exemple |
|----------|-------------|---------|
| `github` | Informations sur le workflow run | `github.ref`, `github.actor` |
| `env` | Variables d'environnement | `env.NODE_VERSION` |
| `vars` | Variables de configuration | `vars.DEPLOYMENT_ENV` |
| `secrets` | Secrets GitHub | `secrets.API_KEY` |
| `job` | Informations sur le job actuel | `job.status` |
| `steps` | Outputs des steps précédents | `steps.build.outputs.version` |
| `runner` | Informations sur le runner | `runner.os`, `runner.arch` |
| `needs` | Outputs des jobs dépendants | `needs.build.outputs.version` |
| `matrix` | Variables de la matrix | `matrix.os`, `matrix.node-version` |
| `inputs` | Inputs du workflow_dispatch | `inputs.environment` |

#### **Contexte `github`**

```yaml
jobs:
  info:
    runs-on: ubuntu-latest
    steps:
      - name: Display GitHub context
        run: |
          echo "Repository: ${{ github.repository }}"
          echo "Ref: ${{ github.ref }}"
          echo "Ref Name: ${{ github.ref_name }}"
          echo "SHA: ${{ github.sha }}"
          echo "Actor: ${{ github.actor }}"
          echo "Event: ${{ github.event_name }}"
          echo "Run ID: ${{ github.run_id }}"
          echo "Run Number: ${{ github.run_number }}"
          echo "Workflow: ${{ github.workflow }}"
          echo "Base Ref: ${{ github.base_ref }}"      # Branch de base (PR)
          echo "Head Ref: ${{ github.head_ref }}"      # Branch source (PR)
```

**Exemples de valeurs :**

| Variable | Push sur `main` | Pull Request | Tag `v1.0.0` |
|----------|-----------------|--------------|--------------|
| `github.ref` | `refs/heads/main` | `refs/pull/42/merge` | `refs/tags/v1.0.0` |
| `github.ref_name` | `main` | `42/merge` | `v1.0.0` |
| `github.event_name` | `push` | `pull_request` | `push` |
| `github.base_ref` | *(empty)* | `main` | *(empty)* |
| `github.head_ref` | *(empty)* | `feature/login` | *(empty)* |

#### **Contexte `secrets`**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy with secrets
        env:
          # ✅ Bonne pratique : Secrets en env vars
          API_KEY: ${{ secrets.API_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          # Les secrets sont automatiquement masqués dans les logs
          deploy.sh

      # ❌ Mauvaise pratique : Ne jamais exposer les secrets directement
      - name: Bad example
        run: echo "API Key: ${{ secrets.API_KEY }}"  # ❌ Ne pas faire !
```

**⚠️ Sécurité :**
- Les secrets sont **automatiquement masqués** dans les logs : `***`
- Ne jamais afficher un secret avec `echo` ou `print`
- Ne jamais commit un secret dans le code

#### **Contexte `steps` : Outputs entre steps**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Set version
        id: version                          # ID unique du step
        run: |
          VERSION=$(cat package.json | jq -r '.version')
          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "sha=$(git rev-parse --short HEAD)" >> $GITHUB_OUTPUT

      - name: Use version
        run: |
          echo "Version: ${{ steps.version.outputs.version }}"
          echo "SHA: ${{ steps.version.outputs.sha }}"

      - name: Tag image
        run: |
          docker tag myapp:latest myapp:${{ steps.version.outputs.version }}
```

**Syntaxe moderne (2024) :**
```bash
# ✅ Nouvelle syntaxe (recommandée)
echo "key=value" >> $GITHUB_OUTPUT

# ❌ Ancienne syntaxe (deprecated)
echo "::set-output name=key::value"
```

#### **Contexte `needs` : Outputs entre jobs**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}  # Exposer l'output du job
      image-tag: ${{ steps.docker.outputs.tag }}
    steps:
      - id: version
        run: echo "version=$(cat package.json | jq -r '.version')" >> $GITHUB_OUTPUT

      - id: docker
        run: echo "tag=myapp:${{ steps.version.outputs.version }}" >> $GITHUB_OUTPUT

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Pull image
        run: docker pull ${{ needs.build.outputs.image-tag }}

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy version
        run: |
          echo "Deploying version ${{ needs.build.outputs.version }}"
          kubectl set image deployment/myapp myapp=${{ needs.build.outputs.image-tag }}
```

#### **Expressions complexes**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      # Expression ternaire
      ENVIRONMENT: ${{ github.ref == 'refs/heads/main' && 'production' || 'staging' }}

      # Fonction fromJSON
      CONFIG: ${{ fromJSON(secrets.DEPLOYMENT_CONFIG) }}

      # Combinaison de contextes
      IMAGE_TAG: ${{ github.repository }}:${{ github.sha }}

      # Condition complexe
      SHOULD_DEPLOY: ${{
        github.event_name == 'push' &&
        (github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/tags/')) &&
        !contains(github.event.head_commit.message, '[skip ci]')
      }}

    steps:
      - name: Conditional deploy
        if: env.SHOULD_DEPLOY == 'true'
        run: deploy.sh
```

---

## 3. Runners en Profondeur

### 3.1 GitHub-hosted Runners : Spécifications détaillées

#### **Runners standard (2024)**

Depuis 2024, GitHub a **doublé les performances** des runners standard pour les repositories publics :

| Spec | Avant 2024 | Depuis 2024 | Amélioration |
|------|------------|-------------|--------------|
| **CPU** | 2 cores | **4 cores** | +100% |
| **RAM** | 7 GB | **16 GB** | +128% |
| **Stockage** | 14 GB SSD | **14 GB SSD** | = |
| **Performance** | Baseline | **+25% avg** | +25% |

**Impact :** Workflows jusqu'à **25% plus rapides** sans aucun changement de configuration.

#### **Catalogue complet des runners**

**Linux :**

```yaml
jobs:
  ubuntu-standard:
    runs-on: ubuntu-latest        # Ubuntu 22.04, 4 cores, 16 GB RAM

  ubuntu-22:
    runs-on: ubuntu-22.04         # Version fixe (LTS)

  ubuntu-20:
    runs-on: ubuntu-20.04         # Version legacy (support jusqu'en 2025)

  ubuntu-slim:
    runs-on: ubuntu-latest-slim   # 2 cores, 8 GB RAM (moins cher)
```

**Windows :**

```yaml
jobs:
  windows-latest:
    runs-on: windows-latest       # Windows Server 2022, 4 cores, 16 GB RAM

  windows-2022:
    runs-on: windows-2022         # Version fixe

  windows-2019:
    runs-on: windows-2019         # Legacy (support jusqu'en 2024)
```

**macOS :**

```yaml
jobs:
  macos-latest:
    runs-on: macos-latest         # macOS 14 (Sonoma), Apple Silicon M1

  macos-14:
    runs-on: macos-14             # macOS 14 (Sonoma), M1, 3 cores

  macos-13:
    runs-on: macos-13             # macOS 13 (Ventura), Intel, 4 cores

  macos-12:
    runs-on: macos-12             # macOS 12 (Monterey), Intel, 3 cores
```

#### **Larger Runners (GitHub Team / Enterprise)**

Pour les besoins plus importants, GitHub propose des runners avec plus de ressources :

| Label | CPU | RAM | Stockage | Prix (min) |
|-------|-----|-----|----------|------------|
| `ubuntu-latest-4-cores` | 4 cores | 16 GB | 150 GB | $0.008 |
| `ubuntu-latest-8-cores` | 8 cores | 32 GB | 300 GB | $0.016 |
| `ubuntu-latest-16-cores` | 16 cores | 64 GB | 600 GB | $0.032 |
| `ubuntu-latest-32-cores` | 32 cores | 128 GB | 1200 GB | $0.064 |
| `ubuntu-latest-64-cores` | 64 cores | 256 GB | 2040 GB | $0.128 |

**Utilisation :**

```yaml
jobs:
  heavy-build:
    runs-on: ubuntu-latest-16-cores    # 16 cores, 64 GB RAM
    steps:
      - name: Compile large project
        run: make -j16                  # Parallélisation sur 16 cores
```

#### **GPU Runners (ML/AI Workloads)**

Disponibles depuis juillet 2024, les runners GPU incluent des **NVIDIA T4 GPUs** :

```yaml
jobs:
  train-model:
    runs-on: ubuntu-latest-gpu-4-cores    # 4 cores + T4 GPU
    steps:
      - name: Train ML model
        run: python train.py --use-gpu
```

**Spécifications :**
- **GPU :** NVIDIA T4 (16 GB VRAM)
- **CPU :** 4-16 cores
- **RAM :** 28-112 GB
- **Prix :** ~$0.07/min (GPU) + CPU cost

### 3.2 Minutes incluses et Pricing

#### **Minutes gratuites (par mois)**

| Plan | Linux | Windows | macOS |
|------|-------|---------|-------|
| **Free** | 2,000 min | 2,000 min × 2 = 4,000 min consommées* | 2,000 min × 10 = 20,000 min consommées* |
| **Pro** | 3,000 min | 3,000 min × 2 | 3,000 min × 10 |
| **Team** | 3,000 min | 3,000 min × 2 | 3,000 min × 10 |
| **Enterprise** | 50,000 min | 50,000 min × 2 | 50,000 min × 10 |

**Multiplicateurs :**
- Linux : **1×** (baseline)
- Windows : **2×** (coûte 2× plus cher)
- macOS : **10×** (coûte 10× plus cher)

**Exemple :** Un workflow de 100 minutes sur macOS consomme **1,000 minutes** du quota.

#### **Prix au-delà du quota**

| OS | Prix par minute |
|----|----------------|
| Linux | $0.008 |
| Windows | $0.016 |
| macOS | $0.08 |

**Exemple de coût :**

```
Workflow quotidien :
- Build (Linux) : 5 min
- Tests (Windows) : 10 min
- E2E (macOS) : 15 min

Coût par run :
= (5 × $0.008) + (10 × $0.016) + (15 × $0.08)
= $0.04 + $0.16 + $1.20
= $1.40 / run

Coût mensuel (30 jours) : $1.40 × 30 = $42/mois
```

### 3.3 Self-hosted Runners

Les self-hosted runners permettent d'exécuter des workflows sur **votre propre infrastructure**.

#### **Architecture**

```
┌──────────────────────────────────────────────────────────────┐
│                    GITHUB.COM (Cloud)                        │
├──────────────────────────────────────────────────────────────┤
│  Workflow Queue                                              │
│    │                                                          │
│    ├─→ Job 1 ──→ Route to runner with label "self-hosted"   │
│    ├─→ Job 2 ──→ Route to runner with label "linux-arm64"   │
│    └─→ Job 3 ──→ Route to runner with label "gpu-enabled"   │
│                                                              │
│  (Encrypted HTTPS connection)                                │
│    │                                                          │
└────┼──────────────────────────────────────────────────────────┘
     │
     │ Polling (Long-lived HTTPS)
     │
┌────▼──────────────────────────────────────────────────────────┐
│               YOUR INFRASTRUCTURE                             │
├───────────────────────────────────────────────────────────────┤
│                                                               │
│  Self-hosted Runner Agent                                     │
│  ├── Polls for jobs every 1s                                 │
│  ├── Downloads workflow files                                │
│  ├── Executes jobs                                            │
│  ├── Uploads logs & artifacts                                │
│  └── Reports status to GitHub                                │
│                                                               │
│  Installation Options:                                        │
│  ├── Bare metal server                                       │
│  ├── VM (AWS EC2, Azure VM, GCP Compute)                     │
│  ├── Docker container                                         │
│  └── Kubernetes pod                                           │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

#### **Installation d'un self-hosted runner**

**1. Téléchargement et installation (Linux)**

```bash
# Créer un répertoire dédié
mkdir actions-runner && cd actions-runner

# Télécharger le runner (vérifier la dernière version sur GitHub)
curl -o actions-runner-linux-x64-2.311.0.tar.gz \
  -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz

# Extraire
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

# Configurer le runner
./config.sh --url https://github.com/YOUR-ORG/YOUR-REPO \
  --token YOUR-REGISTRATION-TOKEN \
  --name "my-runner" \
  --labels "self-hosted,linux,x64,gpu"

# Démarrer le runner
./run.sh
```

**2. Installation en tant que service (systemd)**

```bash
# Installer en tant que service
sudo ./svc.sh install

# Démarrer le service
sudo ./svc.sh start

# Vérifier le statut
sudo ./svc.sh status
```

**3. Installation avec Docker**

```dockerfile
# Dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    && rm -rf /var/lib/apt/lists/*

# Download and install runner
WORKDIR /actions-runner
RUN curl -o actions-runner-linux-x64-2.311.0.tar.gz \
    -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz \
    && rm actions-runner-linux-x64-2.311.0.tar.gz

# Configure and start runner
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
```

```bash
# start.sh
#!/bin/bash
./config.sh --url https://github.com/${GITHUB_REPOSITORY} \
  --token ${RUNNER_TOKEN} \
  --unattended \
  --replace

./run.sh
```

**4. Installation sur Kubernetes (Helm)**

```bash
# Ajouter le repo Helm
helm repo add actions-runner-controller \
  https://actions-runner-controller.github.io/actions-runner-controller

# Installer le controller
helm install arc actions-runner-controller/actions-runner-controller \
  --namespace actions-runner-system \
  --create-namespace \
  --set authSecret.github_token=${GITHUB_PAT}

# Créer un runner deployment
kubectl apply -f - <<EOF
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: my-runner
spec:
  replicas: 5
  template:
    spec:
      repository: my-org/my-repo
      labels:
        - self-hosted
        - kubernetes
EOF
```

#### **Utilisation dans un workflow**

```yaml
jobs:
  build:
    # Utiliser un self-hosted runner avec label "linux"
    runs-on: [self-hosted, linux]

    steps:
      - uses: actions/checkout@v4
      - run: npm install
      - run: npm test

  build-gpu:
    # Utiliser un runner avec GPU
    runs-on: [self-hosted, linux, gpu]

    steps:
      - name: Train model
        run: python train.py --use-gpu
```

### 3.4 Sécurité des Self-hosted Runners

#### **⚠️ Risques majeurs**

| Risque | Description | Impact |
|--------|-------------|--------|
| **Code malveillant** | Un PR malicieux peut exécuter du code arbitraire | Compromission du runner |
| **Secrets exposés** | Accès aux secrets du repository | Fuite de credentials |
| **Persistance** | État partagé entre runs | Contamination croisée |
| **Réseau** | Accès au réseau interne | Pivot vers infrastructure |

#### **🔒 Best Practices de sécurité**

**1. Ne JAMAIS utiliser de self-hosted runners sur des repos publics**

```yaml
# ❌ DANGER : Ne jamais faire ça sur un repo public
jobs:
  build:
    runs-on: self-hosted    # Risque de compromission !
```

**Pourquoi ?** N'importe qui peut ouvrir une PR et exécuter du code malveillant sur votre infrastructure.

**2. Isolation des runners**

```yaml
# ✅ Bonne pratique : Utiliser des runners éphémères
jobs:
  build:
    runs-on: [self-hosted, ephemeral, docker]
    container:
      image: node:20-alpine    # Exécuter dans un container
```

**3. Limiter l'accès aux workflows spécifiques**

Dans les paramètres de votre repository :
- **Settings** → **Actions** → **Runners** → **Runner groups**
- Sélectionner "Selected workflows only"
- Choisir les workflows autorisés

**4. Principe du moindre privilège**

```bash
# Créer un utilisateur dédié sans privilèges sudo
sudo useradd -m -s /bin/bash github-runner

# Installer le runner avec cet utilisateur
sudo -u github-runner ./config.sh ...
```

**5. Monitoring et logging**

```bash
# Activer l'audit logging
export ACTIONS_RUNNER_PRINT_LOG_TO_STDOUT=1

# Envoyer les logs à un SIEM
./run.sh | tee -a /var/log/github-runner.log
```

**6. Auto-scaling avec destruction post-run**

```yaml
# Exemple avec AWS Auto Scaling Groups
# Le runner est détruit après chaque job (no persistence)
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: ephemeral-runner
spec:
  template:
    spec:
      ephemeral: true          # Détruit après le job
      dockerdWithinRunnerContainer: true
```

### 3.5 Quand choisir Self-hosted ?

| Critère | GitHub-hosted | Self-hosted |
|---------|---------------|-------------|
| **Coût** | Limité par quota | Pas de quota, infrastructure propre |
| **Setup** | ✅ Aucun | ❌ Configuration complexe |
| **Performance** | 4 cores, 16 GB | ✅ Configurable (jusqu'à 128+ cores) |
| **Sécurité** | ✅ Isolation garantie | ❌ Risques de compromission |
| **Maintenance** | ✅ Zéro maintenance | ❌ Updates, monitoring, backups |
| **Accès réseau privé** | ❌ Non | ✅ Accès VPN, bases de données internes |
| **Hardware spécifique** | Limité (GPU en beta) | ✅ GPU, TPU, ARM64, etc. |
| **Compliance** | Servers GitHub (USA) | ✅ Contrôle total (EU, on-premise) |

**Recommandations :**

✅ **Utilisez GitHub-hosted si :**
- Repos publics ou open-source
- Workflows standard (build, test, deploy)
- Pas besoin d'accès réseau privé
- Budget limité

✅ **Utilisez Self-hosted si :**
- Repos privés uniquement
- Besoin de performances élevées (>16 GB RAM)
- Accès à un réseau privé (VPN, databases)
- Hardware spécifique (GPU, ARM64)
- Contraintes de compliance (GDPR, SOC2)

---

## 4. Secrets et Sécurité

### 4.1 GitHub Secrets : Repository, Environment, Organization

GitHub Actions supporte trois niveaux de secrets :

```
Organization Secrets (Org-wide)
    │
    ├── Repository A
    │   ├── Repository Secrets
    │   └── Environment Secrets
    │       ├── development
    │       ├── staging
    │       └── production
    │
    └── Repository B
        ├── Repository Secrets
        └── Environment Secrets
```

#### **1. Repository Secrets**

Secrets disponibles pour **tous les workflows** du repository.

**Configuration :**
- **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        env:
          API_KEY: ${{ secrets.API_KEY }}              # Repository secret
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: deploy.sh
```

#### **2. Environment Secrets**

Secrets spécifiques à un **environnement** (dev, staging, production).

**Configuration :**
- **Settings** → **Environments** → **production** → **Add secret**

```yaml
jobs:
  deploy-prod:
    runs-on: ubuntu-latest
    environment:
      name: production                    # Environnement avec protection rules
    steps:
      - name: Deploy to production
        env:
          PROD_API_KEY: ${{ secrets.PROD_API_KEY }}    # Environment secret
        run: deploy-prod.sh
```

**Avantages des Environment Secrets :**
- ✅ **Protection rules** : Require reviewers, wait timer
- ✅ **Deployment branches** : Limiter à main/release/*
- ✅ **Isolation** : Secrets prod ≠ secrets staging

#### **3. Organization Secrets**

Secrets partagés entre **plusieurs repositories** de l'organisation.

**Configuration :**
- **Organization Settings** → **Secrets and variables** → **Actions** → **New organization secret**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        env:
          ORG_REGISTRY_TOKEN: ${{ secrets.ORG_REGISTRY_TOKEN }}  # Org secret
        run: docker login -u user -p $ORG_REGISTRY_TOKEN
```

**Visibilité :**
- ✅ Tous les repos de l'org
- ✅ Repos sélectionnés uniquement
- ✅ Repos publics exclus

### 4.2 Variables d'environnement

En plus des secrets, GitHub Actions supporte des **variables non-sensibles** :

```yaml
# Variables globales (workflow-level)
env:
  NODE_VERSION: '20'
  BUILD_ENV: production

jobs:
  build:
    runs-on: ubuntu-latest
    # Variables spécifiques au job
    env:
      CACHE_KEY: build-cache-v1

    steps:
      - name: Build
        # Variables spécifiques au step
        env:
          API_ENDPOINT: https://api.example.com
        run: |
          echo "Node version: $NODE_VERSION"
          echo "Build env: $BUILD_ENV"
          echo "Cache key: $CACHE_KEY"
          echo "API: $API_ENDPOINT"
```

**Variables vs Secrets :**

| Critère | Variables (`env`) | Secrets |
|---------|-------------------|---------|
| **Visibilité logs** | ✅ Visible | ❌ Masqué (`***`) |
| **Données sensibles** | ❌ Non | ✅ Oui (API keys, passwords) |
| **Configuration** | Hardcoded dans YAML | Settings → Secrets |
| **Rotation** | Modifier le YAML | Modifier dans Settings |

### 4.3 OIDC (OpenID Connect) pour AWS/Azure/GCP

OIDC permet d'authentifier GitHub Actions auprès des cloud providers **sans stocker de credentials à long terme**.

#### **Pourquoi OIDC ?**

**❌ Méthode traditionnelle (avec secrets) :**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS credentials
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}          # ⚠️ Long-lived
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}  # ⚠️ Risque si fuite
        run: aws s3 cp ./dist s3://my-bucket
```

**Problèmes :**
- ❌ Credentials à long terme (ne expirent jamais)
- ❌ Risque de fuite si compromission
- ❌ Rotation manuelle nécessaire
- ❌ Pas de traçabilité fine

**✅ Méthode OIDC (sans secrets) :**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write        # Requis pour OIDC
      contents: read

    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsRole
          aws-region: us-east-1

      - name: Deploy to S3
        run: aws s3 cp ./dist s3://my-bucket
```

**Avantages :**
- ✅ Credentials éphémères (expiration après 1h)
- ✅ Pas de secrets stockés dans GitHub
- ✅ Fine-grained access control (IAM policies)
- ✅ Audit trail complet (CloudTrail)

#### **Configuration OIDC : AWS**

**1. Créer un Identity Provider dans AWS IAM**

```bash
# Dans AWS Console :
# IAM → Identity providers → Add provider

# Provider type: OpenID Connect
# Provider URL: https://token.actions.githubusercontent.com
# Audience: sts.amazonaws.com
```

**2. Créer un IAM Role avec trust policy**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:my-org/my-repo:*"
        }
      }
    }
  ]
}
```

**Claims OIDC disponibles pour filtrage :**

| Claim | Exemple | Usage |
|-------|---------|-------|
| `sub` | `repo:my-org/my-repo:ref:refs/heads/main` | Limiter à un repo/branch |
| `repository` | `my-org/my-repo` | Limiter à un repo |
| `ref` | `refs/heads/main` | Limiter à une branch |
| `actor` | `john-doe` | Limiter à un utilisateur |
| `workflow` | `deploy-production` | Limiter à un workflow |

**Exemple : Limiter au workflow "deploy" sur la branch "main"**

```json
{
  "Condition": {
    "StringEquals": {
      "token.actions.githubusercontent.com:sub": "repo:my-org/my-repo:ref:refs/heads/main",
      "token.actions.githubusercontent.com:workflow": "deploy-production"
    }
  }
}
```

**3. Utiliser dans GitHub Actions**

```yaml
jobs:
  deploy-to-aws:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsDeployRole
          aws-region: us-east-1

      - name: Deploy to S3
        run: |
          aws s3 sync ./dist s3://my-bucket
          aws cloudfront create-invalidation --distribution-id ABCDEF --paths "/*"
```

#### **Configuration OIDC : Azure**

**1. Créer un Service Principal et une Federated Credential**

```bash
# Créer un Service Principal
az ad sp create-for-rbac \
  --name "github-actions-sp" \
  --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}

# Créer une Federated Credential
az ad app federated-credential create \
  --id <application-id> \
  --parameters '{
    "name": "github-actions-federated",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:my-org/my-repo:ref:refs/heads/main",
    "audiences": ["api://AzureADTokenExchange"]
  }'
```

**2. Utiliser dans GitHub Actions**

```yaml
jobs:
  deploy-to-azure:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v1
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Deploy to Azure App Service
        run: |
          az webapp deploy \
            --resource-group my-rg \
            --name my-app \
            --src-path ./dist
```

#### **Configuration OIDC : Google Cloud (GCP)**

**1. Créer un Workload Identity Pool**

```bash
# Créer un Workload Identity Pool
gcloud iam workload-identity-pools create "github-actions-pool" \
  --location="global"

# Créer un Provider
gcloud iam workload-identity-pools providers create-oidc "github-actions-provider" \
  --workload-identity-pool="github-actions-pool" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository"

# Créer un Service Account
gcloud iam service-accounts create github-actions-sa

# Bind le Service Account au Provider
gcloud iam service-accounts add-iam-policy-binding github-actions-sa@PROJECT_ID.iam.gserviceaccount.com \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/my-org/my-repo"
```

**2. Utiliser dans GitHub Actions**

```yaml
jobs:
  deploy-to-gcp:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read

    steps:
      - uses: actions/checkout@v4

      - name: Authenticate to Google Cloud
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: 'projects/123456789/locations/global/workloadIdentityPools/github-actions-pool/providers/github-actions-provider'
          service_account: 'github-actions-sa@PROJECT_ID.iam.gserviceaccount.com'

      - name: Deploy to Cloud Run
        run: |
          gcloud run deploy my-service \
            --image gcr.io/PROJECT_ID/my-image:latest \
            --region us-central1
```

### 4.4 Permissions du GITHUB_TOKEN

Le `GITHUB_TOKEN` est un token automatique créé pour chaque workflow run.

#### **Permissions disponibles**

| Permission | Niveau | Description |
|------------|--------|-------------|
| `actions` | read/write | Gérer les workflows |
| `checks` | read/write | Créer/modifier des checks |
| `contents` | read/write | Lire/écrire le code |
| `deployments` | read/write | Gérer les déploiements |
| `issues` | read/write | Gérer les issues |
| `packages` | read/write | Publier des packages |
| `pages` | read/write | Publier GitHub Pages |
| `pull-requests` | read/write | Gérer les PRs |
| `repository-projects` | read/write | Gérer les projets |
| `security-events` | read/write | Gérer les alertes de sécurité |
| `statuses` | read/write | Créer des commit statuses |

#### **Configuration des permissions**

**Niveau workflow (recommandé) :**

```yaml
name: CI Pipeline

permissions:
  contents: read          # Lire le code
  pull-requests: write    # Commenter les PRs
  issues: write           # Créer/modifier des issues

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Comment PR
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: context.issue.number,
              body: '✅ Build passed!'
            })
```

**Niveau job (override) :**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read      # Lire seulement
    steps:
      - uses: actions/checkout@v4

  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write     # Publier des packages
    steps:
      - name: Publish to GitHub Packages
        run: npm publish
```

**⚠️ Principe du moindre privilège :**

```yaml
# ❌ Mauvaise pratique : Permissions trop larges
permissions: write-all

# ✅ Bonne pratique : Permissions minimales
permissions:
  contents: read
  pull-requests: write
```

### 4.5 Security Best Practices

#### **1. Ne jamais exposer de secrets**

```yaml
# ❌ DANGER : Ne jamais faire ça !
steps:
  - name: Print secret
    run: echo "API Key: ${{ secrets.API_KEY }}"

# ✅ Bonne pratique
steps:
  - name: Use secret
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: ./deploy.sh    # Le script utilise $API_KEY
```

#### **2. Utiliser OIDC au lieu de credentials à long terme**

```yaml
# ❌ Éviter
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

# ✅ Préférer
permissions:
  id-token: write
steps:
  - uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsRole
```

#### **3. Pinning des actions par SHA (sécurité maximale)**

```yaml
# ✅ Maximum sécurité : SHA commit
- uses: actions/checkout@8f4b7f84864484a7bf31766abe9204da3cbe65b3

# ⚠️ Acceptable : Version majeure
- uses: actions/checkout@v4

# ❌ À éviter : Branch (peut changer)
- uses: actions/checkout@main
```

#### **4. Code scanning avec CodeQL**

```yaml
name: CodeQL Security Scan

on:
  push:
    branches: [main]
  pull_request:
  schedule:
    - cron: '0 0 * * 1'    # Tous les lundis

jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
      contents: read

    strategy:
      matrix:
        language: [javascript, python]

    steps:
      - uses: actions/checkout@v4

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: ${{ matrix.language }}

      - name: Autobuild
        uses: github/codeql-action/autobuild@v3

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
```

#### **5. Dependabot pour les dépendances**

```yaml
# .github/dependabot.yml
version: 2
updates:
  # Dépendances npm
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
    reviewers:
      - "security-team"

  # GitHub Actions
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

---

## 5. Artifacts et Caching

### 5.1 Actions Upload/Download Artifact

Les artifacts permettent de **partager des fichiers entre jobs** ou de **persister des fichiers après le workflow**.

#### **Upload artifacts**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Build application
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-output                # Nom de l'artifact
          path: |                            # Chemins à inclure
            dist/
            build/
            *.log
          retention-days: 7                  # Garder 7 jours (défaut: 90)
          if-no-files-found: error           # Erreur si aucun fichier
          compression-level: 6               # 0-9 (défaut: 6)
```

#### **Download artifacts**

```yaml
jobs:
  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-output                # Nom de l'artifact à télécharger
          path: dist/                        # Destination (défaut: current dir)

      - name: Run tests
        run: npm test
```

#### **Exemple complet : Build → Test → Deploy**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: dist-${{ github.sha }}
          path: dist/
          retention-days: 30

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: dist-${{ github.sha }}
          path: dist/

      - name: Run tests
        run: npm test

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: test-results/

  deploy:
    needs: [build, test]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: dist-${{ github.sha }}
          path: dist/

      - name: Deploy
        run: aws s3 sync dist/ s3://my-bucket
```

### 5.2 Partage d'artifacts entre jobs

**Architecture :**

```
Job 1: Build
    │
    ├─→ Upload artifact "dist"
    │
    ├─→ Job 2: Test (needs: build)
    │      │
    │      └─→ Download artifact "dist"
    │
    └─→ Job 3: Deploy (needs: build)
           │
           └─→ Download artifact "dist"
```

**Multi-artifacts :**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Build frontend
        run: npm run build:frontend

      - name: Upload frontend
        uses: actions/upload-artifact@v4
        with:
          name: frontend
          path: dist/frontend/

      - name: Build backend
        run: npm run build:backend

      - name: Upload backend
        uses: actions/upload-artifact@v4
        with:
          name: backend
          path: dist/backend/

  test-frontend:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: frontend
          path: dist/frontend/

      - run: npm run test:frontend

  test-backend:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: backend
          path: dist/backend/

      - run: npm run test:backend
```

### 5.3 Actions Cache : NPM, Pip, Maven

Le cache permet de **réutiliser des dépendances** entre workflows pour accélérer les builds.

#### **Différence Artifacts vs Cache**

| Critère | Artifacts | Cache |
|---------|-----------|-------|
| **Usage** | Partager entre jobs **du même workflow** | Partager entre **workflows** (runs différents) |
| **Durée de vie** | 90 jours max (configurable) | 7 jours (purge automatique si non utilisé) |
| **Taille max** | 2 GB par artifact | 10 GB total par repository |
| **Use case** | Build outputs, test results | node_modules, .m2, pip cache |

#### **Cache avec Node.js (npm)**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'              # ✅ Cache automatique de npm

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build
```

**Cache manuel (pour plus de contrôle) :**

```yaml
steps:
  - uses: actions/checkout@v4

  - name: Cache node modules
    uses: actions/cache@v4
    with:
      path: ~/.npm                  # Répertoire à cacher
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-

  - name: Install dependencies
    run: npm ci
```

**Comment fonctionne la clé de cache ?**

```yaml
key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
# Exemple : "Linux-node-abc123def456"

# Si package-lock.json change → nouveau hash → nouveau cache
# Si package-lock.json identique → même hash → cache hit
```

#### **Cache avec Python (pip)**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
          cache: 'pip'              # ✅ Cache automatique de pip

      - name: Install dependencies
        run: pip install -r requirements.txt
```

**Cache manuel :**

```yaml
steps:
  - uses: actions/checkout@v4

  - name: Cache pip packages
    uses: actions/cache@v4
    with:
      path: ~/.cache/pip
      key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
      restore-keys: |
        ${{ runner.os }}-pip-

  - name: Install dependencies
    run: pip install -r requirements.txt
```

#### **Cache avec Java (Maven)**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'            # ✅ Cache automatique de Maven

      - name: Build with Maven
        run: mvn clean install
```

**Cache manuel :**

```yaml
steps:
  - uses: actions/checkout@v4

  - name: Cache Maven packages
    uses: actions/cache@v4
    with:
      path: ~/.m2/repository
      key: ${{ runner.os }}-maven-${{ hashFiles('**/pom.xml') }}
      restore-keys: |
        ${{ runner.os }}-maven-

  - name: Build with Maven
    run: mvn clean install
```

#### **Cache multi-chemins**

```yaml
steps:
  - name: Cache dependencies
    uses: actions/cache@v4
    with:
      path: |
        ~/.npm
        ~/.cache
        node_modules
        vendor/
      key: ${{ runner.os }}-deps-${{ hashFiles('**/package-lock.json', '**/composer.lock') }}
      restore-keys: |
        ${{ runner.os }}-deps-
```

### 5.4 Cache Hits et Misses

#### **Stratégie de clé de cache**

```yaml
# Primary key (exact match)
key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}-${{ github.sha }}

# Fallback keys (partial match)
restore-keys: |
  ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}-
  ${{ runner.os }}-npm-
  ${{ runner.os }}-
```

**Ordre de recherche :**
1. ✅ **Cache hit** : Clé exacte trouvée → restauration complète
2. ⚠️ **Partial cache hit** : `restore-keys` matchée → restauration partielle
3. ❌ **Cache miss** : Aucune clé trouvée → build from scratch

#### **Exemple de logs**

```
Cache hit on key: Linux-npm-abc123def456-789xyz
Cache restored successfully from key: Linux-npm-abc123def456-789xyz
```

```
Cache miss on primary key: Linux-npm-abc123def456-789xyz
Cache restored from fallback key: Linux-npm-abc123def456-
Partial cache hit (restore-keys)
```

### 5.5 Optimisation des temps de build

#### **Stratégies d'optimisation**

**1. Cache granulaire**

```yaml
# ❌ Cache trop large (invalidé souvent)
key: ${{ runner.os }}-deps

# ✅ Cache spécifique (invalidé seulement si package-lock.json change)
key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
```

**2. Cache multi-niveaux**

```yaml
steps:
  # Niveau 1 : Cache des packages npm
  - uses: actions/cache@v4
    with:
      path: ~/.npm
      key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}

  # Niveau 2 : Cache de node_modules (plus rapide à restaurer)
  - uses: actions/cache@v4
    with:
      path: node_modules
      key: ${{ runner.os }}-node-modules-${{ hashFiles('**/package-lock.json') }}

  - run: npm ci
```

**3. Parallélisation + Cache**

```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/cache@v4
        with:
          path: node_modules
          key: ${{ runner.os }}-nm-${{ hashFiles('**/package-lock.json') }}

      - run: npm ci

      # Pas besoin d'upload artifact, le cache est partagé

  test-unit:
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/cache@v4
        with:
          path: node_modules
          key: ${{ runner.os }}-nm-${{ hashFiles('**/package-lock.json') }}

      - run: npm test:unit

  test-integration:
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/cache@v4
        with:
          path: node_modules
          key: ${{ runner.os }}-nm-${{ hashFiles('**/package-lock.json') }}

      - run: npm test:integration
```

**Gains de performance :**

| Scénario | Sans cache | Avec cache | Gain |
|----------|------------|------------|------|
| npm install (Node.js) | 60s | 10s | **83%** |
| pip install (Python) | 45s | 8s | **82%** |
| mvn clean install (Java) | 120s | 15s | **87%** |

---

## 6. Reusable Workflows

Les reusable workflows permettent de **DRY (Don't Repeat Yourself)** vos pipelines CI/CD.

### 6.1 Workflow Call Event

Un reusable workflow est appelé via l'événement `workflow_call`.

#### **Workflow réutilisable (appelé)**

```yaml
# .github/workflows/reusable-build.yml
name: Reusable Build Workflow

on:
  workflow_call:
    inputs:
      node-version:
        description: 'Node.js version to use'
        required: false
        type: string
        default: '20'

      build-command:
        description: 'Build command to run'
        required: false
        type: string
        default: 'npm run build'

      artifact-name:
        description: 'Name of the artifact'
        required: true
        type: string

    secrets:
      NPM_TOKEN:
        description: 'NPM token for private packages'
        required: false

    outputs:
      build-version:
        description: "Version of the build"
        value: ${{ jobs.build.outputs.version }}

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          cache: 'npm'

      - name: Install dependencies
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
        run: npm ci

      - name: Build
        run: ${{ inputs.build-command }}

      - name: Extract version
        id: version
        run: echo "version=$(jq -r '.version' package.json)" >> $GITHUB_OUTPUT

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: ${{ inputs.artifact-name }}
          path: dist/
```

#### **Workflow appelant**

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:

jobs:
  build-frontend:
    uses: ./.github/workflows/reusable-build.yml
    with:
      node-version: '20'
      build-command: 'npm run build:frontend'
      artifact-name: 'frontend-dist'
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}

  build-backend:
    uses: ./.github/workflows/reusable-build.yml
    with:
      node-version: '18'
      build-command: 'npm run build:backend'
      artifact-name: 'backend-dist'

  deploy:
    needs: [build-frontend, build-backend]
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        run: |
          echo "Frontend version: ${{ needs.build-frontend.outputs.build-version }}"
          echo "Backend version: ${{ needs.build-backend.outputs.build-version }}"
```

### 6.2 Inputs et Secrets

#### **Types d'inputs supportés**

| Type | Description | Exemple |
|------|-------------|---------|
| `string` | Chaîne de caractères | `'main'`, `'v1.0.0'` |
| `number` | Nombre | `42`, `3.14` |
| `boolean` | Booléen | `true`, `false` |
| `choice` | Liste de choix | `['dev', 'staging', 'prod']` |

```yaml
on:
  workflow_call:
    inputs:
      environment:
        type: choice
        required: true
        options:
          - development
          - staging
          - production

      timeout:
        type: number
        default: 30

      dry-run:
        type: boolean
        default: false
```

#### **Secrets inheritance**

```yaml
# Option 1 : Passer tous les secrets
jobs:
  deploy:
    uses: ./.github/workflows/reusable-deploy.yml
    secrets: inherit                # ✅ Passe tous les secrets

# Option 2 : Passer des secrets spécifiques
jobs:
  deploy:
    uses: ./.github/workflows/reusable-deploy.yml
    secrets:
      API_KEY: ${{ secrets.PROD_API_KEY }}
      DATABASE_URL: ${{ secrets.PROD_DATABASE_URL }}
```

### 6.3 Outputs de workflows réutilisables

```yaml
# Reusable workflow
on:
  workflow_call:
    outputs:
      version:
        description: "Application version"
        value: ${{ jobs.build.outputs.version }}

      image-tag:
        description: "Docker image tag"
        value: ${{ jobs.build.outputs.image-tag }}

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
      image-tag: ${{ steps.docker.outputs.tag }}

    steps:
      - id: version
        run: echo "version=$(cat package.json | jq -r '.version')" >> $GITHUB_OUTPUT

      - id: docker
        run: echo "tag=myapp:${{ steps.version.outputs.version }}" >> $GITHUB_OUTPUT
```

```yaml
# Caller workflow
jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy
        run: |
          echo "Deploying version: ${{ needs.build.outputs.version }}"
          kubectl set image deployment/myapp myapp=${{ needs.build.outputs.image-tag }}
```

### 6.4 Exemples pratiques

#### **Exemple 1 : Reusable Deploy Workflow**

```yaml
# .github/workflows/reusable-deploy.yml
name: Reusable Deploy

on:
  workflow_call:
    inputs:
      environment:
        type: choice
        required: true
        options: [dev, staging, production]

      version:
        type: string
        required: true

    secrets:
      AWS_ACCESS_KEY_ID:
        required: true
      AWS_SECRET_ACCESS_KEY:
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: ${{ inputs.environment }}
      url: https://${{ inputs.environment }}.example.com

    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Deploy to ${{ inputs.environment }}
        run: |
          echo "Deploying version ${{ inputs.version }} to ${{ inputs.environment }}"
          aws s3 sync ./dist s3://my-bucket-${{ inputs.environment }}
```

```yaml
# .github/workflows/production.yml
name: Production Deployment

on:
  push:
    tags:
      - 'v*'

jobs:
  deploy-staging:
    uses: ./.github/workflows/reusable-deploy.yml
    with:
      environment: staging
      version: ${{ github.ref_name }}
    secrets:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

  deploy-production:
    needs: deploy-staging
    uses: ./.github/workflows/reusable-deploy.yml
    with:
      environment: production
      version: ${{ github.ref_name }}
    secrets:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

#### **Exemple 2 : Reusable Matrix Test Workflow**

```yaml
# .github/workflows/reusable-test.yml
name: Reusable Test Suite

on:
  workflow_call:
    inputs:
      test-command:
        type: string
        default: 'npm test'

      node-versions:
        type: string
        default: '["18", "20"]'

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: ${{ fromJSON(inputs.node-versions) }}

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: ${{ inputs.test-command }}
```

```yaml
# Caller
jobs:
  test:
    uses: ./.github/workflows/reusable-test.yml
    with:
      test-command: 'npm run test:coverage'
      node-versions: '["18", "20", "21"]'
```

---

## 7. Custom Actions

Les custom actions permettent d'encapsuler de la logique complexe dans des **blocs réutilisables**.

### 7.1 Types d'actions

| Type | Langage | Utilisation | Performance |
|------|---------|-------------|-------------|
| **JavaScript** | Node.js | Logique simple, API calls | ⚡ Très rapide |
| **Docker Container** | Any language | Environnement custom | 🐢 Lent (build image) |
| **Composite** | YAML | Combinaison de steps | ⚡ Rapide |

### 7.2 JavaScript Actions

Les JavaScript actions sont exécutées directement par Node.js.

#### **Structure d'une JavaScript action**

```
my-action/
├── action.yml          # Metadata
├── index.js            # Entry point
├── package.json
└── node_modules/
```

#### **action.yml**

```yaml
name: 'My Custom Action'
description: 'A custom GitHub Action'
author: 'Your Name'

inputs:
  api-key:
    description: 'API key for authentication'
    required: true

  environment:
    description: 'Target environment'
    required: false
    default: 'production'

outputs:
  deployment-url:
    description: 'URL of the deployment'

runs:
  using: 'node20'         # Node.js runtime version
  main: 'dist/index.js'   # Entry point (compiled)
```

#### **index.js**

```javascript
const core = require('@actions/core');
const github = require('@actions/github');

async function run() {
  try {
    // Get inputs
    const apiKey = core.getInput('api-key', { required: true });
    const environment = core.getInput('environment');

    // Log info
    core.info(`Deploying to ${environment}...`);

    // Perform deployment
    const deploymentUrl = await deploy(apiKey, environment);

    // Set output
    core.setOutput('deployment-url', deploymentUrl);

    // Set success
    core.notice(`✅ Deployed successfully to ${deploymentUrl}`);
  } catch (error) {
    core.setFailed(error.message);
  }
}

async function deploy(apiKey, environment) {
  // Deployment logic here
  return `https://${environment}.example.com`;
}

run();
```

#### **package.json**

```json
{
  "name": "my-custom-action",
  "version": "1.0.0",
  "description": "My custom GitHub Action",
  "main": "dist/index.js",
  "scripts": {
    "build": "ncc build index.js -o dist"
  },
  "dependencies": {
    "@actions/core": "^1.10.0",
    "@actions/github": "^6.0.0"
  },
  "devDependencies": {
    "@vercel/ncc": "^0.38.0"
  }
}
```

#### **Build et utilisation**

```bash
# Install dependencies
npm install

# Compile (bundle to single file)
npm run build

# Commit dist/index.js
git add dist/index.js
git commit -m "Build action"
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

```yaml
# Utilisation
steps:
  - name: Deploy with custom action
    uses: my-org/my-action@v1
    with:
      api-key: ${{ secrets.API_KEY }}
      environment: production
```

### 7.3 Docker Container Actions

Les Docker container actions permettent d'utiliser **n'importe quel langage** ou environnement.

#### **Structure**

```
my-docker-action/
├── action.yml
├── Dockerfile
└── entrypoint.sh
```

#### **action.yml**

```yaml
name: 'Docker Action Example'
description: 'A Docker-based GitHub Action'

inputs:
  name:
    description: 'Name to greet'
    required: true

outputs:
  greeting:
    description: 'The greeting message'

runs:
  using: 'docker'
  image: 'Dockerfile'
  args:
    - ${{ inputs.name }}
```

#### **Dockerfile**

```dockerfile
FROM alpine:3.18

# Install dependencies
RUN apk add --no-cache bash curl jq

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
```

#### **entrypoint.sh**

```bash
#!/bin/bash
set -e

NAME="$1"

echo "Hello, $NAME!"

# Set output
echo "greeting=Hello, $NAME!" >> $GITHUB_OUTPUT
```

#### **Utilisation**

```yaml
steps:
  - name: Run Docker action
    uses: my-org/my-docker-action@v1
    with:
      name: 'GitHub Actions'
```

**⚠️ Performance :** Docker actions sont **lents** (build de l'image à chaque run). Préférez JavaScript ou Composite pour de meilleures performances.

### 7.4 Composite Actions

Les composite actions combinent plusieurs steps en une seule action.

#### **Structure**

```
my-composite-action/
└── action.yml
```

#### **action.yml**

```yaml
name: 'Setup Node.js and Cache'
description: 'Setup Node.js with npm cache'

inputs:
  node-version:
    description: 'Node.js version'
    required: false
    default: '20'

runs:
  using: "composite"
  steps:
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: ${{ inputs.node-version }}
        cache: 'npm'

    - name: Install dependencies
      shell: bash
      run: npm ci

    - name: Cache node_modules
      uses: actions/cache@v4
      with:
        path: node_modules
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

#### **Utilisation**

```yaml
steps:
  - uses: actions/checkout@v4

  - name: Setup environment
    uses: my-org/setup-node-cache@v1
    with:
      node-version: '20'

  - name: Build
    run: npm run build
```

**Avantages :**
- ✅ Simple à créer (YAML only)
- ✅ Rapide (pas de build Docker)
- ✅ Facile à maintenir

### 7.5 Publication sur Marketplace

#### **1. Préparer l'action**

```yaml
# action.yml - Métadonnées complètes
name: 'My Awesome Action'
description: 'A comprehensive description of what the action does'
author: 'Your Name or Organization'

branding:
  icon: 'check-circle'      # Icône Feather Icons
  color: 'green'            # Couleur (green, blue, red, etc.)

inputs:
  # ... définir les inputs

outputs:
  # ... définir les outputs

runs:
  # ... configuration d'exécution
```

#### **2. Créer un README.md**

```markdown
# My Awesome Action

## Description
Detailed description of the action.

## Usage
```yaml
steps:
  - uses: my-org/my-action@v1
    with:
      input1: value
```

## Inputs
| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `input1` | Description | Yes | - |

## Outputs
| Output | Description |
|--------|-------------|
| `output1` | Description |

## Example
Full example workflow.

## License
MIT
```

#### **3. Versioning et releases**

```bash
# Tag une version majeure (v1, v2)
git tag -a v1 -m "Version 1"
git push origin v1

# Tag une version mineure (v1.0.0)
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0

# Mettre à jour le tag majeur après un patch
git tag -fa v1 -m "Update v1 to v1.0.1"
git push origin v1 --force
```

**Best practice :** Maintenir les tags majeurs (v1, v2) pour les utilisateurs qui veulent les derniers patches.

#### **4. Publier sur Marketplace**

1. Aller sur **GitHub Repository** → **Releases** → **Draft a new release**
2. Choisir le tag (v1.0.0)
3. ✅ Cocher **"Publish this Action to the GitHub Marketplace"**
4. Remplir :
   - Primary category (CI/CD, Testing, etc.)
   - Icon et color (depuis action.yml)
5. Publier

**🎉 Votre action est maintenant sur le Marketplace !**

---

## Références (Suite de la Partie 2)

### GitHub Actions Official Documentation

40. **Workflow Syntax for GitHub Actions - GitHub Docs**
    - https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax

41. **Events that Trigger Workflows - GitHub Docs**
    - https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows

42. **GitHub-hosted Runners Reference - GitHub Docs**
    - https://docs.github.com/en/actions/reference/runners/github-hosted-runners

43. **About Larger Runners - GitHub Docs**
    - https://docs.github.com/en/actions/using-github-hosted-runners/using-larger-runners/about-larger-runners

### Runners and Performance

44. **GitHub-hosted Runners: Double the Power for Open Source - GitHub Blog (2024)**
    - https://github.blog/news-insights/product-news/github-hosted-runners-double-the-power-for-open-source/

45. **GPU Hosted Runners Generally Available - GitHub Changelog (July 2024)**
    - https://github.blog/changelog/2024-07-08-github-actions-gpu-hosted-runners-are-now-generally-available/

46. **Self-hosted Runners - GitHub Docs**
    - https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners

47. **Architecture Guide to Self-hosted GitHub Actions - Some Natalie**
    - https://some-natalie.dev/blog/arch-guide-to-selfhosted-actions/

### Security

48. **Security Hardening for GitHub Actions - GitHub Docs**
    - https://docs.github.com/actions/security-guides/security-hardening-for-github-actions

49. **Using Secrets in GitHub Actions - GitHub Docs**
    - https://docs.github.com/actions/security-guides/using-secrets-in-github-actions

50. **OpenID Connect (OIDC) - GitHub Docs**
    - https://docs.github.com/en/actions/concepts/security/openid-connect

51. **Secure Deployments with OIDC & GitHub Actions - GitHub Blog (2021)**
    - https://github.blog/2021-11-23-secure-deployments-openid-connect-github-actions-generally-available/

52. **Use IAM Roles to Connect GitHub Actions to AWS - AWS Blog**
    - https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/

53. **Self-hosted GitHub Runners Security Best Practices**
    - https://github.com/dduzgun-security/github-self-hosted-runners

54. **Harden-Runner: CI/CD Security Agent for GitHub Actions - Step Security**
    - https://github.com/step-security/harden-runner

### Matrix Strategy

55. **GitHub Actions Matrix Strategy - Codefresh**
    - https://codefresh.io/learn/github-actions/github-actions-matrix/

56. **Running Variations of Jobs in a Workflow - GitHub Docs**
    - https://docs.github.com/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow

57. **The Matrix Strategy in GitHub Actions - RunsOn**
    - https://runs-on.com/github-actions/the-matrix-strategy/

58. **Matrix Strategies in GitHub Actions - Medium (Credera)**
    - https://medium.com/credera-engineering/matrix-strategies-in-github-actions-56dd6defeb04

### Caching and Artifacts

59. **GitHub Actions Caching and Performance Optimization - Medium (Amaresh Pelleti, Sept 2025)**
    - https://medium.com/@amareswer/github-actions-caching-and-performance-optimization-38c76ac29151

60. **Dependency Caching Reference - GitHub Docs**
    - https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows

61. **actions/cache - GitHub Repository**
    - https://github.com/actions/cache

62. **Difference Between Artifacts and Cache in GitHub Actions - Echobind**
    - https://echobind.com/post/difference-between-artifacts-and-cache-in-GitHub-Actions

63. **Understanding Job Artifacts, Outputs, and Dependency Caching - Medium (Rushain Sovis)**
    - https://medium.com/@sovisrushain/understanding-job-artifacts-job-outputs-and-dependency-caching-in-github-actions-23c68cb51091

### Reusable Workflows and Custom Actions

64. **Reusing Workflow Configurations - GitHub Docs**
    - https://docs.github.com/en/actions/concepts/workflows-and-actions/reusing-workflow-configurations

65. **Composite Actions vs Reusable Workflows - DEV Community (N3WT0N, 2023)**
    - https://dev.to/n3wt0n/github-composite-actions-vs-reusable-workflows-updated-2023-bl8

66. **How to Reuse Workflows and Steps in GitHub Actions (2024) - Victor On Software**
    - https://victoronsoftware.com/posts/github-reusable-workflows-and-steps/

67. **Composite Actions - James Wallis**
    - https://wallis.dev/blog/composite-github-actions

68. **Creating Actions - GitHub Docs**
    - https://docs.github.com/en/actions/creating-actions

69. **Publishing Actions in GitHub Marketplace - GitHub Docs**
    - https://docs.github.com/en/actions/creating-actions/publishing-actions-in-github-marketplace

### Advanced Topics

70. **Contexts Reference - GitHub Docs**
    - https://docs.github.com/en/actions/learn-github-actions/contexts

71. **Store Information in Variables - GitHub Docs**
    - https://docs.github.com/en/actions/learn-github-actions/variables

72. **GitHub Actions Environment Variables and Contexts - Snyk**
    - https://snyk.io/blog/how-to-use-github-actions-environment-variables/

73. **Understanding Contexts in GitHub Actions - Graphite**
    - https://graphite.com/guides/github-actions-contexts

---

## Conclusion de la Partie 3

Cette troisième partie a fourni un **deep dive technique complet** sur GitHub Actions, couvrant :

✅ **Architecture détaillée** : Workflows, Events, Jobs, Steps, Actions, Runners
✅ **Syntaxe YAML complète** : Triggers avancés, Matrix strategy, Conditions, Expressions, Contextes
✅ **Runners en profondeur** : GitHub-hosted (standard, larger, GPU), Self-hosted (installation, sécurité, quand les utiliser)
✅ **Secrets et sécurité** : Repository/Environment/Org secrets, OIDC (AWS/Azure/GCP), GITHUB_TOKEN, Best practices
✅ **Artifacts et Caching** : Partage entre jobs, Stratégies de cache (npm, pip, Maven), Optimisations (gains de 70-87%)
✅ **Reusable Workflows** : workflow_call, Inputs/Secrets/Outputs, Exemples pratiques
✅ **Custom Actions** : JavaScript, Docker, Composite, Publication sur Marketplace

**Points clés à retenir :**

1. **Runners** : GitHub a doublé les performances (4 cores, 16 GB RAM) en 2024 → workflows jusqu'à 25% plus rapides
2. **OIDC** : Éliminer les credentials à long terme → sécurité renforcée avec tokens éphémères
3. **Caching** : Réduction de 70-87% du temps de build avec stratégies de cache optimisées
4. **Matrix strategy** : Tester sur plusieurs OS/versions en parallèle avec include/exclude pour contrôle granulaire
5. **Reusable workflows** : DRY your pipelines → maintainability et consistance
6. **Self-hosted runners** : Puissance et flexibilité, mais risques de sécurité (jamais sur repos publics)

**🎯 Prochaines étapes recommandées :**

- **Partie 4 (optionnelle)** : Cas d'usage avancés (Monorepos, Multi-cloud, GitOps, etc.)
- **Workshops pratiques** : Hands-on labs pour appliquer ces concepts
- **Migration guide** : De Jenkins/CircleCI/GitLab CI vers GitHub Actions

---

**📄 FIN DE LA PARTIE 3**

**Statistiques :**
- **~9,200 mots**
- **73 références** (40-73, suite de la Partie 2)
- **50+ exemples de code** fonctionnels et commentés
- **15+ diagrammes** d'architecture

Cette partie complète le module CI/CD & GitHub Actions avec un niveau de détail technique adapté à des étudiants en ingénierie DevOps. 🚀
