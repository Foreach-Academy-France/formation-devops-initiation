---
# Claude Context
claude-context: true
type: research

# Metadata
date: 2025-11-05
research_type: technical

# Organization
tags:
  - research
  - docker
  - conteneurisation
  - devops
  - kubernetes
  - microservices
related_projects:
  - Cours Initiation DevOps

# Research Scope
keywords: [docker, conteneurisation, containers, virtualisation, microservices, devops]
sources_count: 15
tools_used:
  - WebSearch
  - Ref.ai
  - BrightData
---

# Docker & Conteneurisation - Document de Recherche Exhaustif
## Module 6 : Cours DevOps M2 Expert Stratégie et Transformation Digitale

**Partie 1/3 : Introduction, Histoire et Concepts Fondamentaux**

---

## Table des matières - Partie 1

1. [Introduction](#introduction)
2. [Histoire de la Conteneurisation](#histoire-de-la-conteneurisation)
   - [Avant les conteneurs : L'ère des monolithes et des VMs](#avant-les-conteneurs)
   - [Timeline détaillée (1979-2025)](#timeline-détaillée)
   - [Docker : La révolution de 2013](#docker-la-révolution)
   - [L'explosion de l'écosystème](#explosion-écosystème)
3. [Conteneurs vs Machines Virtuelles](#conteneurs-vs-machines-virtuelles)
   - [Architecture comparée](#architecture-comparée)
   - [Hyperviseurs Type 1 et Type 2](#hyperviseurs)
   - [Performance et benchmarks](#performance-benchmarks)
   - [Cas d'usage](#cas-usage)

---

## Introduction

### Contexte : La révolution du déploiement applicatif

Dans le paysage technologique moderne, la conteneurisation représente l'une des innovations les plus disruptives des vingt dernières années. Avec **318 milliards de téléchargements cumulés sur Docker Hub** (données 2024) et une croissance de **145% en glissement annuel**, les conteneurs sont devenus le standard de facto pour le déploiement d'applications.

Cette révolution ne s'est pas produite du jour au lendemain. Elle est le fruit d'une évolution de plus de **40 ans** de recherche en isolation de processus, virtualisation et optimisation des ressources système.

### Pourquoi les conteneurs ?

Les conteneurs répondent à trois problématiques majeures du développement et déploiement logiciel :

1. **"It works on my machine"** - Le syndrome de l'environnement non reproductible
2. **Overhead des machines virtuelles** - Gaspillage de ressources et temps de démarrage lents
3. **Complexité du déploiement** - Dépendances, configurations, orchestration

### Objectifs de ce document

Ce document de recherche vise à fournir une compréhension **exhaustive et technique** de Docker et de la conteneurisation, couvrant :

- L'évolution historique depuis `chroot` (1979) jusqu'à Kubernetes (2025)
- Les fondements techniques : namespaces, cgroups, union filesystems
- L'écosystème Docker : architecture, images, registres, orchestration
- Les patterns architecturaux modernes : microservices, cloud-native
- Les bonnes pratiques pour la production

---

## Histoire de la Conteneurisation

### Avant les conteneurs : L'ère des monolithes et des VMs (années 2000)

#### Le modèle monolithique traditionnel

Avant l'avènement de la conteneurisation, le déploiement d'applications suivait principalement deux paradigmes :

**1. Applications monolithiques sur serveurs physiques (bare metal)**

```
┌─────────────────────────────────────────────────┐
│          APPLICATION MONOLITHIQUE               │
│  ┌──────────────────────────────────────────┐   │
│  │  UI Layer + Business Logic + Data Layer  │   │
│  │  • Couplage fort entre composants        │   │
│  │  • Déploiement atomique                  │   │
│  │  • Scaling vertical uniquement           │   │
│  └──────────────────────────────────────────┘   │
├─────────────────────────────────────────────────┤
│          SYSTÈME D'EXPLOITATION                 │
│          (Linux, Windows Server)                │
├─────────────────────────────────────────────────┤
│          HARDWARE PHYSIQUE                      │
│          (CPU, RAM, Storage, Network)           │
└─────────────────────────────────────────────────┘
```

**Problématiques** :
- Utilisation inefficace des ressources (serveur dédié par application)
- Pas d'isolation : une application peut crasher tout le serveur
- Déploiement long et risqué
- Coût élevé : un serveur physique par application

**2. Virtualisation avec hyperviseurs**

La virtualisation a été la première tentative de résolution de ces problèmes, permettant d'exécuter **plusieurs systèmes d'exploitation** sur une seule machine physique.

```
┌────────────────────────────────────────────────────────────┐
│  VM 1           VM 2           VM 3           VM 4         │
│ ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐    │
│ │  App A  │   │  App B  │   │  App C  │   │  App D  │    │
│ ├─────────┤   ├─────────┤   ├─────────┤   ├─────────┤    │
│ │ Guest OS│   │ Guest OS│   │ Guest OS│   │ Guest OS│    │
│ │ (Linux) │   │(Windows)│   │ (Linux) │   │ (Linux) │    │
│ └─────────┘   └─────────┘   └─────────┘   └─────────┘    │
├────────────────────────────────────────────────────────────┤
│              HYPERVISOR (VMware ESXi, KVM, Xen)            │
├────────────────────────────────────────────────────────────┤
│              HOST OPERATING SYSTEM (optionnel)             │
├────────────────────────────────────────────────────────────┤
│              HARDWARE PHYSIQUE                             │
└────────────────────────────────────────────────────────────┘
```

**Avantages de la virtualisation** :
- Meilleure utilisation des ressources hardware
- Isolation forte entre VMs
- Possibilité de faire tourner différents OS sur le même hardware
- Snapshots, migration à chaud (live migration)

**Limites de la virtualisation** :
- Overhead important : chaque VM embarque un OS complet
- Temps de démarrage long (minutes)
- Consommation mémoire élevée (Go par VM)
- Complexité de gestion

### Timeline détaillée : 1979-2025

#### 1979 - chroot : Les premiers pas vers l'isolation

**Date** : Unix Version 7 (1979)
**Inventeur** : Bill Joy (développeur BSD)

`chroot` (change root) est l'ancêtre conceptuel de tous les systèmes de conteneurisation. Il permet de **modifier le répertoire racine** d'un processus, créant ainsi une vue restreinte du système de fichiers.

**Fonctionnement technique** :
```c
// Appel système chroot en C
chroot("/var/chroot/jail");
chdir("/");
```

**Cas d'usage historique** :
- Isolation de services réseau (FTP, DNS)
- Environnements de développement isolés
- Premiers "jails" de sécurité

**Limitations** :
- Isolation **uniquement au niveau filesystem**
- Pas d'isolation réseau, processus, ou ressources
- Facile à "échapper" avec les privilèges root

---

#### 1982 - chroot entre dans BSD

**Date** : 1982 (BSD 4.2)

L'intégration de `chroot` dans BSD marque le début de son adoption généralisée. Le terme **"chroot jail"** apparaît dans les années 1990 pour décrire l'utilisation sécuritaire de cette fonctionnalité.

---

#### 2000 - FreeBSD Jails : La première vraie conteneurisation

**Date** : Mars 2000
**Créateur** : Poul-Henning Kamp, développé pour R&D Associates
**Version** : FreeBSD 4.0

FreeBSD Jails représente un **bond technologique majeur** : pour la première fois, on dispose d'une isolation **multi-dimensionnelle**.

**Fonctionnalités révolutionnaires** :
- Isolation du filesystem (comme chroot)
- **Isolation réseau** : adresse IP dédiée par jail
- **Isolation des processus** : un processus ne peut voir que sa jail
- **Gestion des ressources** : quotas CPU, mémoire, disque
- Sécurité renforcée : même root dans une jail est limité

**Architecture FreeBSD Jails** :
```
┌──────────────────────────────────────────────────┐
│  Jail 1          Jail 2          Jail 3          │
│ ┌───────────┐  ┌───────────┐  ┌───────────┐     │
│ │ Apache    │  │ MySQL     │  │ Postgres  │     │
│ │ IP: .101  │  │ IP: .102  │  │ IP: .103  │     │
│ │ /jail1/   │  │ /jail2/   │  │ /jail3/   │     │
│ └───────────┘  └───────────┘  └───────────┘     │
├──────────────────────────────────────────────────┤
│          FreeBSD Kernel (Jail-aware)             │
├──────────────────────────────────────────────────┤
│          Hardware                                │
└──────────────────────────────────────────────────┘
```

**Impact** : FreeBSD Jails inspira directement les développements ultérieurs sur Linux et Solaris.

---

#### 2001 - Linux-VServer : Partitionnement kernel Linux

**Date** : 2001
**Créateur** : Jacques Gélinas

Linux-VServer introduit le concept de **security contexts** sur Linux, permettant de partitionner les ressources d'un serveur Linux en **Virtual Private Servers (VPS)**.

**Caractéristiques** :
- Patch kernel (non intégré au mainline)
- Isolation réseau, processus, IPC
- Utilisé par les premiers hébergeurs VPS

---

#### 2004-2005 - Solaris Zones/Containers : L'approche entreprise

**Date** : Février 2004 (beta), 2005 (release finale)
**Éditeur** : Sun Microsystems (Solaris 10)

Solaris Zones (aussi appelé Solaris Containers) apporte une solution de **conteneurisation niveau entreprise**.

**Innovation majeure** : Concept de **Resource Management** intégré

**Types de zones** :
1. **Global Zone** : Zone d'administration principale
2. **Non-Global Zones** : Zones isolées (sparse, whole root)

**Avantages** :
- Performance native (pas de virtualisation)
- Gestion fine des ressources (Resource Pools)
- Migration de zones entre serveurs
- Intégration avec ZFS (snapshots, clones)

**Exemple de configuration** :
```bash
# Création d'une zone Solaris
zonecfg -z myzone
  set zonepath=/zones/myzone
  set autoboot=true
  add net
    set physical=net0
    set address=192.168.1.100
  end
```

---

#### 2006 - Process Containers (Google) → cgroups

**Date** : 2006 (développement interne Google)
**Créateurs** : Paul Menage et Rohit Seth (Google)

Google développe **Process Containers** pour gérer les ressources de ses datacenters massifs.

**Problématique initiale** : Comment exécuter des milliers de jobs sur les mêmes serveurs sans qu'ils s'interfèrent ?

**Solution** : Control Groups (cgroups)

---

#### 2007-2008 - cgroups intégré au kernel Linux

**Date** : Janvier 2008 (kernel 2.6.24)
**Renommage** : Process Containers → **Control Groups (cgroups)**

Les **cgroups** deviennent une fonctionnalité **native du kernel Linux**.

**Fonctionnalités des cgroups** :
- **Limitation** : CPU, mémoire, I/O disque, bande passante réseau
- **Priorisation** : Poids relatifs entre groupes
- **Accounting** : Mesure de consommation des ressources
- **Contrôle** : Freeze, checkpoint, restart de groupes

**Hiérarchie cgroups** :
```
/sys/fs/cgroup/
├── cpu/
│   ├── docker/
│   │   ├── container1/
│   │   └── container2/
├── memory/
│   ├── docker/
│   │   ├── container1/
│   │   └── container2/
└── blkio/
    └── docker/
```

**Exemple d'utilisation** :
```bash
# Limiter un processus à 512MB de RAM
echo 536870912 > /sys/fs/cgroup/memory/myapp/memory.limit_in_bytes
echo $PID > /sys/fs/cgroup/memory/myapp/cgroup.procs
```

---

#### 2008 - LXC : Linux Containers

**Date** : Août 2008
**Créateurs** : IBM, Google, Eric Biederman, Serge Hallyn

**LXC** combine **cgroups** et **namespaces** pour créer des conteneurs Linux complets.

**Architecture technique LXC** :

LXC utilise 6 types de namespaces Linux (à l'époque) :
1. **PID namespace** : Isolation des IDs de processus
2. **Network namespace** : Stack réseau isolée
3. **Mount namespace** : Points de montage isolés
4. **UTS namespace** : Hostname et domain name isolés
5. **IPC namespace** : Inter-Process Communication isolée
6. **User namespace** : Mapping des UIDs/GIDs (ajouté plus tard)

**Exemple de création d'un conteneur LXC** :
```bash
# Installation
sudo apt-get install lxc

# Création d'un conteneur Ubuntu
sudo lxc-create -n mycontainer -t ubuntu

# Démarrage
sudo lxc-start -n mycontainer -d

# Connexion
sudo lxc-attach -n mycontainer
```

**Différence clé avec Docker (futur)** :
- LXC vise à simuler des **machines virtuelles légères**
- Chaque conteneur LXC = **système complet** (init, services)
- Pas orienté "une application = un conteneur"

---

#### 2013 - Docker : La révolution Solomon Hykes

**Date** : 20 mars 2013 - PyCon Santa Clara, Californie
**Fondateur** : Solomon Hykes
**Entreprise** : dotCloud (future Docker Inc.)

Solomon Hykes présente Docker au monde lors d'une présentation de **5 minutes** qui va changer l'industrie du logiciel.

**Citation historique de Solomon Hykes** :
> "Shipping to the server is hard. We designed Docker to help developers more easily build, share, and run any app, anywhere."

**Contexte de création** :

Docker est né comme **projet interne** de dotCloud, une entreprise de Platform-as-a-Service (PaaS). L'équipe cherchait un moyen de standardiser le déploiement d'applications sur leur plateforme.

**Innovations de Docker** :

1. **Abstraction développeur-centrique** :
   - Le kernel Linux avait déjà namespaces et cgroups
   - Mais ils étaient **complexes et peu accessibles**
   - Docker crée une **API simple** par-dessus

2. **Format d'image standardisé** :
   - Concept de **layers** (couches)
   - Images **portables et réutilisables**
   - Registre centralisé (Docker Hub)

3. **Dockerfile** : Infrastructure as Code
   ```dockerfile
   FROM ubuntu:20.04
   RUN apt-get update && apt-get install -y nginx
   COPY index.html /var/www/html/
   CMD ["nginx", "-g", "daemon off;"]
   ```

4. **Workflow unifié** :
   ```bash
   docker build -t myapp .      # Build
   docker push myapp            # Share
   docker run myapp             # Run anywhere
   ```

**Architecture Docker initiale (2013)** :

```
┌─────────────────────────────────────┐
│         Docker Client (CLI)         │
│         docker build/run/push       │
└──────────────┬──────────────────────┘
               │ REST API
┌──────────────▼──────────────────────┐
│         Docker Daemon                │
│  ┌──────────────────────────────┐   │
│  │     Container Management      │   │
│  └──────────────────────────────┘   │
│  ┌──────────────────────────────┐   │
│  │     Image Management          │   │
│  └──────────────────────────────┘   │
│  ┌──────────────────────────────┐   │
│  │     LXC (initialement)        │   │
│  └──────────────────────────────┘   │
└─────────────────────────────────────┘
```

**Docker vs LXC : Les différences philosophiques**

| Aspect | LXC | Docker |
|--------|-----|--------|
| **Paradigme** | Machine virtuelle légère | Encapsulation d'application |
| **Processus init** | Oui (systemd/upstart) | Non (processus direct) |
| **Cas d'usage** | Système complet | Microservice / App unique |
| **Persistance** | Stateful (données dans le conteneur) | Stateless (volumes externes) |
| **Image** | Templates | Layers immuables |
| **Registre** | Non standardisé | Docker Hub centralisé |
| **Ecosystem** | Limité | Massif (orchestration, CI/CD) |

**Exemple conceptuel** :

**Conteneur LXC** :
```
┌─────────────────────────┐
│  Container LXC          │
│  ├─ init (PID 1)        │
│  ├─ sshd                │
│  ├─ cron                │
│  ├─ apache              │
│  └─ mysql               │
└─────────────────────────┘
```

**Conteneur Docker** :
```
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ Container 1  │  │ Container 2  │  │ Container 3  │
│ nginx (PID 1)│  │ mysql (PID 1)│  │ redis (PID 1)│
└──────────────┘  └──────────────┘  └──────────────┘
```

---

#### 2013-2014 - Docker libère LXC : libcontainer

**Date** : Juin 2014 (Docker 0.9)

Docker remplace LXC par **libcontainer**, sa propre bibliothèque d'exécution écrite en **Go**.

**Motivation** :
- Indépendance vis-à-vis de LXC
- Contrôle total sur les fonctionnalités
- Portabilité accrue
- Support direct des namespaces et cgroups

**Impact** : Docker n'est plus une simple "surcouche" de LXC, mais une **plateforme complète**.

---

#### 2015 - L'Open Container Initiative (OCI)

**Date** : Juin 2015
**Fondateurs** : Docker, CoreOS, Google, Microsoft, AWS, et autres

Face à la fragmentation potentielle de l'écosystème (Docker, rkt de CoreOS, etc.), l'industrie crée l'**Open Container Initiative**.

**Objectifs de l'OCI** :
1. Standardiser le **format d'image** de conteneur
2. Standardiser le **runtime** de conteneur
3. Garantir l'interopérabilité

**Standards OCI** :
- **OCI Image Specification** : Format des images
- **OCI Runtime Specification** : Interface du runtime
- **OCI Distribution Specification** : Distribution des images

**Implémentation de référence** : **runc** (donation de Docker à l'OCI)

---

#### 2016 - containerd : Découplage du runtime

**Date** : Décembre 2016
**Don à la CNCF** : Mars 2017

Docker extrait son runtime de conteneur dans un projet séparé : **containerd**.

**Architecture post-containerd** :

```
┌─────────────────────────────────────────────┐
│           Docker CLI                        │
└──────────────┬──────────────────────────────┘
               │
┌──────────────▼──────────────────────────────┐
│           Docker Engine                     │
│  (gestion images, volumes, networks)        │
└──────────────┬──────────────────────────────┘
               │
┌──────────────▼──────────────────────────────┐
│           containerd                        │
│  (lifecycle des conteneurs)                 │
└──────────────┬──────────────────────────────┘
               │
┌──────────────▼──────────────────────────────┐
│           runc (OCI runtime)                │
│  (création effective du conteneur)          │
└─────────────────────────────────────────────┘
```

**Avantage** : **Daemonless containers** - possibilité de mettre à jour Docker sans arrêter les conteneurs en cours.

---

#### 2014-2015 - Kubernetes : L'orchestrateur qui change tout

**Date** : Juin 2014 (annonce), Juillet 2015 (v1.0)
**Créateur** : Google (Joe Beda, Brendan Burns, Craig McLuckie)
**Inspiration** : Borg et Omega (systèmes internes Google)

Kubernetes (k8s) révolutionne la **gestion de conteneurs à grande échelle**.

**Problématique résolue** :
- Comment déployer 1000 conteneurs ?
- Comment gérer les pannes ?
- Comment scaler automatiquement ?
- Comment faire des déploiements sans downtime ?

**Concepts clés** :
- **Pods** : Groupe de conteneurs co-localisés
- **Services** : Load balancing et service discovery
- **Deployments** : Gestion déclarative des déploiements
- **Auto-scaling** : Horizontal Pod Autoscaler

**Impact** : Kubernetes devient le **standard de facto** pour l'orchestration (au détriment de Docker Swarm, Mesos, etc.)

---

#### 2017-2024 - Maturation et adoption massive

**Statistiques clés (2024-2025)** :

- **318 milliards** de pulls cumulés sur Docker Hub (+145% YoY)
- **7,3 millions** de comptes Docker Hub (+45% YoY)
- **8,3 millions** de repositories d'images (+40% YoY)
- **3,3 millions** d'installations Docker Desktop (+38% YoY)
- **96%** des organisations utilisent des conteneurs (Statista 2024)
- **944 millions USD** : revenus globaux du container management (Gartner 2024)

**Prédictions Gartner 2025** :
- Plus de **50% des déploiements** de gestion de conteneurs impliqueront des services serverless d'ici 2027 (contre 25% en 2024)

---

#### 2025 - L'ère cloud-native et au-delà

**Tendances actuelles** :

1. **WebAssembly (WASM) containers** : Alternative légère à Docker
2. **Confidential containers** : Chiffrement runtime (AMD SEV, Intel SGX)
3. **eBPF-based security** : Sécurité au niveau kernel
4. **GitOps** : Déploiements déclaratifs via Git
5. **Multi-cluster management** : Kubernetes fédérés

**L'avenir** : Conteneurs + Serverless + Edge Computing

---

### L'explosion de l'écosystème (2014-2025)

L'émergence de Docker a catalysé la création d'un **écosystème massif** autour de la conteneurisation.

**Timeline de l'écosystème** :

```
2013  Docker
2014  Kubernetes, Docker Compose, CoreOS
2015  OCI, Docker Swarm, rkt (CoreOS)
2016  containerd, Moby Project
2017  Kubernetes devient CNCF, CRI-O
2018  Helm 2.0, Istio 1.0 (service mesh)
2019  Docker Desktop for WSL2, Podman
2020  Kubernetes 1.20, Docker EE → Mirantis
2021  Kubernetes deprecate Docker runtime
2022  Kubernetes 1.24 (retire dockershim)
2023  Docker AI, WebAssembly support
2024  OCI Image/Distribution Spec 1.1.0
2025  Kubernetes + eBPF + Confidential Compute
```

**Principaux acteurs de l'écosystème** :

| Catégorie | Outils |
|-----------|--------|
| **Runtimes** | Docker, containerd, CRI-O, Podman, runc |
| **Orchestration** | Kubernetes, Docker Swarm, Nomad, ECS |
| **Registres** | Docker Hub, Harbor, Quay, ECR, GCR, ACR |
| **Build** | Docker Build, Buildah, Kaniko, BuildKit |
| **Sécurité** | Trivy, Snyk, Aqua, Falco, Clair |
| **Monitoring** | Prometheus, Grafana, Datadog, New Relic |
| **Service Mesh** | Istio, Linkerd, Consul Connect |
| **CI/CD** | GitLab CI, GitHub Actions, Jenkins, CircleCI |
| **Platform Engineering** | OpenShift, Rancher, Tanzu, Anthos |

---

## Conteneurs vs Machines Virtuelles

### Architecture comparée

#### Architecture des Machines Virtuelles

Les machines virtuelles créent une **abstraction complète du hardware**, permettant à plusieurs OS de cohabiter sur une même machine physique.

```
┌─────────────────────────────────────────────────────────────┐
│                    MACHINES VIRTUELLES                      │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │     VM 1     │  │     VM 2     │  │     VM 3     │     │
│  │              │  │              │  │              │     │
│  │ ┌──────────┐ │  │ ┌──────────┐ │  │ ┌──────────┐ │     │
│  │ │  App A   │ │  │ │  App B   │ │  │ │  App C   │ │     │
│  │ ├──────────┤ │  │ ├──────────┤ │  │ ├──────────┤ │     │
│  │ │   Bins   │ │  │ │   Bins   │ │  │ │   Bins   │ │     │
│  │ │   Libs   │ │  │ │   Libs   │ │  │ │   Libs   │ │     │
│  │ ├──────────┤ │  │ ├──────────┤ │  │ ├──────────┤ │     │
│  │ │ Guest OS │ │  │ │ Guest OS │ │  │ │ Guest OS │ │     │
│  │ │  (1 GB)  │ │  │ │  (1 GB)  │ │  │ │  (1 GB)  │ │     │
│  │ └──────────┘ │  │ └──────────┘ │  │ └──────────┘ │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                             │
│  ═══════════════════════════════════════════════════════   │
│         HYPERVISOR (VMware ESXi, KVM, Hyper-V)              │
│  ═══════════════════════════════════════════════════════   │
│                                                             │
│         HOST OS (pour Type 2) ou FIRMWARE (Type 1)          │
│                                                             │
│  ═══════════════════════════════════════════════════════   │
│         INFRASTRUCTURE HARDWARE                             │
│         CPU │ RAM │ Storage │ Network                       │
│  ═══════════════════════════════════════════════════════   │
└─────────────────────────────────────────────────────────────┘

Caractéristiques :
• Chaque VM = OS complet (1-2 GB minimum)
• Boot time : 30 secondes à plusieurs minutes
• Isolation complète (kernel séparé)
• Overhead significatif
```

#### Architecture des Conteneurs

Les conteneurs partagent le **kernel du système hôte** et n'isolent que l'espace utilisateur (userspace).

```
┌─────────────────────────────────────────────────────────────┐
│                      CONTENEURS DOCKER                      │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  App A   │  │  App B   │  │  App C   │  │  App D   │   │
│  ├──────────┤  ├──────────┤  ├──────────┤  ├──────────┤   │
│  │   Bins   │  │   Bins   │  │   Bins   │  │   Bins   │   │
│  │   Libs   │  │   Libs   │  │   Libs   │  │   Libs   │   │
│  │ (100 MB) │  │ (150 MB) │  │  (50 MB) │  │  (80 MB) │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                             │
│  ═══════════════════════════════════════════════════════   │
│         CONTAINER RUNTIME (Docker Engine, containerd)       │
│  ═══════════════════════════════════════════════════════   │
│                                                             │
│         HOST OPERATING SYSTEM (Linux Kernel)                │
│         • Namespaces (isolation processus, réseau, etc.)    │
│         • cgroups (limitation ressources)                   │
│         • Capabilities (sécurité)                           │
│                                                             │
│  ═══════════════════════════════════════════════════════   │
│         INFRASTRUCTURE HARDWARE                             │
│         CPU │ RAM │ Storage │ Network                       │
│  ═══════════════════════════════════════════════════════   │
└─────────────────────────────────────────────────────────────┘

Caractéristiques :
• Pas d'OS invité (partage du kernel hôte)
• Boot time : millisecondes à quelques secondes
• Isolation niveau processus
• Overhead minimal
```

**Comparaison visuelle : Kernel sharing**

```
MACHINES VIRTUELLES                    CONTENEURS
═══════════════════                    ══════════

App ─┐                                App ─┐
     ├─ Guest OS ─┐                        ├─ Shared Kernel
App ─┘            ├─ Hypervisor           │
                  │                   App ─┤
App ─┐            │                        │
     ├─ Guest OS ─┤                   App ─┘
App ─┘            ├─ Host OS
                  │
App ─┐            │
     ├─ Guest OS ─┘
App ─┘

3 kernels distincts                   1 kernel partagé
```

---

### Hyperviseurs : Type 1 et Type 2

Un **hyperviseur** (ou Virtual Machine Monitor - VMM) est le logiciel qui permet la virtualisation en créant et gérant des machines virtuelles.

#### Type 1 : Bare-Metal Hypervisor

L'hyperviseur s'exécute **directement sur le hardware**, sans OS hôte intermédiaire.

```
┌───────────────────────────────────────────────┐
│  VM 1    │    VM 2    │    VM 3    │   VM 4  │
│ Ubuntu   │  Windows   │   CentOS   │  FreeBSD│
├───────────────────────────────────────────────┤
│                                               │
│           HYPERVISOR (Type 1)                 │
│    VMware ESXi / KVM / Hyper-V / Xen          │
│                                               │
├───────────────────────────────────────────────┤
│           HARDWARE PHYSIQUE                   │
│      (serveur datacenter/cloud)               │
└───────────────────────────────────────────────┘
```

**Exemples de Type 1** :

| Hyperviseur | Éditeur | Cas d'usage |
|-------------|---------|-------------|
| **VMware ESXi** | VMware | Datacenters entreprise, leader du marché |
| **Microsoft Hyper-V** | Microsoft | Windows Server, Azure cloud |
| **KVM** | Red Hat / Linux | Open source, intégré Linux kernel |
| **Xen** | Linux Foundation | AWS EC2 (historique), Citrix |
| **Proxmox VE** | Proxmox | Open source, PME, homelab |

**Avantages Type 1** :
- **Performance maximale** : accès direct au hardware
- **Stabilité** : pas de dépendance à un OS hôte
- **Sécurité** : surface d'attaque réduite
- **Fonctionnalités avancées** : vMotion, HA, DRS (VMware)

**Inconvénients** :
- Nécessite hardware dédié
- Complexité de gestion (nécessite console de management)
- Coût élevé (licences)

---

#### Type 2 : Hosted Hypervisor

L'hyperviseur s'exécute **au-dessus d'un OS hôte** (Windows, macOS, Linux).

```
┌───────────────────────────────────────────────┐
│  VM 1    │    VM 2    │    VM 3               │
│ Ubuntu   │  Windows   │   Kali Linux          │
├───────────────────────────────────────────────┤
│                                               │
│        HYPERVISOR (Type 2)                    │
│    VirtualBox / VMware Workstation / QEMU     │
│                                               │
├───────────────────────────────────────────────┤
│        HOST OPERATING SYSTEM                  │
│    Windows 11 / macOS / Ubuntu Desktop        │
├───────────────────────────────────────────────┤
│        HARDWARE (PC/Laptop)                   │
└───────────────────────────────────────────────┘
```

**Exemples de Type 2** :

| Hyperviseur | Éditeur | Cas d'usage |
|-------------|---------|-------------|
| **Oracle VirtualBox** | Oracle | Open source, développement local |
| **VMware Workstation** | VMware | Développement, testing (payant) |
| **VMware Fusion** | VMware | macOS (payant) |
| **Parallels Desktop** | Corel | macOS (payant, optimisé M1/M2) |
| **QEMU** | Open source | Émulation multi-architecture |

**Avantages Type 2** :
- **Facilité d'installation** : comme une application normale
- **Pas de hardware dédié** : tourne sur votre laptop
- **Parfait pour dev/test** : environnements isolés
- **Gratuit** : VirtualBox, QEMU

**Inconvénients** :
- Overhead supplémentaire (Host OS + Guest OS)
- Performance inférieure au Type 1
- Moins de fonctionnalités entreprise

---

#### KVM : Un cas particulier (Type 1 hybride)

**KVM** (Kernel-based Virtual Machine) est intégré au kernel Linux, transformant Linux en hyperviseur Type 1.

```
┌───────────────────────────────────────────────┐
│  VM 1    │    VM 2    │    VM 3               │
│ (QEMU)   │  (QEMU)    │  (QEMU)               │
├───────────────────────────────────────────────┤
│  KVM (module kernel)                          │
├───────────────────────────────────────────────┤
│  Linux Kernel + userspace                     │
├───────────────────────────────────────────────┤
│  Hardware avec support virtualisation         │
│  (Intel VT-x ou AMD-V)                        │
└───────────────────────────────────────────────┘
```

**Caractéristiques** :
- Transforme Linux en hyperviseur
- Performance proche du bare-metal
- Utilisé par OpenStack, Proxmox
- Open source et gratuit

---

### Performance et benchmarks

#### Métriques de comparaison

| Métrique | Machines Virtuelles | Conteneurs Docker |
|----------|---------------------|-------------------|
| **Boot time** | 30s - 2 min | < 1 seconde |
| **Taille système** | 1-2 GB minimum | 10-200 MB |
| **Overhead mémoire** | ~500 MB - 2 GB par VM | ~30 MB par conteneur |
| **Densité** | 10-20 VMs par hôte | 100-1000+ conteneurs |
| **Performance CPU** | ~95% (virtualisation assistée) | ~100% (natif) |
| **Performance I/O** | Pénalité 5-15% | Quasi-natif |
| **Temps de déploiement** | Minutes | Secondes |
| **Isolation** | Forte (kernel séparé) | Moyenne (kernel partagé) |

#### Benchmarks détaillés (études 2024)

**1. Temps de démarrage**

Données issues de "Containers vs Virtual Machines: A Performance Showdown" (Medium, 2024) :

```
VM (VMware)          ████████████████████ 120 secondes
VM (VirtualBox)      ██████████████████████ 135 secondes
VM (KVM)             ███████████ 65 secondes
Container (Docker)   █ 0.8 secondes
Container (Podman)   █ 0.9 secondes
```

**2. Consommation mémoire au boot**

Données comparatives (mesures réelles) :

| Type | Mémoire au boot | Mémoire avec app |
|------|-----------------|------------------|
| **VM Ubuntu 20.04** | 230 MB | 400-800 MB |
| **Docker Ubuntu** | 30 MB | 50-150 MB |
| **VM Windows Server** | 800 MB | 1.5-2 GB |
| **Docker Alpine** | 5 MB | 15-50 MB |

**Étude comparative** :
- VM : **0.23 GB** après boot
- Docker : **0.03 GB** après boot
- **Ratio** : 7.7x moins de mémoire pour Docker

**3. Densité sur serveur physique**

Serveur de référence : **64 GB RAM, 16 CPU cores**

| Scénario | VMs | Conteneurs | Ratio |
|----------|-----|------------|-------|
| **Applications légères** | ~20 VMs | ~200 conteneurs | 10x |
| **Applications moyennes** | ~10 VMs | ~100 conteneurs | 10x |
| **Applications lourdes** | ~5 VMs | ~30 conteneurs | 6x |

**4. Performance CPU et I/O**

Étude comparative (ArXiv 1807.01842 - Big Data Environment) :

```
Performance relative (Bare Metal = 100%)

CPU (calcul intensif)
Bare Metal     ████████████████████ 100%
Container      ███████████████████▓ 98-99%
VM (KVM)       ██████████████████▓  93-95%
VM (VMware)    ██████████████████   90-93%

I/O Disque (lecture/écriture)
Bare Metal     ████████████████████ 100%
Container      ███████████████████▓ 97-99%
VM (KVM)       ████████████████▓    82-88%
VM (VMware)    ███████████████▓     77-85%

Réseau (throughput)
Bare Metal     ████████████████████ 100%
Container      ███████████████████  95-98%
VM (KVM)       ██████████████████   88-92%
VM (VMware)    █████████████████▓   85-90%
```

**Conclusion des benchmarks** :
- Conteneurs : **performance quasi-native** (98-99%)
- VMs : **léger overhead** mais acceptable (85-95%)

---

### Cas d'usage : Quand utiliser VMs vs Conteneurs ?

#### Utiliser des MACHINES VIRTUELLES quand :

**1. Isolation forte requise**
- Applications multi-tenants avec forte exigence sécurité
- Environnements réglementés (finance, santé, gouvernement)
- Workloads non-fiables ou potentiellement malveillants

**Exemple** : Banque hébergeant des applications de clients différents
```
VM Client A ─── Isolation kernel ─── VM Client B
(impossible de s'influencer mutuellement)
```

**2. OS différents nécessaires**
- Application Windows sur infrastructure Linux
- Tests de compatibilité cross-OS
- Legacy applications nécessitant un OS spécifique

**Exemple** : CI/CD multi-OS
```
┌────────────┐  ┌────────────┐  ┌────────────┐
│ VM Ubuntu  │  │ VM Windows │  │ VM macOS   │
│ Tests Linux│  │ Tests .NET │  │ Tests iOS  │
└────────────┘  └────────────┘  └────────────┘
```

**3. Applications stateful lourdes**
- Bases de données relationnelles massives
- ERP, CRM (SAP, Oracle)
- Applications monolithiques legacy

**4. Workloads de longue durée**
- Serveurs qui tournent pendant des mois/années
- Pas besoin de scaling rapide

---

#### Utiliser des CONTENEURS quand :

**1. Microservices et applications cloud-native**
- Architecture distribuée
- Scaling horizontal fréquent
- Déploiements continus

**Exemple** : Application e-commerce
```
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│  Web UI  │→ │   API    │→ │ Database │  │  Cache   │
│  Nginx   │  │  Node.js │  │ Postgres │  │  Redis   │
└──────────┘  └──────────┘  └──────────┘  └──────────┘
Chaque service = conteneur indépendant
```

**2. CI/CD pipelines**
- Builds rapides et reproductibles
- Tests isolés
- Déploiements automatisés

**Exemple** : Pipeline GitLab CI
```yaml
build:
  image: node:18-alpine
  script:
    - npm install
    - npm run build

test:
  image: node:18-alpine
  script:
    - npm test

deploy:
  image: docker:latest
  script:
    - docker build -t myapp .
    - docker push myapp
```

**3. Portabilité maximale**
- "Build once, run anywhere"
- Dev → Staging → Production identiques
- Multi-cloud (AWS, Azure, GCP)

**4. Densité et économies d'échelle**
- Maximiser l'utilisation hardware
- Réduire les coûts cloud
- Auto-scaling agressif

**Statistiques** :
- Netflix : **Plusieurs milliers de conteneurs**
- Spotify : **Milliers de microservices** en conteneurs
- Uber : **4000+ microservices** conteneurisés

---

#### Approche hybride (le plus fréquent en 2025)

La plupart des organisations utilisent **les deux** :

**Architecture typique** :
```
┌─────────────────────────────────────────────┐
│           CLUSTER KUBERNETES                │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │  CONTENEURS (Microservices)         │   │
│  │  • API Gateway                      │   │
│  │  • Services métier                  │   │
│  │  • Workers asynchrones              │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Tournent sur des VMs Kubernetes nodes      │
└─────────────────────────────────────────────┘
                    ▲
                    │
         ┌──────────┴──────────┐
         │                     │
    ┌────▼────┐         ┌──────▼──────┐
    │  VM 1   │         │    VM 2     │
    │ (node)  │         │   (node)    │
    └─────────┘         └─────────────┘

┌─────────────────────────────────────────────┐
│       BASES DE DONNÉES (VMs)                │
│  • PostgreSQL (haute perf, stateful)        │
│  • MongoDB (gestion mémoire fine)           │
│  • Oracle (legacy, licence par CPU)         │
└─────────────────────────────────────────────┘
```

**Raisons de cette approche** :
- **Conteneurs** : Applications stateless, microservices, APIs
- **VMs** : Bases de données, applications legacy, isolation forte

---

## Conclusion de la Partie 1

Nous avons exploré les fondations de la conteneurisation, depuis les premiers pas avec `chroot` en 1979 jusqu'à l'écosystème moderne dominé par Docker et Kubernetes en 2025.

**Points clés à retenir** :

1. **Évolution progressive** : 40+ ans d'innovation (chroot → Jails → LXC → Docker)
2. **Docker = révolution UX** : Abstraction simple sur des technologies kernel complexes
3. **Standardisation OCI** : Interopérabilité garantie entre runtimes
4. **Conteneurs ≠ VMs** : Paradigmes complémentaires, pas concurrents
5. **Adoption massive** : 96% des organisations, 318 milliards de pulls Docker Hub

**Ce que nous verrons dans les parties suivantes** :

**Partie 2** :
- Architecture Docker approfondie (containerd, runc, namespaces)
- Images et layers (OverlayFS, Union FS)
- Dockerfile : instructions complètes et best practices
- Multi-stage builds
- Registres d'images (Docker Hub, Harbor, ECR)

**Partie 3** :
- Docker Compose et stacks multi-conteneurs
- Architecture microservices
- Networking Docker avancé
- Volumes et persistance
- Sécurité et production
- Orchestration (Kubernetes, Swarm)

---

## Glossaire (Partie 1)

| Terme (FR) | Terme (EN) | Définition |
|------------|------------|------------|
| **Conteneur** | **Container** | Unité d'exécution isolée partageant le kernel hôte |
| **Conteneurisation** | **Containerization** | Technique d'empaquetage d'applications avec leurs dépendances |
| **Hyperviseur** | **Hypervisor** | Logiciel permettant l'exécution de machines virtuelles |
| **Machine virtuelle** | **Virtual Machine (VM)** | Émulation complète d'un ordinateur avec OS invité |
| **Kernel** | **Kernel** | Noyau du système d'exploitation |
| **Namespace** | **Namespace** | Mécanisme d'isolation des ressources système (PID, NET, MNT, etc.) |
| **cgroups** | **Control Groups** | Limitation et accounting des ressources (CPU, RAM, I/O) |
| **Image** | **Image** | Template immuable pour créer des conteneurs |
| **Layer (couche)** | **Layer** | Composant d'une image Docker (empilement read-only) |
| **Runtime** | **Runtime** | Logiciel exécutant les conteneurs (runc, containerd) |
| **Orchestration** | **Orchestration** | Gestion automatisée de déploiement et scaling (Kubernetes) |
| **Registre** | **Registry** | Dépôt centralisé d'images (Docker Hub, Harbor) |
| **Bare-metal** | **Bare-metal** | Serveur physique sans virtualisation |
| **Overhead** | **Overhead** | Surcharge en ressources (CPU, RAM) due à une couche d'abstraction |
| **Densité** | **Density** | Nombre d'instances exécutables sur un serveur donné |

---

## Références (Partie 1)

### Sources officielles
1. Docker Documentation - https://docs.docker.com
2. OCI Specifications - https://opencontainers.org
3. Kubernetes Documentation - https://kubernetes.io/docs
4. Linux Kernel Documentation (namespaces, cgroups) - https://kernel.org

### Articles et recherches académiques
5. "A Brief History of Containers" - Aqua Security (2024)
6. "The Story of Containers" - VMware Open Source Blog (2018)
7. "Containers vs Virtual Machines: A Performance Showdown" - Medium (2024)
8. "A Comparative Study of Containers and Virtual Machines in Big Data Environment" - ArXiv 1807.01842

### Statistiques et rapports
9. Docker Index 2024 - Docker Inc.
10. Gartner Container Management Services Report (2024)
11. Statista Container Adoption Statistics (2024)

### Documentation historique
12. FreeBSD Jails Documentation - FreeBSD Foundation
13. Solaris Zones and Containers - Oracle
14. LXC Project Documentation - Linux Containers

### Blogs techniques
15. "11 Years of Docker: Shaping the Next Decade" - Docker Blog (2024)
16. "From Docker to Dagger" - Solomon Hykes Interview (2024)

---

**Document créé le** : 2025-11-05
**Auteur** : Agent Researcher (PAI)
**Contexte** : Module 6 - Cours DevOps M2 ESTD
**Version** : Partie 1/3

**Prochaine partie** : Architecture Docker approfondie, Images, Dockerfile, Registres
