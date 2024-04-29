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

function base64(){
    Param([switch]$encode=$true, [switch]$decode=$false, [Parameter(Mandatory=$true,ValueFromPipeline=$true)][string]$input)
    Begin{}
    Process{
        if($decode){
            $byte = [System.Convert]::FromBase64String($input)
            $txt = [System.Text.Encoding]::Default.GetString($byte)
            echo $txt
        }
        elseif($encode){
            $byte = ([System.Text.Encoding]::Default).GetBytes($input)
            $b64enc = [Convert]::ToBase64String($byte)
            echo $b64enc
        }
    }
    End{}
}

Set-Alias k kubectl
$env:RUNEWIDTH_EASTASIAN = 0
