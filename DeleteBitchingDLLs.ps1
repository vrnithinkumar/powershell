# Form stuf starting. shamelessly copied from internet.
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Ditching Bitching DLL's"
$form.Size = New-Object System.Drawing.Size(450,250) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(350,40)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "Ditch It !"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(350,80)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(280,20) 
$label.Text = "Please enter the error message in the space below:"
$form.Controls.Add($label) 

$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Size(10,40) 
$textBox.Size = New-Object System.Drawing.Size(300,150)
#$textBox.AcceptsReturn = $true
$textBox.AcceptsTab = $false
$textBox.Multiline = $true
$textBox.ScrollBars = 'Both'

$form.Controls.Add($textBox) 

$form.Topmost = $True

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog() 
# Form stuf ending.

#Function parse.
function BeepNTimes{	
	param(
 		[parameter(Mandatory=$true)]            
 		[String]$errorMessage
	)
    $errorMessageInSingleLine = $errorMessage.replace("`n",", ").replace("`r",", ")
	$arrayOfDlls = New-Object string[]
    $dllIndex = 0
    Foreach ($c in errorMessageInSingleLine)
    {
       if($c -eq '')
       {
           
       }
    }
}

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $errorMessage = $textBox.Text.replace("`n","").replace("`r","")
    $singleQuotes = ([regex]"'[^']*'").Matches($errorMessage);
    $validValues = $singleQuotes | where{$_.value -like "*.dll"}
    Write-Output("`n")
    Write-Output("Ditching these DLL's `n================================")
    for($i =0 ; $i -lt $singleQuotes.Count;$i++)
    {
         Write-Output("Dll : $($singleQuotes[$i])")
    }
   

    Write-Output("`n")
    $deleted = 0
    Foreach($val in $singleQuotes)
    {
        $pathToDll = $val.Value.Replace("'","")

        if (-not (Test-Path $pathToDll))
        {
            Write-Host "Error-DBD1 : File not exist or not a dll: $pathToDll `n" -ForegroundColor Red -BackgroundColor black
        }
        else
        {
            $rmResult = rm -Force $pathToDll > null
            if($?)
            {
                Write-Host "Deleted : $pathToDll `n" -ForegroundColor Green -BackgroundColor black
                $deleted += 1
            }
            else 
            {
                Write-Host "Error-DBD2 : Deletion failed : $pathToDll `n" -ForegroundColor Red -BackgroundColor black
            }
        }
    }
    
    Write-Host "Deleted $deleted out of $($singleQuotes.Count) Bitching Dlls `n" -ForegroundColor Magenta -BackgroundColor black
}