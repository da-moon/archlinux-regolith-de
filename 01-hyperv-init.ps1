# ─── VM CONFIG ──────────────────────────────────────────────────────────────────
$MemoryStartupBytes="4GB"
$VMProcessorCount=4
$VHDSizeBytes="128GB"
$VMName = 'ArchLinux'
# ────────────────────────────────────────────────────────────────────────────────
$dir = $Env:UserProfile + '\Downloads\iso'
New-Item -Path $dir -Type Directory -Force

$url = "https://archive.archlinux.org/iso/$(Get-Date -Format 'yyyy.MM').01/archlinux-$(Get-Date -Format 'yyyy.MM').01-x86_64.iso"
$output ='arch.iso'
aria2c -k 1M -c -j16 -x16 --dir="$dir" --out="$output" "$url"


class Adapter {
  [string]$name
  [string]$ip;
}

$adapters = New-Object System.Collections.ArrayList
Get-NetIPAddress -AddressFamily ipv4 | Where-Object InterfaceAlias -in (Get-NetAdapter | Select-Object -ExpandProperty Name) | Select-Object IPAddress,InterfaceAlias | % {
    Test-Connection -Source $_.IPAddress -Destination 8.8.8.8 -ErrorAction SilentlyContinue | Out-Null
    if($?) {
        $element=[Adapter]@{
          name=$_.InterfaceAlias;
          ip=$_.IPAddress;
        }
        $adapters.Add($element)
    }
}
$switch_network_id="172"
foreach ( $adapter in $adapters.Clone() ) {
  $network_id = $adapter.ip.split(".")[0]
  if ($switch_network_id -eq $network_id) {
    $adapters.Remove($adapter)
  }
}

$adapter = $adapters[0].name
$Switch = 'ArchLinux'
New-VMSwitch -name $Switch  -NetAdapterName $adapter  -AllowManagementOS $true

$VMPath = 'C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\'
Remove-Item -Force -Path "$VMPath\$VMName.vhdx" -ErrorAction SilentlyContinue
New-VM `
  -Name $VMName `
  -MemoryStartupBytes "$MemoryStartupBytes" `
  -Generation 2 `
  -NewVHDPath "$VMPath\$VMName.vhdx" `
  -NewVHDSizeBytes "$VHDSizeBytes" `
  -Path "$VMPath" `
  -SwitchName $Switch
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -CheckpointType Disabled
Set-VMProcessor $VMName -Count $VMProcessorCount
Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMProcessor -VMName $VMName -ExposeVirtualizationExtensions $true
$InstallMedia = Join-Path -Path $dir  -ChildPath $output
Add-VMDvdDrive `
  -VMName $VMName `
  -ControllerNumber 0 `
  -ControllerLocation 1 `
  -Path $InstallMedia

$DVDDrive = Get-VMDvdDrive -VMName $VMName
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive

Start-VM -Name $VMName
$HOSTNAME = (Get-WmiObject -Class Win32_ComputerSystem -Property Name).Name
VMConnect $HOSTNAME $VMName
