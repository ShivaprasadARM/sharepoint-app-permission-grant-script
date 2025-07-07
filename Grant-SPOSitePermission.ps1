<#
.SYNOPSIS
    Grants SharePoint Online site permissions to an Azure AD App using PnP PowerShell.

.DESCRIPTION
    This script connects to a specified SharePoint Online site and assigns the given Azure AD App Registration
    permissions at the site level (Read, Write, FullControl) using Grant-PnPAzureADAppSitePermission.

.NOTES
    Requires: PnP.PowerShell module
    Author: Shivaprasad M S
    License: MIT
#>

# -------------------- USER CONFIGURATION --------------------
$targetSiteUri    = "<Your SharePoint Site URL>"       # e.g., https://yourtenant.sharepoint.com/sites/YourSite
$clientId         = "<Client ID used for authentication>" # Client ID of the app that will authenticate the session
$appId            = "<App ID to grant site permission>"   # App Registration you want to assign site access to
$appDisplayName   = "<Your App Display Name>"          # Friendly name shown in SharePoint permissions
$permissions      = "<Permissions>"                    # e.g., Read, Write, FullControl

# -------------------- CONNECT TO SHAREPOINT --------------------
try {
    Write-Host "Connecting to SharePoint site..." -ForegroundColor Cyan
    Connect-PnPOnline -Url $targetSiteUri -Interactive -ClientId $clientId
    Write-Host "Connected to $targetSiteUri successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to connect to SharePoint: $_"
    exit 1
}

# -------------------- GRANT SITE PERMISSION --------------------
try {
    Write-Host "Granting '$permissions' permission to App '$appDisplayName'..." -ForegroundColor Cyan
    Grant-PnPAzureADAppSitePermission `
        -AppId $appId `
        -DisplayName $appDisplayName `
        -Permissions $permissions `
        -Site $targetSiteUri

    Write-Host "Permission granted successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to grant permission: $_"
    exit 1
}

# -------------------- END --------------------
Write-Host "Script execution completed." -ForegroundColor Yellow
