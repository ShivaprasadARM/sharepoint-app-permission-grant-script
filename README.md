# 🔐 Grant SharePoint Site Access to Azure AD Apps using PowerShell

This PowerShell script allows you to **assign site-level permissions** (e.g., Read, Write, FullControl) to an **Azure AD App Registration** on a **SharePoint Online site**, using the `PnP.PowerShell` module.

## ✅ Why This Is Needed

Azure AD Apps often need to access SharePoint Online for automation tasks such as:

- Uploading or reading documents via APIs
- Integrating GitHub Actions, Azure DevOps, or Logic Apps
- Enabling service principals to operate without user context

By default, app registrations **do not have access to specific SharePoint sites** even if granted Graph or SharePoint API permissions.  
This script uses **site-specific permission granting** to explicitly authorize apps.

## 🕓 When to Use This
Use this script when:

- You’ve registered an app in Azure AD
- Granted it SharePoint API permissions (like `Sites.ReadWrite.All`)
- But the app still cannot access a specific SharePoint site

> Microsoft requires **site-level permissions** for apps to interact with SharePoint Online when `Sites.Selected` is used in app permissions.

## ⚙️ How It Works

1. Connects to SharePoint Online using `Connect-PnPOnline`
2. Uses `Grant-PnPAzureADAppSitePermission` to grant specified permissions
3. Requires interactive login and appropriate admin privileges

## 🧰 Prerequisites

- PowerShell 5.1+ or PowerShell 7+
- [PnP.PowerShell module](https://pnp.github.io/powershell/)
  ```powershell
  Install-Module PnP.PowerShell -Scope CurrentUser
Registered Azure AD App with:
1) App ID
2) API permissions for Microsoft Graph or SharePoint (Sites.Selected)
3) Admin consent granted

Setup & Usage
Step 1: Configure the Script

Edit the script to set your values:
$targetSiteUri    = "<Your SharePoint Site URL>"       # e.g., https://tenant.sharepoint.com/sites/Marketing
$clientId         = "<Client ID of the connecting app>" # Used for interactive authentication
$appId            = "<Target App ID>"                   # App you want to give site access to
$appDisplayName   = "<App Display Name>"                # Friendly name for logs
$permissions      = "<Permissions>"                     # e.g., Read, Write, FullControl

Step 2: Run the Script
Connect-PnPOnline -Url $targetSiteUri -Interactive -ClientId $clientId

Grant-PnPAzureADAppSitePermission `
    -AppId $appId `
    -DisplayName $appDisplayName `
    -Permissions $permissions `
    -Site $targetSiteUri

Supported Permission Levels
Value	Description
Read	Read items in the site
Write	Read and write items
FullControl	Full site access (owner-level permissions)

Example:
$targetSiteUri    = "https://contoso.sharepoint.com/sites/Finance"
$clientId         = "1234abcd-5678-efgh-ijkl-90mnopqrstuv"
$appId            = "abcd9876-5432-lkjh-gfed-cba098765432"
$appDisplayName   = "GitHub SharePoint Uploader"
$permissions      = "Write"

Note: 

1) Make sure the app you're assigning access to has the Sites.Selected permission scope granted via Azure Portal or script
2) Admin consent must be granted for the app’s permissions
3) The user running this script must have permission to grant SharePoint site access

Tags
#PowerShell #SharePoint #AzureAD #PnP #AppRegistration #Automation
#Microsoft365 #PnPPowerShell #DevOps #SitesSelected #Identity
