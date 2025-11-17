---
marp: true
theme: default
paginate: true
header: 'Module 4: Build & Tests Automatisés'
footer: 'Cours DevOps - M2 ESTD | ForEach Academy | Nov 2025'
---

<!-- _class: lead -->

# Module 4
## Build & Tests Automatisés

**Formation DevOps - M2 ESTD Architecte Web**
ForEach Academy | Novembre 2025

---

## 📋 Plan du module

1. **Outils de Build** (15min)
   - Définition et rôle
   - Timeline historique
   - Outils modernes par écosystème

2. **Types de Tests** (20min)
   - Pyramide de tests
   - Tests unitaires, intégration, E2E
   - Trophée de tests

3. **Frameworks Modernes** (15min)
   - Vitest, Playwright, pytest, JUnit

4. **Analyse de Code & Métriques** (10min)
   - Linters, formatters, SonarQube
   - Code coverage, complexité cyclomatique

---

<!-- _class: lead -->

# 1. Outils de Build

---

## Qu'est-ce qu'un outil de build ?

**Définition** : Automatise la transformation du **code source** en **artefact exécutable**.

**Responsabilités** :
- ✅ Compilation du code source
- ✅ Résolution des dépendances
- ✅ Exécution des tests
- ✅ Génération de documentation
- ✅ Packaging et création d'artefacts
- ✅ Optimisation (minification, tree-shaking)

---

## Build vs Compilation

| Aspect | **Compilation** | **Build** |
|--------|-----------------|-----------|
| **Portée** | Code source → code machine | Processus complet |
| **Étapes** | Analyse syntaxique, bytecode | Compilation + tests + packaging |
| **Outils** | `gcc`, `javac`, `tsc` | Maven, Gradle, npm, bun |
| **Sortie** | Fichiers `.o`, `.class`, `.js` | JAR, bundle.js, image Docker |

**Exemple** : `tsc` compile TypeScript → JavaScript, mais `vite build` compile + bundle + minifie + génère sourcemaps.

---

## Timeline des outils de build majeurs

```
1976  Make (Stuart Feldman, Bell Labs)
      │   "The grandfather of build tools"
      │
2000  Apache Ant (James Duncan Davidson)
      │   Premier outil XML pour Java
      │
2004  Apache Maven (Jason van Zyl)
      │   Convention over configuration
      │   Maven Central Repository
      │
2012  Gradle (Hans Dockter)
      │   DSL Groovy/Kotlin
      │   Build incrémental et cache
      │
2010  npm (Isaac Z. Schlueter)
      │   17 millions de packages en 2024
```

---

## Timeline (suite)

```
2016  Yarn (Facebook/Meta)
      │   yarn.lock pour reproducibilité
      │
2017  pnpm (Zoltan Kochan)
      │   Économie d'espace (hard links)
      │
2020  Vite (Evan You, créateur de Vue.js)
      │   ESM natif, HMR ultra-rapide
      │
2020  Bun (Jarred Sumner)
      │   Runtime + bundler + package manager
      │   25x plus rapide que npm
      │
2024  Turbo (Vercel)
      │   Build system pour monorepos
```

---

## Outils modernes par écosystème

### JavaScript/TypeScript

**npm** (2010 - 17M+ packages)
```json
{
  "scripts": {
    "build": "tsc && vite build",
    "test": "vitest",
    "lint": "eslint src/"
  }
}
```

**Vite** (2020 - 15M téléchargements/semaine)
- Dev server ESM natif (démarrage instantané)
- HMR en < 50ms
- Build optimisé avec Rollup

---

## Bun - Le nouveau challenger

**Bun** (2023 - 1M+ utilisateurs)
- Runtime JavaScript/TypeScript (alternative à Node.js)
- Bundler intégré (alternative à Webpack/Rollup)
- Package manager (alternative à npm/yarn/pnpm)

```bash
# 25x plus rapide que npm install
bun install

# Bundler intégré
bun build ./index.ts --outdir ./dist

# Run TypeScript directement
bun run index.ts
```

**Performance** : Écrit en Zig, optimisé pour la vitesse.

---

## Java

### Maven (2004 - 70% des projets Java)

```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.11.0</version>
      <configuration>
        <source>17</source>
        <target>17</target>
      </configuration>
    </plugin>
  </plugins>
</build>
```

**Philosophie** : Convention over configuration.

---

## Java (suite)

### Gradle (2012 - Android officiel)

```kotlin
// build.gradle.kts
plugins {
    kotlin("jvm") version "1.9.20"
}

tasks.test {
    useJUnitPlatform()
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = "com.example.MainKt"
    }
}
```

**Avantages** : DSL Kotlin, build incrémental, cache distribué.

---

## Python

### pip + setuptools (2008 - Classique)

```python
# setup.py
from setuptools import setup

setup(
    name="myapp",
    version="1.0.0",
    install_requires=["fastapi", "pydantic"]
)
```

### Poetry (2018 - Moderne)

```toml
[tool.poetry]
name = "myapp"
version = "1.0.0"

[tool.poetry.dependencies]
python = "^3.11"
fastapi = "^0.104.0"
```

---

## Artefacts de build

**Artefact** = Produit final du build, prêt à être déployé.

| Type | Format | Exemples |
|------|--------|----------|
| Binaires compilés | `.exe`, `.dll`, `.so` | Application C++ |
| Archives Java | `.jar`, `.war`, `.ear` | Spring Boot JAR |
| Packages npm | `.tgz` | Package Node.js |
| Packages Python | `.whl`, `.tar.gz` | Distribution PyPI |
| Images Docker | Image OCI | `myapp:1.2.3` |
| Bundles JS | `.js`, `.mjs` | `bundle.min.js` |

---

<!-- _class: lead -->

# 2. Types de Tests

---

## La Pyramide de Tests (Mike Cohn, 2009)

```
           /\
          /  \
        /  E2E  \    ← Peu nombreux, lents, coûteux
       /________\
      /          \
     / Integration \  ← Moyennement nombreux
    /______________\
   /                \
  /   Unit Tests     \ ← Très nombreux, rapides, peu coûteux
 /____________________\
```

**Ratio recommandé** : 70% Unit / 20% Integration / 10% E2E

---

## Pourquoi cette forme pyramidale ?

**Critères de comparaison** :

| Type | Vitesse | Coût | Maintenance | Fiabilité |
|------|---------|------|-------------|-----------|
| **Unit** | ⚡⚡⚡ | 💰 | ✅✅✅ | 🎯🎯 |
| **Integration** | ⚡⚡ | 💰💰 | ✅✅ | 🎯🎯🎯 |
| **E2E** | ⚡ | 💰💰💰 | ✅ | 🎯🎯🎯 |

**Principe** : Maximiser la couverture avec le meilleur rapport qualité/coût.

---

## Tests Unitaires

**Définition** : Tests d'une **unité de code isolée** (fonction, méthode, classe) sans dépendances externes.

**Caractéristiques** :
- ⚡ **Rapides** : millisecondes par test
- 🎯 **Isolés** : pas de base de données, API, filesystem
- 🔄 **Reproductibles** : même input → même output
- 📊 **Nombreux** : des centaines ou milliers

**Pattern AAA** :
- **Arrange** : Préparer les données
- **Act** : Exécuter l'action
- **Assert** : Vérifier le résultat

---

## Exemple - Test Unitaire (TypeScript/Vitest)

```typescript
// sum.ts
export function sum(a: number, b: number): number {
  return a + b;
}

// sum.test.ts
import { describe, it, expect } from 'vitest';
import { sum } from './sum';

describe('sum', () => {
  it('should add two positive numbers', () => {
    // Arrange
    const a = 2, b = 3;

    // Act
    const result = sum(a, b);

    // Assert
    expect(result).toBe(5);
  });
});
```

---

## Tests d'Intégration

**Définition** : Tests de l'**interaction entre plusieurs composants** (base de données, API, services).

**Caractéristiques** :
- 🐢 **Plus lents** : secondes par test
- 🔗 **Dépendances réelles** : BDD, Redis, APIs
- 🎭 **Scénarios réalistes** : flux utilisateur complets

**Quand les utiliser ?**
- Interactions base de données
- Appels API entre microservices
- Intégration avec services externes (Stripe, SendGrid)

---

## Exemple - Test d'Intégration (TypeScript/Vitest)

```typescript
// api.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import { app } from './app'; // Express/Hono app
import { db } from './database';

describe('User API Integration Tests', () => {
  beforeAll(async () => {
    await db.migrate.latest();
  });

  afterAll(async () => {
    await db.destroy();
  });

  it('should create and retrieve a user', async () => {
    // Arrange: Create user via API
    const createResponse = await request(app)
      .post('/users')
      .send({ name: 'Alice', email: 'alice@example.com' });

    expect(createResponse.status).toBe(201);
    const userId = createResponse.body.id;

    // Act: Retrieve user
    const getResponse = await request(app)
      .get(`/users/${userId}`);

    // Assert
    expect(getResponse.status).toBe(200);
    expect(getResponse.body.name).toBe('Alice');
    expect(getResponse.body.email).toBe('alice@example.com');
  });
});
```

---

## Tests End-to-End (E2E)

**Définition** : Tests du **système complet** du point de vue utilisateur (navigateur, mobile).

**Caractéristiques** :
- 🐌 **Très lents** : minutes par scénario
- 💰 **Coûteux** : maintenance, environnements
- 🎬 **Réalistes** : interactions UI réelles

**Quand les utiliser ?**
- Parcours utilisateur critiques (paiement, inscription)
- Tests de non-régression
- Validation avant release

---

## Exemple - Test E2E (Playwright)

```typescript
// e2e/login.spec.ts
import { test, expect } from '@playwright/test';

test('user can login and see dashboard', async ({ page }) => {
  // Navigate to app
  await page.goto('https://app.example.com');

  // Fill login form
  await page.fill('[data-testid="email"]', 'user@test.com');
  await page.fill('[data-testid="password"]', 'password123');
  await page.click('[data-testid="submit"]');

  // Assert redirect and content
  await expect(page).toHaveURL(/.*dashboard/);
  await expect(page.locator('h1')).toContainText('Welcome');
});
```

---

## Le Trophée de Tests (Kent C. Dodds, 2018)

Réinterprétation moderne de la pyramide :

```
           /\
          /  \
        / E2E  \
       /________\
      /          \
     /            \
    /  Integration \ ← Le sweet spot (meilleur ROI)
   /________________\
  /                  \
 /   Unit   Static    \
/______________________\
```

**Philosophie** : "Write tests. Not too many. Mostly integration."

---

## Pyramide vs Trophée - Débat

**Pyramide (Mike Cohn)** :
- Focus sur les tests unitaires (70%)
- Tests rapides et peu coûteux
- Détection précoce des bugs

**Trophée (Kent C. Dodds)** :
- Focus sur les tests d'intégration (sweet spot)
- Tests plus réalistes
- Meilleur ROI (return on investment)

**Consensus moderne** : Les deux approches sont valides, adaptez selon :
- Architecture de votre app
- Budget et ressources
- Criticité du projet

---

<!-- _class: lead -->

# 3. Frameworks de Test Modernes

---

## Landscape JavaScript/TypeScript (2024-2025)

**Tests unitaires/intégration** :
- ⚡ **Vitest** (2021) - Leader actuel, 6M+ téléchargements/semaine
- 🔧 Jest (2016) - Ancien standard, encore populaire
- 🚀 Node Test Runner (2022) - Natif Node.js 18+

**Tests E2E** :
- 🎭 **Playwright** (2020, Microsoft) - Multi-browser, auto-wait
- 🌲 Cypress (2014) - Approche "inside the browser"
- 🤖 Selenium (2004) - Vétéran, moins moderne

---

## Vitest - Le nouveau standard

**Pourquoi Vitest ?**
- ⚡ **10x plus rapide** que Jest (Vite sous le capot)
- 🔄 **HMR pour les tests** : feedback instantané
- 🎯 **Compatible Jest API** : migration facile
- 📸 **Snapshot testing** intégré
- 🧩 **TypeScript first**

```typescript
// vite.config.ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'jsdom',
    coverage: {
      reporter: ['text', 'json', 'html']
    }
  }
});
```

---

## Exemple Vitest avec coverage

```typescript
// userService.test.ts
import { describe, it, expect, beforeEach } from 'vitest';
import { UserService } from './userService';

describe('UserService', () => {
  let service: UserService;

  beforeEach(() => {
    service = new UserService();
  });

  it('should create a user', () => {
    const user = service.create('Alice', 'alice@test.com');

    expect(user.id).toBeDefined();
    expect(user.name).toBe('Alice');
    expect(user.isActive).toBe(true);
  });
});
```

```bash
bun vitest --coverage
```

---

## Playwright - Leader E2E

**Microsoft Playwright** (2020) remplace Selenium/Puppeteer :

**Avantages** :
- 🌐 **Multi-browser** : Chromium, Firefox, WebKit
- 📱 **Mobile emulation** : iPhone, Android
- 🎥 **Traces & vidéos** : debugging facile
- 🔄 **Auto-wait** : pas de `sleep()` manuels
- ⚡ **Parallélisation** : tests ultra-rapides

**Adoption** : Netflix, GitHub, Microsoft, Vercel.

---

## Configuration Playwright

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  retries: process.env.CI ? 2 : 0,

  use: {
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
    { name: 'Mobile Chrome', use: { ...devices['Pixel 5'] } },
  ],
});
```

---

## pytest - Le standard Python

**pytest** (2004 - 40M+ téléchargements/mois)

**Avantages** :
- 🐍 **Pythonic** : assertions Python natives
- 🔌 **Plugins riches** : pytest-django, pytest-asyncio
- 🎪 **Fixtures puissantes** : injection de dépendances

```python
# test_user.py
import pytest

@pytest.fixture
def user_service():
    return UserService()

def test_create_user(user_service):
    user = user_service.create("Bob", "bob@test.com")
    assert user.id is not None
    assert user.name == "Bob"
```

---

## JUnit 5 - Standard Java moderne

```java
// UserServiceTest.java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("User Service Tests")
class UserServiceTest {

    @Test
    @DisplayName("Should create user with valid data")
    void testCreateUser() {
        UserService service = new UserService();
        User user = service.create("Alice", "alice@test.com");

        assertNotNull(user.getId());
        assertEquals("Alice", user.getName());
        assertTrue(user.isActive());
    }
}
```

---

<!-- _class: lead -->

# 4. Analyse de Code & Métriques

---

## Analyse Statique de Code

**Analyse statique** = Détection de problèmes **sans exécuter** le programme.

**Catégories d'outils** :

1. **Linters** : Détectent bugs potentiels et violations de style
   - ESLint (JavaScript/TypeScript)
   - Pylint (Python)
   - RuboCop (Ruby)

2. **Formatters** : Imposent un style uniforme automatiquement
   - Prettier (JavaScript/TypeScript)
   - Black (Python)
   - gofmt (Go)

3. **Analyseurs avancés** : Sécurité, complexité, duplication
   - SonarQube, CodeQL, Semgrep

---

## ESLint + Prettier - Combo gagnant

**ESLint** (30M+ téléchargements/semaine) :
```javascript
// .eslintrc.js
module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'prettier' // Désactive les règles conflictuelles
  ],
  rules: {
    'no-console': 'warn',
    '@typescript-eslint/no-unused-vars': 'error'
  }
};
```

**Prettier** (20M+ téléchargements/semaine) :
```json
{
  "semi": true,
  "singleQuote": true,
  "printWidth": 80
}
```

---

## SonarQube - Analyse complète

**Plateforme d'analyse de qualité de code** :

**Métriques fournies** :
- 🐛 **Bugs** : null pointers, resource leaks
- 🔒 **Vulnérabilités** : injections SQL, XSS
- 💩 **Code smells** : complexité, duplication
- 📊 **Couverture** : tests et branches

**Ratings** : A (excellent) → E (critique)
- Maintainability Rating
- Reliability Rating
- Security Rating

---

## Code Coverage (Couverture de Code)

**Définition** : Pourcentage de code **exécuté** par les tests.

**Types de couverture** :
- **Line Coverage** : % de lignes exécutées
- **Branch Coverage** : % de branches conditionnelles testées
- **Function Coverage** : % de fonctions appelées

**Exemple de rapport** :
```
File                | % Stmts | % Branch | % Funcs | % Lines |
--------------------|---------|----------|---------|---------|
All files           |   84.21 |    73.33 |   88.88 |   84.21 |
 src/utils.ts       |     100 |      100 |     100 |     100 |
 src/services/      |   78.57 |    66.66 |   83.33 |   78.57 |
```

---

## Qu'est-ce qu'un bon taux de couverture ?

| Taux | Interprétation |
|------|----------------|
| < 50% | ⚠️ Critique - tests insuffisants |
| 50-70% | 🟡 Acceptable - peut mieux faire |
| 70-85% | ✅ Bon - **cible recommandée** |
| 85-95% | 🌟 Excellent |
| > 95% | ⚠️ Attention - coût/bénéfice discutable |

**Important** : La couverture est un **indicateur**, pas un **objectif** !

> "100% code coverage doesn't mean 100% bug-free"
> — Martin Fowler

---

## Complexité Cyclomatique

**Définition** (Thomas McCabe, 1976) : Nombre de **chemins indépendants** dans le code.

| Complexité | Risque | Action |
|------------|--------|--------|
| 1-10 | Faible | Code simple, facile à tester |
| 11-20 | Modéré | Acceptable, surveiller |
| 21-50 | Élevé | Refactoring recommandé |
| > 50 | Très élevé | ⚠️ Refactoring urgent |

**Exemple** :
```typescript
// ❌ Complexité = 8 (trop élevé)
function calculateDiscount(user, amount) {
  if (user.isPremium) {
    if (amount > 1000) return amount * 0.2;
    else if (amount > 500) return amount * 0.15;
  } else {
    if (amount > 1000) return amount * 0.1;
    else if (amount > 500) return amount * 0.05;
  }
  return 0;
}
```

---

## Refactoring pour réduire la complexité

```typescript
// ✅ Complexité = 3 (bien mieux !)
function calculateDiscount(user: User, amount: number): number {
  const tier = getDiscountTier(user, amount);
  return amount * tier.rate;
}

function getDiscountTier(user: User, amount: number): DiscountTier {
  const tiers = user.isPremium ? PREMIUM_TIERS : STANDARD_TIERS;
  return tiers.find(tier => amount >= tier.threshold) ?? DEFAULT_TIER;
}

const PREMIUM_TIERS = [
  { threshold: 1000, rate: 0.2 },
  { threshold: 500, rate: 0.15 }
];

const STANDARD_TIERS = [
  { threshold: 1000, rate: 0.1 },
  { threshold: 500, rate: 0.05 }
];
```

---

## DORA Metrics - Impact des tests

**DORA** = DevOps Research and Assessment (Google Cloud)

Les 4 métriques clés :

1. **Deployment Frequency** : Fréquence des déploiements
2. **Lead Time for Changes** : Temps commit → production
3. **Change Failure Rate** : % de déploiements échoués
4. **Time to Restore Service** : Temps de récupération

**Impact des tests** :
- Tests rapides → déploiements fréquents
- Pipeline optimisé → lead time réduit
- Tests solides → taux d'échec réduit
- Tests facilitent le rollback rapide

---

## Benchmarks DORA 2024

| Niveau | Deployment Freq. | Lead Time | Change Failure | MTTR |
|--------|-----------------|-----------|----------------|------|
| **Elite** | On-demand (plusieurs/jour) | < 1 heure | 0-15% | < 1 heure |
| **High** | 1x/jour - 1x/semaine | 1 jour - 1 semaine | 16-30% | < 1 jour |
| **Medium** | 1x/mois - 1x/6 mois | 1 semaine - 1 mois | 16-30% | 1-7 jours |
| **Low** | < 1x/6 mois | 1-6 mois | > 30% | > 6 mois |

**Objectif** : Viser le niveau **Elite** ou **High** grâce à l'automatisation.

---

<!-- _class: lead -->

# 🎯 Démo Live

## Pipeline de Tests en Action

*Démonstration d'un projet avec Vitest + Playwright + CI/CD*

---

## Ce que nous allons voir en démo

1. **Tests unitaires avec Vitest**
   - Exécution rapide (< 1 seconde)
   - Watch mode et HMR
   - Rapport de coverage

2. **Tests E2E avec Playwright**
   - Exécution multi-browser
   - Génération de traces et vidéos
   - Rapport HTML interactif

3. **Intégration CI/CD**
   - GitHub Actions workflow
   - Tests automatiques à chaque push
   - Rapport de coverage dans PR

---

## Récapitulatif Module 4

**Outils de Build** :
- Automatisation de la création d'artefacts
- npm/Vite/Bun pour JS, Maven/Gradle pour Java

**Types de Tests** :
- Pyramide : 70% Unit / 20% Integration / 10% E2E
- Trophée : Focus sur Integration (sweet spot)

**Frameworks Modernes** :
- Vitest (JS), pytest (Python), JUnit 5 (Java), Playwright (E2E)

**Analyse & Métriques** :
- Code coverage : cible 70-85%
- Complexité cyclomatique : < 10
- DORA metrics pour mesurer la performance

---

<!-- _class: lead -->

# Questions ?

**Module 4 : Build & Tests Automatisés**

---

## 📚 Ressources Complémentaires

### Articles
- **"The Practical Test Pyramid"** - Martin Fowler
- **"Write tests. Not too many. Mostly integration."** - Kent C. Dodds

### Documentation
- Vitest : https://vitest.dev/
- Playwright : https://playwright.dev/
- pytest : https://docs.pytest.org/

### Rapports
- **State of DevOps Report 2024** - DORA/Google Cloud
- **State of JS 2024** - Testing tools survey

### Document de recherche
- **build-et-tests-automatises.md** (15,000+ mots, disponible dans les ressources du cours)

---

<!-- _class: lead -->

# Prochaine étape

## Module 5
### CI/CD avec GitHub Actions

*Pause ☕ 15 minutes*
