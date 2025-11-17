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
  pre {
    font-size: 14px;
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
---

<!-- _class: lead -->

# Module 07
## Autres Outils DevOps

**Infrastructure as Code • Kubernetes • Monitoring**

*M2 ESTD - Initiation DevOps*
ForEach Academy - 2025

---

## 📋 Agenda - Module 07 (45min)

### Infrastructure as Code (IaC)
- Ansible - Configuration management
- Terraform - Infrastructure provisioning

### Kubernetes
- Introduction à l'orchestration de conteneurs

### Monitoring & Observabilité
- Prometheus, Grafana, métriques

### Intégration DevOps
- Comment tout s'intègre

---

<!-- _class: lead -->

# 1. Infrastructure as Code (IaC)

**Gérer l'infrastructure comme du code**

---

## 🤔 Le Problème Pré-IaC

### Configuration Manuelle (Années 2000)

- 🖱️ **ClickOps**: 10-15 clics dans interfaces Web
- ❌ **Configuration drift**: Serveurs devenant incohérents
- 🐌 **Impossible de scaler**: Gérer 100+ serveurs manuellement?
- 🔥 **"Snowflake servers"**: Chaque serveur unique

> "Works on my machine... but not in production"

---

## ✨ Infrastructure as Code - Solution

### Traiter l'Infrastructure comme du Logiciel

```hcl
# Terraform - Infrastructure déclarative
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer"
  }
}
```

**Avantages**: Version contrôle • Répétabilité • Collaboration • Rollback

---

## 📚 Deux Catégories d'IaC

### Configuration Management
- **Rôle**: Configurer serveurs existants
- **Outils**: Ansible, Puppet, Chef
- **Use case**: Installer logiciels, gérer configs

### Infrastructure Provisioning
- **Rôle**: Créer l'infrastructure cloud
- **Outils**: Terraform, CloudFormation, Pulumi
- **Use case**: VMs, réseaux, databases

**Pattern commun**: Terraform + Ansible

---

<!-- _class: lead -->

# Ansible
## Configuration Management Agentless

---

## 🎯 Qu'est-ce qu'Ansible?

### Automatisation Open-Source par Red Hat

**Architecture**:
- 🚫 **Agentless**: Pas d'installation sur serveurs cibles
- 🔌 **SSH**: Communication via SSH (Linux) ou WinRM (Windows)
- 📝 **YAML**: Playbooks lisibles et déclaratifs
- ⚡ **Push-based**: Changements poussés à la demande

**Adoption**: Netflix, NASA, Capital One

---

## 📝 Playbook Ansible - Exemple

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes  # Exécuter en tant que root

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Copy website files
      copy:
        src: ./site/
        dest: /var/www/html/

    - name: Start Nginx
      service:
        name: nginx
        state: started
```

---

## 🏗️ Ansible - Concepts Clés

### Inventory (hosts.ini)
```ini
[webservers]
web1.example.com
web2.example.com

[databases]
db1.example.com
```

### Modules
- **apt/yum**: Gestion packages
- **copy/template**: Fichiers
- **service**: Services système
- **git**: Repos Git

### Idempotence
✅ Réexécuter le playbook = même résultat

---

## 🌟 Ansible Galaxy

### Hub Communautaire de Rôles

- 📦 **30,000+ rôles** pré-construits
- 🚀 **Installation rapide**: `ansible-galaxy install geerlingguy.nginx`
- 💼 **Ansible Tower/AWX**: Interface web entreprise

**Example de rôle**:
```bash
ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.kubernetes
```

---

<!-- _class: lead -->

# Terraform
## Infrastructure Provisioning Multi-Cloud

---

## 🏗️ Terraform par HashiCorp

### IaC Déclaratif Multi-Cloud

**Créé**: 2014
**Providers**: 1000+ (AWS, Azure, GCP, Cloudflare, K8s...)
**Langage**: HCL (HashiCorp Configuration Language)

**Success stories**:
- Netflix: Infrastructure AWS complète
- Spotify: Multi-cloud deployment
- Uber: Gestion globale infrastructure

---

## 📖 HCL - HashiCorp Configuration Language

```hcl
# Définition de variable
variable "aws_region" {
  description = "Région AWS pour ressources"
  type        = string
  default     = "us-west-2"
}

# Configuration provider
provider "aws" {
  region = var.aws_region
}

# Ressource
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}
```

---

## 🔄 Workflow Terraform

### 4 Commandes Essentielles

```bash
# 1. Initialiser (télécharger providers)
terraform init

# 2. Planifier (prévisualiser changements)
terraform plan

# 3. Appliquer (créer infrastructure)
terraform apply

# 4. Détruire (supprimer infrastructure)
terraform destroy
```

**Workflow**: Init → Plan → Review → Apply

---

## 💾 State File - Le Cerveau de Terraform

### terraform.tfstate

- 📊 **JSON** tracking état infrastructure
- 🔗 **Mapping** ressources réelles ↔ configuration
- ⚠️ **Sensible**: Contient secrets, IPs, identifiants

### Remote State (Obligatoire Équipes)

```hcl
terraform {
  backend "s3" {
    bucket  = "terraform-state"
    key     = "prod/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}
```

**Avantages**: Collaboration • Locking • Sécurité

---

## 📦 Modules Terraform

### Composants Réutilisables (DRY)

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "production-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
}
```

**Registry**: registry.terraform.io

---

## ⚖️ Terraform vs CloudFormation vs Pulumi

| Feature | **Terraform** | **CloudFormation** | **Pulumi** |
|---------|--------------|-------------------|------------|
| **Multi-cloud** | ✅ Oui (1000+) | ❌ AWS uniquement | ✅ Oui |
| **Langage** | HCL | YAML/JSON | Python, TS, Go |
| **État** | Manuel/Cloud | AWS-géré | Manuel/Cloud |
| **Communauté** | 🔥 Très large | AWS-focused | 📈 Croissance |
| **Learning Curve** | Moyenne | Élevée | Facile (devs) |

**Recommandation**: Terraform pour multi-cloud entreprise

---

## 🎯 Ansible + Terraform = ❤️

### Pattern Complémentaire

```
┌─────────────────────┐
│   TERRAFORM         │
│  (Provisioning)     │
│  - Créer VMs        │
│  - Créer VPC/réseaux│
│  - Créer databases  │
└──────────┬──────────┘
           │
           ↓
┌──────────┴──────────┐
│     ANSIBLE         │
│  (Configuration)    │
│  - Installer apps   │
│  - Configurer       │
│  - Déployer code    │
└─────────────────────┘
```

**Workflow**: Terraform crée → Ansible configure

---

<!-- _class: lead -->

# Kubernetes
## Orchestration de Conteneurs

---

## 🤔 Pourquoi l'Orchestration?

### Docker Compose ≠ Production

**Problèmes à Échelle**:
- 🖥️ **Single host**: Docker Compose = 1 machine
- 🔄 **Pas d'auto-scaling**: Charger ↑ = Crash
- 💔 **Pas de self-healing**: Conteneur crash = Down
- ⚖️ **Pas de load balancing**: Distribution manuelle

**Solution**: Orchestrateur comme Kubernetes

---

## ☸️ Kubernetes - Origine

### Héritage Google Borg

- 🏢 **Google**: 15+ ans d'expérience avec Borg
- 📅 **2014**: Donation à la CNCF
- 🎓 **2018**: CNCF Graduated Project
- 📊 **2024**: 93% adoption cloud-native

**K8s = Kubernetes** (K + 8 lettres + s)

**Problèmes résolus**:
- Gestion milliers de conteneurs
- Auto-scaling intelligent
- Self-healing automatique
- Zero-downtime deployments

---

## 🏛️ Architecture Kubernetes

```
┌─────────────────────────────────────────┐
│         CONTROL PLANE (Master)          │
│  ┌──────────┐  ┌──────┐  ┌───────────┐ │
│  │ API      │  │ etcd │  │ Scheduler │ │
│  │ Server   │  │      │  │           │ │
│  └──────────┘  └──────┘  └───────────┘ │
│  ┌────────────────────────────────────┐ │
│  │    Controller Manager              │ │
│  └────────────────────────────────────┘ │
└─────────────────────────────────────────┘
              │
    ┌─────────┼─────────┐
    │                   │
┌───▼─────┐      ┌──────▼──┐
│ Worker  │      │ Worker  │
│ Node 1  │      │ Node 2  │
│ Kubelet │      │ Kubelet │
│ Kube-   │      │ Kube-   │
│ proxy   │      │ proxy   │
│ Pods    │      │ Pods    │
└─────────┘      └─────────┘
```

---

## 🧩 Concepts Clés - Pod

### Plus Petite Unité Déployable

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    ports:
    - containerPort: 80
```

**Caractéristiques**:
- 📦 1+ conteneurs partageant réseau/stockage
- 🆔 IP unique dans le cluster
- ⚡ Éphémère (peut être détruit/recréé)

---

## 🚀 Deployment - Gestion de Pods

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3  # 3 copies du Pod
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
```

**Fonctionnalités**: Rolling updates • Rollback • Scaling

---

## 🌐 Service - Exposition de Pods

### 3 Types Principaux

**ClusterIP** (interne):
```yaml
spec:
  type: ClusterIP  # Défaut
```

**NodePort** (accessible via nœud):
```yaml
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30007
```

**LoadBalancer** (cloud externe):
```yaml
spec:
  type: LoadBalancer
```

---

## 📊 K8s vs Docker Compose

| Aspect | **Kubernetes** | **Docker Compose** |
|--------|----------------|-------------------|
| **Échelle** | Multi-node | Single-host |
| **Auto-scaling** | ✅ HPA, VPA | ❌ |
| **Self-healing** | ✅ Auto-restart | ⚠️ Limité |
| **Load Balancing** | ✅ Natif | ❌ Config externe |
| **Rolling Updates** | ✅ Automatique | ❌ Manuel |
| **Complexité** | 🔴 Élevée | 🟢 Faible |
| **Use Case** | Production | Dev local |

**Règle**: Dev → Compose | Prod → K8s

---

## ☁️ Managed Kubernetes

### Services Cloud

**GKE** (Google):
- Gestion auto control plane
- Intégration Google Cloud native

**EKS** (AWS):
- Gestion complète control plane
- Intégration IAM/VPC/ALB

**AKS** (Azure):
- Control plane gratuit
- Azure Active Directory

### Local Dev

- **Minikube**: Cluster single-node
- **k3s**: K8s léger (<512MB RAM)
- **Kind**: Kubernetes in Docker

---

## 🎯 Cas d'Usage Kubernetes

### Microservices

- 🔀 Isolation des services
- 📈 Scaling indépendant
- 🚀 Déploiements indépendants
- 🌐 Service mesh (Istio, Linkerd)

### Haute Disponibilité

- 🌍 Multi-zone/région deployments
- 💚 Health checks (liveness, readiness)
- 🔄 Rolling updates zéro-downtime
- ⚖️ Load balancing automatique

### Auto-Scaling

- 📊 HPA: Horizontal Pod Autoscaler
- 📈 VPA: Vertical Pod Autoscaler
- 🖥️ Cluster Autoscaler

---

<!-- _class: lead -->

# Monitoring & Observabilité
## Observer, Mesurer, Améliorer

---

## 👁️ Les 3 Piliers de l'Observabilité

### 1. Metrics (Métriques)

Valeurs numériques au fil du temps
```
http_requests_total{status="200"} 1423
memory_usage_bytes 524288000
```

### 2. Logs (Journaux)

Événements horodatés
```json
{"level": "ERROR", "message": "DB connection failed"}
```

### 3. Traces (Traçage)

Parcours requête à travers services
```
API Gateway [200ms] → Auth [50ms] → DB [80ms]
```

---

## 📊 Prometheus - TSDB pour Métriques

### Architecture

**Composants**:
- 🗄️ **Prometheus Server**: Time-Series Database + PromQL
- 📤 **Pushgateway**: Jobs éphémères
- 🔔 **Alertmanager**: Gestion alertes
- 📡 **Exporters**: Exposent métriques (Node, MySQL...)

**Modèle Pull**:
- Prometheus scrape targets à intervalles réguliers
- Targets exposent `/metrics` HTTP endpoint

---

## 🔍 PromQL - Prometheus Query Language

### Requêtes Métriques

```promql
# Taux de requêtes HTTP par seconde
rate(http_requests_total[5m])

# Utilisation CPU moyenne
avg(rate(cpu_usage_seconds[1m])) by (instance)

# Percentile 95 de latence
histogram_quantile(0.95,
  rate(http_request_duration_seconds_bucket[5m])
)

# Alertes sur erreurs
sum(rate(http_requests_total{status=~"5.."}[5m])) > 10
```

---

## 🎨 Grafana - Visualisation

### Dashboards Interactifs

**Fonctionnalités**:
- 📈 100+ types de panels (graphs, gauges, tables)
- 🔌 Data sources multiples (Prometheus, Loki, Tempo)
- 🔔 Alerting natif
- 🔗 Annotations pour événements

**Grafana 2024**:
- Scenes: Dashboards dynamiques
- Explore: Interface unifiée logs/metrics/traces
- OnCall: Gestion rotation
- SLO Management natif

---

## 📚 Stack LGTM

### Loki, Grafana, Tempo, Mimir

**Grafana Loki** (Logs):
- "Like Prometheus, but for logs"
- Indexe labels uniquement (pas contenu)
- LogQL pour requêtes

**Grafana Tempo** (Traces):
- Stockage massif traces
- Compatible OpenTelemetry
- Recherche par Trace ID

**Grafana Mimir** (Metrics):
- Long-term storage Prometheus
- Multi-tenancy, haute disponibilité

---

## 🎯 SLI, SLO, SLA

### Définitions

**SLI** (Service Level Indicator):
- Métrique quantitative du service
- Ex: disponibilité, latence, taux d'erreur

**SLO** (Service Level Objective):
- Cible pour un SLI
- Ex: "99.9% de disponibilité sur 30 jours"

**SLA** (Service Level Agreement):
- Contrat avec conséquences
- Ex: "99.95% uptime ou remboursement"

---

## 💰 Error Budget

### Budget d'Erreur = 100% - SLO

**Exemple**:
- SLO: 99.9% disponibilité
- Error budget: 0.1% = 43 min/mois

**Utilisation**:
- Budget consommé → Ralentir déploiements
- Budget disponible → Innover rapidement
- ⚖️ Balance vitesse/fiabilité

---

## 🔔 Alert Fatigue - Le Problème

### Trop d'Alertes Tue l'Alerte

**Statistiques**:
- 📧 2000+ alertes par semaine par équipe
- ✅ Seulement 3% nécessitent action immédiate
- 📉 97% sont du bruit
- 😴 Résultat: Alertes ignorées, vrais incidents manqués

---

## ✅ Solutions Alert Fatigue

### 1. Alerter sur Symptômes, pas Causes

```yaml
# ❌ Mauvais
- alert: HighCPU
  expr: cpu_usage > 80%

# ✅ Bon
- alert: SlowResponseTime
  expr: http_request_duration{quantile="0.95"} > 1
  for: 5m
```

### 2. Seuils Dynamiques

```promql
# Écart de 3 déviations standard
abs(metric - avg_over_time(metric[1h]))
  > 3 * stddev_over_time(metric[1h])
```

---

## 🤖 Self-Healing Systems

### Auto-Remédiation Kubernetes

**Liveness Probes**:
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  failureThreshold: 3
```
→ Redémarre conteneur si échec

**HPA** (Horizontal Pod Autoscaler):
```yaml
spec:
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
```
→ Scale automatiquement basé sur charge

---

<!-- _class: lead -->

# Intégration DevOps Complète
## Comment Tout S'Intègre

---

## 🔄 Pipeline DevOps Complet

```
Developer Commit
    ↓
GitHub Actions CI
    - Tests, build, scan sécurité
    ↓
Terraform
    - Provisionne infrastructure (EKS, VPC, RDS)
    ↓
ArgoCD/Flux (GitOps)
    - Déploie vers Kubernetes
    ↓
Kubernetes
    - Orchestre conteneurs, auto-scale
    ↓
Prometheus + Grafana
    - Collecte métriques, alerte
    ↓
Feedback Loop
    - Rollback automatique si erreurs
```

---

## 🎯 GitOps - Git comme Source de Vérité

### Principes

1. **Déclaratif**: État désiré dans Git
2. **Versionné**: Historique complet
3. **Auto-sync**: Détection changements automatique
4. **Auditable**: Qui a changé quoi quand

### Outils

**ArgoCD**: Interface web riche, multi-cluster
**Flux CD**: CLI-driven, Kubernetes-native

---

## 📊 Métriques DORA

### 4 Métriques Clés DevOps

1. **Deployment Frequency**: Combien de déploiements/jour?
2. **Lead Time**: Temps commit → production
3. **MTTR**: Mean Time To Recovery
4. **Change Failure Rate**: % déploiements causant incidents

**Elite performers**:
- Deploy: Plusieurs fois/jour
- Lead time: <1 heure
- MTTR: <1 heure
- Failure rate: <15%

---

## 🌐 Écosystème CNCF

### Cloud Native Computing Foundation

**Graduated Projects**:
- ☸️ **Kubernetes**: Orchestration
- 📊 **Prometheus**: Monitoring
- 🔄 **ArgoCD/Flux**: GitOps
- 🌐 **Envoy**: Service proxy
- 🔒 **cert-manager**: Certificats TLS

**Landscape**: 1000+ projets
**URL**: landscape.cncf.io

---

## 🎓 Gestion Multi-Environnements

### Séparation Dev/Staging/Prod

**Production**:
- Contrôle accès strict
- Auto-scaling activé
- Monitoring complet
- Backups automatiques

**Staging**:
- Miroir config production
- Données anonymisées
- Tests pré-production

**Development**:
- Itération rapide
- Accès développeurs
- Ressources optimisées coût

---

## 🔐 Secrets Management

### Ne JAMAIS Hardcoder les Secrets

```yaml
# ❌ Mauvais
env:
  - name: DB_PASSWORD
    value: "password123"

# ✅ Bon
env:
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: password
```

**Solutions**:
- HashiCorp Vault
- AWS Secrets Manager
- Kubernetes Secrets (chiffrés etcd)

---

## 🎯 Exemple Réel - E-commerce

### Workflow Complet

1. **Dev commit** → GitHub
2. **CI/CD** → Tests + Build Docker
3. **Terraform** → Crée EKS + RDS + S3
4. **ArgoCD** → Déploie vers K8s
5. **K8s** → Orchestre 100+ Pods
6. **Prometheus** → Collecte métriques
7. **Grafana** → Dashboard temps réel
8. **Alert** → Rollback auto si erreurs >1%

**Résultat**: Deploy 50x/jour, MTTR <10min

---

## 📚 Récapitulatif - Ce qu'on a Couvert

### Infrastructure as Code

✅ Ansible - Configuration management
✅ Terraform - Infrastructure provisioning
✅ Pattern Terraform + Ansible

### Kubernetes

✅ Architecture Control Plane/Workers
✅ Pods, Deployments, Services
✅ K8s vs Docker Compose

---

## 📚 Récapitulatif (suite)

### Monitoring & Observabilité

✅ 3 Piliers: Metrics, Logs, Traces
✅ Prometheus + Grafana
✅ Stack LGTM (Loki, Grafana, Tempo, Mimir)
✅ SLI/SLO/SLA et Error Budgets
✅ Alert Fatigue et solutions

### Intégration DevOps

✅ Pipeline complet Code → Prod
✅ GitOps avec ArgoCD/Flux
✅ Métriques DORA
✅ Multi-environnements

---

## 🔑 Points Clés à Retenir

### Infrastructure as Code

> "Infrastructure = Code = Versionné = Testé = Reproductible"

### Kubernetes

> "Docker pour dev local, Kubernetes pour production"

### Observabilité

> "On ne peut améliorer que ce qu'on mesure"

### DevOps

> "Automatiser tout ce qui est répétable"

---

## 🚀 Aller Plus Loin

### Pour Approfondir

**Ansible**:
- Ansible Galaxy: galaxy.ansible.com
- AWX: Interface web gratuite

**Terraform**:
- Registry: registry.terraform.io
- Terraform Cloud: app.terraform.io

**Kubernetes**:
- Minikube: Local K8s pour apprendre
- k3s: K8s léger pour IoT/Edge

**Monitoring**:
- Prometheus: prometheus.io
- Grafana Labs: grafana.com

---

## 📖 Ressources Recommandées

### Documentation Officielle

- 📘 **Kubernetes**: kubernetes.io/docs
- 📕 **Terraform**: developer.hashicorp.com/terraform
- 📗 **Ansible**: docs.ansible.com
- 📙 **Prometheus**: prometheus.io/docs

### Livres

- 📖 **Site Reliability Engineering** (Google)
- 📖 **Kubernetes Up & Running**
- 📖 **Terraform: Up & Running**

### Communautés

- r/devops, r/kubernetes (Reddit)
- CNCF Slack, Kubernetes Slack

---

## 🎯 Prochaines Étapes

### Après ce Module

1. ✅ **TP pratiques** à venir:
   - TP Git/GitFlow (Module 3)
   - TP GitHub Actions (Module 5)
   - TP Docker (Module 7)

2. 📝 **QCM final**: Évaluation Modules 2-8

3. 💼 **Projet professionnel**:
   - Appliquer DevOps dans votre contexte
   - Identifier processus à automatiser

---

## ❓ Questions?

### Module 07 - Autres Outils DevOps

**Thèmes couverts**:
- Infrastructure as Code (Ansible, Terraform)
- Kubernetes (Orchestration)
- Monitoring & Observabilité (Prometheus, Grafana)
- Intégration DevOps complète

**Contact**: Fabrice Claeys
**Email**: fabrice@example.com

---

<!-- _class: lead -->

# Merci!

**Module 07 terminé**

*Pause de 15 minutes*

*Retour pour Module 08: Conclusion*

M2 ESTD - Initiation DevOps | ForEach Academy
