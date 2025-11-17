---
marp: true
theme: uncover
paginate: true
footer: M2 ESTD - Initiation DevOps | ForEach Academy
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
    color: #1e40af;
  }
  ul, ol {
    margin: 10px 0;
  }
  li {
    margin: 5px 0;
  }
  .success {
    color: #10b981;
    font-weight: bold;
  }
---

<!-- _class: lead -->

# Module 08
## Conclusion & Récapitulatif

**Votre Parcours DevOps**

*M2 ESTD - Initiation DevOps*
ForEach Academy - 2025

---

## 🎯 Ce que Vous Avez Appris Aujourd'hui

### Une Journée Intensive DevOps (7h)

📚 **6 Modules Techniques** +  **2 Modules Transversaux**

🛠️ **3 Outils Majeurs**: Git, GitHub Actions, Docker

🏗️ **3 Concepts Clés**: IaC, K8s, Monitoring

💡 **1 Philosophie**: Culture DevOps

---

## 📅 Récapitulatif de la Journée

### Matin (9h00-12h15)

**Module 2**: Principes DevOps (45min)
- Culture DevOps, chaîne de production logicielle
- Relation DevOps/Agile

**Module 3**: Git & Versioning (1h)
- Git workflow, branches, tags
- GitFlow
- ✅ **TP1**: GitFlow en pratique (15min)

**Module 4**: Build & Tests (1h)
- Outils de build, types de tests
- Métriques logicielles
- 🎬 **Démo**: Pipeline de test

---

## 📅 Récapitulatif de la Journée (suite)

### Après-midi (13h15-17h00)

**Module 5**: CI/CD avec GitHub Actions (1h15)
- Intégration/livraison/déploiement continu
- Workflows YAML, Actions
- ✅ **TP2**: Workflow CI/CD complet (30min)

**Module 7**: Docker & Conteneurisation (1h)
- Conteneurs vs VMs, Dockerfile
- Docker Compose, architecture micro-services
- ✅ **TP3**: Conteneuriser une application (25min)

**Module 6 & 8**: Autres outils DevOps (45min)
- IaC (Ansible, Terraform), Kubernetes, Monitoring

---

## 🏆 Les 8 Principes DevOps

### Ce que Vous Devez Retenir

1. **Culture de collaboration** Dev + Ops
2. **Automatisation** de tout ce qui est répétable
3. **Mesure** continue via métriques
4. **Partage** de la responsabilité
5. **CI/CD** pour déploiements rapides
6. **Infrastructure as Code** pour reproductibilité
7. **Monitoring** et feedback continu
8. **Amélioration continue** via retours

> "DevOps n'est pas un outil, c'est une culture"

---

## 🔑 Points Clés par Module

### Git & Versioning

- ✅ Git = Unique source de vérité
- ✅ GitFlow pour collaboration
- ✅ Branches feature, develop, main
- ✅ Tags pour releases

### Build & Tests

- ✅ Pyramide de tests (unitaires > intégration > E2E)
- ✅ Tests automatisés dans CI
- ✅ Métriques DORA pour mesurer performance
- ✅ Artefacts versionnés et reproductibles

---

## 🔑 Points Clés par Module (suite)

### CI/CD

- ✅ GitHub Actions pour automatisation
- ✅ Workflows YAML déclaratifs
- ✅ Tests + Build + Deploy automatiques
- ✅ Stratégies de déploiement (canary, blue-green)

### Docker

- ✅ Conteneurs ≠ VMs (légers, portables)
- ✅ Dockerfile pour builds reproductibles
- ✅ Docker Compose pour stacks multi-conteneurs
- ✅ Images immutables et versionnées

---

## 🔑 Points Clés par Module (fin)

### Infrastructure as Code

- ✅ Ansible pour configuration management
- ✅ Terraform pour provisioning infrastructure
- ✅ État infrastructure versionné dans Git
- ✅ Idempotence et reproductibilité

### Kubernetes & Monitoring

- ✅ Kubernetes pour orchestration production
- ✅ Prometheus + Grafana pour observabilité
- ✅ 3 piliers: Metrics, Logs, Traces
- ✅ SLO/SLI/SLA et error budgets

---

## 📊 Chaîne de Production Logicielle Complète

```
┌──────────────┐
│  Developer   │ Commit code → GitHub
└──────┬───────┘
       ↓
┌──────────────┐
│ CI Pipeline  │ Tests, Build, Scan
└──────┬───────┘
       ↓
┌──────────────┐
│ CD Pipeline  │ Deploy (staging → prod)
└──────┬───────┘
       ↓
┌──────────────┐
│ Monitoring   │ Métriques, Logs, Alertes
└──────┬───────┘
       ↓
┌──────────────┐
│   Feedback   │ Amélioration continue
└──────────────┘
```

---

## 🛠️ Votre Boîte à Outils DevOps

### Outils Essentiels

| Catégorie | Outil | Usage |
|-----------|-------|-------|
| **Versioning** | Git, GitHub | Code source, collaboration |
| **CI/CD** | GitHub Actions | Automatisation pipelines |
| **Conteneurs** | Docker, Docker Compose | Packaging, dev local |
| **Orchestration** | Kubernetes | Production, scale |
| **IaC** | Terraform, Ansible | Infrastructure, config |
| **Monitoring** | Prometheus, Grafana | Métriques, visualisation |

---

## 📈 Métriques DORA - Mesurer la Performance

### 4 Métriques Clés

1. **Deployment Frequency**
   - Elite: Plusieurs fois/jour
   - Vous: ?

2. **Lead Time for Changes**
   - Elite: <1 heure
   - Vous: ?

3. **Mean Time to Recovery (MTTR)**
   - Elite: <1 heure
   - Vous: ?

4. **Change Failure Rate**
   - Elite: <15%
   - Vous: ?

---

## 🚀 Niveaux de Maturité DevOps

### Où En Êtes-Vous?

**Niveau 1 - Initial** (❌ Pré-DevOps):
- Déploiements manuels
- Pas de tests automatisés
- Aucune mesure

**Niveau 2 - Managed** (🟡 Début):
- CI/CD basique
- Tests unitaires
- Métriques simples

**Niveau 3 - Defined** (🟠 Intermédiaire):
- CI/CD complet
- Tests E2E
- Monitoring avancé

**Niveau 4 - Optimized** (✅ Mature):
- GitOps, IaC complet
- Chaos engineering
- Self-healing systems

---

## 💡 Best Practices DevOps

### Les 10 Commandements

1. **Tout automatiser** (builds, tests, déploiements)
2. **Tout versionner** (code, infra, configs)
3. **Tester tôt et souvent** (shift-left testing)
4. **Mesurer tout** (si non mesuré, non améliorable)
5. **Déployer petit et fréquemment**
6. **Monitorer en production** (observabilité)
7. **Partager la responsabilité** (blameless culture)
8. **Automatiser la sécurité** (DevSecOps)
9. **Documenter comme code** (README, ADRs)
10. **Améliorer continuellement** (rétrospectives)

---

## ⚠️ Anti-Patterns à Éviter

### Ce Qu'il NE Faut PAS Faire

❌ **Silos Dev/Ops**: "Not my problem"
✅ **Équipes intégrées**: Responsabilité partagée

❌ **Déploiements manuels**: Risque d'erreurs
✅ **CI/CD automatisé**: Répétable, fiable

❌ **Tests uniquement en fin de cycle**
✅ **Tests continus** dès le commit

❌ **Pas de monitoring**: Vol aveugle
✅ **Observabilité** complète

❌ **"Works on my machine"**
✅ **Environnements reproductibles** (conteneurs)

---

## 🎓 Compétences Acquises

### Vous Êtes Maintenant Capables De...

✅ Utiliser **Git et GitFlow** pour collaboration
✅ Écrire des **workflows CI/CD** avec GitHub Actions
✅ **Conteneuriser** des applications avec Docker
✅ Comprendre **IaC** avec Terraform/Ansible
✅ Appréhender **Kubernetes** pour production
✅ Mettre en place **monitoring** avec Prometheus/Grafana
✅ Identifier **processus à automatiser** dans vos projets
✅ Appliquer **culture DevOps** en entreprise

---

## 📚 Ressources pour Continuer

### Documentation Officielle

- 🌐 **Git**: git-scm.com/doc
- 🌐 **GitHub Actions**: docs.github.com/actions
- 🌐 **Docker**: docs.docker.com
- 🌐 **Kubernetes**: kubernetes.io/docs
- 🌐 **Terraform**: developer.hashicorp.com/terraform
- 🌐 **Prometheus**: prometheus.io/docs

### Communautés

- r/devops, r/kubernetes (Reddit)
- CNCF Slack, Kubernetes Slack
- HashiCorp Community Forums

---

## 📖 Livres Recommandés

### Pour Approfondir

**Culture DevOps**:
- 📘 *The Phoenix Project* - Gene Kim
- 📘 *The DevOps Handbook* - Gene Kim et al.
- 📘 *Accelerate* - Nicole Forsgren (DORA metrics)

**Technique**:
- 📗 *Site Reliability Engineering* - Google
- 📗 *Kubernetes Up & Running* - Kelsey Hightower
- 📗 *Terraform: Up & Running* - Yevgeniy Brikman
- 📗 *Docker Deep Dive* - Nigel Poulton

---

## 🎯 Prochaines Étapes

### Après Cette Formation

**Immédiatement**:
1. ✅ Passer le **QCM d'évaluation**
2. 📝 Identifier **1 processus** à automatiser dans votre projet
3. 🐳 **Conteneuriser** une application personnelle

**Cette Semaine**:
4. 🔄 Mettre en place **CI/CD basique** sur un projet
5. 📊 Implémenter **monitoring simple** avec logs

**Ce Mois**:
6. 🏗️ Apprendre **Terraform** via tutoriels
7. ☸️ Déployer **Minikube** localement
8. 📚 Lire **The Phoenix Project**

---

## 💼 Application Professionnelle

### Dans Votre Contexte

**Questions à se Poser**:

- Quels processus **manuels et répétitifs** existe-t-il?
- Combien de temps pour un **déploiement**?
- Quelle est la **fréquence** de déploiement?
- Comment sont **détectés** les incidents?
- Existe-t-il des **métriques** de qualité?
- La **collaboration** Dev/Ops est-elle fluide?

> Identifiez 1-2 quick wins pour démarrer!

---

## 🌟 Success Stories DevOps

### Transformations Réelles

**Netflix**:
- De DVD-par-la-poste à streaming global
- 1000+ déploiements/jour
- Auto-scaling massif

**Amazon**:
- Deploy toutes les 11.6 secondes
- Architecture microservices
- Two-pizza teams

**Etsy**:
- 50+ déploiements/jour
- Blameless post-mortems
- Continuous deployment

**Votre entreprise peut être la suivante!**

---

## 🔮 Tendances DevOps 2025

### Ce Qui Arrive

**GitOps**:
- Git comme unique source de vérité
- ArgoCD, Flux CD
- Déclaratif, auditable

**Platform Engineering**:
- Internal Developer Platforms (IDPs)
- Self-service infrastructure
- Abstraire complexité

**AI/ML Ops**:
- MLOps pour modèles ML
- AI-assisted coding (Copilot)
- Prédiction d'incidents

**FinOps**:
- Optimisation coûts cloud
- Cost as Code
- Tagging automatique

---

## 🎓 Certifications DevOps

### Pour Aller Plus Loin

**Générales**:
- 🏅 **AWS Certified DevOps Engineer**
- 🏅 **Azure DevOps Engineer Expert**
- 🏅 **Google Cloud Professional DevOps Engineer**

**Spécialisées**:
- 🏅 **Kubernetes Administrator (CKA)**
- 🏅 **Kubernetes Application Developer (CKAD)**
- 🏅 **HashiCorp Certified: Terraform Associate**
- 🏅 **Docker Certified Associate**

**Culture**:
- 🏅 **DevOps Institute Certifications**

---

## 📝 Évaluation Finale

### QCM - 30 Questions

**Couverture**:
- Module 2: Principes DevOps (5 questions)
- Module 3: Git & Versioning (5 questions)
- Module 4: Build & Tests (5 questions)
- Module 5: CI/CD GitHub Actions (5 questions)
- Module 7: Docker (5 questions)
- Modules 6 & 8: IaC, K8s, Monitoring (5 questions)

**Durée**: 15 minutes
**Note minimale**: 70% pour validation

---

## 🎯 Compétences Validées

### Référentiel M2 ESTD

**C19**: Concevoir et gérer le cycle de vie des applications
- ✅ Versioning avec Git
- ✅ CI/CD avec GitHub Actions
- ✅ Tests automatisés
- ✅ Déploiement continu

**C20**: Concevoir et déployer une infrastructure
- ✅ Conteneurisation avec Docker
- ✅ IaC avec Terraform/Ansible
- ✅ Orchestration avec Kubernetes
- ✅ Monitoring avec Prometheus/Grafana

---

## 💬 Feedback

### Votre Avis Nous Intéresse!

**Questions**:
- Clarté du contenu?
- Rythme de la formation?
- Équilibre théorie/pratique?
- Points à améliorer?
- Suggestions de sujets?

**Contact**:
- 📧 Email: fabrice.claeys@foreach.fr
- 💼 LinkedIn: linkedin.com/in/fabriceclaeys

---

## 🙏 Remerciements

### Merci à Vous!

- ✨ Votre **attention** et **participation**
- 💡 Vos **questions** pertinentes
- 🚀 Votre **motivation** à apprendre DevOps

### Merci à ForEach Academy

- 🏫 Opportunité de **partager** cette passion
- 🎓 Soutien pour une **formation de qualité**

---

## 🎯 Citations DevOps Inspirantes

> "If you can't measure it, you can't improve it."
> — **Peter Drucker**

> "Automation is not about replacing people, it's about empowering them."
> — **Anonymous**

> "The best way to predict the future is to implement it."
> — **DevOps adaptation of David Heinemeier Hansson**

> "Move fast and break things... but have good monitoring!"
> — **Facebook (adapted)**

---

## ❓ Questions & Réponses

### Dernières Questions

**30 minutes de Q&A**

- Clarifications sur concepts
- Applications pratiques
- Conseils carrière DevOps
- Outils spécifiques
- Anything DevOps!

---

<!-- _class: lead -->

# 🎓 Félicitations!

**Vous Avez Terminé l'Initiation DevOps!**

---

## 🚀 Votre Parcours DevOps Commence Ici

### Continuez à Apprendre

- 🛠️ **Pratiquez** avec vos propres projets
- 📚 **Lisez** la documentation officielle
- 👥 **Rejoignez** les communautés DevOps
- 🎯 **Automatisez** un processus par mois
- 📊 **Mesurez** vos progrès avec DORA metrics
- 🌟 **Partagez** vos apprentissages

> "The journey of a thousand deploys begins with a single commit"

---

<!-- _class: lead -->

# Merci!

**Bonne Continuation dans Votre Parcours DevOps**

*M2 ESTD - Initiation DevOps*
*ForEach Academy - 2025*

**Contact**: fabrice.claeys@foreach.fr
**LinkedIn**: linkedin.com/in/fabriceclaeys

---

<!-- _class: lead -->

# 🎉

**Fin de la Formation**

*N'oubliez pas le QCM!*
