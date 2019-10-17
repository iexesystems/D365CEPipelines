param (
    [Parameter(Mandatory = $true)]
    [string] $toolsDirectory
)

New-Item `
    -ItemType Directory `
    -Path $toolsDirectory\CoreTools

Invoke-WebRequest `
    -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe `
    -OutFile $toolsDirectory\nuget.exe
Set-Alias nuget $toolsDirectory\nuget.exe

nuget install Microsoft.CrmSdk.CoreTools -O $toolsDirectory
$coreToolsFolder = Get-ChildItem $toolsDirectory `
    | Where-Object { $_.Name -match 'Microsoft.CrmSdk.CoreTools.' }
Move-Item `
    -Path "$toolsDirectory\\$coreToolsFolder\\content\\bin\\coretools\\*.*" `
    -Destination "$toolsDirectory\\CoreTools"
Remove-Item "$toolsDirectory\\$coreToolsFolder" -Force -Recurse