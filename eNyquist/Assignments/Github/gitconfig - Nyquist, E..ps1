<#
gitconfig.ps1

Drew.Minkin@divergence.one

Purpose - Introduce coding & simplify configuration
#>

<# These are the two variables input from running the script#>
$GithubName = Read-Host -Prompt "Enter your Github Name"
$GithubEmail = Read-Host -Prompt "Enter your Github Email"

<# These are the two actions done by the script  using variables #>
Invoke-Command  -ScriptBlock {git config --global user.name  $GithubName}
Invoke-Command  -ScriptBlock {git config --global user.email $GithubEmail}

<# This lets you know it worked#>
Write-Host "Configuration Complete for : " $GithubName  "/"  $GithubEmail
