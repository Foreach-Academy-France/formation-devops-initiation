# Build & Tests Automatisés - Guide Complet

> **Document de recherche pour le Module 4 du cours DevOps**
> *Formation M2 ESTD - Architecte Web | ForEach Academy | Novembre 2025*

---

## 📋 Table des matières

1. [Introduction](#introduction)
2. [Outils de Build](#outils-de-build)
3. [Types de Tests](#types-de-tests)
4. [Frameworks de Test Modernes](#frameworks-de-test-modernes)
5. [Analyse de Code](#analyse-de-code)
6. [Métriques Logicielles](#métriques-logicielles)
7. [Gestion des Artefacts](#gestion-des-artefacts)
8. [Glossaire](#glossaire)
9. [Références](#références)

---

## Introduction

Le **build** et les **tests automatisés** constituent le cœur de la **livraison continue** (Continuous Delivery) dans les pratiques DevOps modernes. Ces processus transforment le code source en artefacts déployables tout en garantissant la qualité et la fiabilité du logiciel.

### Pourquoi automatiser le build et les tests ?

L'automatisation apporte des bénéfices mesurables :

- **Rapidité** : Build reproductible en quelques minutes au lieu d'heures
- **Fiabilité** : Détection précoce des bugs (shift-left testing)
- **Confiance** : Déploiements sans peur grâce aux tests automatisés
- **Productivité** : Les développeurs se concentrent sur la valeur métier

### Statistiques clés (2024-2025)

Selon le **State of DevOps Report 2024** (DORA/Google Cloud) :

- Les équipes performantes déploient **208 fois plus fréquemment**
- Leur **lead time** (commit → production) est **106 fois plus rapide**
- Le taux d'échec des changements est **7 fois plus bas**
- Le **MTTR** (Mean Time To Recovery) est **2 604 fois plus rapide**

**La différence ?** Des pipelines de build et test automatisés robustes.

---

## Outils de Build

### Qu'est-ce qu'un outil de build ?

Un **outil de build** automatise la transformation du code source en un **artefact exécutable** (binaire, package, image Docker, etc.).

**Responsabilités typiques d'un outil de build** :
- Compilation du code source
- Résolution des dépendances
- Exécution des tests
- Génération de documentation
- Packaging et création d'artefacts
- Optimisation (minification, tree-shaking)

### Build vs Compilation

| Aspect | Compilation | Build |
|--------|-------------|-------|
| **Portée** | Code source → code machine | Processus complet de création d'artefact |
| **Étapes** | Analyse syntaxique, génération de bytecode | Compilation + tests + packaging + documentation |
| **Outils** | `gcc`, `javac`, `tsc` | Maven, Gradle, npm, bun |
| **Sortie** | Fichiers `.o`, `.class`, `.js` | JAR, WAR, bundle.js, image Docker |

### Timeline des outils de build majeurs

```
1976 ── Make (Stuart Feldman, Bell Labs)
        │   "The grandfather of build tools"
        │   Fichiers Makefile, encore utilisé aujourd'hui
        │
2000 ── Apache Ant (James Duncan Davidson, Apache)
        │   Premier outil de build XML pour Java
        │   Remplace les Makefiles complexes
        │
2004 ── Apache Maven (Jason van Zyl, Apache)
        │   Convention over configuration
        │   Gestion de dépendances centralisée (Maven Central)
        │   Cycle de vie standardisé
        │
2007 ── Rake (Jim Weirich)
        │   Make-like pour Ruby
        │   DSL Ruby pour définir les tâches
        │
2012 ── Gradle (Hans Dockter, Adam Murdoch)
        │   DSL Groovy/Kotlin
        │   Build incrémental et cache distribué
        │   Adopté par Google pour Android (2013)
        │
2010 ── npm (Isaac Z. Schlueter)
        │   Package manager + build tool pour Node.js
        │   Scripts dans package.json
        │   17 millions de packages en 2024
        │
2016 ── Yarn (Facebook/Meta)
        │   Résolution déterministe des dépendances
        │   yarn.lock pour reproducibilité
        │
2017 ── pnpm (Zoltan Kochan)
        │   Économie d'espace disque (hard links)
        │   Monorepos optimisés
        │
2020 ── Bun (Jarred Sumner)
        │   Runtime + bundler + package manager
        │   Performance extrême (écrit en Zig)
        │   Compatible npm, 25x plus rapide
        │
2020 ── Vite (Evan You, créateur de Vue.js)
        │   ESM natif, HMR ultra-rapide
        │   esbuild sous le capot
        │   Rollup pour production
        │
2024 ── Turbo (Vercel)
        │   Build system incrémental pour monorepos
        │   Remote caching
        │   Intégration Vercel
```

### Outils de build modernes par écosystème

#### JavaScript/TypeScript

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
- Tree-shaking automatique

**Bun** (2023 - 1M+ utilisateurs)
```bash
# 25x plus rapide que npm install
bun install

# Bundler intégré
bun build ./index.ts --outdir ./dist
```

#### Java

**Maven** (2004 - 70% des projets Java)
```xml
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.11.0</version>
    </plugin>
  </plugins>
</build>
```

**Gradle** (2012 - Android officiel)
```kotlin
// build.gradle.kts
plugins {
    kotlin("jvm") version "1.9.20"
}

tasks.test {
    useJUnitPlatform()
}
```

#### Python

**pip + setuptools** (2008)
```python
# setup.py
from setuptools import setup

setup(
    name="myapp",
    version="1.0.0",
    install_requires=["fastapi", "pydantic"]
)
```

**Poetry** (2018 - Moderne)
```toml
[tool.poetry]
name = "myapp"
version = "1.0.0"

[tool.poetry.dependencies]
python = "^3.11"
fastapi = "^0.104.0"
```

#### .NET

**MSBuild** (2003 - Officiel Microsoft)
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
</Project>
```

### Artefacts de build

Un **artefact** est le produit final du build, prêt à être déployé ou distribué.

**Types d'artefacts courants** :

| Type | Format | Exemples |
|------|--------|----------|
| **Binaires compilés** | `.exe`, `.dll`, `.so` | Application C++, bibliothèque native |
| **Archives Java** | `.jar`, `.war`, `.ear` | Spring Boot JAR, application Java EE |
| **Packages npm** | `.tgz` | Package Node.js |
| **Packages Python** | `.whl`, `.tar.gz` | Distribution PyPI |
| **Images Docker** | Image OCI | `myapp:1.2.3` |
| **Bundles JS** | `.js`, `.mjs` | `bundle.min.js` optimisé |

---

## Types de Tests

### La Pyramide de Tests (Mike Cohn, 2009)

La **pyramide de tests** illustre la répartition idéale des tests dans une stratégie de test efficace :

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

### 1. Tests Unitaires

**Définition** : Tests d'une **unité de code isolée** (fonction, méthode, classe) sans dépendances externes.

**Caractéristiques** :
- ⚡ **Rapides** : millisecondes par test
- 🎯 **Isolés** : pas de base de données, API, filesystem
- 🔄 **Reproductibles** : même input → même output
- 📊 **Nombreux** : des centaines ou milliers

**Exemple (JavaScript/Vitest)** :
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
    expect(sum(2, 3)).toBe(5);
  });

  it('should handle negative numbers', () => {
    expect(sum(-1, 1)).toBe(0);
  });
});
```

**Bonnes pratiques** :
- Pattern **AAA** : Arrange, Act, Assert
- Un concept testé par test
- Noms de tests descriptifs
- Pas de logique dans les tests

### 2. Tests d'Intégration

**Définition** : Tests de l'**interaction entre plusieurs composants** (base de données, API, services).

**Caractéristiques** :
- 🐢 **Plus lents** : secondes par test
- 🔗 **Dépendances réelles** : BDD, Redis, APIs
- 🎭 **Scénarios réalistes** : flux utilisateur complets

**Exemple (Python/pytest + API)** :
```python
# test_api_integration.py
import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_and_get_user():
    # Arrange: Create user via API
    response = client.post(
        "/users",
        json={"name": "Alice", "email": "alice@example.com"}
    )
    assert response.status_code == 201
    user_id = response.json()["id"]

    # Act: Retrieve user
    response = client.get(f"/users/{user_id}")

    # Assert
    assert response.status_code == 200
    assert response.json()["name"] == "Alice"
```

### 3. Tests End-to-End (E2E)

**Définition** : Tests du **système complet** du point de vue utilisateur (navigateur, mobile).

**Caractéristiques** :
- 🐌 **Très lents** : minutes par scénario
- 💰 **Coûteux** : maintenance, environnements
- 🎬 **Réalistes** : interactions UI réelles

**Exemple (Playwright)** :
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

### Le Trophée de Tests (Kent C. Dodds, 2018)

Réinterprétation moderne de la pyramide, mettant l'accent sur les **tests d'intégration** :

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

## Frameworks de Test Modernes (2024-2025)

### JavaScript/TypeScript

#### Vitest (2021 - 6M+ téléchargements/semaine)

**Pourquoi Vitest ?**
- ⚡ **10x plus rapide** que Jest (Vite sous le capot)
- 🔄 **HMR pour les tests** : feedback instantané
- 🎯 **Compatible Jest API** : migration facile
- 📸 **Snapshot testing** intégré

```typescript
// vite.config.ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'jsdom',
    coverage: {
      reporter: ['text', 'json', 'html'],
      threshold: {
        lines: 80,
        functions: 80,
        branches: 75,
        statements: 80
      }
    }
  }
});
```

**Commandes** :
```bash
# Run tests
bun vitest

# Watch mode
bun vitest --watch

# Coverage
bun vitest --coverage
```

#### Playwright (2020 - Microsoft)

**Leader du test E2E** (remplace Selenium/Puppeteer) :
- 🌐 **Multi-browser** : Chromium, Firefox, WebKit
- 📱 **Mobile emulation** : iPhone, Android
- 🎥 **Traces & vidéos** : debugging facile
- 🔄 **Auto-wait** : pas de `sleep()` manuels

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',

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

### Python

#### pytest (2004 - 40M+ téléchargements/mois)

**Le standard Python** :
- 🐍 **Pythonic** : assertions Python natives
- 🔌 **Plugins riches** : pytest-django, pytest-asyncio
- 🎪 **Fixtures puissantes** : injection de dépendances

```python
# conftest.py (fixtures partagées)
import pytest
from sqlalchemy import create_engine
from app.database import Base

@pytest.fixture(scope="session")
def db_engine():
    engine = create_engine("sqlite:///:memory:")
    Base.metadata.create_all(engine)
    yield engine
    engine.dispose()

@pytest.fixture
def db_session(db_engine):
    from sqlalchemy.orm import sessionmaker
    Session = sessionmaker(bind=db_engine)
    session = Session()
    yield session
    session.rollback()
    session.close()

# test_user.py
def test_create_user(db_session):
    user = User(name="Bob", email="bob@test.com")
    db_session.add(user)
    db_session.commit()

    assert user.id is not None
    assert user.name == "Bob"
```

**Configuration (pyproject.toml)** :
```toml
[tool.pytest.ini_options]
minversion = "7.0"
addopts = "-ra -q --cov=app --cov-report=html"
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"
```

### Java

#### JUnit 5 (2017 - Standard Java moderne)

```java
// UserServiceTest.java
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("User Service Tests")
class UserServiceTest {

    private UserService userService;

    @BeforeEach
    void setUp() {
        userService = new UserService();
    }

    @Test
    @DisplayName("Should create user with valid data")
    void testCreateUser() {
        User user = userService.create("Alice", "alice@test.com");

        assertNotNull(user.getId());
        assertEquals("Alice", user.getName());
        assertTrue(user.isActive());
    }

    @ParameterizedTest
    @ValueSource(strings = {"", "   ", "null"})
    @DisplayName("Should reject invalid names")
    void testInvalidNames(String name) {
        assertThrows(
            ValidationException.class,
            () -> userService.create(name, "test@example.com")
        );
    }
}
```

### .NET

#### xUnit (2007 - Recommandé par Microsoft)

```csharp
// UserServiceTests.cs
using Xunit;

public class UserServiceTests
{
    [Fact]
    public void CreateUser_ValidData_ReturnsUser()
    {
        // Arrange
        var service = new UserService();

        // Act
        var user = service.Create("Alice", "alice@test.com");

        // Assert
        Assert.NotNull(user.Id);
        Assert.Equal("Alice", user.Name);
    }

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData(null)]
    public void CreateUser_InvalidName_ThrowsException(string name)
    {
        var service = new UserService();

        Assert.Throws<ArgumentException>(
            () => service.Create(name, "test@example.com")
        );
    }
}
```

---

## Analyse de Code

L'**analyse statique de code** détecte les problèmes **sans exécuter** le programme.

### Linters

Les **linters** analysent le code source pour détecter :
- Erreurs de syntaxe
- Code non utilisé
- Violations de conventions
- Bugs potentiels

#### ESLint (JavaScript/TypeScript)

**Le standard JavaScript** (30M+ téléchargements/semaine) :

```javascript
// .eslintrc.js
module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'prettier' // Désactive les règles conflictuelles avec Prettier
  ],
  rules: {
    'no-console': 'warn',
    '@typescript-eslint/no-unused-vars': 'error',
    'react/prop-types': 'off' // TypeScript gère déjà les types
  }
};
```

#### Pylint (Python)

```python
# .pylintrc
[MASTER]
ignore=migrations,tests

[MESSAGES CONTROL]
disable=C0111  # missing-docstring

[FORMAT]
max-line-length=100
```

### Formatters

Les **formatters** imposent un **style uniforme** automatiquement (pas de débat !).

#### Prettier (JavaScript/TypeScript)

**"An opinionated code formatter"** (20M+ téléchargements/semaine) :

```json
{
  "semi": true,
  "singleQuote": true,
  "printWidth": 80,
  "trailingComma": "es5",
  "tabWidth": 2
}
```

**Intégration CI** :
```bash
# Check formatting
prettier --check "src/**/*.{ts,tsx}"

# Fix automatically
prettier --write "src/**/*.{ts,tsx}"
```

#### Black (Python)

**"The uncompromising Python formatter"** :
```bash
# Format entire project
black .

# Check only
black --check src/
```

### Analyse Statique Avancée

#### SonarQube

**Plateforme complète d'analyse de code** :
- 🐛 **Bugs** : null pointers, resource leaks
- 🔒 **Vulnérabilités** : injections SQL, XSS
- 💩 **Code smells** : complexité, duplication
- 📊 **Couverture** : tests et branches

**Métriques fournies** :
- **Maintenability Rating** : A-E basé sur technical debt
- **Reliability Rating** : bugs par milliers de lignes
- **Security Rating** : vulnérabilités critiques
- **Duplications** : % de code dupliqué

```yaml
# sonar-project.properties
sonar.projectKey=my-project
sonar.sources=src
sonar.tests=tests
sonar.exclusions=**/node_modules/**,**/dist/**
sonar.javascript.lcov.reportPaths=coverage/lcov.info
```

---

## Métriques Logicielles

### Code Coverage (Couverture de Code)

**Définition** : Pourcentage de code **exécuté** par les tests.

**Types de couverture** :

1. **Line Coverage** : % de lignes exécutées
2. **Branch Coverage** : % de branches conditionnelles testées
3. **Function Coverage** : % de fonctions appelées
4. **Statement Coverage** : % d'instructions exécutées

**Exemple de rapport (Vitest)** :
```
-----------------------------|---------|----------|---------|---------|
File                         | % Stmts | % Branch | % Funcs | % Lines |
-----------------------------|---------|----------|---------|---------|
All files                    |   84.21 |    73.33 |   88.88 |   84.21 |
 src/                        |     100 |      100 |     100 |     100 |
  utils.ts                   |     100 |      100 |     100 |     100 |
 src/services/               |   78.57 |    66.66 |   83.33 |   78.57 |
  userService.ts             |   78.57 |    66.66 |   83.33 |   78.57 |
-----------------------------|---------|----------|---------|---------|
```

**Qu'est-ce qu'un bon taux de couverture ?**

| Taux | Interprétation |
|------|----------------|
| < 50% | ⚠️ Critique - tests insuffisants |
| 50-70% | 🟡 Acceptable - peut mieux faire |
| 70-85% | ✅ Bon - cible recommandée |
| 85-95% | 🌟 Excellent |
| > 95% | ⚠️ Attention - coût/bénéfice discutable |

**Important** : La couverture est un **indicateur**, pas un **objectif** !

> "100% code coverage doesn't mean 100% bug-free" - Martin Fowler

### Complexité Cyclomatique

**Définition** (Thomas McCabe, 1976) : Nombre de **chemins indépendants** dans le code.

**Calcul** : `M = E - N + 2P`
- E = nombre d'arêtes (transitions)
- N = nombre de nœuds (blocs)
- P = nombre de composants connectés

**Interprétation** :

| Complexité | Risque | Action |
|------------|--------|--------|
| 1-10 | Faible | Code simple, facile à tester |
| 11-20 | Modéré | Acceptable, surveiller |
| 21-50 | Élevé | Refactoring recommandé |
| > 50 | Très élevé | ⚠️ Refactoring urgent |

**Exemple (fonction complexe)** :
```typescript
// Complexité cyclomatique = 8 (trop élevé !)
function calculateDiscount(user, amount) {
  if (user.isPremium) {
    if (amount > 1000) {
      return amount * 0.2;
    } else if (amount > 500) {
      return amount * 0.15;
    }
  } else {
    if (amount > 1000) {
      return amount * 0.1;
    } else if (amount > 500) {
      return amount * 0.05;
    }
  }
  return 0;
}

// Refactoré (complexité = 3)
function calculateDiscount(user, amount) {
  const tier = getDiscountTier(user, amount);
  return amount * tier.rate;
}
```

### DORA Metrics (liées au testing)

**DORA** = DevOps Research and Assessment (Google Cloud)

Les 4 métriques clés :

1. **Deployment Frequency** : Fréquence des déploiements
2. **Lead Time for Changes** : Temps commit → production
3. **Change Failure Rate** : % de déploiements échoués
4. **Time to Restore Service** : Temps de récupération après incident

**Impact des tests sur les DORA metrics** :

| Métrique | Impact des tests |
|----------|-----------------|
| Deployment Frequency | Tests rapides = déploiements fréquents |
| Lead Time | Pipeline optimisé réduit le lead time |
| Change Failure Rate | Tests solides réduisent les échecs |
| Time to Restore | Tests facilitent le rollback rapide |

**Benchmarks 2024** (DORA Report) :

| Niveau | Deployment Freq. | Lead Time | Change Failure | MTTR |
|--------|-----------------|-----------|----------------|------|
| Elite | On-demand (plusieurs fois/jour) | < 1 heure | 0-15% | < 1 heure |
| High | 1x/jour à 1x/semaine | 1 jour - 1 semaine | 16-30% | < 1 jour |
| Medium | 1x/mois à 1x/6 mois | 1 semaine - 1 mois | 16-30% | 1 jour - 1 semaine |
| Low | < 1x/6 mois | 1-6 mois | > 30% | > 6 mois |

---

## Gestion des Artefacts

### Qu'est-ce qu'un artefact ?

Un **artefact** est un fichier **immuable** produit par le build, identifié par :
- **Nom** : `myapp`
- **Version** : `1.2.3`
- **Checksum** : `sha256:a3b2c1...`

**Propriétés** :
- ✅ **Reproductible** : même build = même artefact
- ✅ **Versioned** : semver (Semantic Versioning)
- ✅ **Signé** : garantie d'intégrité (GPG, cosign)

### Registres d'artefacts publics

#### npm (JavaScript/TypeScript)

**17 millions de packages** (le plus grand registre) :

```bash
# Publish to npm
npm publish

# Install specific version
npm install express@4.18.2
```

**Versioning avec semver** :
```json
{
  "name": "my-package",
  "version": "1.2.3",
  "dependencies": {
    "express": "^4.18.0",  // Compatible avec 4.x
    "lodash": "~4.17.0"    // Compatible avec 4.17.x
  }
}
```

#### PyPI (Python)

**500,000+ packages** :

```bash
# Build wheel
python -m build

# Upload to PyPI
twine upload dist/*

# Install
pip install requests==2.31.0
```

#### Maven Central (Java)

**12 millions d'artefacts** :

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <version>3.2.0</version>
</dependency>
```

#### Docker Hub (Images OCI)

**100 millions d'images** :

```bash
# Pull image
docker pull nginx:1.25-alpine

# Push image
docker tag myapp:latest myuser/myapp:1.2.3
docker push myuser/myapp:1.2.3
```

### Registres privés (entreprise)

#### JFrog Artifactory

**Leader du marché** pour artefacts entreprise :
- 🔒 **Sécurité** : RBAC, scanning de vulnérabilités
- 🌐 **Multi-format** : Maven, npm, Docker, Helm
- 📊 **Métriques** : téléchargements, usage
- 🔄 **Réplication** : géographique

#### Nexus Repository

**Alternative open source** (Sonatype) :
- Maven Central official mirror
- Support npm, PyPI, Docker
- OSS version gratuite

#### GitHub Packages

**Intégré à GitHub** :
- npm, Maven, NuGet, Docker
- CI/CD avec GitHub Actions
- Gratuit pour public repos

```yaml
# .github/workflows/publish.yml
- name: Publish to GitHub Packages
  run: |
    echo "//npm.pkg.github.com/:_authToken=${{ secrets.GITHUB_TOKEN }}" > ~/.npmrc
    npm publish
```

### Semantic Versioning (semver)

**Format** : `MAJOR.MINOR.PATCH` (ex: `2.4.1`)

```
MAJOR: 2  ← Breaking changes (incompatibilité)
MINOR: 4  ← Nouvelles fonctionnalités (rétro-compatible)
PATCH: 1  ← Bug fixes (rétro-compatible)
```

**Exemples** :
- `1.0.0` → `1.0.1` : Bug fix (patch)
- `1.0.1` → `1.1.0` : Nouvelle feature (minor)
- `1.1.0` → `2.0.0` : Breaking change (major)

**Versions pré-release** :
- `1.0.0-alpha.1` : Alpha (instable)
- `1.0.0-beta.2` : Beta (testing)
- `1.0.0-rc.1` : Release Candidate

---

## Glossaire

### Français → Anglais

| Français | Anglais | Définition |
|----------|---------|------------|
| **Artefact** | Artifact | Produit final du build (JAR, image Docker) |
| **Couverture de code** | Code coverage | % de code exécuté par les tests |
| **Dépendance** | Dependency | Bibliothèque externe utilisée par le projet |
| **Livraison continue** | Continuous Delivery (CD) | Automatisation du déploiement en production |
| **Intégration continue** | Continuous Integration (CI) | Tests automatisés à chaque commit |
| **Pipeline** | Pipeline | Séquence d'étapes automatisées (build, test, deploy) |
| **Tests de bout en bout** | End-to-End (E2E) tests | Tests du système complet (UI incluse) |
| **Tests d'intégration** | Integration tests | Tests de l'interaction entre composants |
| **Tests unitaires** | Unit tests | Tests d'une fonction/méthode isolée |

---

## Références

### Articles fondateurs

1. **"The Practical Test Pyramid"** - Martin Fowler (2012)
   - https://martinfowler.com/articles/practical-test-pyramid.html
   - Introduction de la pyramide de tests

2. **"Write tests. Not too many. Mostly integration."** - Kent C. Dodds (2018)
   - https://kentcdodds.com/blog/write-tests
   - Trophée de tests et pragmatisme

3. **"A Complexity Measure"** - Thomas J. McCabe (1976)
   - IEEE Transactions on Software Engineering
   - Introduction de la complexité cyclomatique

### Rapports annuels

4. **State of DevOps Report 2024** - DORA (Google Cloud)
   - https://dora.dev/research/
   - DORA metrics et benchmarks

5. **State of JS 2024** - Testing tools survey
   - https://stateofjs.com/en-US/libraries/testing/
   - Adoption des frameworks de test JavaScript

### Documentation officielle

6. **Vitest** - https://vitest.dev/
7. **Playwright** - https://playwright.dev/
8. **pytest** - https://docs.pytest.org/
9. **JUnit 5** - https://junit.org/junit5/
10. **SonarQube** - https://docs.sonarqube.org/

### Livres recommandés

11. **"Test Driven Development: By Example"** - Kent Beck (2002)
12. **"Growing Object-Oriented Software, Guided by Tests"** - Steve Freeman & Nat Pryce (2009)
13. **"The Art of Unit Testing"** - Roy Osherove (2013)

---

**Document créé le** : Novembre 2025
**Auteur** : Fabrice Claeys
**Formation** : Cours Initiation DevOps - M2 ESTD Architecte Web
**Institution** : ForEach Academy

---

*Ce document fait partie du Module 4 du cours DevOps. Pour toute question ou correction, contactez l'équipe pédagogique.*
