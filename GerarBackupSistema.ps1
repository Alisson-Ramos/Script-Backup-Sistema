# ---------------------------------------------------------------
# Script Criado por Alisson Ramos 13/11/2024
# Script que cria backup do Sistema para Recuperação
# ---------------------------------------------------------------
$backupTarget = "C:"
$computerName = $env:COMPUTERNAME
$backupPath = Join-Path $backupTarget "WindowsImageBackup\$computerName"


function Check-WbAdmin-Process {
    $wbadminProcess = Get-Process -Name "wbengine" -ErrorAction SilentlyContinue
    if ($wbadminProcess) {
        Write-Host "O processo 'wbengine' está em execução. Finalizando o processo..." -ForegroundColor Yellow
        Stop-Process -Name "wbengine" -Force
        Write-Host "Processo 'wbengine' finalizado. aguarde...." -ForegroundColor Yellow
        
    } else {
        Write-Host "O processo 'wbadmin' não está em execução." -ForegroundColor Yellow
    }
    Start-Sleep -Seconds 5
}


function Check-BackupExists {
    param (
        [string]$backupDirectory
    )
    Check-WbAdmin-Process

    if (Test-Path -Path $backupDirectory) {
        Write-Host "Backup encontrado em $backupDirectory. Iniciando a exclusão do backup anterior..." -ForegroundColor Yellow
        Remove-Item -Path $backupDirectory -Recurse -Force
        Write-Host "Backup anterior excluído." -ForegroundColor Yellow
    } else {
        Write-Host "Nenhum backup anterior encontrado. Prosseguindo com o novo backup..." -ForegroundColor Yellow
    }
}


function Start-Backup {
    try{
        Write-Host "Iniciando o backup..." -ForegroundColor Yellow
        wbadmin start backup -backupTarget:$backupTarget -include:C: -allCritical -quiet
    } catch { Write-Host "Erro ao realizar o backup." -ForegroundColor Red }
}


function Verify-BackupIntegrity {
    Write-Host "Verificando a integridade do backup..."
    
    $backupStatus = wbadmin get status
    
    if ($backupStatus -contains "backup completed successfully") {
        Write-Host "Backup realizado com sucesso." -ForegroundColor Green
    
        Check-WbAdmin-Process
    } else { Write-Host "Erro na integridade do backup." -ForegroundColor Red }
}

Check-BackupExists -backupDirectory $backupPath

Start-Backup

Verify-BackupIntegrity