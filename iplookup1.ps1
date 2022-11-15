function Get-IPGeolocation {
  Param
  (
    [string]$IPAddress
  ) 
  $request = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPAddress"
  [PSCustomObject]@{
    IP      = $request.query
    City    = $request.city
    Country = $request.country
    Isp     = $request.isp
  }
}
$pwd = pwd

$pwd

$OutputFile = "LOCATION OF THE FILE\IP_GeoLocation2.csv"

$IPAddress = Get-Content "location of the \IPAddress.txt"
$i=0
ForEach ($IP In $IPAddress) {
 Start-Sleep -s 5
  $i++    # More than 150 queries per minute gets you banned from ip-api.com
  If ($i -gt 203) {
   Write-Host Just pausing a minute to avoid IP blocking from ip-api.com
    
    $i = 0}
   Get-IPGeolocation($IP) | Select-Object IP, City, Country, Isp | Export-Csv $OutputFile -NoTypeInformation -Append
}