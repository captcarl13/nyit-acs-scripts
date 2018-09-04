<#
  Maybe add the ability to create Bootable Media with an existing WinPE environment
  and add this to the existing system's hidden menu? -cv
#>
<#
  NOTE: This script is intended to work only in a preimage environment.
  If you want to create media in an existing Windows environment, follow the documentation
  located in \\owcaddist-srv\GhostImages\WinPE\WINDOWS PE IMAGE AUTOMATION.docx
#>
Start-Sleep -s 1
Write-Output "NYIT ACS WinPE bootable media creation script, version PowerShell"
Start-Sleep -s 1
<#
  DISKPART BEGINS HERE
#>
Get-Disk 1 | Clear-Disk -RemoveData #prompts user to confirm, possibly always confirm as yes?
Start-Sleep -s 1
Write-Output "Formatting USB as ACS bootable drive, please stand by..."
Start-Sleep -s 1
New-Partition -DiskNumber 1 -UseMaximumSize -IsActive -DriveLetter U | Format-Volume -FileSystem FAT32 -NewFileSystemLabel ACS
<#
  Force assign to always mount USB to a unique drive letter not in use (U:\)
  DISKPART ENDS HERE & ROBOCOPY BEGINS HERE
#>
Start-Sleep -s 1
Write-Output "Copying WinPE files..."
ROBOCOPY /S /XO O:\WinPE\USB\ U:\
<#
  robocopy ends here
  #>
Start-Sleep -s 1
Write-Output "Bootable USB creation complete!"
<#
  end of script
#>
