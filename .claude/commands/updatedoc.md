---
description: "Met à jour le README, le skill Claude Code et vérifie la documentation de tous les composants"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, TodoWrite, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_take_screenshot, mcp__playwright__browser_click, mcp__playwright__browser_wait_for, mcp__playwright__browser_close
model: opus
---

# UpdateDoc - Mise à jour automatique de la documentation

Tu es un expert en documentation technique pour gems Rails. Ta mission est de maintenir la documentation parfaitement à jour: le README ET le skill Claude Code.

## Contexte

<context>
Ce projet est une gem Rails UI (`chalky_layout`) qui fournit des composants ViewComponent pour créer des interfaces admin.

### Documentation principale (README)
Le README est la documentation utilisateur. Il doit:
- Documenter TOUS les composants disponibles
- Inclure des exemples de code Slim pour chaque composant
- Avoir des screenshots à jour pour les composants visuels
- Être structuré de manière cohérente et lisible
- Utiliser une syntaxe markdown correcte

Les screenshots sont stockés dans `docs/screenshots/` et référencés dans le README.

### Skill Claude Code
Le skill Claude Code est injecté dans les projets utilisateurs lors de l'installation de la gem via le générateur.

**Emplacement des fichiers source (dans la gem):**
- `lib/generators/chalky_layout/install/templates/claude_skill/SKILL.md` - Guide principal pour Claude
- `lib/generators/chalky_layout/install/templates/claude_skill/reference.md` - Référence API complète

**Emplacement chez l'utilisateur (après installation):**
- `.claude/skills/chalky-layout/SKILL.md`
- `.claude/skills/chalky-layout/reference.md`

**Rôle du skill:**
- Apprendre à Claude à utiliser les helpers `chalky_*` pour tout travail frontend
- Fournir des exemples de code rapides et corrects
- Documenter TOUS les helpers et leurs paramètres
- Être activé automatiquement quand Claude travaille sur des vues/templates
</context>

---

# PHASE 1 : ANALYSE DES CHANGEMENTS NON COMMITÉS

<phase_analyse>
## Objectif
Identifier tous les fichiers modifiés ou ajoutés qui ne sont pas encore commités.

## Actions

1. **Lister les fichiers non commités**
   ```bash
   git status --porcelain
   ```

2. **Catégoriser les changements**
   - Nouveaux composants (`app/components/chalky/`)
   - Composants modifiés
   - Nouveaux helpers (`app/helpers/`)
   - Controllers Stimulus modifiés
   - Autres fichiers pertinents

3. **Analyser chaque changement**
   - Lire le contenu des fichiers modifiés/ajoutés
   - Comprendre ce qui a changé ou été ajouté
   - Identifier l'impact sur la documentation

## Livrable
Liste claire des éléments nécessitant une mise à jour de la documentation.
</phase_analyse>

---

# PHASE 2 : MISE À JOUR DU README

<phase_update_readme>
## Objectif
Mettre à jour le README pour refléter les changements détectés.

## Actions pour les NOUVEAUX composants

1. **Documenter le nouveau composant**
   - Ajouter une section dédiée au bon endroit (respecter l'ordre logique)
   - Inclure le helper name et sa description
   - Ajouter un exemple de code Slim
   - Documenter TOUS les paramètres dans un tableau

2. **Prendre un screenshot**
   - Démarrer l'application dummy si nécessaire
   - Naviguer vers une page d'exemple du composant
   - Prendre le screenshot avec Playwright
   - Sauvegarder dans `docs/screenshots/[component-name].png`
   - Référencer l'image dans le README

## Actions pour les composants MODIFIÉS

1. **Vérifier si la documentation est à jour**
   - Comparer les paramètres documentés vs implémentés
   - Vérifier que les exemples sont toujours valides
   - Mettre à jour si nécessaire

2. **Mettre à jour le screenshot si le visuel a changé**
   - Reprendre un nouveau screenshot
   - Remplacer l'ancien

## Format de documentation attendu

```markdown
### `helper_name`

Description claire et concise du composant.

\`\`\`slim
= helper_name(param1: value1, param2: value2) do
  / Content example
\`\`\`

![Component Name](docs/screenshots/component-name.png)

**Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `param1` | Type | `default` | Description |
```

## Livrable
README mis à jour avec tous les nouveaux éléments documentés.
</phase_update_readme>

---

# PHASE 3 : VÉRIFICATION COMPLÈTE DES COMPOSANTS

<phase_verification>
## Objectif
S'assurer que TOUS les composants existants sont correctement documentés et fonctionnels.

## Actions

1. **Lister tous les composants**
   - Scanner `app/components/chalky/`
   - Scanner `app/helpers/` pour les helpers

2. **Pour chaque composant, vérifier**
   - ✅ Est-il documenté dans le README ?
   - ✅ La documentation est-elle complète (description, exemple, params) ?
   - ✅ Y a-t-il un screenshot si c'est un composant visuel ?
   - ✅ L'exemple de code est-il correct et à jour ?
   - ✅ Les paramètres listés correspondent-ils au code ?

3. **Corriger les problèmes identifiés**
   - Ajouter la documentation manquante
   - Corriger les exemples incorrects
   - Mettre à jour les paramètres obsolètes
   - Prendre les screenshots manquants

## Checklist de vérification

<verification_checklist>
Pour chaque composant:
- [ ] Section présente dans README
- [ ] Description claire
- [ ] Exemple de code Slim valide
- [ ] Tableau des paramètres complet
- [ ] Types et valeurs par défaut corrects
- [ ] Screenshot présent (si composant visuel)
- [ ] Screenshot à jour (correspond au rendu actuel)
</verification_checklist>

## Livrable
Rapport de vérification et corrections effectuées.
</phase_verification>

---

# PHASE 4 : QUALITÉ ET POLISH

<phase_quality>
## Objectif
S'assurer que le README est parfait : syntaxe, structure, clarté.

## Actions

1. **Vérifier la syntaxe markdown**
   - Pas d'erreurs de formatage
   - Tables correctement formées
   - Code blocks avec le bon langage
   - Liens d'images valides

2. **Vérifier la cohérence**
   - Style uniforme entre les sections
   - Ordre logique des composants
   - Nommage cohérent
   - Pas de doublons

3. **Vérifier la clarté**
   - Descriptions compréhensibles
   - Exemples pertinents et fonctionnels
   - Paramètres bien expliqués

4. **Itérer si nécessaire**
   - Relire le README entier
   - Corriger les imperfections
   - S'assurer que tout est clair pour un nouveau développeur

## Critères de qualité

<quality_criteria>
Le README doit être:
- ✅ Sans erreur de syntaxe markdown
- ✅ Structuré logiquement
- ✅ Cohérent dans son style
- ✅ Complet (tous composants documentés)
- ✅ Clair et compréhensible
- ✅ Avec des exemples fonctionnels
- ✅ Avec des screenshots à jour
</quality_criteria>

## Livrable
README finalisé et parfait.
</phase_quality>

---

# PHASE 5 : MISE À JOUR DU SKILL CLAUDE CODE

<phase_skill>
## Objectif
Mettre à jour le skill Claude Code pour qu'il documente tous les composants avec les mêmes informations que le README.

## Fichiers à mettre à jour

<skill_files>
1. **SKILL.md** (`lib/generators/chalky_layout/install/templates/claude_skill/SKILL.md`)
   - Guide principal et concis pour Claude
   - Quick Reference avec exemples de code
   - Tableau récapitulatif de TOUS les helpers
   - Doit être auto-suffisant pour 80% des cas d'usage

2. **reference.md** (`lib/generators/chalky_layout/install/templates/claude_skill/reference.md`)
   - Documentation API complète
   - TOUS les paramètres de chaque composant
   - Exemples détaillés pour chaque helper
   - Référence exhaustive
</skill_files>

## Actions

1. **Synchroniser avec le README**
   - Vérifier que chaque helper documenté dans le README est aussi dans le skill
   - Vérifier que les paramètres sont identiques
   - Vérifier que les exemples de code sont cohérents

2. **Mettre à jour SKILL.md**
   - Ajouter les nouveaux helpers au tableau récapitulatif
   - Ajouter des exemples Quick Reference pour les nouveaux composants
   - Garder le fichier concis mais complet

3. **Mettre à jour reference.md**
   - Documenter chaque nouveau composant avec sa section dédiée
   - Inclure TOUS les paramètres dans les tableaux
   - Ajouter des exemples de code Slim

## Structure attendue pour SKILL.md

<skill_structure>
Le fichier SKILL.md doit contenir:
- Frontmatter avec name, description, allowed-tools
- Section "IMPORTANT: Always use Chalky helpers"
- Section "When to use this skill" (liste des cas d'usage)
- Section "Quick Reference" avec exemples de code par catégorie
- Tableau "Available Helpers" avec TOUS les helpers
- Lien vers reference.md pour la documentation complète
</skill_structure>

## Structure attendue pour reference.md

<reference_structure>
Le fichier reference.md doit contenir pour chaque composant:
- Nom du helper en titre (`### \`helper_name\``)
- Description courte
- Exemple de code Slim complet
- Tableau des paramètres avec: Parameter, Type, Default, Description
- Notes ou exemples supplémentaires si nécessaire
</reference_structure>

## Vérification de cohérence

<coherence_check>
Pour chaque composant, vérifier:
- [ ] Présent dans README ✓
- [ ] Présent dans SKILL.md (tableau helpers) ✓
- [ ] Présent dans reference.md (section dédiée) ✓
- [ ] Paramètres identiques partout ✓
- [ ] Exemples de code fonctionnels ✓
</coherence_check>

## Livrable
Skill Claude Code mis à jour avec tous les composants documentés.
</phase_skill>

---

# Instructions d'exécution

<execution_flow>
## Déroulement obligatoire

1. **Phase 1** : Analyse des changements
   - Exécute `git status`
   - Catégorise les fichiers modifiés
   - Crée une TODO list avec TodoWrite

2. **Phase 2** : Mise à jour du README
   - Documente les nouveaux éléments
   - Prends les screenshots nécessaires
   - Mets à jour le README

3. **Phase 3** : Vérification complète
   - Vérifie CHAQUE composant existant
   - Corrige les problèmes trouvés
   - Mets à jour les TODOs

4. **Phase 4** : Polish
   - Relis le README entièrement
   - Corrige toute imperfection
   - Valide la qualité finale

5. **Phase 5** : Mise à jour du Skill Claude Code
   - Synchronise SKILL.md avec les nouveaux helpers
   - Met à jour reference.md avec la doc complète
   - Vérifie la cohérence README ↔ Skill

## Règles importantes

<rules>
- **Sois exhaustif** : Ne néglige aucun composant
- **Sois précis** : Les paramètres doivent correspondre exactement au code
- **Sois visuel** : Prends des screenshots pour les composants visuels
- **Itère** : Refais plusieurs passes jusqu'à ce que tout soit parfait
- **Utilise TodoWrite** : Track ta progression rigoureusement
- **Synchronise** : Le skill doit TOUJOURS être cohérent avec le README
- **Pense utilisateur** : Le skill sera copié chez l'utilisateur, il doit être auto-suffisant
</rules>

## Pour les screenshots

<screenshot_instructions>
1. L'application dummy doit être en cours d'exécution sur http://localhost:3000
2. Utilise Playwright pour naviguer et prendre les screenshots
3. Sauvegarde les screenshots dans `docs/screenshots/`
4. Format de nommage : `component-name.png` (kebab-case)
5. Assure-toi que le screenshot montre bien le composant
</screenshot_instructions>

## Pour le skill Claude Code

<skill_instructions>
1. **Fichiers sources** : Toujours modifier les fichiers dans `lib/generators/chalky_layout/install/templates/claude_skill/`
2. **SKILL.md** : Garder concis, focus sur les cas d'usage courants
3. **reference.md** : Documentation exhaustive, tous les paramètres
4. **Cohérence** : Un helper dans le README = un helper dans le skill
5. **Exemples Slim** : Utiliser la même syntaxe que dans le README
6. **Tableau helpers** : Mettre à jour le tableau récapitulatif à chaque ajout
7. **Test mental** : "Si Claude lit seulement le skill, peut-il utiliser correctement ce helper?"
</skill_instructions>
</execution_flow>

---

Commence maintenant par la **Phase 1 : Analyse des changements non commités**.
