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

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $res = $x -match "'.*'"
    Write-Output("`n")
    Write-Output("Ditching these DLL's `n================================")
    Foreach($val in $Matches.values)
    {
        Write-Output("Dll : $val")
    }

    Write-Output("`n")

    Foreach($val in $Matches.values)
    {
        $pathToDll = $val.Replace("'","")

        if (Test-Path $$pathToDll) 
        {
            Write-Warning(" File not exist: $pathToDll")
        }
        else 
        {
            rm -Force $pathToDll
            Write-Output("Deleted : $pathToDll")
        }
        Write-Output("`n")
    }
}