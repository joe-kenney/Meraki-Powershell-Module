function Get-MerakiOrganizationDevicesStatusesOverview {
    <#
    .SYNOPSIS
    Retrieves the device status overview for an organization in the Meraki Dashboard.

    .DESCRIPTION
    The Get-MerakiOrganizationDevicesStatusesOverview function retrieves the device status overview for an organization in the Meraki Dashboard using the Meraki Dashboard API. This function requires an API key for authentication.

    .PARAMETER AuthToken
    The Meraki Dashboard API key for authentication.

    .PARAMETER OrgId
    The organization ID. If not specified, the function will use the ID of the first organization returned by the Get-MerakiOrganizations function.

    .PARAMETER networkIds
    An array of network IDs to filter the devices by. If not specified, all devices are returned.

    .PARAMETER productTypes
    An array of product types to filter the devices by. If not specified, all devices are returned.

    .EXAMPLE
    PS C:\> Get-MerakiOrganizationDevicesStatusesOverview -AuthToken "1234567890abcdef" -OrgId "1234567890" -productTypes "appliance"

    This example retrieves the device status overview for an organization with ID "1234567890", filtering by devices with the product type "appliance".

    .NOTES
    For more information about the Meraki Dashboard API, see https://developer.cisco.com/meraki/api-v1/.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AuthToken,

        [Parameter(Mandatory=$false)]
        [string]$OrganizationID = (Get-OrgID -AuthToken $AuthToken),

        [Parameter(Mandatory=$false)]
        [array]$networkIds = $null,

        [Parameter(Mandatory=$false)]
        [array]$productTypes = $null
    )
    If($OrganizationID -eq "Multiple organizations found. Please specify an organization ID.") {
        Return "Multiple organizations found. Please specify an organization ID."
    } else {
        try {
            $header = @{
                "X-Cisco-Meraki-API-Key" = $AuthToken
                "Content-Type" = "application/json"
            }

            $queryParams = @{}
            if ($networkIds) {
                $queryParams['networkIds[]'] = $networkIds
            }
            if ($productTypes) {
                $queryParams['productTypes[]'] = $productTypes
            }
            
            $queryString = New-MerakiQueryString -queryParams $queryParams
            $URI = "https://api.meraki.com/api/v1/organizations/$OrganizationID/devices/statuses/overview?$queryString"
            $response = Invoke-RestMethod -Method Get -Uri $URI -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat"

            return $response
        }
        catch {
        Write-Debug $_
        Throw $_
    }
    }
}
