# 📝 QCM d'Évaluation - Initiation DevOps

**Durée**: 20 minutes
**Questions**: 30
**Note**: 30 points (1 point par question)
**Seuil de réussite**: 24/30 (80%)

**Instructions**:
- Cocher la ou les bonnes réponses
- Certaines questions ont plusieurs réponses correctes
- Pas de pénalité pour les mauvaises réponses

---

## Module 2: Principes du DevOps (5 questions)

### Question 1
**Que signifie "DevOps" ?**

- [ ] A) Development Operations
- [ ] B) Developers and Operations working together
- [ ] C) Automated Development and Operations
- [x] D) Development + Operations (collaboration)

**Réponse**: D

---

### Question 2
**Quels sont les 3 piliers de la culture DevOps ? (3 réponses attendues)**

- [x] A) Collaboration
- [x] B) Automatisation
- [ ] C) Documentation
- [x] D) Amélioration continue
- [ ] E) Centralisation

**Réponses**: A, B, D

---

### Question 3
**Quelle est la principale différence entre DevOps et Agile ?**

- [ ] A) DevOps remplace Agile
- [ ] B) Agile est uniquement pour les développeurs
- [x] C) DevOps étend Agile jusqu'à la mise en production et l'exploitation
- [ ] D) Il n'y a pas de différence

**Réponse**: C

---

### Question 4
**Qu'est-ce que la "chaîne de production logicielle" (software delivery pipeline) ?**

- [ ] A) Un outil de gestion de projet
- [x] B) L'ensemble des étapes du code source jusqu'à la production
- [ ] C) Un système de versioning
- [ ] D) Un framework de tests

**Réponse**: B

---

### Question 5
**Quel est l'objectif principal du DevOps ?**

- [ ] A) Réduire le nombre de développeurs
- [x] B) Réduire le temps entre l'écriture du code et sa mise en production
- [ ] C) Augmenter la documentation
- [ ] D) Éliminer les tests manuels

**Réponse**: B

---

## Module 3: Git & Versioning (5 questions)

### Question 6
**Quelle commande Git permet de créer un nouveau commit ?**

- [ ] A) `git push`
- [ ] B) `git add`
- [x] C) `git commit`
- [ ] D) `git checkout`

**Réponse**: C

---

### Question 7
**Dans GitFlow, quelle branche contient le code en production ?**

- [ ] A) `develop`
- [x] B) `main` (ou `master`)
- [ ] C) `feature/`
- [ ] D) `release/`

**Réponse**: B

---

### Question 8
**Qu'est-ce qu'un "merge conflict" ?**

- [ ] A) Une erreur de compilation
- [x] B) Deux branches modifient les mêmes lignes de code différemment
- [ ] C) Un bug dans Git
- [ ] D) Une erreur de syntaxe

**Réponse**: B

---

### Question 9
**Quelle est la différence entre `git fetch` et `git pull` ?**

- [x] A) `fetch` télécharge les changements sans les fusionner, `pull` télécharge ET fusionne
- [ ] B) `fetch` est plus rapide que `pull`
- [ ] C) `pull` est uniquement pour les branches locales
- [ ] D) Il n'y a pas de différence

**Réponse**: A

---

### Question 10
**Qu'est-ce qu'un "tag" Git ?**

- [ ] A) Un alias pour une branche
- [x] B) Une référence immuable vers un commit spécifique (ex: version v1.0.0)
- [ ] C) Un message de commit
- [ ] D) Un type de merge

**Réponse**: B

---

## Module 4: Build & Tests (5 questions)

### Question 11
**Dans la pyramide de tests, quel type de test doit être le plus nombreux ?**

- [x] A) Tests unitaires
- [ ] B) Tests d'intégration
- [ ] C) Tests E2E (end-to-end)
- [ ] D) Tous doivent être en nombre égal

**Réponse**: A

---

### Question 12
**Qu'est-ce que la couverture de code (code coverage) ?**

- [ ] A) Le nombre de lignes de code dans le projet
- [x] B) Le pourcentage de code exécuté par les tests
- [ ] C) Le nombre de tests écrits
- [ ] D) Le temps d'exécution des tests

**Réponse**: B

---

### Question 13
**Quel est un bon objectif de couverture de code ?**

- [ ] A) 100% obligatoire
- [ ] B) 50%
- [x] C) 80-90%
- [ ] D) La couverture n'est pas importante

**Réponse**: C

---

### Question 14
**Qu'est-ce qu'un "artefact" en DevOps ?**

- [ ] A) Un bug dans le code
- [x] B) Un fichier généré par le build (executable, archive, image Docker, etc.)
- [ ] C) Un test qui échoue
- [ ] D) Une branche Git

**Réponse**: B

---

### Question 15
**Que teste un test unitaire ?**

- [x] A) Une seule fonction ou méthode de manière isolée
- [ ] B) L'application complète
- [ ] C) L'intégration entre plusieurs composants
- [ ] D) L'interface utilisateur

**Réponse**: A

---

## Module 5: CI/CD & GitHub Actions (7 questions)

### Question 16
**Que signifie "CI/CD" ?**

- [ ] A) Continuous Installation / Continuous Debugging
- [x] B) Continuous Integration / Continuous Delivery (ou Deployment)
- [ ] C) Code Integration / Code Deployment
- [ ] D) Continuous Improvement / Continuous Development

**Réponse**: B

---

### Question 17
**Quelle est la différence entre Continuous Delivery et Continuous Deployment ?**

- [ ] A) Il n'y a pas de différence
- [x] B) Delivery nécessite une validation manuelle avant production, Deployment est 100% automatique
- [ ] C) Delivery est plus rapide
- [ ] D) Deployment est uniquement pour le cloud

**Réponse**: B

---

### Question 18
**Dans GitHub Actions, qu'est-ce qu'un "workflow" ?**

- [ ] A) Une branche Git
- [x] B) Un fichier YAML qui définit un pipeline CI/CD automatisé
- [ ] C) Un outil de gestion de projet
- [ ] D) Un type de commit

**Réponse**: B

---

### Question 19
**Où sont stockés les workflows GitHub Actions dans un repo ?**

- [ ] A) À la racine du projet
- [x] B) `.github/workflows/`
- [ ] C) `ci/workflows/`
- [ ] D) `scripts/ci/`

**Réponse**: B

---

### Question 20
**Qu'est-ce qu'un "build matrix" dans GitHub Actions ?**

- [ ] A) Une erreur de build
- [x] B) Tester le code sur plusieurs versions/OS en parallèle (ex: Node 18, 20, 22)
- [ ] C) Un tableau de métriques
- [ ] D) Un fichier de configuration

**Réponse**: B

---

### Question 21
**Pourquoi utiliser le caching dans une pipeline CI ?**

- [ ] A) Pour économiser de l'espace disque
- [x] B) Pour accélérer les builds en réutilisant les dépendances déjà téléchargées
- [ ] C) Pour sécuriser les secrets
- [ ] D) Pour améliorer la couverture de code

**Réponse**: B

---

### Question 22
**Quelles sont les 4 métriques DORA ? (4 réponses attendues)**

- [x] A) Deployment Frequency (fréquence de déploiement)
- [x] B) Lead Time for Changes (temps entre commit et production)
- [ ] C) Code Coverage (couverture de code)
- [x] D) Mean Time to Recovery (MTTR - temps de résolution d'incident)
- [x] E) Change Failure Rate (taux d'échec des déploiements)
- [ ] F) Number of Developers (nombre de développeurs)

**Réponses**: A, B, D, E

---

## Module 7: Docker & Conteneurisation (7 questions)

### Question 23
**Quelle est la principale différence entre un conteneur Docker et une machine virtuelle ?**

- [ ] A) Les conteneurs sont plus lents
- [x] B) Les conteneurs partagent le kernel de l'OS hôte, les VMs ont leur propre OS complet
- [ ] C) Les VMs sont plus légères
- [ ] D) Il n'y a pas de différence

**Réponse**: B

---

### Question 24
**Qu'est-ce qu'un Dockerfile ?**

- [ ] A) Un fichier de configuration Git
- [x] B) Un fichier texte qui contient les instructions pour construire une image Docker
- [ ] C) Un script de déploiement
- [ ] D) Un fichier de logs Docker

**Réponse**: B

---

### Question 25
**Quel est l'avantage d'un multi-stage build Docker ?**

- [ ] A) Plus rapide à construire
- [x] B) Image finale beaucoup plus légère (pas de devDependencies ni outils de build)
- [ ] C) Meilleure sécurité des secrets
- [ ] D) Support de plusieurs langages

**Réponse**: B

---

### Question 26
**Qu'est-ce que Docker Compose ?**

- [ ] A) Un éditeur de Dockerfile
- [x] B) Un outil pour orchestrer plusieurs conteneurs Docker (fichier YAML)
- [ ] C) Une alternative à Docker
- [ ] D) Un registre d'images Docker

**Réponse**: B

---

### Question 27
**Quelle commande Docker permet de voir les conteneurs en cours d'exécution ?**

- [ ] A) `docker images`
- [x] B) `docker ps`
- [ ] C) `docker run`
- [ ] D) `docker logs`

**Réponse**: B

---

### Question 28
**Qu'est-ce qu'un "volume" Docker ?**

- [ ] A) La taille d'une image
- [x] B) Un mécanisme pour persister les données en dehors du conteneur
- [ ] C) Un type de réseau Docker
- [ ] D) Une variable d'environnement

**Réponse**: B

---

### Question 29
**Pourquoi utiliser l'image Alpine Linux dans Docker ?**

- [ ] A) Elle est plus rapide
- [x] B) Elle est beaucoup plus légère (~5 MB vs ~100+ MB pour Ubuntu)
- [ ] C) Elle supporte plus de langages
- [ ] D) Elle est plus sécurisée par défaut

**Réponse**: B

---

## Module 6 & 8: IaC, Kubernetes, Monitoring (1 question)

### Question 30
**Qu'est-ce que l'Infrastructure as Code (IaC) ?**

- [ ] A) Écrire du code pour créer des applications
- [x] B) Gérer l'infrastructure (serveurs, réseau, etc.) avec du code (Terraform, Ansible)
- [ ] C) Utiliser Docker
- [ ] D) Automatiser les tests

**Réponse**: B

---

## Corrigé & Barème

### Répartition des points par module
- **Module 2** (DevOps): 5 points
- **Module 3** (Git): 5 points
- **Module 4** (Tests): 5 points
- **Module 5** (CI/CD): 7 points
- **Module 7** (Docker): 7 points
- **Module 6 & 8** (IaC/K8s/Monitoring): 1 point

**Total**: 30 points

### Grille d'évaluation
- **27-30 points** (90-100%): Excellent ✅
- **24-26 points** (80-89%): Bien ✅
- **18-23 points** (60-79%): Passable ⚠️
- **< 18 points** (< 60%): Insuffisant ❌

---

## Corrigé Détaillé

| Q# | Réponse(s) | Points |
|----|-----------|--------|
| 1  | D | 1 |
| 2  | A, B, D | 1 |
| 3  | C | 1 |
| 4  | B | 1 |
| 5  | B | 1 |
| 6  | C | 1 |
| 7  | B | 1 |
| 8  | B | 1 |
| 9  | A | 1 |
| 10 | B | 1 |
| 11 | A | 1 |
| 12 | B | 1 |
| 13 | C | 1 |
| 14 | B | 1 |
| 15 | A | 1 |
| 16 | B | 1 |
| 17 | B | 1 |
| 18 | B | 1 |
| 19 | B | 1 |
| 20 | B | 1 |
| 21 | B | 1 |
| 22 | A, B, D, E | 1 |
| 23 | B | 1 |
| 24 | B | 1 |
| 25 | B | 1 |
| 26 | B | 1 |
| 27 | B | 1 |
| 28 | B | 1 |
| 29 | B | 1 |
| 30 | B | 1 |

---

**QCM prêt à être utilisé ! ✅**
