# Objectifs Pédagogiques - TP2: CI/CD avec GitHub Actions

## 🎯 Compétence Validée

**C20 - Concevoir et déployer une infrastructure**

> *"Automatiser les processus de build, test et déploiement via des pipelines d'intégration et de déploiement continus."*

---

## 📚 Savoirs

### CI/CD - Concepts Fondamentaux
- ✅ Comprendre la différence entre CI, Continuous Delivery, et Continuous Deployment
- ✅ Connaître les bénéfices de l'automatisation (réduction erreurs, feedback rapide, releases fréquentes)
- ✅ Maîtriser le concept de pipeline (séquence d'étapes automatisées)
- ✅ Comprendre les triggers et événements (push, pull_request, schedule)

### GitHub Actions - Architecture
- ✅ Comprendre l'architecture: Workflows → Jobs → Steps → Actions
- ✅ Connaître la syntaxe YAML pour les workflows
- ✅ Savoir où trouver des Actions (GitHub Marketplace)
- ✅ Comprendre les runners (GitHub-hosted vs self-hosted)

### Optimisations et Patterns
- ✅ Comprendre le caching de dépendances (pourquoi et comment)
- ✅ Connaître les artifacts et leur utilisation
- ✅ Maîtriser les matrix builds pour tester multi-versions/multi-OS
- ✅ Comprendre le parallélisme des jobs

### Bonnes Pratiques CI/CD
- ✅ Tests automatisés obligatoires avant merge
- ✅ Builds reproductibles (mêmes inputs → mêmes outputs)
- ✅ Feedback rapide (échec en <5 minutes)
- ✅ Protection de branche (require status checks)

---

## 🛠️ Savoir-Faire

### Configuration GitHub Actions
- ✅ Créer un repository GitHub
- ✅ Créer la structure `.github/workflows/`
- ✅ Écrire un fichier workflow YAML valide
- ✅ Configurer des triggers (on: push, pull_request)
- ✅ Définir des jobs avec runs-on

### Utilisation des Actions
- ✅ Utiliser `actions/checkout@v4` pour récupérer le code
- ✅ Utiliser `actions/setup-node@v4` pour configurer Node.js
- ✅ Utiliser `actions/cache@v3` pour le caching
- ✅ Utiliser `actions/upload-artifact@v3` pour les artifacts
- ✅ Explorer le Marketplace pour trouver d'autres Actions

### Optimisation des Workflows
- ✅ Configurer le cache avec clé basée sur hash (package-lock.json)
- ✅ Utiliser `npm ci` au lieu de `npm install` (reproductible)
- ✅ Créer des matrix builds pour tester plusieurs configurations
- ✅ Uploader des artifacts pour inspection/débogage

### Débogage et Monitoring
- ✅ Lire les logs des workflows dans l'onglet Actions
- ✅ Identifier l'étape qui échoue
- ✅ Utiliser des commandes de debug (`echo`, inspection variables)
- ✅ Re-run des jobs échoués
- ✅ Interpréter les badges de statut

---

## 💡 Savoir-Être

### Rigueur et Qualité
- ✅ Écrire des workflows clairs et documentés
- ✅ Tester localement avant de pousser
- ✅ Ne jamais commiter de secrets dans le code
- ✅ Valider la syntaxe YAML (indentation correcte)

### Automatisation Intelligente
- ✅ Identifier ce qui doit être automatisé vs manuel
- ✅ Optimiser pour la vitesse (caching, parallélisme)
- ✅ Équilibrer couverture et temps d'exécution

### Culture DevOps
- ✅ Accepter que le CI puisse bloquer un merge (c'est son rôle!)
- ✅ Voir les échecs CI comme du feedback, pas comme des punitions
- ✅ Prendre responsabilité de fixer les builds cassés rapidement

---

## 📊 Critères d'Évaluation

### Setup et Configuration (25 points)
- [ ] Repository GitHub créé correctement (5 pts)
- [ ] Starter kit poussé et fonctionnel (5 pts)
- [ ] Structure `.github/workflows/` créée (5 pts)
- [ ] Workflow YAML syntaxiquement valide (10 pts)

### Workflow CI Basique (25 points)
- [ ] Triggers configurés (push, pull_request) (5 pts)
- [ ] Job s'exécute automatiquement (10 pts)
- [ ] Tous les steps réussissent (checkout, setup, install, test, build) (10 pts)

### Optimisations (30 points)
- [ ] Cache configuré correctement (clé avec hash) (10 pts)
- [ ] Cache fonctionne (visible dans logs "Cache restored") (5 pts)
- [ ] Artifacts uploadés (5 pts)
- [ ] Matrix build avec 6 jobs (2 OS × 3 Node versions) (10 pts)

### Qualité et Documentation (20 points)
- [ ] Workflow bien structuré et commenté (5 pts)
- [ ] Badge CI ajouté dans README (5 pts)
- [ ] Tous les 6 jobs du matrix réussissent (10 pts)

### Total: 100 points
Seuil de validation: 70/100

---

## 🎓 Compétences Transversales

### Automatisation
- Éliminer les tâches répétitives manuelles
- Standardiser les processus de build/test
- Réduire les erreurs humaines

### Qualité Logicielle
- Tests automatiques sur chaque changement
- Détection précoce des régressions
- Garantie de non-régression

### Collaboration
- Feedback immédiat sur les PRs
- Blocage des merges si tests échouent
- Transparence sur l'état du projet (badges)

### Infrastructure as Code
- Configuration CI en YAML versionné
- Workflows reproductibles
- Évolution trackée dans Git

---

## 🔗 Liens avec Autres Modules

### Module 3: Git & Versioning
- Branches = triggers de workflows
- Tags = déclencheurs de déploiement
- Commits = unités de CI/CD

### Module 4: Build & Tests
- CI exécute les tests automatiquement
- Métriques de couverture dans CI
- Build artifacts pour déploiement

### Module 6: Docker
- CI peut builder des images Docker
- Push vers registres (Docker Hub, GHCR)
- Tests de conteneurs

### Module 7: Infrastructure
- GitHub Actions peut exécuter Terraform
- Déploiement vers Kubernetes
- GitOps avec ArgoCD déclenché par CI

---

## 📖 Pour Aller Plus Loin

### Workflows Avancés

**Reusable Workflows**:
```yaml
jobs:
  call-workflow:
    uses: owner/repo/.github/workflows/reusable.yml@main
    with:
      node-version: 20
```

**Conditional Execution**:
```yaml
- name: Deploy to prod
  if: github.ref == 'refs/heads/main'
  run: npm run deploy
```

**Secrets Management**:
```yaml
- name: Deploy
  env:
    API_KEY: ${{ secrets.API_KEY }}
  run: ./deploy.sh
```

### Intégrations Populaires

- **Déploiement**: Vercel, Netlify, AWS, Azure
- **Tests**: CodeCov, SonarCloud
- **Sécurité**: Snyk, Dependabot
- **Notifications**: Slack, Discord, Email

### Ressources Complémentaires

- [GitHub Actions Examples](https://github.com/actions/starter-workflows)
- [Awesome Actions](https://github.com/sdras/awesome-actions)
- [GitHub Actions Community Forum](https://github.community/c/code-to-cloud/github-actions)

---

## 💡 Métriques DORA Applicables

Ce TP vous aide à améliorer les **4 métriques DORA**:

1. **Deployment Frequency** ↑
   - CI automatique = déploiements plus fréquents

2. **Lead Time for Changes** ↓
   - Feedback immédiat = changements plus rapides

3. **Mean Time to Recovery** ↓
   - Tests automatiques détectent problèmes tôt

4. **Change Failure Rate** ↓
   - Validation avant merge = moins d'échecs

---

**Ce TP est au cœur du DevOps moderne. GitHub Actions est l'outil CI/CD le plus utilisé en 2025!**
