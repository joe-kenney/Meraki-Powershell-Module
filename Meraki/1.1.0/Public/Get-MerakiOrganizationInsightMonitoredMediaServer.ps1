function Get-MerakiOrganizationInsightMonitoredMediaServer {
    <#
    .SYNOPSIS
    Retrieves a monitored media server for a specified Meraki organization.

    .DESCRIPTION
    This function retrieves a monitored media server for a specified Meraki organization using the Meraki Dashboard API. The authentication token, organization ID, and monitored media server ID are required for this operation.

    .PARAMETER AuthToken
    Specifies the authentication token for the Meraki Dashboard API.

    .PARAMETER OrgId
    Specifies the ID of the Meraki organization. If not specified, the function will use the ID of the first organization returned by Get-MerakiOrganizations.

    .PARAMETER monitoredMediaServerId
    Specifies the ID of the monitored media server.

    .EXAMPLE
    PS C:\> Get-MerakiOrganizationInsightMonitoredMediaServer -AuthToken "12345" -OrgId "123456" -monitoredMediaServerId "1234"

    Retrieves the monitored media server with ID "1234" for the organization with ID "123456" using the authentication token "12345".
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$false)]
        [string]$OrganizationID = (Get-OrgID -AuthToken $AuthToken),
        [parameter(Mandatory=$true)]
        [string]$monitoredMediaServerId
    )
    If($OrganizationID -eq "Multiple organizations found. Please specify an organization ID.") {
        Return "Multiple organizations found. Please specify an organization ID."
    } else {
        try {
            $header = @{
                "X-Cisco-Meraki-API-Key" = $AuthToken
            }
            $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/organizations/$OrganizationID/insight/monitoredMediaServers/$monitoredMediaServerId" -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat"
            return $response
        }
        catch {
        Write-Debug $_
        Throw $_
    }
    }
}