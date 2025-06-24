# Risky-AD-Users.ps1

## Description

**Risky-AD-Users.ps1** est un script PowerShell destiné aux administrateurs systèmes et aux professionnels de la sécurité informatique.  
Il permet d’identifier rapidement les **comptes utilisateurs Active Directory potentiellement à risque**, notamment dans le cadre de la gestion du cycle de vie des mots de passe.

## Objectif

Détecter les comptes Active Directory présentant l’un des deux risques suivants :

- Mot de passe qui n’expire jamais
- Mot de passe non modifié depuis plus de 365 jours

Ces pratiques affaiblissent la sécurité globale du domaine et peuvent exposer l’organisation à des compromissions.

## Fonctionnalités

### Analyse complète des utilisateurs AD

- Récupère tous les comptes utilisateurs actifs
- Évalue les propriétés liées aux mots de passe pour chaque utilisateur

### Filtrage intelligent

- N'affiche **que** les comptes présentant au moins un des deux critères suivants :
  - Mot de passe configuré pour ne jamais expirer
  - Mot de passe non modifié depuis plus de 365 jours

### Affichage clair en console

- Tableau formaté avec les colonnes :
  - `Nom`
  - `SamAccountName`
  - `MotDePasseJamaisExpire` (Oui / Non)
  - `MotDePasseVieux365j` (Oui / Non)
  - `DernierChgtMotDePasse`

### Export CSV (optionnel)

- Enregistre les résultats dans un fichier `rapport_AD_mdp_risque.csv` pour archivage ou reporting

## Prérequis

- Être membre d’un domaine Active Directory
- Avoir les droits nécessaires pour interroger Active Directory
- PowerShell 5.1 ou version supérieure (y compris PowerShell Core)
- Module PowerShell `ActiveDirectory` installé :
  ```powershell
  Import-Module ActiveDirectory
