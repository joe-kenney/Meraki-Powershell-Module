function Get-MerakiNetworkSwitchRoutingMulticastRendezvousPoints {
    <#
    .SYNOPSIS
        Gets the multicast rendezvous points for a Meraki network switch.
    .DESCRIPTION
        This function retrieves the multicast rendezvous points for a Meraki network switch using the Meraki Dashboard API.
    .PARAMETER AuthToken
        The API authentication token for the Meraki Dashboard.
    .PARAMETER networkId
        The ID of the Meraki network to retrieve the multicast rendezvous points for.
    .EXAMPLE
        PS C:\> Get-MerakiNetworkSwitchRoutingMulticastRendezvousPoints -AuthToken "api_token" -networkId "L_123456789"
        Returns the multicast rendezvous points for the specified Meraki network switch.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AuthToken,
        [Parameter(Mandatory=$true)]
        [string]$networkId
    )

    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/networks/$networkId/switch/routing/multicast/rendezvousPoints" -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat"
        return $response
    }
    catch {
        Write-Debug $_
        Throw $_
    }
}
