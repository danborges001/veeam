param(
[string]$RetentionLength
)
$JobArray = Get-VBRJob | ? {$_.jobtype -eq "Backup"} | Select-Object -Property name,@{N="Target repository"; E={$_.GetTargetRepository().name}} | Where-Object {$_."Target repository" -Like "Default*"} 
ForEach ($Job in $JobArray)
	{
	Get-VBRJob -Name $Job.name | Set-VBRJobAdvancedOptions -EnableIntegrityChecks $True -RetainDays $RetentionLength
	}