[cmdletbinding()]
param()
Write-Verbose "This psm1 is replaced in the build output. This file is only used for debugging."
Write-Verbose $PSScriptRoot

Write-Verbose 'Import everything in sub folders'
foreach ($folder in @('classes', 'private', 'public', 'includes', 'internal'))
{
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder
    if (Test-Path -Path $root)
    {
        Write-Verbose "processing folder $root"
        $files = Get-ChildItem -Path $root -Filter *.ps1 -Recurse

        # dot source each file
        $files | where-Object { $_.name -NotLike '*.Tests.ps1'} |
            ForEach-Object {Write-Verbose $_.basename; . $_.FullName}
    }
}

Export-ModuleMember -function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1").basename

# This framework is built in such a way that each public function MUST reside in its own file.

# Get public and private function definition files
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# Dot sourcing those files loads them into memory
Foreach ($File in @($Public + $Private))
{
    Try
    {
        . $File.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($File.FullName): $_"
    }
}

# In order to make modules easier to use, they can be pre-loaded with variables.
# To avoid releasing confidential information, module-wide variables are stored
#   in a CSV file in the .\lib directory.
# The Variables.csv file should contain the name, value, and scope for each variable
#   used by the commands within the module.
# If the variable needs to be exposed to the user, the Scope should be set to global,
#   otherwise the variable will just be available to the module.
# In my testing, there was no difference between variables in the local scope, versus
#   the script scope, but I didn't test that much.
$VariablesPath = "$PSScriptRoot\lib\Variables.csv"
if (Test-Path $VariablesPath) {
    $ModuleVariables = Import-Csv -Path $VariablesPath
    foreach ($Item in $ModuleVariables) {
        if ( $Item.Scope) {
            $Scope = $Item.Scope
        } else {
            $Scope = 'Script'
        }
        # Remove the variable if it exists, to prevent re-creating globally scoped variables
        if (Get-Variable -Name ExpandedValue -ErrorAction SilentlyContinue) {
            Remove-Variable -Name ExpandedValue -ErrorAction SilentlyContinue
        }

        # Convert string versions of true and false to boolean versions if needed
        if ($ExecutionContext.InvokeCommand.ExpandString($Item.Value) -in 'true','false') {
            [boolean]$ExpandedValue = [System.Convert]::ToBoolean($ExecutionContext.InvokeCommand.ExpandString($Item.Value))
        } else {
            $ExpandedValue = $ExecutionContext.InvokeCommand.ExpandString($Item.Value)
        }

        if (! (Get-Variable -Name $Item.VariableName -ErrorAction SilentlyContinue) ) {
            New-Variable -Name $Item.VariableName -Value $ExpandedValue -Scope $Item.Scope
        }
    }
}

# We don't need to do anything with the contents of the csv file, so lets get rid of it
$ModuleVariables = $null

# Make all of the functions in the .\Public folder available for use outside the module
# This also keeps any functions in the .\Private folder inaccessible

Export-ModuleMember -Function $($Public | Select-Object -ExpandProperty BaseName)