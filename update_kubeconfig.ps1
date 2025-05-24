# PowerShell script to update the server URL in kubeconfig file for Jenkins

$kubeconfigPath = "C:\jenkins\.kube\config"
$oldServer = "https://127.0.0.1:52002"
$newServer = "https://127.0.0.1:54594"

if (Test-Path $kubeconfigPath) {
    (Get-Content $kubeconfigPath) -replace [regex]::Escape($oldServer), $newServer | Set-Content $kubeconfigPath
    Write-Output "Updated server URL in kubeconfig from $oldServer to $newServer"
} else {
    Write-Output "kubeconfig file not found at $kubeconfigPath"
}
