function Get-MerakiNetworkWirelessSsid {
    <#
    .SYNOPSIS
    Retrieves the configuration for a specified SSID in a Meraki network.
    .DESCRIPTION
    This function retrieves the configuration for a specified SSID in a Meraki network using the Meraki Dashboard API.
    .PARAMETER AuthToken
    The Meraki API token for the account.
    .PARAMETER networkId
    The ID of the Meraki network for which to retrieve the SSID configuration.
    .PARAMETER SSIDNumber
    The number of the SSID for which to retrieve the configuration.
    .EXAMPLE
    PS> Get-MerakiNetworkWirelessSsid -AuthToken "1234" -networkId "abcd" -SSIDNumber 1
    Retrieves the configuration for SSID 1 in network "abcd" using the Meraki API token "1234".
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$true)]
        [string]$networkId,
        [parameter(Mandatory=$true)]
        [string]$SSIDNumber
    )

    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }

        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/networks/$networkId/wireless/ssids/$SSIDNumber" -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat"
        return $response
    }
    catch {
        Write-Debug $_
        Throw $_
    }
}
