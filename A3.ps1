Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.DirectoryServices.AccountManagement

function TestString()
{
   # change the value to your org compname name values
   # for example if the comp name is bbcomphaifa123, change on of the ____ values to "haifa" etc
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}
    if ($testString -match "____") {}


       
 
}
function PasswordReset {
# form type
$form = New-Object System.Windows.Forms.Form
$form.Text = "Change Password"
$form.Size = New-Object System.Drawing.Size(300, 250)
$form.StartPosition = "CenterScreen"

# label type
$label = New-Object System.Windows.Forms.Label
$label.Text = "Password Changing Function"
$label.Location = New-Object System.Drawing.Point(20, 25)
$label.Font = New-Object System.Drawing.Font("Times New Roman", 15, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(280, 25)
$form.Controls.Add($label)

# label type
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select an account:"
$label.Location = New-Object System.Drawing.Point(20, 50)
$label.Font = New-Object System.Drawing.Font("Times New Roman", 15, [System.Drawing.FontStyle]::Regular)
$label.Size = New-Object System.Drawing.Size(160, 20)
$form.Controls.Add($label)

# dropdown type
$dropdown = New-Object System.Windows.Forms.ComboBox
$dropdown.Location = New-Object System.Drawing.Point(20, 80)
$form.Controls.Add($dropdown)

# Get the list of Active Directory user accounts
$context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Domain)
$userQuery = New-Object System.DirectoryServices.AccountManagement.UserPrincipal($context)
$userQuery.Name = "*"
$userSearcher = New-Object System.DirectoryServices.AccountManagement.PrincipalSearcher($userQuery)
$users = $userSearcher.FindAll()

# not sure even god himself knows how this works but it does and we shall leave it be. its a mircale
foreach ($user in $users) {
    $dropdown.Items.Add($user.Name)
}

# pass input
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(20, 110)
$textBox.PasswordChar = "*"
$form.Controls.Add($textBox)

# Create a button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Change Password"
$button.Location = New-Object System.Drawing.Point(20, 150)
$button.Size = New-Object System.Drawing.Size(200, 40)
$button.Add_Click({
    $selectedUser = $dropdown.SelectedItem.ToString()
    $newPassword = $textBox.Text

    if (-not [string]::IsNullOrWhiteSpace($selectedUser) -and -not [string]::IsNullOrWhiteSpace($newPassword)) {
        try {
            $userPrincipal = [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($context, $selectedUser)
            $userPrincipal.SetPassword($newPassword)
            $userPrincipal.Save()

            [System.Windows.Forms.MessageBox]::Show("Password changed successfully!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
        catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to change password. Error: $($_.Exception.Message)", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
    else {
        [System.Windows.Forms.MessageBox]::Show("Please select a user and enter a new password.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
$form.Controls.Add($button)

# Show the form
$result = $form.ShowDialog()

# Dispose the form
$form.Dispose()
}
function compname($ess) {
    #city names in israel
    if ($ess -eq "Haifa")
    {
     Return "bbHaifacomp"
    }
    if ($ess -eq "Beitel")
    {
     Return "bbBetlcomp"
    }
    if ($ess -eq "Tel-aviv")
    {
     Return "bbtelavivcomp"
    }
    if ($ess -eq "metola")
    {
     Return "bbmetolacomp"
    }
    if ($ess -eq "Rishon")
    {
     Return "bbrishoncomp"
    }
    if ($ess -eq "Afula")
    {
     Return "bbAfulacomp"
    }
    if ($ess -eq "atlit")
    {
     Return "bbatlitcomp"
    }
    if ($ess -eq "Ramala")
    {
     Return "bbRamlacomp"
    }
    
}
function CreateRandomComputer {
    # Create a form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Itay Tool Box"
    $form.Size = New-Object System.Drawing.Size(400, 300)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = "white"

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Text = "Create Computer:"
    $label1.Font = New-Object System.Drawing.Font("Times New Roman", 25, [System.Drawing.FontStyle]::Bold)
    $label1.Location = New-Object System.Drawing.Point(50, 10)
    $label1.Size = New-Object System.Drawing.Size(300, 50)
    $form.Controls.Add($label1)

    $label2 = New-Object System.Windows.Forms.Label
    $label2.Text = "OU:"
    $label2.Font = New-Object System.Drawing.Font("Times New Roman", 15, [System.Drawing.FontStyle]::Bold)
    $label2.Location = New-Object System.Drawing.Point(20, 80)
    $label2.Size = New-Object System.Drawing.Size(70, 30)
    $form.Controls.Add($label2)

    $dropdown = New-Object System.Windows.Forms.ComboBox
    $dropdown.Location = New-Object System.Drawing.Point(100, 80)

    # Get the list of OUs
    $ous = @("Haifa", "atlit", "Ramala", "Afula", "Rishon", "Metola", "Tel-aviv", "Beitel")
    $ous | ForEach-Object {
        $dropdown.Items.Add($_)
    }

    $form.Controls.Add($dropdown)

    $button = New-Object System.Windows.Forms.Button
    $button.Text = "Confirm"
    $button.Location = New-Object System.Drawing.Point(100, 120)
    $button.add_Click({
        $selectedValue = $dropdown.SelectedItem
        $computerName = (compname($selectedValue) + (Get-Random -Minimum 1 -Maximum 1000)).ToString()
        Write-Host "Selected value: $selectedValue"
        Write-Host "Computer name: $computerName"

        # Check if computer name already exists
        while (Test-ComputerNameExists -Name $computerName) {
            $computerName = (compname($selectedValue) + (Get-Random -Minimum 1 -Maximum 1000)).ToString()
            Write-Host "Computer name '$computerName' already exists. Trying a new name."
        }

        # Create the computer in Active Directory
        New-Computer -Name $computerName

        # Update the label to display selected value
        $label3.Text = "Selected Value: $selectedValue"

        # Display the computer name
        $label4.Text = "Computer Name: $computerName"
    })
    $form.Controls.Add($button)

    # Label to display selected value
    $label3 = New-Object System.Windows.Forms.Label
    $label3.Font = New-Object System.Drawing.Font("Times New Roman", 12)
    $label3.Location = New-Object System.Drawing.Point(20, 160)
    $label3.Size = New-Object System.Drawing.Size(300, 30)
    $form.Controls.Add($label3)

    # Label to display computer name
    $label4 = New-Object System.Windows.Forms.Label
    $label4.Font = New-Object System.Drawing.Font("Times New Roman", 12)
    $label4.Location = New-Object System.Drawing.Point(20, 200)
    $label4.Size = New-Object System.Drawing.Size(300, 30)
    $form.Controls.Add($label4)

    #epic gamer

    $form.ShowDialog()

    # Dispose the form
    $form.Dispose()
}
function Test-ComputerNameExists {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    # Check if computer name exists in Active Directory
    if (Get-ADComputer -Filter "Name -eq '$Name'" -ErrorAction SilentlyContinue) {
        return $true
    }
    return $false
}
function New-Computer {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    
    $OU = call(TestString) 
    $SAMAccountName = $Name + "$"

    New-ADComputer -Name $Name -SamAccountName $SAMAccountName -Path $OU

    Write-Host "Creating computer '$Name' in Active Directory..."
    Start-Sleep -Seconds 2
    Write-Host "Computer '$Name' created successfully!"
}
function NonwordPermissions{
# assuming your org has a shared folder for every branch etc, u can use this tool to add users permission to that folder :)
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Shared folder permission"
    $form.Size = New-Object System.Drawing.Size(400, 300)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = "white"

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Text = "Shared folder permission:"
    $label1.Font = New-Object System.Drawing.Font("Times New Roman", 25, [System.Drawing.FontStyle]::Bold)
    $label1.Location = New-Object System.Drawing.Point(30, 10)
    $label1.Size = New-Object System.Drawing.Size(500, 70)
    $form.Controls.Add($label1)

    $label2 = New-Object System.Windows.Forms.Label
    $label2.Text = "OU:"
    $label2.Font = New-Object System.Drawing.Font("Times New Roman", 15, [System.Drawing.FontStyle]::Bold)
    $label2.Location = New-Object System.Drawing.Point(20, 80)
    $label2.Size = New-Object System.Drawing.Size(70, 30)
    $form.Controls.Add($label2)

    $label3 = New-Object System.Windows.Forms.Label
    $label3.Text = "User:"
    $label3.Font = New-Object System.Drawing.Font("Times New Roman", 15, [System.Drawing.FontStyle]::Bold)
    $label3.Location = New-Object System.Drawing.Point(20, 120)
    $label3.Size = New-Object System.Drawing.Size(70, 30)
    $form.Controls.Add($label3)

    $dropdown = New-Object System.Windows.Forms.ComboBox
    $dropdown.Location = New-Object System.Drawing.Point(100, 80)
    $form.Controls.Add($dropdown)

    # Get the list of OUs
    $ous = @("Hifa", "Beitel", "Ramala", "Tel-Aviv", "Metola", "Afula", "Rishon", "Atlit")
    $ous | ForEach-Object {
        $dropdown.Items.Add($_)
    }


  
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(100, 120)
    $form.Controls.Add($textBox)


    $button = New-Object System.Windows.Forms.Button
    $button.Text = "Confirm"
    $button.Location = New-Object System.Drawing.Point(100, 150)
    $button.add_Click(
    {
    #drop_down
    $selectedValue_dropdown = $dropdown.SelectedItem.ToString()
    function link($pass)
    #replace the value in return to your org permission group name for each folder
    {
    if ($pass -eq "Haifa")
    {
        return 'link to betl permission group'
    }
    if ($pass -eq "Beitel")
    {
        return "link to betl permission group"
    }
    if ($pass -eq "Ramala")
    {
        return "link to dotn permission group"
    }
    if ($pass -eq "Atlit")
    {
        return "link to hbrn permission group"
    }
    if ($pass -eq "Afula")
    {
        return "link to verd permission group"
    }
    if ($pass -eq "Tel-Aviv")
    {
        return "link to ezio permission group"
    }
    if ($pass -eq "Rishon")
    {
        return "link to otef permission group"
    }
    if ($pass -eq "Metola")
    {
        return "link to ramala permission group"
    }
    }
    #username
    $selectedValue_user = $textBox.Text
    $groupName = link($selectedValue_dropdown)
    Write-Host $groupName
    Add-ADGroupMember -Identity $groupName -Members $selectedValue_user
    }
 
    )
     $form.Controls.Add($button)

   
    $result = $form.ShowDialog()

}

###Main window
# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Itay Tool Box"
$form.Size = New-Object System.Drawing.Size(420, 300)
$form.StartPosition = "CenterScreen"
$form.BackColor = "#93C7F8"
$form.WindowState = "Minimized"
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$Form.FormBorderStyle = 'Fixed3D'

# Create a PictureBox
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Location = New-Object System.Drawing.Point(295, 140)
$pictureBox.Size = New-Object System.Drawing.Size(125, 125)  # Set the size of the picture box
$pictureBox.Image = [System.Drawing.Image]::FromFile("C:\Users\___________\Desktop\lay.png") # add a cool picture for background :)
$pictureBox.SizeMode = "Zoom"  
$form.Controls.Add($pictureBox)

# Button number 1 "Password Reset"
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Password Reset"
$button1.Font = New-Object System.Drawing.Font("Calibri Light (Headings)", 11, [System.Drawing.FontStyle]::Bold)
$button1.Location = New-Object System.Drawing.Point(115, 50)
$button1.Size = New-Object System.Drawing.Size(170, 30)
$button1.FlatStyle = 'Flat' 
$button1.Add_Click({
    PasswordReset

})
$form.Controls.Add($button1)

# Button number 2
$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Create Computer"
$button2.Font = New-Object System.Drawing.Font("Calibri Light (Headings)", 11, [System.Drawing.FontStyle]::Bold)
$button2.Location = New-Object System.Drawing.Point(115, 90)
$button2.Size = New-Object System.Drawing.Size(170, 30)
$button2.Add_Click({CreateRandomComputer})
$button2.FlatStyle = 'Flat' 
$button2.FlatAppearance.BorderColor = 'Black'  
$button2.FlatAppearance.BorderSize = 2  
$form.Controls.Add($button2)

# Button number 3
$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Nonword Perms"
$button3.Font = New-Object System.Drawing.Font("Calibri Light (Headings)", 11, [System.Drawing.FontStyle]::Bold)
$button3.Location = New-Object System.Drawing.Point(115, 130)
$button3.Size = New-Object System.Drawing.Size(170, 30)
$button3.FlatStyle = 'Flat' 
$button3.FlatAppearance.BorderColor = 'Black'  
$button3.FlatAppearance.BorderSize = 2  
$button3.Add_Click({NonwordPermissions})
$form.Controls.Add($button3)

# Button number 4
$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "Unlock User"
$button4.Font = New-Object System.Drawing.Font("Calibri Light (Headings)", 11, [System.Drawing.FontStyle]::Bold)
$button4.Location = New-Object System.Drawing.Point(115, 170)
$button4.Size = New-Object System.Drawing.Size(170, 30)
$button4.FlatStyle = 'Flat' 
$button4.FlatAppearance.BorderColor = 'Black'  
$button4.FlatAppearance.BorderSize = 2  
$button4.Add_Click()
$form.Controls.Add($button4)



$label3 = New-Object System.Windows.Forms.Label
$label3.Text = "Itay Tool Box"
$label3.Font = New-Object System.Drawing.Font("Times New Roman", 20, [System.Drawing.FontStyle]::Bold)
$label3.Location = New-Object System.Drawing.Point(115, 15)
$label3.Size = New-Object System.Drawing.Size(200, 60)
$label3.ForeColor = 'White'
$form.Controls.Add($label3)


# Show the form
$result = $form.ShowDialog()

# Dispose the form
$form.Dispose()






