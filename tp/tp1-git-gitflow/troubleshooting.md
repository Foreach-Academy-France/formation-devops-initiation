# Troubleshooting - TP1: Git/GitFlow

Guide de dépannage pour résoudre les erreurs courantes lors du TP Git/GitFlow.

---

## 🔴 Erreurs de Configuration

### Erreur: `Author identity unknown`

**Message**:
```
*** Please tell me who you are.

Run
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
```

**Solution**:
```bash
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"

# Vérifier la configuration
git config --global --list
```

---

### Erreur: `fatal: not a git repository`

**Cause**: Vous n'êtes pas dans un dossier Git ou vous avez oublié `git init`.

**Solution**:
```bash
# Vérifier où vous êtes
pwd

# Revenir au bon dossier
cd ~/Desktop/mon-projet-devops

# Si le dossier n'est pas initialisé
git init
```

---

## 🟠 Erreurs de Branches

### Erreur: `fatal: A branch named 'develop' already exists`

**Cause**: Vous essayez de créer une branche qui existe déjà.

**Solution**:
```bash
# Lister les branches
git branch

# Si develop existe déjà, basculer dessus
git checkout develop

# Ou supprimer et recréer
git branch -D develop
git checkout -b develop
```

---

### Erreur: `error: Your local changes would be overwritten`

**Cause**: Vous avez des modifications non commitées avant de changer de branche.

**Solution**:
```bash
# Voir les fichiers modifiés
git status

# Option 1: Commit les changements
git add .
git commit -m "fix: save changes before switching branch"

# Option 2: Stash (mettre de côté temporairement)
git stash
git checkout <branch>
# Puis récupérer les changements
git stash pop

# Option 3: Annuler les changements (ATTENTION: PERTE DE DONNÉES)
git checkout -- .
```

---

### Erreur: `fatal: branch rename failed`

**Cause**: Renommer une branche sur laquelle vous êtes actuellement.

**Solution**:
```bash
# Basculer sur une autre branche d'abord
git checkout main

# Puis renommer
git branch -m old-name new-name
```

---

## 🟡 Erreurs de Fusion (Merge)

### Erreur: `CONFLICT (content): Merge conflict in <file>`

**Cause**: Git ne peut pas fusionner automatiquement deux versions différentes d'un fichier.

**Solution**:
```bash
# 1. Voir les fichiers en conflit
git status

# 2. Ouvrir le fichier et chercher les marqueurs de conflit
# <<<<<<< HEAD
# Votre version
# =======
# Leur version
# >>>>>>> branch-name

# 3. Éditer manuellement le fichier pour résoudre

# 4. Marquer comme résolu
git add <file>

# 5. Finaliser le merge
git commit -m "fix: resolve merge conflict"
```

**Astuce VS Code**:
VS Code affiche des boutons "Accept Current" / "Accept Incoming" / "Accept Both" pour faciliter la résolution.

---

### Erreur: `fatal: refusing to merge unrelated histories`

**Cause**: Vous essayez de fusionner deux branches sans historique commun.

**Solution**:
```bash
# Forcer la fusion (ATTENTION: à utiliser avec précaution)
git merge <branch> --allow-unrelated-histories
```

---

### Erreur: `error: You have not concluded your merge`

**Cause**: Vous avez commencé un merge mais ne l'avez pas terminé.

**Solution**:
```bash
# Option 1: Finaliser le merge
git commit -m "chore: complete merge"

# Option 2: Annuler le merge
git merge --abort
```

---

## 🔵 Erreurs de Commit

### Erreur: `nothing added to commit but untracked files present`

**Cause**: Vous avez oublié `git add` avant `git commit`.

**Solution**:
```bash
# Ajouter les fichiers
git add <file>
# ou tout ajouter
git add .

# Puis commit
git commit -m "feat: add new files"
```

---

### Erreur: Message de commit vide

**Message**: `Aborting commit due to empty commit message`

**Cause**: Vous avez quitté l'éditeur sans message ou laissé le message vide.

**Solution**:
```bash
# Toujours fournir un message avec -m
git commit -m "feat: descriptive message here"

# Si vous êtes coincé dans vim
# Appuyer sur 'i' pour insérer
# Écrire le message
# Appuyer sur 'Esc' puis taper ':wq' et Enter
```

---

### Erreur: Modifier le dernier commit

**Situation**: Vous venez de faire un commit mais avez oublié un fichier ou voulez changer le message.

**Solution**:
```bash
# Ajouter les fichiers oubliés
git add <forgotten-file>

# Amender le dernier commit
git commit --amend

# Ou changer juste le message
git commit --amend -m "nouveau message"
```

⚠️ **ATTENTION**: Ne jamais amender un commit déjà pushé sur un dépôt partagé!

---

## 🟢 Erreurs de Tags

### Erreur: `fatal: tag 'v1.0.0' already exists`

**Cause**: Vous essayez de créer un tag qui existe déjà.

**Solution**:
```bash
# Lister les tags
git tag

# Supprimer le tag existant
git tag -d v1.0.0

# Recréer le tag
git tag -a v1.0.0 -m "Release version 1.0.0"
```

---

### Erreur: Tag sur le mauvais commit

**Solution**:
```bash
# Supprimer le tag
git tag -d v1.0.0

# Aller sur le bon commit
git checkout <commit-hash>

# Recréer le tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Revenir sur la branche
git checkout main
```

---

## 🟣 Commandes de Dépannage Utiles

### Voir l'état actuel

```bash
# Où suis-je? Quelle branche?
git status

# Quel est l'historique?
git log --oneline --graph --all --decorate

# Quelles sont mes branches?
git branch -a

# Quels sont mes tags?
git tag -l
```

---

### Annuler des changements

```bash
# Annuler les changements d'un fichier non commité
git checkout -- <file>

# Annuler tous les changements non commités
git reset --hard HEAD

# Revenir en arrière d'un commit (GARDE les changements)
git reset --soft HEAD~1

# Revenir en arrière d'un commit (SUPPRIME les changements)
git reset --hard HEAD~1
```

⚠️ **DANGER**: `git reset --hard` SUPPRIME les changements définitivement!

---

### Inspecter les différences

```bash
# Voir ce qui a changé (non staged)
git diff

# Voir ce qui a été stagé
git diff --staged

# Voir les différences entre branches
git diff develop..main
```

---

## 🆘 Situations d'Urgence

### J'ai tout cassé, je veux recommencer

**Solution nucléaire**:
```bash
# Sauvegarder d'abord (au cas où)
cd ..
cp -r mon-projet-devops mon-projet-devops-backup

# Supprimer et recommencer
rm -rf mon-projet-devops
# Recommencer le TP depuis le début
```

---

### Je suis perdu dans l'historique Git

```bash
# Voir tous les commits avec détails
git log --all --decorate --oneline --graph

# Voir ce qui a changé dans les derniers commits
git log -p -2

# Trouver quand un fichier a été modifié
git log --follow -- <file>
```

---

### J'ai supprimé un fichier par erreur

```bash
# Si pas encore commité
git checkout HEAD -- <file>

# Si déjà commité, trouver le commit avant suppression
git log --all --full-history -- <file>
# Puis restaurer depuis ce commit
git checkout <commit-hash> -- <file>
```

---

## 📚 Commandes Git Essentielles - Aide-Mémoire

### Navigation

```bash
git branch                  # Lister branches locales
git branch -a              # Lister toutes les branches
git checkout <branch>      # Changer de branche
git checkout -b <branch>   # Créer et changer de branche
```

### Modifications

```bash
git status                 # Voir l'état
git add <file>            # Ajouter un fichier
git add .                 # Ajouter tous les fichiers
git commit -m "message"   # Commiter avec message
```

### Fusion

```bash
git merge <branch>         # Fusionner une branche
git merge --no-ff <branch> # Fusion sans fast-forward
git merge --abort          # Annuler une fusion
```

### Historique

```bash
git log                    # Voir l'historique
git log --graph --all      # Voir l'arbre complet
git log --oneline          # Vue compacte
```

### Tags

```bash
git tag                    # Lister les tags
git tag -a v1.0 -m "msg"  # Créer tag annoté
git tag -d v1.0           # Supprimer un tag
git show v1.0             # Voir détails d'un tag
```

---

## 🔗 Ressources de Dépannage

- [Oh Shit, Git!?!](https://ohshitgit.com/) - Guide humoristique pour situations d'urgence
- [Git Flight Rules](https://github.com/k88hudson/git-flight-rules) - Guide de dépannage complet
- [GitHub Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Stack Overflow - Git Tag](https://stackoverflow.com/questions/tagged/git)

---

## 💡 Conseils Généraux

1. **Lire les messages d'erreur**: Git donne souvent la solution dans le message
2. **Git status is your friend**: Utilisez `git status` souvent
3. **Commit souvent**: Petits commits = facile à annuler
4. **Branches = sécurité**: Expérimentez sur des branches
5. **Google est votre ami**: Beaucoup d'autres ont eu les mêmes erreurs

---

**En cas de doute, appelez le formateur! Il vaut mieux demander que de perdre du travail.**
