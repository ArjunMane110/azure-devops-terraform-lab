<#
.SYNOPSIS
    Azure Resource Tag Compliance Audit
.DESCRIPTION
    Scans all resources in a subscription and reports
    which ones are missing required tags.
    Fails the pipeline if non-compliant resources are found.
.PARAMETER SubscriptionId
    The Azure Subscription ID to audit
.PARAMETER RequiredTags
    Array of required tag keys
.PARAMETER FailOnNonCompliance
    If true, exits with code 1 when non-compliant resources found
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory=$false)]
    [string[]]$RequiredTags = @('Environment', 'ManagedBy', 'Project'),

    [Parameter(Mandatory=$false)]
    [bool]$FailOnNonCompliance = $false
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Azure Resource Tag Compliance Audit   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Required tags: $($RequiredTags -join ', ')"
Write-Host ""

# Set subscription context if provided
if ($SubscriptionId) {
    Write-Host "Setting subscription context: $SubscriptionId"
    Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
}

# Get current context
$context = Get-AzContext
Write-Host "Scanning subscription: $($context.Subscription.Name)"
Write-Host ""

# Get all resources
Write-Host "Fetching all resources..." -ForegroundColor Yellow
$resources = Get-AzResource
Write-Host "Total resources found: $($resources.Count)"
Write-Host ""

# Check compliance
$nonCompliant = @()

foreach ($resource in $resources) {
    $missingTags = @()
    foreach ($tag in $RequiredTags) {
        if (-not $resource.Tags -or -not $resource.Tags.ContainsKey($tag)) {
            $missingTags += $tag
        }
    }
    if ($missingTags.Count -gt 0) {
        $nonCompliant += [PSCustomObject]@{
            ResourceName      = $resource.Name
            ResourceType      = $resource.ResourceType
            ResourceGroup     = $resource.ResourceGroupName
            Location          = $resource.Location
            MissingTags       = ($missingTags -join ', ')
        }
    }
}

# Output results
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AUDIT RESULTS                         " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($nonCompliant.Count -eq 0) {
    Write-Host "All resources are compliant." -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "Non-compliant resources: $($nonCompliant.Count)" -ForegroundColor Red
    Write-Host ""
    $nonCompliant | Format-Table -AutoSize
    
    # Export to CSV
    $csvPath = "$(Split-Path -Parent $MyInvocation.MyCommand.Path)/tag-audit-report.csv"
    $nonCompliant | Export-Csv -Path $csvPath -NoTypeInformation
    Write-Host "Report saved to: $csvPath" -ForegroundColor Yellow
    Write-Host ""

    if ($FailOnNonCompliance) {
        Write-Host "Pipeline failing due to non-compliant resources." -ForegroundColor Red
        exit 1
    }
}

Write-Host "Audit complete." -ForegroundColor Green