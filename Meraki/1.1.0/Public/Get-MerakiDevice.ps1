function Get-MerakiDevice {
    <#
    .SYNOPSIS
        Gets information about a specific Cisco Meraki device by serial number.
    .DESCRIPTION
        This function makes a REST API call to the Meraki dashboard API to retrieve information about a specific Cisco Meraki device, based on its serial number. The function returns detailed information about the device, including its name, model, firmware version, and more.
    .PARAMETER AuthToken
        The authentication token to use for the API call. This should be a valid API key for the Meraki dashboard.
    .PARAMETER deviceSerial
        The serial number of the Cisco Meraki device to retrieve information for.
    .EXAMPLE
        PS C:\> Get-MerakiDevice -AuthToken "myapikey" -serialNumber "Q2XX-XXXX-XXXX"
        Returns information about the Cisco Meraki device with the specified serial number.
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$AuthToken,
        [parameter(Mandatory=$true)]
        [string]$serialNumber
    )
    try {
        $header = @{
            "X-Cisco-Meraki-API-Key" = $AuthToken
        }
        $response = Invoke-RestMethod -Method Get -Uri "https://api.meraki.com/api/v1/devices/$serialNumber" -headers $header -UserAgent "MerakiPowerShellModule/1.1.0 DocNougat"
        return $response
    }
    catch {
        Write-Debug $_
        Throw $_
    }
}