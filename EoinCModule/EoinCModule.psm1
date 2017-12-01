<# 
 .Synopsis
  Converts an IPv4 Address to an unsigned integer

 .Description
  Converts an IPv4 Address in 4 octet format to an unsigned integer taking account of system endianness

 .Parameter Ip
  The IPv4 Address in 4 Octet string format

 .Example
    Convert-FromIPv4 "192.168.10.1"
#>
Function Convert-FromIPv4 {
    Param (
        [Parameter(Position=0,mandatory=$true)]
        [IPAddress]$Ip
    )
    Process {
    $bytes = $ip.GetAddressBytes()
    if ([BitConverter]::IsLittleEndian) {
        [Array]::Reverse($bytes)
    }
    [BitConverter]::ToUInt32($bytes, 0)
    }
}

<# 
 .Synopsis
  Converts an IPv4 Address integer to 4 octet string

 .Description
  Converts an IPv4 Address represented as an unsigned integer to 4 octet format taking account of system endianness

 .Parameter Ip
  The IPv4 Address unsigned int

 .Example
    Convert-ToIPv4 3232238081
#>
Function Convert-ToIPv4 {
    Param (
        [Parameter(Position=0,mandatory=$true)]
        [UInt32]$Ip
    )
    Process {
        $bytes = [System.Byte[]][BitConverter]::GetBytes($ip)
        if ([BitConverter]::IsLittleEndian) {
            [Array]::Reverse($bytes)
        }
        $newip = New-Object System.Net.IPAddress -ArgumentList @(,$bytes)
        $newip.ToString();
    }    
}

Export-ModuleMember -Function Convert-FromIPv4
Export-ModuleMember -Function Convert-ToIpv4