$searchRoot = "OU=Account,DC=example,DC=com"
$OutputPath = 'C:\exportpath'

<# Function for convert thumbnail in active directory to jpeg format #>
Function ConvertTo-Jpeg {
 param ($userName,$photoAsBytes,$path=$OutputPath)
 if ( ! ( Test-Path $path ) ) { New-Item $path -ItemType Directory }
 $Filename="$($path)\$($userName).jpg"
 [System.Io.File]::WriteAllBytes( $Filename,$photoAsBytes )
}

<# Get all users with filter #>
$users = Get-ADUser -Filter * -SearchBase $searchRoot -Properties thumbnailPhoto | ? {$_.thumbnailPhoto}

<# iterate and export all users avatars #>
foreach ($user in $users) {
    $name = $user.SamAccountName + ".jpg"
    ConvertTo-Jpeg -userName $user.SamAccountName -photoAsBytes $user.thumbnailPhoto -path $OutputPath
}