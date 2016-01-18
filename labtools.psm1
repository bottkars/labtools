<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Get-LAByesnoabort
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LAByesnoabort",
                  ConfirmImpact='Medium')]
Param
    (
    $title = "Delete Files",
    $message = "Do you want to delete the remaining files in the folder?",
    $Yestext = "Yes",
    $Notext = "No",
    $AbortText = "Abort"
    )
$yes = New-Object System.Management.Automation.Host.ChoiceDescription ("&Yes","$Yestext")
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","$Notext"
$abort = New-Object System.Management.Automation.Host.ChoiceDescription "&Abort","$Aborttext"
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $Abort )
$result = $host.ui.PromptForChoice($title, $message, $options, 0)
return ($result)
}

function Set-LABDefaultGateway
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABDefaultGateway")]
	param (    
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DefaultGateway,
    [Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml"
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.DefaultGateway = $DefaultGateway
    Write-Verbose "Setting Default Gateway $DefaultGateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABDNS1
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#SET-LABDNS1")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DNS1
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.DNS1 = $DNS1
    Write-Verbose "Setting DNS1 $DNS1"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABvmnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABvmnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet9','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19')]$VMnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.vmnet = $VMnet
    Write-Verbose "Setting LABVMnet $VMnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABVlanID
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABvlanid")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateRange(0,4096)]$vlanID
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.vlanID = $vlanID
    Write-Verbose "Setting LABVMnet $VMnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}
<#
.Synopsis
   Short description
.DESCRIPTION
   This function matches naming conventios from vmware vmnet definitions to Hype-V Switchnames
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Set-LABvmnet2hvswitch
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABvmnet")]
	param (
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('vmnet0','vmnet1','vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet8')]$VMnet, #','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19'
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 2)][String]$hvswitch,
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile=".\Switchdefaults.xml"

    )
    if (!(Test-Path $SwitchDefaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile
    }
    $SwitchDefaults = Get-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile
    $SwitchDefaults.$($vmnet) = $hvswitch
    Write-Verbose "Setting $VMnet 2 $hvswitch"
    Save-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile -SwitchDefaults $SwitchDefaults
}

function Set-LABGateway
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABGateway")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Warning "Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Gateway = $enabled.IsPresent
    Write-Verbose "Setting $Gateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABNoDomainCheck
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABNoDomainCheck")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Warning "Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.NoDomainCheck = $enabled.IsPresent
    Write-Verbose "Setting $NoDomainCheck"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABpuppet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Warning "Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.puppet = $enabled.IsPresent
    Write-Verbose "Setting $puppet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABPuppetMaster
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABpuppetMaster")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('puppetlabs-release-7-11', 'PuppetEnterprise')]$PuppetMaster = "PuppetEnterprise"
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Warning "Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.puppetmaster = $PuppetMaster
    Write-Verbose "Setting $puppetMaster"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABnmm
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABnmm")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$NMM
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.NMM = $NMM.IsPresent
    Write-Verbose "Setting NMM to $($NMM.IsPresent)"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABsubnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABsubnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$subnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Mysubnet = $subnet
    Write-Verbose "Setting subnet $subnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABHostKey
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABHostKey")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$HostKey
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.HostKey = $HostKey
    Write-Verbose "Setting HostKey $HostKey"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABBuilddomain
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABBuilddomain")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateLength(1,15)][ValidatePattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,15}[a-zA-Z0-9]+$")][string]$BuildDomain
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.builddomain = $builddomain
    Write-Verbose "Setting builddomain $builddomain"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABSources
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Set-LABSources")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [ValidateLength(3,10)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateScript({ 
    try
        {
        Get-Item -Path $_ -ErrorAction Stop | Out-Null 
        }
        catch
        [System.Management.Automation.DriveNotFoundException] 
        {
        Write-Warning "Drive not found, make sure to have your Source Stick connected"
        exit
        }
        catch #[System.Management.Automation.ItemNotFoundException]
        {
        write-warning "no sources directory found"
        exit
        }
        return $True
        })]$Sourcedir
    
#Test-Path -Path $_ })]$Sourcedir
    )   
    if (!(Test-Path $Sourcedir)){exit} 

    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.sourcedir = $Sourcedir
    Write-Verbose "Setting Sourcedir $Sourcedir"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Get-LABDefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml"
    )
begin {
    }
process 
{
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Defaults does not exist. please create with New-LABdefaults or set any parameter with set-LABxxx"
    }
    else
        {

        Write-Verbose "Loading defaults from $Defaultsfile"
        [xml]$Default = Get-Content -Path $Defaultsfile
        $object = New-Object psobject
	    $object | Add-Member -MemberType NoteProperty -Name Master -Value $Default.config.master
        $object | Add-Member -MemberType NoteProperty -Name ScaleIOVer -Value $Default.config.scaleiover
        $object | Add-Member -MemberType NoteProperty -Name BuildDomain -Value $Default.config.Builddomain
        $object | Add-Member -MemberType NoteProperty -Name MySubnet -Value $Default.config.MySubnet
        $object | Add-Member -MemberType NoteProperty -Name vmnet -Value $Default.config.vmnet
        $object | Add-Member -MemberType NoteProperty -Name vlanID -Value $Default.config.vlanID
        $object | Add-Member -MemberType NoteProperty -Name DefaultGateway -Value $Default.config.DefaultGateway
        $object | Add-Member -MemberType NoteProperty -Name DNS1 -Value $Default.config.DNS1
        $object | Add-Member -MemberType NoteProperty -Name Gateway -Value $Default.config.Gateway
        $object | Add-Member -MemberType NoteProperty -Name AddressFamily -Value $Default.config.AddressFamily
        $object | Add-Member -MemberType NoteProperty -Name IPV6Prefix -Value $Default.Config.IPV6Prefix
        $object | Add-Member -MemberType NoteProperty -Name IPv6PrefixLength -Value $Default.Config.IPV6PrefixLength
        $object | Add-Member -MemberType NoteProperty -Name Sourcedir -Value $Default.Config.Sourcedir
        $object | Add-Member -MemberType NoteProperty -Name SQLVer -Value $Default.config.sqlver
        $object | Add-Member -MemberType NoteProperty -Name e15_cu -Value $Default.config.e15_cu
        $object | Add-Member -MemberType NoteProperty -Name e16_cu -Value $Default.config.e16_cu
        $object | Add-Member -MemberType NoteProperty -Name NMM_Ver -Value $Default.config.nmm_ver
        $object | Add-Member -MemberType NoteProperty -Name NW_Ver -Value $Default.config.nw_ver
        $object | Add-Member -MemberType NoteProperty -Name NMM -Value $Default.config.nmm
        $object | Add-Member -MemberType NoteProperty -Name Masterpath -Value $Default.config.Masterpath
        $object | Add-Member -MemberType NoteProperty -Name NoDomainCheck -Value $Default.config.NoDomainCheck
        $object | Add-Member -MemberType NoteProperty -Name Puppet -Value $Default.config.Puppet
        $object | Add-Member -MemberType NoteProperty -Name PuppetMaster -Value $Default.config.PuppetMaster
        $object | Add-Member -MemberType NoteProperty -Name HostKey -Value $Default.config.Hostkey

        Write-Output $object
        }
    }
end {
    }
}

function Get-LABSwitchDefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LABSwitchDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile=".\SwitchDefaults.xml"
    )
begin {
    }
process 
{
    if (!(Test-Path $SwitchDefaultsfile))
    {
        Write-Warning "SwitchDefaults does not exist. please create with New-LABSwitchDefaults or set any parameter with set-LABxxx"
    }
    else
        {

        Write-Verbose "Loading SwitchDefaults from $SwitchDefaultsfile"
        [xml]$Default = Get-Content -Path $SwitchDefaultsfile
        $object = New-Object psobject

	    $object | Add-Member -MemberType NoteProperty -Name vmnet0 -Value $Default.config.vmnet0
	    $object | Add-Member -MemberType NoteProperty -Name vmnet1 -Value $Default.config.vmnet1
	    $object | Add-Member -MemberType NoteProperty -Name vmnet2 -Value $Default.config.vmnet2
	    $object | Add-Member -MemberType NoteProperty -Name vmnet3 -Value $Default.config.vmnet3
	    $object | Add-Member -MemberType NoteProperty -Name vmnet4 -Value $Default.config.vmnet4
	    $object | Add-Member -MemberType NoteProperty -Name vmnet5 -Value $Default.config.vmnet5
	    $object | Add-Member -MemberType NoteProperty -Name vmnet6 -Value $Default.config.vmnet6
	    $object | Add-Member -MemberType NoteProperty -Name vmnet7 -Value $Default.config.vmnet7
	    $object | Add-Member -MemberType NoteProperty -Name vmnet8 -Value $Default.config.vmnet8

        Write-Output $object
        }
    }
end {
    }
}

function Save-LABdefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Save-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$Defaults

    )
begin {
    }
process {
        Write-Verbose "Saving defaults to $Defaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<nmm_ver>$($Defaults.nmm_ver)</nmm_ver>")
        $xmlcontent += ("<nmm>$($Defaults.nmm)</nmm>")
        $xmlcontent += ("<nw_ver>$($Defaults.nw_ver)</nw_ver>")
        $xmlcontent += ("<master>$($Defaults.Master)</master>")
        $xmlcontent += ("<sqlver>$($Defaults.SQLVER)</sqlver>")
        $xmlcontent += ("<e15_cu>$($Defaults.e15_cu)</e15_cu>")
        $xmlcontent += ("<e16_cu>$($Defaults.e16_cu)</e16_cu>")
        $xmlcontent += ("<vmnet>$($Defaults.VMnet)</vmnet>")
        $xmlcontent += ("<vlanID>$($Defaults.vlanID)</vlanID>")
        $xmlcontent += ("<BuildDomain>$($Defaults.BuildDomain)</BuildDomain>")
        $xmlcontent += ("<MySubnet>$($Defaults.MySubnet)</MySubnet>")
        $xmlcontent += ("<AddressFamily>$($Defaults.AddressFamily)</AddressFamily>")
        $xmlcontent += ("<IPV6Prefix>$($Defaults.IPV6Prefix)</IPV6Prefix>")
        $xmlcontent += ("<IPv6PrefixLength>$($Defaults.IPv6PrefixLength)</IPv6PrefixLength>")
        $xmlcontent += ("<Gateway>$($Defaults.Gateway)</Gateway>")
        $xmlcontent += ("<DefaultGateway>$($Defaults.DefaultGateway)</DefaultGateway>")
        $xmlcontent += ("<DNS1>$($Defaults.DNS1)</DNS1>")
        $xmlcontent += ("<Sourcedir>$($Defaults.Sourcedir)</Sourcedir>")
        $xmlcontent += ("<ScaleIOVer>$($Defaults.ScaleIOVer)</ScaleIOVer>")
        $xmlcontent += ("<Masterpath>$($Defaults.Masterpath)</Masterpath>")
        $xmlcontent += ("<NoDomainCheck>$($Defaults.NoDomainCheck)</NoDomainCheck>")
        $xmlcontent += ("<Puppet>$($Defaults.Puppet)</Puppet>")
        $xmlcontent += ("<PuppetMaster>$($Defaults.PuppetMaster)</PuppetMaster>")
        $xmlcontent += ("<Hostkey>$($Defaults.HostKey)</Hostkey>")
        $xmlcontent += ("</config>")
        $xmlcontent | Set-Content $defaultsfile
        }
end {}
}

function Save-LABSwitchdefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Save-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile=".\Switchdefaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$SwitchDefaults

    )
begin {
    }
process {
        Write-Verbose "Saving defaults to $SwitchDefaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<vmnet0>$($SwitchDefaults.VMnet0)</vmnet0>")
        $xmlcontent += ("<vmnet1>$($SwitchDefaults.VMnet1)</vmnet1>")
        $xmlcontent += ("<vmnet2>$($SwitchDefaults.VMnet2)</vmnet2>")
        $xmlcontent += ("<vmnet3>$($SwitchDefaults.VMnet3)</vmnet3>")
        $xmlcontent += ("<vmnet4>$($SwitchDefaults.VMnet4)</vmnet4>")
        $xmlcontent += ("<vmnet5>$($SwitchDefaults.VMnet5)</vmnet5>")
        $xmlcontent += ("<vmnet6>$($SwitchDefaults.VMnet6)</vmnet6>")
        $xmlcontent += ("<vmnet7>$($SwitchDefaults.VMnet7)</vmnet7>")
        $xmlcontent += ("<vmnet8>$($SwitchDefaults.VMnet8)</vmnet8>")
        $xmlcontent += ("</config>")
        $xmlcontent | Set-Content $SwitchDefaultsfile
        }
end {}
}

function New-LABdefaults   
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#New-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile=".\defaults.xml"
    )
        Write-Verbose "Saving defaults to $Defaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<nmm_ver></nmm_ver>")
        $xmlcontent += ("<nmm></nmm>")
        $xmlcontent += ("<nw_ver></nw_ver>")
        $xmlcontent += ("<master></master>")
        $xmlcontent += ("<sqlver></sqlver>")
        $xmlcontent += ("<e15_cu></e15_cu>")
        $xmlcontent += ("<e16_cu></e16_cu>")
        $xmlcontent += ("<vmnet></vmnet>")
        $xmlcontent += ("<vlanID></vlanID>")
        $xmlcontent += ("<BuildDomain></BuildDomain>")
        $xmlcontent += ("<MySubnet></MySubnet>")
        $xmlcontent += ("<AddressFamily></AddressFamily>")
        $xmlcontent += ("<IPV6Prefix></IPV6Prefix>")
        $xmlcontent += ("<IPv6PrefixLength></IPv6PrefixLength>")
        $xmlcontent += ("<Gateway></Gateway>")
        $xmlcontent += ("<DefaultGateway></DefaultGateway>")
        $xmlcontent += ("<DNS1></DNS1>")
        $xmlcontent += ("<Sourcedir></Sourcedir>")
        $xmlcontent += ("<ScaleIOVer></ScaleIOVer>")
        $xmlcontent += ("<Masterpath></Masterpath>")
        $xmlcontent += ("<NoDomainCheck></NoDomainCheck>")
        $xmlcontent += ("<Puppet></Puppet>")
        $xmlcontent += ("<PuppetMaster></PuppetMaster>")
        $xmlcontent += ("<HostKey></HostKey>")
        $xmlcontent += ("</config>")
        $xmlcontent | Set-Content $defaultsfile
     }

function New-LABSwitchdefaults   
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#New-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile=".\Switchdefaults.xml"
    )
        Write-Verbose "Saving defaults to $SwitchDefaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<vmnet0></vmnet0>")
        $xmlcontent += ("<vmnet1></vmnet1>")
        $xmlcontent += ("<vmnet2></vmnet2>")
        $xmlcontent += ("<vmnet3></vmnet3>")
        $xmlcontent += ("<vmnet4></vmnet4>")
        $xmlcontent += ("<vmnet5></vmnet5>")
        $xmlcontent += ("<vmnet6></vmnet6>")
        $xmlcontent += ("<vmnet7></vmnet7>")
        $xmlcontent += ("<vmnet8></vmnet8>")
        $xmlcontent += ("</config>")
        $xmlcontent | Set-Content $SwitchDefaultsfile
     }

function Expand-LAB7Zip
{
 [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
    HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Expand-LABZip")]
	param (
        [string]$Archive,
        [string]$destination=$vmxdir
        #[String]$Folder
        )
	$Origin = $MyInvocation.MyCommand
	if (test-path($Archive))
	{
 #   If ($Folder)
 #      {
 #     $zipfilename = Join-Path $zipfilename $Folder
 #    }
    	$7za = "$vmwarepath\7za.exe"
    
        if (!(test-path $7za))
            {
            Write-Warning "7za not found in $vmwarepath"
            }	
        Write-Verbose "extracting $Archive to $destination"
        if (!(test-path  $destination))
            {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
            }
        $destination = "-o"+$destination
        .$7za x $destination $Archive
	}
}

function Expand-LABZip
{
 [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
    HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Expand-LABZip")]
	param (
        [string]$zipfilename,
        [string] $destination,
        [String]$Folder)
	$copyFlag = 16 # overwrite = yes
	$Origin = $MyInvocation.MyCommand
	if (test-path($zipfilename))
	{
    If ($Folder)
        {
        $zipfilename = Join-Path $zipfilename $Folder
        }
    		
        Write-Verbose "extracting $zipfilename to $destination"
        if (!(test-path  $destination))
            {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
            }
        $shellApplication = New-object -com shell.application
		$zipPackage = $shellApplication.NameSpace($zipfilename)
		$destinationFolder = $shellApplication.NameSpace("$destination")
		$destinationFolder.CopyHere($zipPackage.Items(), $copyFlag)
	}
}

function Get-LABFTPFile
{ 
[CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LABFTPfile")]
Param(
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$Source,
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$TarGet,
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$UserName = "Anonymous",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$Password = "Admin@LABbuildr.local",
    [Parameter(ParameterSetName = "1", Mandatory = $false)][switch]$Defaultcredentials
) 
if (!$TarGet)
    {
    $TarGet = Split-Path -Leaf $Source 
    }
# Create a FTPWebRequest object to handle the connection to the ftp server 
try
    {
    $ftprequest = [System.Net.FtpWebRequest]::create($Source)
    }
catch
    {
    Write-Warning "Error Downloading File"
    break
    } 
 
# set the request's network credentials for an authenticated connection 
if ($Defaultcredentials.Ispresent)
    {
    $ftprequest.UseDefaultCredentials 
    }
else
    {
    $ftprequest.Credentials = New-Object System.Net.NetworkCredential($username,$password)
    }     

$ftprequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile 
$ftprequest.UseBinary = $true 
$ftprequest.KeepAlive = $false 
 
# send the ftp request to the server 
try
    {
    $ftpresponse = $ftprequest.GetResponse() 
    }
catch
    {
    Write-Warning "Error downlaoding $Source"
    break
    }
Write-Verbose $ftpresponse.WelcomeMessage
Write-Verbose "Filesize: $($ftpresponse.ContentLength)"
 
# Get a download stream from the server response 
$responsestream = $ftpresponse.GetResponseStream() 
 
# create the tarGet file on the local system and the download buffer 
$tarGetfile = New-Object IO.FileStream ($TarGet,[IO.FileMode]::Create) 
[byte[]]$readbuffer = New-Object byte[] 1024 
Write-Verbose "Downloading $Source via ftp" 
# loop through the download stream and send the data to the tarGet file 
$I = 1
do{ 
    $readlength = $responsestream.Read($readbuffer,0,1024) 
    $tarGetfile.Write($readbuffer,0,$readlength)
    if ($I -eq 1024)
        {
        Write-Host '#' -NoNewline 
        $I = 0
        }
    $I++
} 
while ($readlength -ne 0) 
 
$tarGetfile.close()
Write-Host
return $true
}

function Enable-LABfolders
    {
    [CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Enable-Labfolders")]
    param()
    Get-vmx | where state -match running  | Set-VMXSharedFolderState -Enabled
    }

function Get-LABscenario
    {
    [CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LABScenario")]
    param()
    Get-VMX | Get-vmxscenario | Sort-Object Scenarioname | ft -AutoSize
    }

function Start-LABScenario
    {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Start-LABscenario")]
	    param (
	    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 0)][ValidateSet('Exchange','SQL','DPAD','EMCVSA','hyper-V','ScaleIO','ESXi','LABbuildr')]$Scenario
	
	)
begin
	{
    if ((Get-vmx .\DCNODE).state -ne "running")
        {Get-vmx .\DCNODE | Start-vmx}
	}
process
	{
	Get-vmx | where scenario -match $Scenario | sort-object ActivationPreference | Start-vmx
	}
end { }
}

function Stop-LABScenario
    {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Stop-LABSscenario")]
	    param (
	    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 0)][ValidateSet('Exchange','SQL','DPAD','EMCVSA','hyper-V','ScaleIO','ESXi','LABbuildr')]$Scenario,
        [Parameter(ParameterSetName = "1", Mandatory = $false)][switch]$dcnode
	
	)
begin
	{

	}
process
	{
	Get-vmx | where { $_.scenario -match $Scenario -and $_.vmxname -notmatch "dcnode" } | sort-object ActivationPreference  -Descending | Stop-vmx
        if ($dcnode)
            {
            Get-vmx .\DCNODE | Stop-vmx
            }
	}
end { }
}

function Start-LABPC
   {
    [cmdletbinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Start-LABPC")]
    param ([String]$MAC= $(throw 'No MAC addressed passed, please pass as xx:xx:xx:xx:xx:xx'))
    $MACAddr = $MAC.split(':') | %{ [byte]('0x' + $_) }
    if ($MACAddr.Length -ne 6)
    {
        throw 'MAC address must be format xx:xx:xx:xx:xx:xx'
    }
    $UDPclient = New-Object System.Net.Sockets.UdpClient
    $UDPclient.Connect(([System.Net.IPAddress]::Broadcast),4000)
    $packet = [byte[]](,0xFF * 6)
    $packet += $MACAddr * 16
    [void] $UDPclient.Send($packet, $packet.Length)
    write "Wake-On-Lan magic packet sent to $MACAddrString, length $($packet.Length)"
 }

function Get-LABHttpFile
 {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#GET-LABHttpFile")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $true,Position = 0)]$SourceURL,
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$TarGetFile,
    [Parameter(ParameterSetName = "1", Mandatory = $false)][switch]$ignoresize
    )


begin
{}
process
{
if (!$TarGetFile)
    {
    $TarGetFile = Split-Path -Leaf $SourceURL
    }
try
                    {
                    $Request = Invoke-WebRequest $SourceURL -UseBasicParsing -Method Head
                    }
                catch [Exception] 
                    {
                    Write-Warning "Could not downlod $SourceURL"
                    Write-Warning $_.Exception
                    break
                    }
                
                $Length = $request.Headers.'content-length'
                try
                    {
                    # $Size = "{0:N2}" -f ($Length/1GB)
                    # Write-Warning "
                    # Trying to download $SourceURL 
                    # The File size is $($size)GB, this might take a while....
                    # Please do not interrupt the download"
                    Invoke-WebRequest $SourceURL -OutFile $TarGetFile
                    }
                catch [Exception] 
                    {
                    Write-Warning "Could not downlod $SourceURL. please download manually"
                    Write-Warning $_.Exception
                    break
                    }
                if ( (Get-ChildItem  $TarGetFile).length -ne $Length -and !$ignoresize)
                    {
                    Write-Warning "File size does not match"
                    Remove-Item $TarGetFile -Force
                    break
                    }                       


}
end
{}
}  
               
 function Get-LABJava64
    {
    [CmdletBinding(HelpUri = "https://github.com/bottkars/LABbuildr/wiki/LABtools#Get-LABJava64")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$DownloadDir=$vmxdir
    )
    Write-warning "Asking for latest Java"
    Try
        {
        $javaparse = Invoke-WebRequest https://www.java.com/en/download/manual.jsp
        }
    catch [Exception] 
        {
        Write-Warning "Could not connect to java.com"
        Write-Warning $_.Exception
        break
        }
    write-verbose "Analyzing response Stream"
    $Link = $javaparse.Links | Where-Object outerText -Match "Windows Offline \(64-Bit\)" | Select-Object href
    If ($Link)
        {
        $latest_java8uri = $link.href
        Write-Verbose "$($link.href)"
        $Headers = Invoke-WebRequest  $Link.href -UseBasicParsing -Method Head
        $File =  $Headers.BaseResponse | Select-Object responseUri
        $Length = $Headers.Headers.'Content-Length'
        $Latest_java8 = split-path -leaf $File.ResponseUri.AbsolutePath
        Write-verbose "We found $latest_java8 online"
        if (!(Test-Path "$DownloadDir\$Latest_java8"))
            {
            Write-Verbose "Downloading $Latest_java8"
            Try
                {
                Invoke-WebRequest "$latest_java8uri" -OutFile "$DownloadDir\$latest_java8" -TimeoutSec 60
                }
            catch [Exception] 
                {
                Write-Warning "Could not DOWNLOAD FROM java.com"
                Write-Warning $_.Exception
                break
                } 
            if ( (Get-ChildItem $DownloadDir\$Latest_java8).length -ne $Length )
                {
                Write-Warning "Invalid FileSize, must be $Length, Deleting Download File"
                Remove-Item $DownloadDir\$Latest_java8 -Force
                break
                }
            }
        else
            {
            Write-Warning "$Latest_java8 already exists in $DownloadDir"
            }
            $object = New-Object psobject
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8 -Value $Latest_java8
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8File -Value (Join-Path $DownloadDir $Latest_java8)
            Write-Output $object
        }
    }

function update-LABfromGit
{


	param (
            [string]$Repo,
            [string]$RepoLocation,
            [string]$branch,
            [string]$latest_local_Git,
            [string]$Destination,
            [switch]$delete
            )
        $Isnew = $false
        Write-Verbose "Using update-fromgit function for $repo"
        $Uri = "https://api.github.com/repos/$RepoLocation/$repo/commits/$branch"
        $Zip = ("https://github.com/$RepoLocation/$repo/archive/$branch.zip").ToLower()
        try
            {
            $request = Invoke-WebRequest -UseBasicParsing -Uri $Uri -Method Head -ErrorAction Stop
            }
        Catch
            {
            Write-Warning "Error connecting to git"
            if ($_.Exception.Response.StatusCode -match "Forbidden")
                {
                Write-Warning "Status inidicates that Connection Limit is exceeded"
                }
            exit
            }
        [datetime]$latest_OnGit = $request.Headers.'Last-Modified'
                Write-Verbose "We have $repo version $latest_local_Git, $latest_OnGit is online !"
                if ($latest_local_Git -lt $latest_OnGit -or $force.IsPresent )
                    {
                    $Updatepath = "$Builddir\Update"
					if (!(Get-Item -Path $Updatepath -ErrorAction SilentlyContinue))
					        {
						    $newDir = New-Item -ItemType Directory -Path "$Updatepath" | out-null
                            }
                    Write-host "We found a newer Version for $repo on Git Dated $($request.Headers.'Last-Modified')"
                    if ($delete.IsPresent)
                        {
                        Write-Verbose "Cleaning $Destination"
                        Remove-Item -Path $Destination -Recurse -ErrorAction SilentlyContinue
                        }
                    Get-LABHttpFile -SourceURL $Zip -TarGetFile "$Builddir\update\$repo-$branch.zip" -ignoresize
                    Expand-LABZip -zipfilename "$Builddir\update\$repo-$branch.zip" -destination $Destination -Folder $repo-$branch
                    $Isnew = $true
                    $request.Headers.'Last-Modified' | Set-Content ($Builddir+"\$repo-$branch.gitver") 
                    }
                else 
                    {
                    Status "No update required for $repo on $branch, already newest version "                    
                    }
return $Isnew
}

function Receive-LABBitsFile
{ 
param ([string]$DownLoadUrl,
        [string]$destination )
$ReturnCode = $True
if (!(Test-Path $Destination))
    {
        Try 
        {
        if (!(Test-Path (Split-Path $destination)))
            {
            New-Item -ItemType Directory  -Path (Split-Path $destination) -Force
            }
        Write-verbose "Starting Download of $DownLoadUrl"
        Start-BitsTransfer -Source $DownLoadUrl -Destination $destination -DisplayName "Getting $destination" -Priority Foreground -Description "From $DownLoadUrl..." -ErrorVariable err 
                If ($err) {Throw ""} 

        } 
        Catch 
        { 
            $ReturnCode = $False 
            Write-Warning " - An error occurred downloading `'$FileName`'" 
            Write-Error $_ 
        }
    }
    else
    {
    write-Warning "No download needed, file exists" 
    }
    return $ReturnCode 
}

function Receive-LABNetworker
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
    [ValidateSet('nw90.DA','nw9001','nw9002',
    'nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw821',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw82',
    'nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw813',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw812',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw81',
    'nw81044','nw8043','nw8042','nw8041',
    'nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw80',
    'nwunknown')]
    $nw_ver,
    [ValidateSet(
    'aixpower',
    'hpux11_64',
    'hpux11_ia64',
    'linux_ia64',
    'linux_ppc64',
    'linux_x86',
    'linux_x86_64',
    'linux_s390',
    'macosx',
    'solaris_64',
    'solaris_am64',
    'solaris_x86',
    'win_x64',
    'win_x86'
    )][string]$arch="win_x64",

    [String]$Destination,
    [switch]$unzip,
    [switch]$force
    )
        
if (!(Test-Path $Destination))
    {
    Try
        {
        $NewDirectory = New-Item -ItemType Directory $Destination -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory"
        break
        }
    }
Write-Warning "Receive Request for $NW_ver in $Destination"
if ($nw_ver -notin ('nw822','nw821','nw82'))
    {
    $nwdotver = $nw_ver -replace "nw",""
    $nwdotver = $nwdotver.insert(1,'.')
    $nwdotver = $nwdotver.insert(3,'.')
    $nwdotver = $nwdotver.insert(5,'.') 
    [System.Version]$nwversion = $nwdotver
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Verbose "Requested Networker Version is:"
        $nwversion
        }
    Write-Verbose "NW Dot Ver $nwdotver"
    $nwzip = "$($nwversion.Major)$($nwversion.Minor)"
    switch ($nwzip)
        {
        "80"
            {
            if ($nwversion.Build -in (1,2))
                {
                $nwzip = "$($nwzip)sp$($nwversion.Build)"
                }
            if ($nwversion.Build -gt (2))
                {
                $nwzip = "$($nwzip)$($nwversion.Build)"
                }
            }
        "81"
            {
            if ($nwversion.Build -eq (3))
                {
                $nwzip = "$($nwzip)sp$($nwversion.Build)"
                }
            if ($nwversion.Build -in (1,2))
                {
                $nwzip = "$($nwzip)$($nwversion.Build)"
                }
            }
         "82"
            {
            if ($nwversion.Build -ne (0))
                {
                $nwzip = "$($nwzip)$($nwversion.Build)"
                }
            }


        }
    Switch ($arch)
        {
            {($_ -match "mac")}
                {
                if ($($nwversion.Minor) -lt 1)
                    { 
                    $extension = "tar.gz"
                    }
                else
                    {
                    $extension = "dmg"
                    $unzip = $false
                    }
                }

            {($_ -match "win")}
                {
                $extension = "zip"
                }
            default
                {
                $extension = "tar.gz"
                $unzip = $false
                }
        }
         
    $nwzip = "nw$($nwzip)_$arch.$Extension"
    Write-Verbose "nwzip for ftp: $nwzip"
    $url = "ftp://ftp.legato.com/pub/NetWorker/Cumulative_Hotfixes/$($nwdotver.Substring(0,3))/$nwversion/$nwzip"
    if ($url)
        {
            # $FileName = Split-Path -Leaf -Path $Url
        $FileName = "$($nw_ver)_$arch.$extension"
        $Zipfilename = Join-Path $Destination $FileName
        Write-Verbose $Zipfilename
        $Destinationdir = Join-Path $Destination $nw_ver
        if (!(test-path $Zipfilename ) -or $force.IsPresent)
            {
            Write-Verbose "$FileName not found, trying to download from $url"
            if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                {
                Write-Verbose "Press any Key to start Download"
                pause
                }

            if (!( Get-LABFTPFile -Source $URL -Target $Zipfilename -Defaultcredentials))
                { 
                write-warning "Error Downloading file $Url, 
                $url might not exist.
                Please check connectivity or download manually"
                break
                }
            }
        else
            {
            Write-Warning "Networker $NW_ver already on $Destination, try -force to overwrite"
            }
        if ($unzip)
            {
            Write-Verbose $Zipfilename     
            Expand-LABZip -zipfilename "$Zipfilename" -destination "$Destinationdir"
            }
        
        }
    }
    else
        {
        Write-Warning "We can only autodownload Cumulative Updates from ftp, please get $nw_ver from support.emc.com"
        break
        }
    return $nwversion

    }

function Receive-LABSysCtrInstallers
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('SC2012_R2','SCTP3','SCTP4')]$SC_Version,
    [Parameter(Mandatory = $true)][ValidateSet('SCOM','SCVMM','SCO','SCDPM','ConfigMGR','SCAC')]$Component,
    [Parameter(Mandatory = $true)][String]$Destination,
    [String]$Product_Dir= "SysCtr",
    [String]$Prereq = "prereq",
    [switch]$unzip,
    [switch]$force
)
    Try
        {
        $Product_Dir = Join-Path $Destination "$Product_Dir\$SC_Version"
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }    
    
    
    Write-Verbose "SCDIR : $Product_Dir"
if (!(Test-Path $Product_Dir)
)    {
    Try
        {
        Write-Verbose "Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
    }
try 
     {
     $Prereq_Dir = Join-Path $Destination $Prereq -ErrorAction stop
     }
catch
     {
     Write-Warning "error finding Destination Directory !"
     }
Write-Warning "Entering $SC_Version Prereq Section for $Component in $Prereq_Dir"
#$SCVMM_DIR = "SC$($SC_Version)_$($Component)"
#############
$Component_Dir = $Product_Dir
if ($Component -match 'SCVMM')
    {
    $DownloadUrls= (
            "http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
            "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SqlCmdLnUtils.msi",
            "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/sqlncli.msi"
            )
    
    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Verbose "Testing $FileName in $Prereq_Dir"
    if (!(test-path  "$Prereq_Dir\$FileName"))
        {
        Write-Verbose "Trying Download"
        if (!(receive-LABBitsFile -DownLoadUrl $URL -destination  "$Prereq_Dir\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            exit
            }
        }
    }

switch ($SC_Version)
    {
        "SC2012_R2"
            {
            $adkurl = "http://download.microsoft.com/download/6/A/E/6AEA92B0-A412-4622-983E-5B305D2EBE56/adk/adksetup.exe" # ADKSETUP 8.1
            $URL = "http://care.dlservice.microsoft.com/dl/download/evalx/sc2012r2/SC2012_R2_SCVMM.exe"
            $WAIK_VER = "WAIK_8.1"
            }
        "SCTP4"
            {
            $adkurl = "http://download.microsoft.com/download/8/1/9/8197FEB9-FABE-48FD-A537-7D8709586715/adk/adksetup.exe" #ADKsetup 10
            $URL = "http://care.dlservice.microsoft.com/dl/download/7/0/A/70A7A007-ABCA-42E5-9C82-79CB98B7855E/SCTP4_SCVMM_EN.exe"
            $WAIK_VER = "WAIK_10"
            }
        "SCTP3"
            {
            $adkurl = "http://download.microsoft.com/download/8/1/9/8197FEB9-FABE-48FD-A537-7D8709586715/adk/adksetup.exe" #ADKsetup 10
            $URL = "http://care.dlservice.microsoft.com/dl/download/F/A/A/FAA14AC2-720A-4B17-8250-75EEEA13B259/SCTP3_SCVMM_EN.exe"
            $WAIK_VER = "WAIK_10"
            }
    }# end switch
    Write-Verbose "Testing $WAIK_VER in $Destination"
    $WAIK_DIR = Join-Path $Destination $WAIK_VER
    if (!(test-path  "$WAIK_DIR"))
        {
        New-Item -ItemType Directory $WAIK_DIR -Force | Out-Null
        }
    $FileName = Split-Path -Leaf -Path $adkurl
    if (!(test-path  "$WAIK_DIR\Installers"))
        {
        # New-Item -ItemType Directory -Path "$Destination\$Prereqdir\WAIK" -Force | Out-Null
        Write-Verbose "Trying Download of $WAIK_VER"
        if (!(receive-LABBitsFile -DownLoadUrl $adkurl -destination  "$WAIK_DIR\$FileName"))
            { 
            write-warning "Error Downloading file $adkurl, Please check connectivity"
            exit
            }
        Write-Warning "Getting WAIK, Could take a While"
        Start-Process -FilePath "$WAIK_DIR\$FileName" -ArgumentList "/quiet /layout $WAIK_DIR\" -Wait
        }
    } # end SCVMM
if ($Component -match 'SCOM')
    {
    Write-Verbose "We are now going to Test $Component Prereqs"
            $DownloadUrls= (
            'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi',
            'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
            )
    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Verbose "Testing $FileName in $Prereq_Dir"
    if (!(test-path  "$Prereq_Dir\$FileName")) 
        {
        Write-Verbose "Trying Download"
        if (!(receive-LABBitsFile -DownLoadUrl $URL -destination  "$Prereq_Dir\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            $return = $False
            break
            }
        }
    }
    switch ($SC_Version)
        {
        "SC2012_R2"
            {
            $SCOM_VER = "$($SC_Version)_$($Component)"
            $URL = "http://care.dlservice.microsoft.com/dl/download/evalx/sc2012r2/$SCOM_VER.exe"
            }
        
        "SCTP3"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/B/0/7/B07BF90E-2CC8-4538-A7D2-83BB074C49F5/SCTP3_SCOM_EN.exe"
            }

        "SCTP4"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/3/3/3/333022FC-3BB1-4406-8572-ED07950151D4/SCTP4_SCOM_EN.exe"
            }
        }    
}#end scom
if ($Component -match 'SCDPM')
    {
    <#Write-Verbose "We are now going to Test $Component Prereqs"
         #   $DownloadUrls= (
          #  'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi',
            'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
            )
    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Verbose "Testing $FileName in $Prereq_Dir"
    if (!(test-path  "$Prereq_Dir\$FileName")) 
        {
        Write-Verbose "Trying Download"
        if (!(receive-LABBitsFile -DownLoadUrl $URL -destination  "$Prereq_Dir\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            $return = $False
            break
            }
        }
    }#>
    switch ($SC_Version)
        {
        "SC2012_R2"
            {
            $SCOM_VER = "$($SC_Version)_$($Component)"
            $URL = "http://care.dlservice.microsoft.com/dl/download/evalx/sc2012r2/SC2012_R2_SCDPM_EVAL.zip"
            }
        
        "SCTP3"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/B/B/3/BB3A1E87-28F2-4362-9B1E-24CC3992EF3B/SCTP3_SCSM_EN.exe"
            }

        "SCTP4"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/A/D/E/ADECA4CB-2E75-48AF-8FE8-A892531C7AD7/SCTP4_SCDPM_EN.exe"
            }
        }    
}#end scom
    $FileName = Split-Path -Leaf -Path $Url
    Write-Verbose "Testing $SC_Version"
    if (!(test-path  "$Product_Dir\$FileName") -or $force.IsPresent) 
        {
        Write-Verbose "Trying Download of $Filename"
        if (!(receive-LABBitsFile -DownLoadUrl $URL -destination  "$Product_Dir\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            return $False
            }
        Unblock-File -Path "$Product_Dir\$FileName"
        }
        if ($unzip.IsPresent) 
            {
            if ((Test-Path "$Product_Dir\$Component\Setup.exe") -and !$force.IsPresent)
                { 
                Write-Warning "setup.exe already exists, overwrite with -force"
                return $true
                }
            else
                {
                write-host "We are going to Extract $FileName, this may take a while"
                Start-Process "$Product_Dir\$FileName" -ArgumentList "/SP- /dir=$Product_Dir\$Component /SILENT" -Wait
                $return = $true
                }
            }
return $return
}

function Receive-LABExchange
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
    [Parameter(ParameterSetName = "E16",Mandatory = $true)][switch][alias('e16')]$Exchange2016,
    [Parameter(ParameterSetName = "E16", Mandatory = $false)]
    [ValidateSet('final')]$e16_cu = 'final',
    [Parameter(ParameterSetName = "E15",Mandatory = $true)][switch][alias('e15')]$Exchange2013,
    [Parameter(ParameterSetName = "E15", Mandatory = $false)]
    [ValidateSet('cu1', 'cu2', 'cu3', 'sp1','cu5','cu6','cu7','cu8','cu9','cu10')]$e15_cu,
    [String]$Destination,
    [String]$Product_Dir= "Exchange",
    [String]$Prereq = "prereq",
    [switch]$unzip,
    [switch]$force
)
    $Product_Dir = Join-Path $Destination $Product_Dir
    Write-Verbose "EXDIR : $Product_Dir"
if (!(Test-Path $Product_Dir)
)    {
    Try
        {
        Write-Verbose "Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
    }
$Prereq_Dir = Join-Path $Destination $Prereq

  #############
if ($Exchange2016)
    {    
    $ex_cu = $e16_cu
    $ex_version = "E2016"
    $Product_Dir = Join-Path $Product_Dir $ex_version
    Write-Verbose "We are now going to Test $EX_Version Prereqs"
    $DownloadUrls = (
		        "http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
                "http://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe"
                )
    if (Test-Path -Path "$Prereq_Dir")
        {
        Write-Verbose "$Prereq_Dir Found"
        }
        else
        {
        Write-Verbose "Creating Sourcedir for Prereqs"
        New-Item -ItemType Directory -Path $Prereq_Dir -Force | Out-Null
        }


    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$Prereq_Dir\$FileName"))
            {
            Write-Verbose "$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Prereq_Dir\$FileName"))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
            else
                {
                Write-Host -ForegroundColor Magenta  "found $Filename in $Prereq_Dir"
                }
        }

    switch ($e16_cu)
        {
        'final'
            {
            $URL = "http://download.microsoft.com/download/3/9/B/39B8DDA8-509C-4B9E-BCE9-4CD8CDC9A7DA/Exchange2016-x64.exe"
            }

        }
    }
if ($Exchange2013)
    {
    $ex_cu = $e15_cu
    $ex_version = "E2013"
    $Product_Dir = Join-Path $Product_Dir $ex_version
    Write-Verbose "We are now going to Test $EX_Version Prereqs"
    $DownloadUrls = (
		        "http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
                "http://download.microsoft.com/download/A/A/3/AA345161-18B8-45AE-8DC8-DA6387264CB9/filterpack2010sp1-kb2460041-x64-fullfile-en-us.exe",
                "http://download.microsoft.com/download/0/A/2/0A28BBFA-CBFA-4C03-A739-30CCA5E21659/FilterPack64bit.exe",
                "http://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe",
                "http://download.microsoft.com/download/6/2/D/62DFA722-A628-4CF7-A789-D93E17653111/ExchangeMapiCdo.EXE"
                )
    if (Test-Path -Path "$Prereq_Dir")
        {
        Write-Verbose "$Prereq_Dir Found"
        }
        else
        {
        Write-Verbose "Creating Sourcedir for $EX_Version Prereqs"
        New-Item -ItemType Directory -Path $Prereq_Dir -Force | Out-Null
        }
    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$Prereq_Dir\$FileName"))
            {
            Write-Verbose "$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Prereq_Dir\$FileName"))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Magenta  "found $Filename in $Prereq_Dir"
            }
        }
    Write-Verbose "Testing $Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"      
    if (!(test-path  "$Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"))
        {
        Write-Verbose "Extracting MAPICDO"
        Start-Process -FilePath "$Prereq_Dir\ExchangeMapiCdo.EXE" -ArgumentList "/x:$Prereq_Dir /q" -Wait
        }


    Switch ($ex_cu)
        {
        "CU1"
            {
            $URL = "http://download.microsoft.com/download/5/4/7/547784D7-2954-4BEE-AFD6-B4D11232DF82/Exchange-x64.exe"
            }
        "CU2"
            {
            $URL = "http://download.microsoft.com/download/A/F/C/AFC84463-E1CB-4C55-B012-AEC5927EEAA8/Exchange2013-KB2859928-x64-v2.exe"
            }
        "CU3"
            {
            $URL = "http://download.microsoft.com/download/3/2/2/3226085F-1B33-4899-8DEA-26E5E60D77BD/Exchange2013-x64-cu3.exe"
            }
        "SP1"
            {
            $URL = "http://download.microsoft.com/download/8/4/9/8494E4ED-8FA8-40CA-9E89-B9317995AD7E/Exchange2013-x64-SP1.exe"
            }
        "CU5"
            {
            $URL = "http://download.microsoft.com/download/F/E/5/FE5F57FF-A897-4A5B-8F47-00341B7BA8EE/Exchange2013-x64-cu5.exe"
            }
        "CU6"
            {
            $URL = "http://download.microsoft.com/download/C/D/0/CD08800B-0DF9-4A9F-9870-5A4CC6D8A261/Exchange2013-x64-cu6.exe"
            }
        "CU7"
            {
            $URL = "http://download.microsoft.com/download/F/1/8/F1855E0B-1B90-4E5B-B64E-B5B564D67637/Exchange2013-x64-cu7.exe"
            }
        "CU8"
            {
            $url = "http://download.microsoft.com/download/0/5/2/05265E88-F7E2-4386-8811-9071BAA1FD64/Exchange2013-x64-cu8.exe"
            }
        "CU9"
            {
            $url = "http://download.microsoft.com/download/C/6/8/C6899C99-F933-4181-9692-17A5BB7F1A4B/Exchange2013-x64-cu9.exe"
            }
        "CU10"
            {
            $url = "https://download.microsoft.com/download/1/D/1/1D15B640-E2BB-4184-BFC5-83BC26ADD689/Exchange2013-x64-cu10.exe"
            }
        }
    }        
        $FileName = Split-Path -Leaf -Path $Url
        $Downloadfile = Join-Path $Product_Dir $FileName
        if (!(test-path  $Downloadfile))
            {
            Write-host "we are now Downloading $Product_Dir\$FileName from $url, this may take a while"
            if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                {
                Write-Verbose "Press any Key to continue"
                pause
                }
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Downloadfile))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
            }
        }
        if ($unzip.IsPresent) 
            {
            $EX_CU_PATH = Join-Path $Product_Dir "$ex_version$ex_cu"
            if ((Test-Path "$EX_CU_PATH\Setup.exe") -and !($force.IsPresent))
                { 
                Write-Warning "setup.exe already exists, overwrite with -force"
                return $true
                }
            else
                {
                write-host "We are going to Extract $FileName, this may take a while"
                Start-Process "$Product_Dir\$FileName" -ArgumentList "/extract:$Product_Dir\$ex_version$ex_cu /passive" -Wait
                $return = $true
                }
            }
    return $return
} #end else



function Receive-LABScaleIO
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    $Destination,
    <#
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet('')]
    $sio_ver,
    #>
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
#    'aixpower',
#    'hpux11_64',
#    'hpux11_ia64',
#    'linux_ia64',
#    'linux_ppc64',
#    'linux_x86',
    'linux',
#    'linux_s390',
#    'macosx',
#    'solaris_64',
#    'solaris_am64',
#    'solaris_x86',
    'windows',
    'vmware'
    )]
    [string]$arch="win_x64",
    [switch]$unzip,
    [switch]$force

)
#requires -version 3.0
$Product = 'ScaleIO'
$Destination_path = Join-Path $Destination $Product
if (!(Test-Path $Destination_path))
    {
    Try
        {
        $NewDirectory = New-Item -ItemType Directory $Destination_path -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory"
        break
        }
    }
    write-host -ForegroundColor Magenta  "we will check for the latest ScaleIO version from EMC.com"
    $Uri = "http://www.emc.com/products-solutions/trial-software-download/scaleio.htm"
    $request = Invoke-WebRequest -Uri $Uri -UseBasicParsing
    $DownloadLinks = $request.Links | where href -match $Arch
    foreach ($Link in $DownloadLinks)
        {
        $Url = $link.href
        $FileName = Split-Path -Leaf -Path $Url
        Write-Host -ForegroundColor Magenta "We found $FileName for $Arch on EMC Website"
        $Destination_File = Join-Path $Destination_path $FileName
        if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
            {
            if (!$force.IsPresent)
                {
                $ok = Get-labyesnoabort -title "Start Download" -message "Should we Download $FileName from www.emc.com ?"
                }
            else
                {
                $ok = "0"
                }
            switch ($ok)
                {
                "0"
                    {
                    Write-Verbose "$FileName not found, trying Download"
                    Get-LABHttpFile -SourceURL $URL -TarGetFile "$Destination_File"
                    $Downloadok = $true
                    }
                "1"
                    {
                    break
                    }   
                "2"
                    {
                    Write-Verbose "User requested Abort"
                    exit
                    }
                }
            }
        Else
            {
            Write-Warning "Found $Destination_File, using this one unless -force is specified ! "
            }
        }
        if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
            {
            Expand-LABZip -zipfilename "$Destination_File" -destination "$Destination_path\$arch"
            }
} #end ScaleIO
