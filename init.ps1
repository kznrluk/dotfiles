# RUN AS ADMIN

# install gcloud
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe") & $env:Temp\GoogleCloudSDKInstaller.exe

gcloud components install kubectl

cd /

$directoryPath = "C:\Bin"

if (-Not (Test-Path -Path $directoryPath)) {
    New-Item -Path $directoryPath -ItemType Directory
} else {
    Write-Host "Directory already exists."
}


go install github.com/kznrluk/aski@main
go install github.com/peco/peco/cmd/peco@main
go install github.com/derailed/k9s@latest
go install github.com/zyedidia/micro/cmd/micro@master
