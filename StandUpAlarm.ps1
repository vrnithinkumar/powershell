<#
	Script to make desktop notification on windows 
	with a beep on every hour with. just to stand up from continues sitting 
#>

#Function to show desktop alert.
function Show-BalloonTip {            
	[cmdletbinding()]            
	param(            
		[parameter(Mandatory=$true)]            
		[string]$Title,            
		[ValidateSet("Info","Warning","Error")]             
		[string]$MessageType = "Info",            
		[parameter(Mandatory=$true)]            
		[string]$Message,            
		[string]$Duration=10000            
	)            

	[system.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null            
	$balloon = New-Object System.Windows.Forms.NotifyIcon            
	$path = Get-Process -id $pid | Select-Object -ExpandProperty Path            
	$icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)            
	$balloon.Icon = $icon            
	$balloon.BalloonTipIcon = $MessageType            
	$balloon.BalloonTipText = $Message            
	$balloon.BalloonTipTitle = $Title            
	$balloon.Visible = $true            
	$balloon.ShowBalloonTip($Duration)
	Start-Sleep -s 10
	$balloon.Dispose()
}

#Function to beep n times
function BeepNTimes{	
	param(
 		[parameter(Mandatory=$true)]            
 		[int]$times
	)
	#$times =  ConvertTime($beepsTimes);
	#for($i =0 ; $i -lt $times; $i++){
	#	[console]::beep(1000,500)
	#}
	[console]::beep(440,500) 
	[console]::beep(440,500) 
	[console]::beep(440,500) 
	[console]::beep(349,350) 
	[console]::beep(523,150) 
	[console]::beep(440,500) 
	[console]::beep(349,350) 
	[console]::beep(523,150) 
	[console]::beep(440,1000) 
	[console]::beep(659,500) 
	[console]::beep(659,500) 
	[console]::beep(659,500) 
	[console]::beep(698,350) 
	[console]::beep(523,150) 
	[console]::beep(415,500) 
	[console]::beep(349,350) 
	[console]::beep(523,150) 
	[console]::beep(440,1000)
}

#Function to convert time from 24 format to 12
function ConvertTime($hour)
{	
	$times = $hour;
	if($hour -gt 12)
	{
		$times = $hour - 12;
	}
	return $times;
}
$dateInitial = Get-Date
$initialHour = [convert]::ToInt32($dateInitial.Hour, 10)
$nextAlarmTime = $initialHour+1
write-host "Running Stand Up and Walk Script. Begins from $nextAlarmTime : 00 " -ForegroundColor Yellow   -BackgroundColor black
DO
{
	$date = Get-Date
	[string]$strNum = $date.Hour
	[int]$intNum = [convert]::ToInt32($strNum, 10)
	if( ($intNum -ne $initialHour))
	{

		$ready =$true
		$initialHour = $intNum
		$time =  ConvertTime($initialHour);
		echo "Stand Up and Walk, time is $time "
		BeepNTimes -times $time 
		Show-BalloonTip -Title “Stand Up Time dude” -MessageType Warning -Message “You have to walk for five minutes, time is $time O clock ” -Duration 3000
		rundll32.exe user32.dll,LockWorkStation
	}

}WHILE($true)
