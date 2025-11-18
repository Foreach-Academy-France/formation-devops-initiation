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
    font-size: 16px;
    padding: 8px;
    margin: 10px 0;
  }
---

<!-- _class: lead -->
# Module 2

## Principes du mouvement DevOps

### 45 minutes pour comprendre la culture DevOps

---

## 📚 Ce que nous allons voir

1. **Qu'est-ce que DevOps ?**
2. **Vocabulaire et objectifs**
3. **La chaîne de production logicielle**
4. **Compétences et culture DevOps**
5. **Bénéfices pour l'entreprise**
6. **Relation avec l'Agile**

---

## 🤔 DevOps : Définition

<div class="highlight">Dev + Ops = DevOps</div>

**DevOps** est une **culture** et un ensemble de **pratiques** qui vise à :

- Rapprocher les équipes **Développement** et **Opérations**
- **Automatiser** la chaîne de production logicielle
- Livrer des logiciels plus **rapidement** et de manière plus **fiable**

> "DevOps n'est pas un outil, c'est une philosophie"

---

## 🏢 Le problème traditionnel

### Avant DevOps : Le mur de confusion

<div style="display: flex; justify-content: center; align-items: center; gap: 40px; margin: 30px 0; font-size: 18px;">
  <div style="text-align: center;">
    👨‍💻 <strong>Développeurs</strong><br>
    "Ça marche sur ma machine!"<br>
    😡
  </div>
  <div style="font-size: 48px; color: #666;">|</div>
  <div style="text-align: center;">
    🧑‍🔧 <strong>Opérations</strong><br>
    "Tu casses la prod!"<br>
    😡
  </div>
</div>

- **Dev** : Livrer des fonctionnalités rapidement
- **Ops** : Maintenir la stabilité du système

➡️ **Objectifs contradictoires** = Lenteur, bugs, conflits

---

## ✨ La solution DevOps

### Après DevOps : Collaboration

```
👨‍💻 + 🧑‍🔧 = 🤝 DevOps
"On livre ensemble, rapidement et sainement"
```

- **Objectifs alignés**
- **Responsabilités partagées**
- **Automatisation maximale**
- **Feedback continu**

---

## 🎯 Les objectifs DevOps

### 3 objectifs principaux :

1. **Rapidité** 🚀
   - Déployer plus souvent (plusieurs fois par jour)
   - Réduire le Time-to-Market

2. **Fiabilité** ✅
   - Qualité constante des livraisons
   - Moins de bugs en production

3. **Scalabilité** 📈
   - Gérer la croissance facilement
   - Infrastructure adaptable

---

## 📖 Vocabulaire DevOps essentiel

### Les termes à connaître :

- **CI/CD** : Intégration et Déploiement Continu
- **Pipeline** : Chaîne automatisée de build/test/deploy
- **Artifact** : Résultat packagé d'un build
- **Infrastructure as Code (IaC)** : Infrastructure définie dans du code
- **Container** : Environnement d'exécution isolé et portable

---

## 📖 Vocabulaire (suite)

- **Provisioning** : Création automatique d'infrastructure
- **Orchestration** : Gestion automatisée de containers
- **Monitoring** : Surveillance des systèmes
- **Rollback** : Retour à une version précédente
- **Blue/Green Deployment** : Déploiement sans interruption

---

## 🔧 La chaîne de production logicielle

### Le cycle DevOps complet :

<div style="background: #f5f5f5; padding: 30px; border-radius: 10px; margin: 20px 0;">
  <div style="text-align: center; font-size: 20px; font-weight: bold; margin-bottom: 15px;">
    Plan → Code → Build → Test → Release → Deploy → Operate → Monitor
  </div>
  <div style="text-align: center; font-size: 20px; color: #667eea; font-weight: bold; margin-top: 15px;">
    ↻ Feedback & Amélioration Continue ↻
  </div>
</div>

C'est un **cycle continu** d'amélioration !

---

## 🔧 Chaîne de production : Détail

### Phase 1 : Développement

1. **Plan** 📋 : Définir les features (backlog, tickets)
2. **Code** 💻 : Développer et versionner (Git)
3. **Build** 🏗️ : Compiler et packager l'application
4. **Test** ✅ : Tests automatisés (unitaires, intégration, E2E)

---

## 🔧 Chaîne de production : Détail

### Phase 2 : Déploiement

5. **Release** 📦 : Préparer la version pour production
6. **Deploy** 🚀 : Déployer sur les environnements
7. **Operate** ⚙️ : Gérer l'infrastructure et les services
8. **Monitor** 📊 : Surveiller performances et erreurs

---

## 👥 Compétences de l'équipe DevOps

### Une équipe pluridisciplinaire :

- **Développeurs** : Code, tests, automatisation
- **Ops/SRE** : Infrastructure, monitoring, sécurité
- **QA** : Qualité, tests, validation
- **Security** : Sécurité (DevSecOps)

➡️ **T-shaped skills** : Large connaissance + expertise

---

## 🎨 La culture DevOps

### Les 3 piliers (The Three Ways) :

1. **Flow** 🌊
   - Optimiser le flux Dev → Ops
   - Automatiser au maximum

2. **Feedback** 🔄
   - Boucles de retour rapides
   - Apprendre vite de ses erreurs

3. **Amélioration Continue** 📈
   - Expérimentation
   - Apprentissage constant

---

## 🎨 Culture DevOps : CALMS

### Le framework CALMS :

- **C**ulture : Collaboration entre équipes
- **A**utomation : Automatiser tout ce qui est répétitif
- **L**ean : Éliminer le gaspillage
- **M**easurement : Mesurer tout (métriques)
- **S**haring : Partager les connaissances

---

## 💡 Bénéfices pour l'entreprise

### Pourquoi adopter DevOps ?

**Statistiques (State of DevOps Report) :**

- <span class="stat">200x</span> **plus de déploiements**
- <span class="stat">24x</span> **récupération plus rapide** après incidents
- <span class="stat">3x</span> **moins de changements qui échouent**
- <span class="stat">50%</span> **moins de temps passé sur du travail non planifié**

---

## 💡 Bénéfices concrets

### Pour le business :

✅ **Time-to-Market** réduit
✅ **Qualité** améliorée
✅ **Coûts** optimisés
✅ **Innovation** facilitée
✅ **Satisfaction client** accrue

### Pour les équipes :

✅ Moins de stress
✅ Plus d'autonomie
✅ Travail plus intéressant

---

## 🔗 DevOps et Agile

### Quelle différence ?

**Agile** 🏃
- Méthodologie de **gestion de projet**
- Focus sur le **développement**
- Livraisons **itératives**

**DevOps** 🔧
- **Culture** et pratiques techniques
- Focus sur **Dev + Ops**
- Livraisons **continues**

---

## 🔗 DevOps complète Agile

### Ils sont complémentaires !

<div style="display: flex; justify-content: center; align-items: center; gap: 60px; margin: 30px 0;">
  <div style="text-align: center; background: #e3f2fd; padding: 20px; border-radius: 10px;">
    <strong style="font-size: 22px;">Agile</strong><br><br>
    Planning<br>
    Sprints<br>
    Reviews
  </div>
  <div style="font-size: 36px; font-weight: bold; color: #667eea;">+</div>
  <div style="text-align: center; background: #f3e5f5; padding: 20px; border-radius: 10px;">
    <strong style="font-size: 22px;">DevOps</strong><br><br>
    Automation<br>
    CI/CD<br>
    Monitoring
  </div>
</div>

<div style="text-align: center; font-size: 24px; color: #667eea; font-weight: bold; margin-top: 20px;">
  ⬇️ Livraison continue de valeur business ⬇️
</div>

**Agile** : Comment on construit
**DevOps** : Comment on livre et on opère

---

## 🚀 Les pratiques DevOps clés

### Ce que nous allons voir cette journée :

1. **Version Control** : Git, GitFlow
2. **Continuous Integration** : Tests automatisés
3. **Continuous Delivery** : GitHub Actions
4. **Infrastructure as Code** : Ansible, Terraform
5. **Containerization** : Docker
6. **Orchestration** : Kubernetes
7. **Monitoring** : Métriques et dashboards

---

## 📊 Niveaux de maturité DevOps

### Où en êtes-vous ?

| Niveau | Pratiques |
|--------|-----------|
| **0** | Déploiements manuels, pas de tests |
| **1** | Version control, quelques tests |
| **2** | CI/CD basique, tests automatisés |
| **3** | Infrastructure as Code, monitoring |
| **4** | Full automation, self-healing |

---

## 🎯 DevOps : Mindset

### Les principes à retenir :

- **"You build it, you run it"**
  ➡️ Responsabilité de bout en bout

- **"Fail fast, learn faster"**
  ➡️ Expérimentation et feedback rapide

- **"Automate everything"**
  ➡️ Si c'est répétitif, automatise-le

- **"Measure everything"**
  ➡️ Les données guident les décisions

---

## ⚠️ Les pièges à éviter

### Erreurs communes :

❌ Penser que DevOps = Outils
❌ Créer une "équipe DevOps" isolée
❌ Vouloir tout automatiser d'un coup
❌ Ignorer la culture et les humains
❌ Ne pas mesurer les résultats

✅ **DevOps est un voyage, pas une destination**

---

## 🏁 Anti-patterns DevOps

### Ce qui NE fonctionne PAS :

- **DevOps Theater** 🎭
  ➡️ Faire semblant sans vraiment changer

- **Tool obsession** 🔧
  ➡️ Collectionner les outils sans stratégie

- **Blame culture** 👎
  ➡️ Chercher des coupables au lieu de solutions

---

## 📚 Récapitulatif

### Ce qu'il faut retenir :

1. DevOps = **Culture** de collaboration Dev + Ops
2. Objectif : Livrer **rapidement** et **fiablement**
3. Basé sur **automatisation** et **feedback**
4. Complémentaire à **Agile**
5. Bénéfices **business** + **humains**
6. C'est un **voyage** d'amélioration continue

---

## ❓ Questions ?

### Discussion ouverte

- Avez-vous déjà rencontré des problèmes Dev vs Ops ?
- Quelles pratiques DevOps connaissez-vous déjà ?
- Des questions sur les concepts ?

---

<!-- _class: lead -->
# 🎯 À suivre

## Module 3 : Git & Versioning

### Pause de 5 minutes ☕

Préparez vos environnements Git !
