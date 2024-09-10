# Imposta l'intervallo di tempo (in secondi) per il monitoraggio
$interval = 5

# Loop infinito per monitorare continuamente l'utilizzo della CPU
while ($true) {
    # Ottieni l'utilizzo della CPU per il sistema (media globale)
    $cpuUsage = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average

    # Ottieni la data e ora correnti
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Visualizza i risultati
    Write-Host "$timestamp - Utilizzo CPU: $cpuUsage %"

    # Attendi per l'intervallo specificato prima di ripetere il ciclo
    Start-Sleep -Seconds $interval
}
