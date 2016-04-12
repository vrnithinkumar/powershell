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
 		[int]$beepsTimes
	)
	$times = 12;
	if($beepsTimes -gt 12){
		$times = $beepsTimes - 12;
	}
	for($i =0 ; $i -lt $times; $i++){
		[console]::beep(1000,500)
	}
}

$initialHour = 0
echo "Running Stand Up and Walk Script"
DO{
	$date = Get-Date
	[string]$strNum = $date.Hour
	[int]$intNum = [convert]::ToInt32($strNum, 10)

	if( $intNum -ne $initialHour){
		$initialHour = $intNum
		echo "Stand Up and Walk, time is $initialHour "
		BeepNTimes -beepsTimes $initialHour 
		Show-BalloonTip -Title “Stand Up Time dude” -MessageType Warning -Message “You have to walk for five minutes, time is $initialHour  ” -Duration 3000
	}
	
}WHILE($true)
