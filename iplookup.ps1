function Get-IPGeolocation {
  Param
  (
    [string]$IPs
  )
 
   $request = Invoke-RestMethod -Method Get -Uri "https://ipinfo.io/$IPs"
 
  [PSCustomObject]@{
#ip =$request.ip
#city =$request.city
#region =$request.region
#country =$request.country
#loc =$request.loc
#postal =$request.postal
#timezone =$request.timezone
Route =$request.Route
Organization=$request.Organization
ASN=$request.ASN
  }
}

$pwd = pwd


$OutputFile = "LOCATION OF THE FILE\IP_GeoLocation2.csv"
$i = 0
$IPAddress = Get-Content "location of the \IPAddress.txt"
ForEach ($IP In $IPs) {
  $i++    # More than 150 queries per minute gets you banned from ipinfo.io.com
  If ($i -gt 203) {
    Write-Host Just pausing a minute to avoid IP blocking from ipinfo.io.com
    Start-Sleep 70
    $i = 0
  }
  Get-IPGeolocation($IP) | Select-Object ip, city, region, country, loc, postal, timezone, Route, Organization, ASN | Export-Csv $OutputFile -NoTypeInformation -Append
}


