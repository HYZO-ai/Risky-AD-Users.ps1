Import-Module ActiveDirectory
# Se connecter sur l'AD et lancer le script en Administrateur
# Définir la date de seuil
$joursMax = 365
$dateLimite = (Get-Date).AddDays(-$joursMax)

# Récupérer tous les utilisateurs avec les attributs nécessaires
$utilisateurs = Get-ADUser -Filter * -Properties DisplayName, PasswordLastSet, PasswordNeverExpires, Enabled

# Filtrage et génération du rapport
$rapport = foreach ($utilisateur in $utilisateurs) {

    # Sauter les comptes désactivés
    if (-not $utilisateur.Enabled) { continue }

    $motDePasseJamaisExpire = $utilisateur.PasswordNeverExpires
    $motDePasseAncien = $utilisateur.PasswordLastSet -lt $dateLimite

    # Affiche seulement si une des deux conditions est vraie
    if ($motDePasseJamaisExpire -or $motDePasseAncien) {
        [PSCustomObject]@{
            Nom                       = $utilisateur.Name
            SamAccountName            = $utilisateur.SamAccountName
            MotDePasseJamaisExpire    = if ($motDePasseJamaisExpire) { "Oui" } else { "Non" }
            MotDePasseVieux365j       = if ($motDePasseAncien) { "Oui" } else { "Non" }
            DernierChgtMotDePasse     = $utilisateur.PasswordLastSet
        }
    }
}

# Affiche les résultats
$rapport | Format-Table -AutoSize

# Export en CSV (optionnel)
$rapport | Export-Csv -Path "rapport_AD_mdp_risque.csv" -NoTypeInformation -Encoding UTF8
