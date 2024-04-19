function Select-GcloudAccount {
    $account = gcloud auth list --format="value(account)" | peco
    gcloud config set account $account
}
Set-Alias -Name ga -Value Select-GcloudAccount

function Select-GcloudProject {
    $project = gcloud projects list --format="value(project_id)" | peco
    gcloud config set project $project
}
Set-Alias -Name gpr -Value Select-GcloudProject

function Select-KubeContext {
    $context = kubectl config get-contexts -o name | peco
    kubectl config use-context $context
}
Set-Alias -Name ka -Value Select-KubeContext

function Get-GKEClusterCredentials {
    $clusters = gcloud container clusters list --format="value(name, location)" | Out-String
    $clusterLines = $clusters -split "`n" | Where-Object { $_ -ne "" }
    foreach ($line in $clusterLines) {
        $clusterData = $line -split '\s+'
        $clusterName = $clusterData[0]
        $clusterLocation = $clusterData[1]

        $command = "gcloud container clusters get-credentials $clusterName --region $clusterLocation"
        Write-Host "Running command: $command"
        Invoke-Expression $command
    }
}

$env:RUNEWIDTH_EASTASIAN = 0
