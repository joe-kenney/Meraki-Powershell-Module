function Set-MerakiNetworkWirelessSSIDBonjourForwarding {
    <#
    .SYNOPSIS
    Updates the Bonjour forwarding configuration for a Meraki wireless SSID using the Meraki Dashboard API.

    .DESCRIPTION
    The Set-MerakiNetworkWirelessSSIDBonjourForwarding function allows you to update the Bonjour forwarding configuration for a specified Meraki wireless SSID by providing the authentication token, network ID, SSID number, and a Bonjour forwarding configuration string.

    .PARAMETER AuthToken
    The authentication token (API key) required to access the Meraki Dashboard API.

    .PARAMETER NetworkId
    The ID of the Meraki network to which the wireless SSID belongs.

    .PARAMETER SSIDNumber
    The number of the wireless SSID for which you want to update the Bonjour forwarding configuration.

    .PARAMETER BonjourConfig
    A string containing the Bonjour forwarding configuration. The string should be in JSON format and should include the "enabled" and "exception" properties, as well as an array of "rules" if applicable.

    .EXAMPLE
    $BonjourConfig = [PSCustomObject]@{
        enabled = $true
        exception = [PSCustomObject]@{
            enabled = $true
            rules = @(
                [PSCustomObject]@{
                    description = "My Bonjour rule"
                    vlanId = "123"
                    services = @("AirPlay", "iTunes")
                }
            )
        }
    }
    $BonjourConfig = $BonjourConfig | ConvertTo-Json -Compress
    Set-MerakiNetworkWirelessSSIDBonjourForwarding -AuthToken "your-api-token" -NetworkId "N_1234567890" -SsidNumber 1 -BonjourConfig $BonjourConfig

    This example enables Bonjour forwarding on the first wireless SSID of the Meraki network with ID "N_1234567890". It also enables Bonjour forwarding exception and adds a single Bonjour forwarding rule that allows AirPlay and iTunes services on VLAN 123.

    .NOTES
    The function requires the "Invoke-RestMethod" cmdlet to be available.

    The function returns the response from the API if the configuration is successful, otherwise, it displays an error message.
    #>

    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$true)]
        [string]$NetworkId,
        [parameter(Mandatory=$true)]
        [int]$SSIDNumber,
        [parameter(Mandatory=$true)]
        [string]$BonjourConfig
    )
    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
            "content-type" = "application/json; charset=utf-8"
        }

        $url = "https://api.meraki.com/api/v1/networks/$NetworkId/wireless/ssids/$SsidNumber/bonjourForwarding"

        $response = Invoke-RestMethod -Method Put -Uri $url -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat" -Body $BonjourConfig
        return $response
    }
    catch {
        Write-Debug $_
        Throw $_
    }
}