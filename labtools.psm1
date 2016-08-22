<#
.Synopsis
   Short description
.DESCRIPTION
   Labtools are common extensions to Labbuildr, used for downlods, checks, environment settings
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
#requires -version 3.0
function Get-LAByesnoabort
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LAByesnoabort",
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
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDefaultGateway")]
	param (    
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DefaultGateway,
    [Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml"
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.DefaultGateway = $DefaultGateway
    Write-Host -ForegroundColor Gray " ==>setting Default Gateway $DefaultGateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABDNS1
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDNS1")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DNS1
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.DNS1 = $DNS1
    Write-Host -ForegroundColor Gray " ==>setting DNS1 $DNS1"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABDNS
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDNS1")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $False,Position = 1)][system.net.ipaddress]$DNS1,
    [Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][system.net.ipaddress]$DNS2
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    if ($DNS1)
        {
        $Defaults.DNS1 = $DNS1
        }
    if ($DNS2)
        {
        $Defaults.DNS2 = $DNS2
        }
    Write-Host -ForegroundColor Gray " ==>setting DNS"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABvmnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABvmnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet9','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19')]$VMnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.vmnet = $VMnet
    Write-Host -ForegroundColor Gray " ==>setting LABVMnet $VMnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABVlanID
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABvlanid")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateRange(0,4096)]$vlanID
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.vlanID = $vlanID
    Write-Host -ForegroundColor Gray " ==>setting LABVMnet $VMnet"
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
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABvmnet")]
	param (
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('vmnet0','vmnet1','vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet8')]$VMnet, #','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19'
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 2)][String]$hvswitch,
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile=".\Switchdefaults.xml"

    )
    if (!(Test-Path $SwitchDefaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile
    }
    $SwitchDefaults = Get-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile
    $SwitchDefaults.$($vmnet) = $hvswitch
    Write-Host -ForegroundColor Gray " ==>setting $VMnet 2 $hvswitch"
    Save-LABSwitchdefaults -SwitchDefaultsfile $SwitchDefaultsfile -SwitchDefaults $SwitchDefaults
}

function Set-LABGateway
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABGateway")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Gateway = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $Gateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABNoDomainCheck
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABNoDomainCheck")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.NoDomainCheck = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $NoDomainCheck"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABpuppet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.puppet = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $puppet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABPuppetMaster
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppetMaster")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('puppetlabs-release-7-11', 'PuppetEnterprise')]$PuppetMaster = "PuppetEnterprise"
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.puppetmaster = $PuppetMaster
    Write-Host -ForegroundColor Gray " ==>setting $puppetMaster"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}
function Set-LABLanguageTag
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABLanguageTag")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('de_DE','en_US')]$LanguageTag = "en_US"
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.LanguageTag = $LanguageTag
    Write-Host -ForegroundColor Gray " ==>setting $LanguageTag"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}


function Set-LABnmm
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABnmm")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$NMM
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.NMM = $NMM.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting NMM to $($NMM.IsPresent)"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABsubnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABsubnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$subnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Mysubnet = $subnet
    Write-Host -ForegroundColor Gray " ==>setting subnet $subnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABHostKey
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABHostKey")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$HostKey
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.HostKey = $HostKey
    Write-Host -ForegroundColor Gray " ==>setting HostKey $HostKey"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABBuilddomain
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABBuilddomain")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateLength(1,63)][ValidatePattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,63}[a-zA-Z0-9]+$")][string]$BuildDomain
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.builddomain = $builddomain.ToLower()
    Write-Host -ForegroundColor Gray " ==>setting builddomain $($builddomain.ToLower())"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABCustomDomainSuffix
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABCustom_DomainSuffix")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateLength(1,63)]
	#"^[a-zA-Z0-9][a-zA-Z0-9-]{1,63}[a-zA-Z0-9]+$")][string]
	$Custom_DomainSuffix
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Custom_DomainSuffix = $Custom_DomainSuffix.ToLower()
    Write-Host -ForegroundColor Gray " ==>setting Custom_DomainSuffix $($Custom_DomainSuffix.ToLower())"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}
function Set-LABSources
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABSources")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [ValidateLength(3,256)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$Sourcedir
    )   
    try
        {
        Get-Item -Path $_ -ErrorAction Stop | Out-Null 
        }
    catch
        [System.Management.Automation.DriveNotfoundException] 
        {
        Write-Warning "Drive not found, make sure to have your Source Stick connected"
        exit
        }
    catch #[System.Management.Automation.ItemNotfoundException]
        {
        Write-Warning "no sources directory found, trying to create"
        New-Item -ItemType Directory -Path $Sourcedir -Force| Out-Null
        }

    if (!(Test-Path $Sourcedir)){exit} 

    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.sourcedir = $Sourcedir
    Write-Host -ForegroundColor Gray " ==>setting Sourcedir $Sourcedir"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}

function Set-LABMasterpath
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABMaster")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml",
    [ValidateLength(3,200)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)] 
    $Masterpath
    )
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
        write-warning "no Master directory found, creating now"
        New-Item -ItemType Directory -Path $Masterpath -Force | Out-Null
        }
    if (!(Test-Path $Masterpath))
        {
        exit
        }
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Defaults = Get-LABdefaults -Defaultsfile $Defaultsfile
    $Defaults.Masterpath = $Masterpath
    Write-Host -ForegroundColor Gray " ==>setting Masterpath $Masterpath"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Defaults
}



function Get-LABSIOConfig
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\scaleioenv.xml"
    )
begin {
    }
process 
{
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Defaults does not exist. please create with New-LABdefaults or set any parameter with Set-LABxxx"
    }
    else
        {

        Write-Host -ForegroundColor Gray " ==>loading defaults from $Defaultsfile"
        [xml]$Default = Get-Content -Path $Defaultsfile
        $object = New-Object psobject
	    $object | Add-Member -MemberType NoteProperty -Name mdm_ipa -Value $Default.scaleio.sio_mdm_ipa
        $object | Add-Member -MemberType NoteProperty -Name mdm_ipb -Value $Default.scaleio.sio_mdm_ipb
        $object | Add-Member -MemberType NoteProperty -Name gateway_ip -value  $Default.scaleio.sio_gateway_ip
        $object | Add-Member -MemberType NoteProperty -Name system_name -Value $Default.scaleio.sio_system_name
        $object | Add-Member -MemberType NoteProperty -Name pool_name -Value $Default.scaleio.sio_pool_name
        $object | Add-Member -MemberType NoteProperty -Name pd_name -Value $Default.scaleio.sio_pd_name
        Write-Output $object
        }
    }
end {
    }
}


function Get-LABDefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile=".\defaults.xml"
    )
begin {
    }
process 
{
    if (!(Test-Path $Defaultsfile))
    {
        Write-Warning "Defaults does not exist. please create with New-LABdefaults or set any parameter with Set-LABxxx"
    }
    else
        {

        Write-Host -ForegroundColor Gray " ==>loading defaults from $Defaultsfile"
        [xml]$Default = Get-Content -Path $Defaultsfile
        $object = New-Object psobject
	    $object | Add-Member -MemberType NoteProperty -Name LanguageTag -Value $Default.config.LanguageTag
	    $object | Add-Member -MemberType NoteProperty -Name Master -Value $Default.config.master
        $object | Add-Member -MemberType NoteProperty -Name ScaleIOVer -Value $Default.config.scaleiover
        $object | Add-Member -MemberType NoteProperty -Name BuildDomain -Value $Default.config.Builddomain
        $object | Add-Member -MemberType NoteProperty -Name Custom_DomainSuffix  -Value $Default.config.Custom_DomainSuffix
        $object | Add-Member -MemberType NoteProperty -Name MySubnet -Value $Default.config.MySubnet
        $object | Add-Member -MemberType NoteProperty -Name vmnet -Value $Default.config.vmnet
        $object | Add-Member -MemberType NoteProperty -Name vlanID -Value $Default.config.vlanID
        $object | Add-Member -MemberType NoteProperty -Name DefaultGateway -Value $Default.config.DefaultGateway
        $object | Add-Member -MemberType NoteProperty -Name DNS1 -Value $Default.config.DNS1
        $object | Add-Member -MemberType NoteProperty -Name DNS2 -Value $Default.config.DNS2
        $object | Add-Member -MemberType NoteProperty -Name Gateway -Value $Default.config.Gateway
        $object | Add-Member -MemberType NoteProperty -Name AddressFamily -Value $Default.config.AddressFamily
        $object | Add-Member -MemberType NoteProperty -Name IPV6Prefix -Value $Default.Config.IPV6Prefix
        $object | Add-Member -MemberType NoteProperty -Name IPv6PrefixLength -Value $Default.Config.IPV6PrefixLength
        $object | Add-Member -MemberType NoteProperty -Name Sourcedir -Value $Default.Config.Sourcedir
        $object | Add-Member -MemberType NoteProperty -Name SQLVer -Value $Default.config.sqlver
        $object | Add-Member -MemberType NoteProperty -Name e14_ur -Value $Default.config.e14_ur
        $object | Add-Member -MemberType NoteProperty -Name e14_sp -Value $Default.config.e14_sp
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
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABSwitchDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile=".\SwitchDefaults.xml"
    )
begin {
    }
process 
{
    if (!(Test-Path $SwitchDefaultsfile))
    {
        Write-Warning "SwitchDefaults does not exist. please create with New-LABSwitchDefaults or set any parameter with Set-LABxxx"
    }
    else
        {

        Write-Host -ForegroundColor Gray " ==>loading SwitchDefaults from $SwitchDefaultsfile"
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
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Save-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile=".\defaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$Defaults

    )
begin {
    }
process {
        Write-Host -ForegroundColor Gray " ==>saving defaults to $Defaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<LanguageTag>$($Defaults.LanguageTag)</LanguageTag>")
        $xmlcontent += ("<nmm_ver>$($Defaults.nmm_ver)</nmm_ver>")
        $xmlcontent += ("<nmm>$($Defaults.nmm)</nmm>")
        $xmlcontent += ("<nw_ver>$($Defaults.nw_ver)</nw_ver>")
        $xmlcontent += ("<master>$($Defaults.Master)</master>")
        $xmlcontent += ("<sqlver>$($Defaults.SQLVER)</sqlver>")
        $xmlcontent += ("<e14_ur>$($Defaults.e14_ur)</e14_ur>")
        $xmlcontent += ("<e14_sp>$($Defaults.e14_sp)</e14_sp>")
        $xmlcontent += ("<e15_cu>$($Defaults.e15_cu)</e15_cu>")
        $xmlcontent += ("<e16_cu>$($Defaults.e16_cu)</e16_cu>")
        $xmlcontent += ("<vmnet>$($Defaults.VMnet)</vmnet>")
        $xmlcontent += ("<vlanID>$($Defaults.vlanID)</vlanID>")
        $xmlcontent += ("<Custom_DomainSuffix>$($Defaults.Custom_DomainSuffix)</Custom_DomainSuffix>")
        $xmlcontent += ("<BuildDomain>$($Defaults.BuildDomain)</BuildDomain>")
        $xmlcontent += ("<MySubnet>$($Defaults.MySubnet)</MySubnet>")
        $xmlcontent += ("<AddressFamily>$($Defaults.AddressFamily)</AddressFamily>")
        $xmlcontent += ("<IPV6Prefix>$($Defaults.IPV6Prefix)</IPV6Prefix>")
        $xmlcontent += ("<IPv6PrefixLength>$($Defaults.IPv6PrefixLength)</IPv6PrefixLength>")
        $xmlcontent += ("<Gateway>$($Defaults.Gateway)</Gateway>")
        $xmlcontent += ("<DefaultGateway>$($Defaults.DefaultGateway)</DefaultGateway>")
        $xmlcontent += ("<DNS1>$($Defaults.DNS1)</DNS1>")
        $xmlcontent += ("<DNS2>$($Defaults.DNS2)</DNS2>")
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
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Save-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile=".\Switchdefaults.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$SwitchDefaults

    )
begin {
    }
process {
        Write-Host -ForegroundColor Gray " ==>saving defaults to $SwitchDefaultsfile"
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

function Set-LABSIOConfig   
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABsioconfig")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile=".\scaleioenv.xml",
    [Parameter(ParameterSetName = "1", Mandatory = $true)][ipaddress]$mdm_ipa,
    [Parameter(ParameterSetName = "1", Mandatory = $true)][ipaddress]$mdm_ipb,
    [Parameter(ParameterSetName = "1", Mandatory = $true)][ipaddress]$gateway_ip,
    [Parameter(ParameterSetName = "1", Mandatory = $true)][string]$system_name,
    [Parameter(ParameterSetName = "1", Mandatory = $true)][string]$pool_name,
    [Parameter(ParameterSetName = "1", Mandatory = $true)][string]$pd_name
    )
        Write-Host -ForegroundColor Gray " ==>saving defaults to $Defaultsfile"
        #$xmlcontent =@()
        $xmlcontent = "<scaleio>
<sio_mdm_ipa>$mdm_ipa</sio_mdm_ipa>
<sio_mdm_ipb>$mdm_ipb</sio_mdm_ipb>
<sio_gateway_ip>$gateway_ip</sio_gateway_ip>
<sio_system_name>$system_name</sio_system_name>
<sio_pool_name>$pool_name</sio_pool_name>
<sio_pd_name>$pd_name</sio_pd_name>
</scaleio>
"
     $xmlcontent | Set-Content $defaultsfile
     }

function New-LABdefaults   
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/New-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile=".\defaults.xml"
    )
        Write-Host -ForegroundColor Gray " ==>saving defaults to $Defaultsfile"
        $xmlcontent =@()
        $xmlcontent += ("<config>")
        $xmlcontent += ("<LanguageTag</LanguageTag>")
        $xmlcontent += ("<nmm_ver></nmm_ver>")
        $xmlcontent += ("<nmm></nmm>")
        $xmlcontent += ("<nw_ver></nw_ver>")
        $xmlcontent += ("<master></master>")
        $xmlcontent += ("<sqlver></sqlver>")
        $xmlcontent += ("<e14_ur></e14_ur>")
        $xmlcontent += ("<e14_sp></e14_sp>")
        $xmlcontent += ("<e15_cu></e15_cu>")
        $xmlcontent += ("<e16_cu></e16_cu>")
        $xmlcontent += ("<vmnet></vmnet>")
        $xmlcontent += ("<vlanID></vlanID>")
        $xmlcontent += ("<BuildDomain></BuildDomain>")
        $xmlcontent += ("<Custom_DomainSuffix></Custom_DomainSuffix>")
        $xmlcontent += ("<MySubnet></MySubnet>")
        $xmlcontent += ("<AddressFamily></AddressFamily>")
        $xmlcontent += ("<IPV6Prefix></IPV6Prefix>")
        $xmlcontent += ("<IPv6PrefixLength></IPv6PrefixLength>")
        $xmlcontent += ("<Gateway></Gateway>")
        $xmlcontent += ("<DefaultGateway></DefaultGateway>")
        $xmlcontent += ("<DNS1></DNS1>")
        $xmlcontent += ("<DNS2></DNS2>")
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
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/New-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile=".\Switchdefaults.xml"
    )
        Write-Host -ForegroundColor Gray " ==>saving defaults to $SwitchDefaultsfile"
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
    HelpUri = "https://github.com/bottkars/labtools/wiki/Expand-LABZip")]
	param (
        [Parameter(Mandatory = $true, Position = 1)][ValidateScript({ Test-Path -Path $_ -ErrorAction SilentlyContinue })]
        [string]$Archive,
        [string]$destination=$vmxdir,
        [switch]$force
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
        Write-Host -ForegroundColor Gray " ==>extracting $Archive to $destination"
        if (!(test-path  $destination))
            {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
            }
        $Archivefile = Get-ChildItem $Archive
        $command = "x"
        if ($force.ispresent)
            {
			$7zdestination = "-yo"+$destination
            }
        else
            {
			$7zdestination = "-o"+$destination
            }
        .$7za $command $7zdestination $Archivefile.FullName
        switch ($LASTEXITCODE)
            {
            0
                {
                Write-Host -ForegroundColor Gray " ==>Sucess expanding $Archive"
                $object = New-Object psobject
	            $object | Add-Member -MemberType NoteProperty -Name Destination -Value "$Destination"
	            $object | Add-Member -MemberType NoteProperty -Name Archive -Value "$($Archivefile.Name)"
                Write-Output $object
                # return $true
                }
            1
                { 
                Write-Warning "There was an error $LASTEXITCODE"
                return $false
                break
                }
            default
                {
                Write-Host -ForegroundColor Gray " ==>expand exited with code $LASTEXITCODE"
                }
            }
	}
}

function Expand-LABpackage
{
 [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
    HelpUri = "https://github.com/bottkars/labtools/wiki/Expand-LABZip")]
	param (
        [Parameter(Mandatory = $true, Position = 1)][ValidateScript({ Test-Path -Path $_ -ErrorAction SilentlyContinue })]
        [string]$Archive,
        [string]$destination=$vmxdir,
        [switch]$force
        )
	$Origin = $MyInvocation.MyCommand
	if (test-path($Archive))
	{
	$Archivefile = Get-ChildItem $Archive
	switch ($global:vmxtoolkit_type)
		{
		"OSX"
			{
			$extract_Parameter = "-x"
			$extract_destination = $destination
			$Extract_cmd = "$Global:VMware_packer $extract_Parameter $($Archivefile.FullName) $destination"
			}
		"win_x86_64"
			{
			$extract_Parameter = "x"
			if ($force.ispresent)
				{
				$extract_destination = "-yo"+$destination
				}
			else
				{
				$extract_destination = "-o"+$destination
				}
			$Extract_cmd = "$Global:VMware_packer $extract_Parameter $destination $($Archivefile.FullName)"
			}
		}
        Write-Host -ForegroundColor Gray " ==>extracting $Archive to $destination"
        if (!(test-path  $destination))
            {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
            }
        Write-Verbose $Extract_cmd
		pause
		switch ($LASTEXITCODE)
            {
            0
                {
                Write-Host -ForegroundColor Gray " ==>Sucess expanding $Archive"
                $object = New-Object psobject
	            $object | Add-Member -MemberType NoteProperty -Name Destination -Value "$Destination"
	            $object | Add-Member -MemberType NoteProperty -Name Archive -Value "$($Archivefile.Name)"
                Write-Output $object
                # return $true
                }
            1
                { 
                Write-Warning "There was an error $LASTEXITCODE"
                return $false
                break
                }
            default
                {
                Write-Host -ForegroundColor Gray " ==>expand exited with code $LASTEXITCODE"
                }
            }
	}
}

function Expand-LABZip
{
 [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
    HelpUri = "https://github.com/bottkars/labtools/wiki/Expand-LABZip")]
	param (
        #[Parameter(Mandatory = $true, Position = 1)][ValidateScript({ Test-Path -Path $_ -ErrorAction SilentlyContinue })]
        [string]$zipfilename,
        [string]$destination,
        [String]$Folder)
	$copyFlag = 16 # overwrite = yes
	$Origin = $MyInvocation.MyCommand
	if (test-path($zipfilename))
	{
    If ($Folder)
        {
        $zipfilename = Join-Path $zipfilename $Folder
        }
    		
        Write-Host -ForegroundColor Gray " ==>extracting $zipfilename to $destination"
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
[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABFTPfile")]
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
    Write-Error "Error downlaoding $Source"
    return
    }
Write-Verbose $ftpresponse.WelcomeMessage
Write-Host -ForegroundColor Gray " ==>Filesize: $($ftpresponse.ContentLength)"
 
# Get a download stream from the server response 
$responsestream = $ftpresponse.GetResponseStream() 
 
# create the tarGet file on the local system and the download buffer 
$tarGetfile = New-Object IO.FileStream ($TarGet,[IO.FileMode]::Create) 
[byte[]]$readbuffer = New-Object byte[] 1024 
Write-Host -ForegroundColor Gray " ==>Downloading $Source via ftp" 
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
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Enable-LABFolders
.EXAMPLE

#>
#requires -version 3
function Enable-LABfolders
    {
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Enable-Labfolders")]
    param()
    Get-vmx | where state -match running  | Set-VMXSharedFolderState -Enabled
    }
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Get-LABScenario

#>
#requires -version 3
function Get-LABscenario
    {
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABScenario")]
    param()
    Get-VMX | Get-vmxscenario | Sort-Object Scenarioname | ft -AutoSize
    }
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Start-LABScenario
.EXAMPLE

#>
#requires -version 3
function Start-LABScenario
    {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/labtools/wiki/Start-LABscenario")]
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
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Stop-LABScenario
.EXAMPLE

#>
#requires -version 3
function Stop-LABScenario
    {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/labtools/wiki/Stop-LABSscenario")]
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
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Start-LABPC
.EXAMPLE

#>
#requires -version 3
function Start-LABPC
   {
    [cmdletbinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Start-LABPC")]
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
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABHttpFile
.EXAMPLE

#>
#requires -version 3
function Get-LABHttpFile
 {
    [CmdletBinding(DefaultParametersetName = "1",
    HelpUri = "https://github.com/bottkars/labtools/wiki/GET-LABHttpFile")]
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
 <#
.Synopsis
   Short description
.DESCRIPTION
   Receive-LABnetworker receives all versions of networker client and server from legato´s ftp. see Get-help Receive-LABnetworker -online for details
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABjava64
.EXAMPLE

#>
#requires -version 3              
function Receive-LABjava64
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Receive-LABjava64")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$DownloadDir=$vmxdir
    )
    Write-Host -ForegroundColor Gray " ==>Asking for latest Java"
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
    Write-Host -ForegroundColor Gray " ==>Analyzing response Stream"
    $Link = $javaparse.Links | Where-Object outerText -Match "Windows Offline \(64-Bit\)" | Select-Object href
    If ($Link)
        {
        $latest_java8uri = $link.href
        Write-Host -ForegroundColor Gray " ==>$($link.href)"
        $Headers = Invoke-WebRequest  $Link.href -UseBasicParsing -Method Head
        $File =  $Headers.BaseResponse | Select-Object responseUri
        $Length = $Headers.Headers.'Content-Length'
        $Latest_java8 = split-path -leaf $File.ResponseUri.AbsolutePath

		if (!$Latest_java8)
			{
			Write-Warning "Could not retrieve latest java, please download manually"
			break
			}
        Write-Host -ForegroundColor Gray " ==>we found $latest_java8 online"
        if (!(Test-Path "$DownloadDir\$Latest_java8"))
            {
            Write-Host -ForegroundColor Gray " ==>Downloading $Latest_java8"
            Try
                {
                Receive-LABBitsFile -DownLoadUrl $latest_java8uri -destination "$DownloadDir\$latest_java8" 
                #Invoke-WebRequest "$latest_java8uri" -OutFile "$DownloadDir\$latest_java8" -TimeoutSec 60
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
            Write-Host -ForegroundColor Gray "$Latest_java8 already exists in $DownloadDir"
            }
            $object = New-Object psobject
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8 -Value $Latest_java8
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8File -Value (Join-Path $DownloadDir $Latest_java8)
            Write-Output $object
        }
    }
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Update-LABfromGit
.EXAMPLE

#>
#requires -version 3
function Update-LABfromGit
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
        Write-Host -ForegroundColor Gray " ==>Using update-fromgit function for $repo"
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
                Write-Host -ForegroundColor Gray " ==>we have $repo version $latest_local_Git, $latest_OnGit is online !"
                if ($latest_local_Git -lt $latest_OnGit -or $force.IsPresent )
                    {
                    $Updatepath = "$Builddir\Update"
					if (!(Get-Item -Path $Updatepath -ErrorAction SilentlyContinue))
					        {
						    $newDir = New-Item -ItemType Directory -Path "$Updatepath" | out-null
                            }
                    Write-Host -ForegroundColor Gray  " ==>found a newer Version for $repo on Git Dated $($request.Headers.'Last-Modified')"
                    if ($delete.IsPresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Cleaning $Destination"
                        Remove-Item -Path $Destination -Recurse -ErrorAction SilentlyContinue
                        }
                    Get-LABHttpFile -SourceURL $Zip -TarGetFile "$Builddir\update\$repo-$branch.zip" -ignoresize
                    Expand-LABZip -zipfilename "$Builddir\update\$repo-$branch.zip" -destination $Destination -Folder $repo-$branch
                    $Isnew = $true
                    $request.Headers.'Last-Modified' | Set-Content ($Builddir+"\$repo-$branch.gitver") 
                    }
                else 
                    {
                    Write-Host -ForegroundColor Gray " ==>No update required for $repo on $branch, already newest version "                    
                    }
return $Isnew
}
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABBitsFile
.EXAMPLE

#>
#requires -version 3
function Receive-LABBitsFile
{
    [CmdletBinding(SupportsShouldProcess=$true,
        ConfirmImpact='None' )]
	[OutputType([psobject])]
param ([string]$DownLoadUrl,
        [string]$destination )
$ReturnCode = $True
if (!(Test-Path $Destination ) -or ($Global:vmxtoolkit_type -match  "OSX"))
    {
	switch ($global:vmxtoolkit_type)
		{
		default
			{
			Try 
				{
				if (!(Test-Path (Split-Path $destination)))
					{
					New-Item -ItemType Directory  -Path (Split-Path $destination) -Force
					}
				Write-Host -ForegroundColor Gray " ==>Starting Download of $DownLoadUrl to $destination"
				Start-BitsTransfer -Source $DownLoadUrl -Destination $destination -DisplayName "Getting $destination" -Priority Foreground -Description "From $DownLoadUrl..." -ErrorVariable err -Confirm:$false
				If ($err) {Throw ""} 
				} 
			Catch 
				{ 
				$ReturnCode = $False 
				Write-Error " - An error occurred  downloading `'$FileName`'" 
				#Write-Error $_ 
				break
				}
			}
		"OSX"
			{
			$CurlArgs = "-o"
			$Curl = '/usr/bin/curl'
			Write-Host " ==>$global:vmxtoolkit_type, need trying start-process $Curl -ArgumentList `"$CurlArgs $destination $DownLoadUrl`" -Wait -NoNewWindow"
			Start-Process "/usr/bin/curl" -ArgumentList "$CurlArgs $destination $DownLoadUrl" -Wait -NoNewWindow
			}			
		}
    }
else
    {
    Write-Host -ForegroundColor Gray " ==>No download needed, file exists" 
    }
    return $ReturnCode 
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Receive-LABnetworker receives all versions of networker client and server from legato´s ftp. see Get-help Receive-LABnetworker -online for details
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABnetworker 
.EXAMPLE
#>
#requires -version 3
function Receive-LABNetworker
{
[CmdletBinding(DefaultParametersetName = "installer",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	<#
	Version Of Networker Server / Client to be installed
    'nw9010','nw9011',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
    'nw8232','nw8231',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw821',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw82',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw813',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw812',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw81',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw80',
    'nwunknown'
#>

    [Parameter(ParameterSetName = "installer",Mandatory = $true)][ValidateSet(
    'nw9010','nw9011',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
    'nw8232','nw8231',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw821',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw82',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw813',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw812',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw81',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw80',
    'nwunknown'
    )]
    $nw_ver,
    [Parameter(ParameterSetName = "nve",Mandatory = $true)][switch]$nve,
    [Parameter(ParameterSetName = "nve",Mandatory = $true)][ValidateSet(
    '9.0.1-72')]$nve_ver,
	<#
	architecture to be downloaded, valid values are
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
	#>
    [Parameter(ParameterSetName = "installer",Mandatory = $true)]
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
    )]
    [string]$arch="win_x64",
    [Parameter(ParameterSetName = "nve",Mandatory = $true)]
    [Parameter(ParameterSetName = "installer",Mandatory = $true)]
    [String]$Destination,
    [Parameter(ParameterSetName = "installer",Mandatory = $false)]
    [switch]$unzip,
    [Parameter(ParameterSetName = "nve",Mandatory = $false)]
    [Parameter(ParameterSetName = "installer",Mandatory = $false)]
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
switch ($PsCmdlet.ParameterSetName)
    {
    "nve"
        {
        switch ($nve_ver)
            {
            "9.0.1-72"
                {
                $url ="ftp://ftp.legato.com/pub/eval/2016Q2/NVE-9.0.1.72.ova"
                $FileName = Split-Path -Leaf $url
                $Destination_Filename = Join-Path $Destination $FileName
                if (!(test-path $Destination_Filename ) -or $force.IsPresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>$FileName not found  locally, trying to download from $url"
                    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Press any Key to start Download"
                        pause
                        }

                    if (!( Get-LABFTPFile -Source $URL -Target $Destination_Filename -Defaultcredentials -ErrorAction SilentlyContinue))
                        { 
                        write-warning "Error Downloading $file from $Url, 
                        $url might not exist."
                        }
                    }
                }
            }
        }
    "installer"
        {
        Write-Host -ForegroundColor Gray " ==>Receive Request for $NW_ver in $Destination"
        if ($nw_ver -notin ('nw822','nw821','nw82'))
            {
            $nwdotver = $nw_ver -replace "nw",""
            $nwdotver = $nwdotver.insert(1,'.')
            $nwdotver = $nwdotver.insert(3,'.')
            $nwdotver = $nwdotver.insert(5,'.')
            [System.Version]$nwversion = $nwdotver 
            Write-Host -ForegroundColor Gray " ==>NW Dot Ver $nwdotver"
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
				"90"
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
            switch ($nw_ver)
                {
                "nw9010"
                    {
                    $nwzip = "nw901_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2016Q2/$nwzip"
                    }
                default
                    {
                    $url = "ftp://ftp.legato.com/pub/NetWorker/Cumulative_Hotfixes/$($nwdotver.Substring(0,3))/$nwversion/$nwzip"
                    }
                }
            Write-Host -ForegroundColor Gray " ==>nwzip for ftp: $nwzip"
            if ($url)
                {
                $FileName = "$($nw_ver)_$arch.$extension"
                $Zipfilename = Join-Path $Destination $FileName
                Write-Verbose $Zipfilename
                $Destinationdir = Join-Path $Destination $nw_ver
                if (!(test-path $Zipfilename ) -or $force.IsPresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download from $url"
                    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Press any Key to start Download"
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
                    Write-Host -ForegroundColor Gray "Networker $NW_ver already on $Destination, try -force to overwrite"
                    }
                if ($unzip)
                    {
                    Write-Verbose $Zipfilename     
                    Expand-LABZip -zipfilename "$Zipfilename" -destination "$Destinationdir"
                    }
               if ($nwversion.Major -ge 9)
                    { 
                    $Readme = "Readmefile.txt"
                    }
                else
                    {
                    $Readme = "Readme.txt"
                    }
                Write-Host -ForegroundColor Magenta "trying download of Readme"
                $URL = "ftp://ftp.legato.com/pub/NetWorker/Cumulative_Hotfixes/$($nwdotver.Substring(0,3))/$nwversion/Cumulative_$($nwdotver.Substring(0,3))_$Readme"
                $FileName = Split-Path -Leaf $url
                $Destination_Filename = Join-Path $Destinationdir $FileName
                if (!(test-path $Destination_Filename ) -or $force.IsPresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>Readme $FileName not found, trying to download from $url"
                    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Press any Key to start Download"
                        pause
                        }

                    if (!( Get-LABFTPFile -Source $URL -Target $Destination_Filename -Defaultcredentials -ErrorAction SilentlyContinue))
                        { 
                        write-warning "Error Downloading Readme $Url, 
                        $url might not exist."
                        }
                    }

                }
            }
        else
            {
            Write-Warning "We can only autodownload Cumulative Updates from ftp, please get $nw_ver from support.emc.com"
            return
            }
        Write-Output $nwversion
        }
    }
}
<#
.DESCRIPTION
   receives specific Networker Modules for Microsoft from EMC Legato FTP Site
   https://github.com/bottkars/labtools/wiki/Receive-LABnmm
.EXAMPLE

#>
#requires -version 3
function Receive-LABnmm
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	<#
	'nmm9010','nmm9011',#
    'nmm90.DA','nmm9001','nmm9002','nmm9003','nmm9004','nmm9005','nmm9006','nmm9007','nmm9008',
    'nmm8231','nmm8232',  
    'nmm8221','nmm8222','nmm8223','nmm8224','nmm8225',
    'nmm8218','nmm8217','nmm8216','nmm8214','nmm8212','nmm821'
	#>
    [ValidateSet(
    'nmm9010','nmm9011',#
    'nmm90.DA','nmm9001','nmm9002','nmm9003','nmm9004','nmm9005','nmm9006','nmm9007','nmm9008',
    'nmm8231','nmm8232',  
    'nmm8221','nmm8222','nmm8223','nmm8224','nmm8225',
    'nmm8218','nmm8217','nmm8216','nmm8214','nmm8212','nmm821'
    )]
    $nmm_ver,
    [String]$Destination,
    [switch]$unzip,
    [switch]$force
    )
$nmm_scvmm_ver = $nmm_ver -replace "nmm","scvmm"
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
Write-Host -ForegroundColor Gray " ==>Receive Request for $NMM_ver in $Destination"
        $URLS = ""
        # if ($nmm_ver -notin ('nmm822','nmm821','nmm82','nmm90.DA','nmm9001') -and 
if ($nmm_ver -gt 'nmm_82')
    {
    $nmmdotver = $nmm_ver -replace "nmm",""
    $nmmdotver = $nmmdotver.insert(1,'.')
    $nmmdotver = $nmmdotver.insert(3,'.')
    $nmmdotver = $nmmdotver.insert(5,'.')
    [System.Version]$nmmversion = $nmmdotver
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Gray " ==>Requested Networker Version is:"
        $nmmversion
        }
    Write-Host -ForegroundColor Gray " ==>NMM Dot Ver $nmmdotver"
    $nmm_family = "$($nmmversion.Major)$($nmmversion.Minor)$($nmmversion.Build)"
    switch ($nmm_family)
        {
        "901"
            {
			if ($nmm_ver -eq "nmm9010")
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/eval/2016Q2/$nmm_zip",
					"ftp://ftp.legato.com/pub/eval/2016Q2/$scvmm_zip")
				}
			else
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
					"ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
				}
            }
        "900"
            {
            $nmm_zip = "nmm$($nmmversion.Major)$($nmmversion.Minor)_win_x64.zip"
            $SCVMM_zip = "scvmm$($nmmversion.Major)$($nmmversion.Minor)_win_x64.zip"
            $urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
                "ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
            }
        default
            {
            $nmm_zip = "nmm$($nmm_family)_win_x64.zip"
            $SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
            $urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
                "ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
            }
        }
    Write-Host -ForegroundColor Gray " ==>SVCMM Zip Version : $SCVMM_zip"
    Write-Host -ForegroundColor Gray " ==>NMM Zip Version : $nmm_zip"
    }
if ($urls)
    {
    foreach ($url in $urls)
        {
        Write-Verbose $url
        $FileName = Split-Path -Leaf -Path $Url
        if ($FileName -match "nmm")
            {
            $Zipfilename = "$nmm_ver.zip"
            }
        if ($FileName -match "scvmm")
            {
            $Zipfilename = "$NMM_scvmm_ver.zip"
            }
        $Zipfile = Join-Path $Destination $Zipfilename
        Write-Verbose $Zipfile
        if (!(test-path  $Zipfile ) -or $force.IsPresent)
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download from $url"
            if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                {
                Write-Host -ForegroundColor Gray " ==>Press any Key to start Download"
                pause
                }

        if (!( Get-LABFTPFile -Source $URL -Target $Zipfile -verbose -Defaultcredentials))
            { 
            write-warning "Error Downloading file $Url, 
            $url might not exist.
            Please check connectivity or download manually"
            break
            }
    }
        else
            {
            Write-Host -ForegroundColor Gray "Networker $Zipfilename already on $Destination, try -force to overwrite"
            }
        $Destinationdir =  "$($Zipfile.replace(".zip"," "))"
        Write-Verbose $Destinationdir
        if ($unzip)
            {
            Write-Verbose $Zipfilename     
            Expand-LABZip -zipfilename "$Zipfile" -destination "$Destinationdir" -verbose
            }
        }
    }
}
<#
.Synopsis

.DESCRIPTION
  retrieves system center eval versions along with prerequirements
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABSysCtrInstallers
.EXAMPLE
#>
#requires -version 3
function Receive-LABSysCtrInstallers
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('SC2012_R2','SCTP3','SCTP4','SCTP5')]
    $SC_VERSION = "SC2012_R2",
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
    
    
    Write-Host -ForegroundColor Gray " ==>SCDIR : $Product_Dir"
if (!(Test-Path $Product_Dir)
)    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Product_Dir"
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
Write-Host -ForegroundColor Gray " ==>Entering $SC_Version Prereq Section for $Component in $Prereq_Dir"
#$SCVMM_DIR = "SC$($SC_Version)_$($Component)"
#############
$Component_Dir = $Product_Dir
if ($Component -match 'SCVMM')
    {
    $DownloadUrls= (
            #"http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
            "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SqlCmdLnUtils.msi",
            "http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/sqlncli.msi"
            )
    
    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $Prereq_Dir"
    if (!(test-path  "$Prereq_Dir\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>Trying Download"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$Prereq_Dir\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            exit
            }
        }
    }
Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 452   

switch ($SC_Version)
    {
        "SC2012_R2"
            {
            $adkurl = "http://download.microsoft.com/download/6/A/E/6AEA92B0-A412-4622-983E-5B305D2EBE56/adk/adksetup.exe" # ADKSETUP 8.1
            $URL = "http://care.dlservice.microsoft.com/dl/download/evalx/sc2012r2/SC2012_R2_SCVMM.exe"
            $WAIK_VER = "WAIK_8.1"
            }
        "SCTP5"
            {
            $adkurl = "http://download.microsoft.com/download/8/1/9/8197FEB9-FABE-48FD-A537-7D8709586715/adk/adksetup.exe" #ADKsetup 10
            $url = "http://care.dlservice.microsoft.com/dl/download/F/E/6/FE60EBEB-EE0F-4457-951D-E89A4175F229/SCTP5_SCVMM_EN.exe"
            $WAIK_VER = "WAIK_10"
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
    Write-Host -ForegroundColor Gray " ==>Testing $WAIK_VER in $Destination"
    $WAIK_DIR = Join-Path $Destination $WAIK_VER
    if (!(test-path  "$WAIK_DIR"))
        {
        New-Item -ItemType Directory $WAIK_DIR -Force | Out-Null
        }
    $FileName = Split-Path -Leaf -Path $adkurl
    if (!(test-path  "$WAIK_DIR\Installers"))
        {
        # New-Item -ItemType Directory -Path "$Destination\$Prereqdir\WAIK" -Force | Out-Null
        Write-Host -ForegroundColor Gray " ==>Trying Download of $WAIK_VER"
        if (!(Receive-LABBitsFile -DownLoadUrl $adkurl -destination "$WAIK_DIR\$FileName"))
            { 
            write-warning "Error Downloading file $adkurl, Please check connectivity"
            exit
            }
        Write-Host -ForegroundColor Gray " ==>Getting WAIK, Could take a While, please do not kill process adksetup !"
        Write-Host -ForegroundColor Gray "Install Tree will be in $WAIK_DIR"
        Start-Process -FilePath "$WAIK_DIR\$FileName" -ArgumentList "/quiet /layout $WAIK_DIR" -Wait -WindowStyle Normal -PassThru
        }
    } # end SCVMM
if ($Component -match 'SCOM')
    {
    Write-Host -ForegroundColor Gray " ==>we are now going to test $Component prereqs"
            $DownloadUrls= (
            'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi',
            'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
            )
    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $Prereq_Dir"
    if (!(test-path  "$Prereq_Dir\$FileName")) 
        {
        Write-Host -ForegroundColor Gray " ==>Trying Download"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$Prereq_Dir\$FileName"))
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
        "SCTP5"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/2/A/F/2AF219F5-37CB-4901-80D1-EED797ABDF6A/SCTP5_SCOM_EN.exe"
            }

        }    
}#end scom
if ($Component -match 'SCDPM')
    {
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
        "SCTP5"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/8/B/7/8B75A31B-48E9-463C-9E1E-53FD5BFAD0F1/SCTP5_SCDPM_EN.exe"
            }        
        }    
}#end scdpm
    $FileName = Split-Path -Leaf -Path $Url
    Write-Host -ForegroundColor Gray " ==>Testing $SC_Version"
    if (!(test-path  "$Product_Dir\$FileName") -or $force.IsPresent) 
        {
        Write-Host -ForegroundColor Gray " ==>Getting $SC_Version $FileName, Could take a While"

        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$Product_Dir\$FileName"))
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
                Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
                Start-Process "$Product_Dir\$FileName" -ArgumentList "/SP- /dir=$Product_Dir\$Component /SILENT" -Wait
                $return = $true
                }
            }
return $return
}
<#
.DESCRIPTION
   receives latest Exchange Versions from Microsoft by Give CU / SP
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABExchange
.EXAMPLE

#>
#requires -version 3
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
    [ValidateSet('final','cu1','cu2')]
    $e16_cu,
    [Parameter(ParameterSetName = "E15",Mandatory = $true)][switch][alias('e15')]$Exchange2013,
    [Parameter(ParameterSetName = "E15", Mandatory = $false)]
    [ValidateSet('cu1', 'cu2', 'cu3', 'sp1','cu5','cu6','cu7','cu8','cu9','cu10','cu11','cu12','cu13')]
    $e15_cu,
    [Parameter(ParameterSetName = "E14",Mandatory = $true)][switch][alias('e14')]$Exchange2010,
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('ur1','ur2','ur3','ur4','ur5','ur6','ur7','ur8v2','ur9','ur10','ur11','ur12','ur13')]
    $e14_ur = "ur13",
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('sp3')]
    $e14_sp="sp3",
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('de_DE')]
    $e14_lang = "de_DE",
    [Parameter(Mandatory = $true)][String]$Destination,
    [String]$Product_Dir= "Exchange",
    [String]$Prereq = "prereq",
    [switch]$unzip,
    [switch]$force
)
    $Product_Dir = Join-Path $Destination $Product_Dir
    Write-Host -ForegroundColor Gray " ==>destination : $Product_Dir"
if (!(Test-Path $Product_Dir))    
    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
}
    $Prereq_Dir = Join-Path $Destination $Prereq
    Write-Host -ForegroundColor Gray " ==>prereq = $Prereq_Dir"
    if (Test-Path -Path "$Prereq_Dir")
        {
        Write-Host -ForegroundColor Gray " ==>$Prereq_Dir found"
        }
    else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for $EX_Version Prereqs"
        New-Item -ItemType Directory -Path $Prereq_Dir -Force | Out-Null
        }

#############
if ($Exchange2016)
    {    
    $ex_cu = $e16_cu
    $ex_version = "E2016"
    $Product_Dir = Join-Path $Product_Dir $ex_version
    Write-Host -ForegroundColor Gray " ==>we are now going to test $EX_Version prereqs"
    $DownloadUrls = (
		       #"http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
                "http://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe"
                )
    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$Prereq_Dir\$FileName"))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Prereq_Dir\$FileName"))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Prereq_Dir"
            }
        }
    Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 452   
    switch ($e16_cu)
        {
        'final'
            {
            $URL = "http://download.microsoft.com/download/3/9/B/39B8DDA8-509C-4B9E-BCE9-4CD8CDC9A7DA/Exchange2016-x64.exe"
            }
        'CU1'
            {
            $URL = "https://download.microsoft.com/download/6/4/8/648EB83C-00F9-49B2-806D-E46033DA4AE6/ExchangeServer2016-CU1.iso"
            }
        'CU2'
            {
            $URL = "https://download.microsoft.com/download/C/6/C/C6C10C1B-EFD8-4AE7-AEE1-C04F45869F5D/ExchangeServer2016-x64-CU2.iso"
            }
        }
    }
if ($Exchange2013)
    {
    $ex_cu = $e15_cu
    $ex_version = "E2013"
    $Product_Dir = Join-Path $Product_Dir $ex_version
    Write-Host -ForegroundColor Gray " ==>we are now going to test $EX_Version prereqs"
    $DownloadUrls = (
		        #"http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
                "http://download.microsoft.com/download/A/A/3/AA345161-18B8-45AE-8DC8-DA6387264CB9/filterpack2010sp1-kb2460041-x64-fullfile-en-us.exe",
                "http://download.microsoft.com/download/0/A/2/0A28BBFA-CBFA-4C03-A739-30CCA5E21659/FilterPack64bit.exe",
                "http://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe",
                "http://download.microsoft.com/download/6/2/D/62DFA722-A628-4CF7-A789-D93E17653111/ExchangeMapiCdo.EXE"
                )

    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$Prereq_Dir\$FileName"))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Prereq_Dir\$FileName"))
                { 
                write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Prereq_Dir"
            }
        }
    Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 452   
    Write-Host -ForegroundColor Gray " ==>Testing $Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"      
    if (!(test-path  "$Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"))
        {
        Write-Host -ForegroundColor Gray " ==>Extracting MAPICDO"
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
        "CU11"
            {
            $url = "https://download.microsoft.com/download/A/A/B/AAB18934-BC8F-429D-8912-6A98CBC96B07/Exchange2013-x64-cu11.exe"
            }
        "CU12"
            {
            $url = "https://download.microsoft.com/download/2/C/1/2C151059-9B2A-466B-8220-5AE8B829489B/Exchange2013-x64-cu12.exe"
            }
        "CU13"
            {
            $url = "https://download.microsoft.com/download/7/4/9/74981C3B-0D3C-4068-8272-22358F78305F/Exchange2013-x64-cu13.exe"
            }
        }
    } 
If ($Exchange2010)
    {
    $ex_cu = $e14_sp
    $LANG_Prereq_Dir = Join-Path $Prereq_Dir $e14_lang
    $ex_version = "E2010"
    $Product_Dir = Join-Path $Product_Dir "$ex_version"
    Write-Host -ForegroundColor Gray " ==>we are now going to test $EX_Version prereqs"
    $DownloadUrls = (
                'http://download.microsoft.com/download/6/2/D/62DFA722-A628-4CF7-A789-D93E17653111/ExchangeMapiCdo.EXE',
                'https://download.microsoft.com/download/D/F/F/DFFB3570-3264-4E01-BB9B-0EFDA4F9354F/UcmaRuntimeSetup.exe',
                'https://download.microsoft.com/download/0/1/3/0131A8C8-001B-4448-9DD8-62C98D862560/filterpack2010sp1-kb2460041-x64-fullfile-de-de.exe',
                'https://download.microsoft.com/download/D/1/2/D12F3512-6BED-4D5B-919A-DDD42C41F839/FilterPack64bit.exe'
                )
    if (Test-Path -Path "$LANG_$Prereq_Dir")
        {
        Write-Host -ForegroundColor Gray " ==>$LANG_Prereq_Dir found"
        }
        else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for $E14_EX_Version Prereqs"
        New-Item -ItemType Directory -Path $LANG_Prereq_Dir -Force | Out-Null
        }
    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$LANG_Prereq_Dir\$FileName"))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$LANG_Prereq_Dir\$FileName"))
                { 
                write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $LANG_Prereq_Dir"
            }
        }
    Write-Host -ForegroundColor Gray " ==>Testing $LANG_Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"      
    if (!(test-path  "$LANG_Prereq_Dir\ExchangeMapiCdo\ExchangeMapiCdo.msi"))
        {
        Write-Host -ForegroundColor Gray " ==>Extracting MAPICDO"
        Start-Process -FilePath "$LANG_Prereq_Dir\ExchangeMapiCdo.EXE" -ArgumentList "/x:$LANG_Prereq_Dir /q" -Wait
        }

#"https://download.microsoft.com/download/D/E/9/DE977823-1438-46F2-BFD4-14B3B630D165/Exchange2010-KB3141339-x64-de.msp"
    Switch ($e14_ur)
        {
        'ur1'
            {
            $de_DE_URL = "https://download.microsoft.com/download/D/7/B/D7BD4C5C-BBA5-49A9-8FE4-430D9C4F42AE/Exchange2010-KB2803727-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/0/6/F/06FC58CA-94AE-4AC9-996B-52FF08B9DEA1/Exchange2010-KB2803727-x64-en.msp"
            }
        'ur2'
            {
            $de_DE_URL = "https://download.microsoft.com/download/3/B/9/3B9A60A1-2567-432A-AA7C-80592064702D/Exchange2010-KB2866475-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/E/E/A/EEA9BF1A-6996-4EDA-B0F6-C87F7CF46342/Exchange2010-KB2866475-x64-en.msp"
            }
        'ur3'
            {
            $de_DE_URL = "https://download.microsoft.com/download/6/A/5/6A5FEC21-58F4-4F94-83CF-ACAEA0B51804/Exchange2010-KB2891587-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/5/F/1/5F14A1C9-0B16-4811-BD13-CC7C9FDC5636/Exchange2010-KB2891587-x64-en.msp"
            }
        'ur4'
            {
            $de_DE_URL = "https://download.microsoft.com/download/2/5/9/259753E2-7C34-4678-A392-898FD79B67DB/Exchange2010-KB2905616-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/8/F/0/8F0F7879-B343-4CE8-95F4-647FC344AC45/Exchange2010-KB2905616-x64-en.msp"
            }
        'ur5'
            {
            $de_DE_URL = "https://download.microsoft.com/download/8/4/1/841E559B-33AE-4A91-9FF9-D8E9CF8E95A7/Exchange2010-KB2917508-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/C/B/E/CBE0481B-DA9D-4B80-AE62-93B438A620BB/Exchange2010-KB2917508-x64-en.msp"
            }
        'ur6'
            {
            $de_DE_URL = "https://download.microsoft.com/download/1/F/2/1F25992D-D7CB-4EE0-8E0D-29E5406D85AF/Exchange2010-KB2936871-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/1/7/2/1729F8A5-0B67-4543-A965-08A6F46F5587/Exchange2010-KB2936871-x64-en.msp"
            }
        'ur7'
            {
            $de_DE_URL = "https://download.microsoft.com/download/F/4/9/F49FA0F2-116B-4C7D-875D-B8E0D01EDE1E/Exchange2010-KB2961522-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/8/9/8/8985C71F-4251-47D6-BED4-6796F6EE34AA/Exchange2010-KB2961522-x64-en.msp"
            }
        'ur8v2'
            {
            $de_DE_URL = "https://download.microsoft.com/download/A/2/5/A25F765E-6D74-439A-B6F2-6435D7879F49/Exchange2010-KB2986475-v2-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/B/1/0/B102A2CD-9E03-4C01-A0EE-9CB3C9A1F00F/Exchange2010-KB2986475-v2-x64-en.msp"
            }
        'ur9'
            {
            $de_DE_URL = "https://download.microsoft.com/download/A/7/6/A76EA3C0-630F-458D-B415-BB57FBA2FADE/Exchange2010-KB3030085-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/3/D/C/3DC697AD-F886-4345-9097-4B3A04232296/Exchange2010-KB3030085-x64-en.msp"
            }
        'ur10'
            {
            $de_DE_URL = "https://download.microsoft.com/download/D/F/3/DF377207-8851-46C7-B051-A5B4FB9A0F43/Exchange2010-KB3049853-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/0/6/7/06782A49-43BC-4C49-98C3-059B3455D12A/Exchange2010-KB3049853-x64-en.msp"
            }
        'ur11'
            {
            $de_DE_URL = "https://download.microsoft.com/download/B/8/3/B83BACD6-1062-43A5-B175-55B2E3D36242/Exchange2010-KB3078674-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/4/9/3/4939D546-D91D-4E15-A8E4-D9829B9F4FCE/Exchange2010-KB3078674-x64-en.msp"
            }
        'ur12'
            {
            $de_DE_URL = "https://download.microsoft.com/download/2/9/A/29A37BD7-7CB8-4A79-BB88-E426BB1BAF22/Exchange2010-KB3096066-x64-de.msp" 
            $en_US_URL = "https://download.microsoft.com/download/D/A/1/DA15AF48-E5EB-4D3A-805A-699C27969E9F/Exchange2010-KB3096066-x64-en.msp"
            }
        'ur13'
            {
            $de_DE_URL = "https://download.microsoft.com/download/D/E/9/DE977823-1438-46F2-BFD4-14B3B630D165/Exchange2010-KB3141339-x64-de.msp"
            $en_US_URL = 'https://download.microsoft.com/download/D/C/2/DC2AE92F-80DA-45B0-8046-5E4110324509/Exchange2010-KB3141339-x64-en.msp'
            }
        }
    Switch ($e14_lang)
        {
        "de_DE"
            {
            $URL = $de_DE_URL
            }
        "en_US"
            {
            $URL = $en_US_URL
            }
        }
        if ($URL)
            {
            $FileName = Split-Path -Leaf -Path $Url
            $UR_Download_Path = join-path $Product_Dir $e14_ur
            $Downloadfile = Join-Path $UR_Download_Path $FileName
            if (!(test-path  $Downloadfile))
                {
                Write-Host -ForegroundColor Gray " ==>we are now downloading $Product_Dir\$FileName from $url, this may take a while"
                if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>Press any Key to continue"
                    pause
                    }
                if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Downloadfile))
                    { 
                    write-warning "Error Downloading file $Url, Please check connectivity"
                    exit
                    }
                }
            }
    Switch ($e14_sp)
        {
        "SP3"
            {
            $URL = "https://download.microsoft.com/download/3/0/3/30383778-FB6F-429A-9F65-AF1FE57D7017/Exchange2010-SP3-x64.exe"
            }
        }
    } 
        $FileName = Split-Path -Leaf -Path $Url
        $Downloadfile = Join-Path $Product_Dir $FileName
        if (!(test-path  $Downloadfile))
            {
            Write-Host -ForegroundColor Gray " ==>we are now Downloading $Product_Dir\$FileName from $url, this may take a while"
            if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
                {
                Write-Host -ForegroundColor Gray " ==>Press any Key to continue"
                pause
                }
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Downloadfile))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
            }
        }
        if ($unzip.IsPresent -and $Filename.Contains(".exe")) 
            {
            $EX_CU_PATH = Join-Path $Product_Dir "$ex_version$ex_cu"
            Write-Verbose $EX_CU_PATH
            if ((Test-Path "$EX_CU_PATH\Setup.exe") -and (!$force.IsPresent))
                { 
                Write-Host -ForegroundColor Gray "setup.exe already exists, overwrite with -force"
                return $true
                }
            else
                {
                Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
                Start-Process "$Product_Dir\$FileName" -ArgumentList "/extract:$Product_Dir\$ex_version$ex_cu /passive" -Wait
                $return = $true
                }
            }
            elseif ($Filename.Contains(".iso"))
                { 
                Write-Host -ForegroundColor Gray " ==>no unzip required, CU delivered as ISO"
                $return = $true
                }
    return $return
} 
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABScaleIO
.EXAMPLE

#>
#requires -version 3
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
    'Windows',
    'VMware',
    'all'
    )]
    [string]$arch="win_x64",
    [switch]$unzip,
    [switch]$force

)
#requires -version 3.0
if ($arch -eq 'all')
    {
    $myarch = @('VMware','Windows','Linux')
    }
else
    {
    $myarch = @($arch)
    }
$Product = 'ScaleIO'
$Destination_path = Join-Path $Destination "$Product"
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
    write-host -ForegroundColor Gray " ==>we will check for the latest ScaleIO version from EMC.com"
    $Uri = "http://www.emc.com/products-solutions/trial-software-download/scaleio.htm"
    $request = Invoke-WebRequest -Uri $Uri -UseBasicParsing
    foreach ($arch in $MyArch)
    {
    $Extract_Path = Join-Path $Destination_path "ScaleIO_$($Arch)_SW_Download"
    $DownloadLinks = $request.Links | where href -match $arch
    foreach ($Link in $DownloadLinks)
        {
        $Url = $link.href
        $FileName = Split-Path -Leaf -Path $Url
        Write-Host -ForegroundColor Gray  " ==>found $FileName for $Arch on EMC Website"
        $Destination_File = Join-Path $Destination_path $FileName
        if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
            {
            if (!$force.IsPresent)
                {
                $ok = Get-LAByesnoabort -title "Start Download" -message " ==>should we download $FileName from www.emc.com ?"
                }
            else
                {
                $ok = "0"
                }
            switch ($ok)
                {
                "0"
                    {
                    Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
                    Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
                    $Downloadok = $true
                    }
                "1"
                    {
                    break
                    }   
                "2"
                    {
                    Write-Host -ForegroundColor Gray " ==>User requested Abort"
                    exit
                    }
                }
            }
        Else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Destination_File, using this one unless -force is specified ! "
            }
        }
        if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
            {
            Expand-LABZip -zipfilename "$Destination_File" -destination "$Extract_Path"
            }
        }
} #end ScaleIO

<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABIsilon
.EXAMPLE
#>
#requires -version 3
function Receive-LABISIlon
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    $Destination,
    [switch]$unzip,
    [switch]$force

)
$Product = 'ISILON'
$Destination_path = Join-Path $Destination "$Product"
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
write-host -ForegroundColor Magenta  "we will check for the latest $Product version from EMC.com"
$Uri = "http://www.emc.com/products-solutions/trial-software-download/isilon.htm"
$request = Invoke-WebRequest -Uri $Uri -UseBasicParsing
$Link = $request.Links | where OuterHTML -Match Onefs_simulator
$Url = $link.href
try
    {
    $FileName = Split-Path -Leaf -Path $Url
    }
catch
    {
    Write-Warning "could not extraxt filename from downlod page.
    Maybe links changed, please report on https://github.com/bottkars/labtools/issues for $($MyInvocation.MyCommand)
    including the text below:
    $($_.Exception.Message) "
        Break
    }
Write-Host -ForegroundColor Gray  " ==>found $FileName for $Product at EMC Website"
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    if (!$force.IsPresent)
        {
        $ok = Get-LAByesnoabort -title "Start Download" -message " ==>should we download $FileName from www.emc.com ?"
        }
    else
        {
        $ok = "0"
        }
    switch ($ok)
        {
        "0"
            {
            Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
            Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
            $Downloadok = $true
            }
        "1"
            {
            break
            }   
        "2"
            {
            Write-Host -ForegroundColor Gray " ==>User requested Abort"
            exit
            }
        }
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File, using this one unless -force is specified ! "
    }

if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
    {
    Expand-LABZip -zipfilename "$Destination_File" -destination "$Destination_path"
    }
} #end ISI

<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABAppSync
.EXAMPLE

#>
#requires -version 3
function Receive-LABAppSync
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    $Destination,
    [switch]$unzip,
    [switch]$force

)
$Product = 'appsync'
$Destination_path = Join-Path $Destination "$Product"
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
write-host -ForegroundColor Magenta  "we will check for the latest $Product version from EMC.com"
$Uri = "http://www.emc.com/products-solutions/trial-software-download/appsync-download-page.htm"
$request = Invoke-WebRequest -Uri $Uri -UseBasicParsing
$Link = $request.Links | where OuterHTML -Match "appsync-software-download.htm" | Select-Object -First 1
$Url = "https://www.emc.com/$($link.href)"
try
    {
    $FileName = Split-Path -Leaf -Path $Url
    }
catch
    {
    Write-Warning "could not extraxt filename from downlod page.
    Maybe links changed, please report on https://github.com/bottkars/labtools/issues for $($MyInvocation.MyCommand)
    including the text below:
    $($_.Exception.Message) "
        Break
    }
Write-Host -ForegroundColor Gray  " ==>found $FileName for $Product at EMC Website"
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    if (!$force.IsPresent)
        {
        $ok = Get-LAByesnoabort -title "Start Download" -message " ==>should we download $FileName from www.emc.com ?"
        }
    else
        {
        $ok = "0"
        }
    switch ($ok)
        {
        "0"
            {
            Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
            Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
            $Downloadok = $true
            }
        "1"
            {
            break
            }   
        "2"
            {
            Write-Host -ForegroundColor Gray " ==>User requested Abort"
            exit
            }
        }
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File, using this one unless -force is specified ! "
    }

if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
    {
    Expand-LABZip -zipfilename "$Destination_File" -destination "$Destination_path"
    }
} #end ISI

function Receive-LABECScli
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet('2.2.1')]
    $ECS_ver = "2.2.1"
    #[switch]$force

)
#requires -version 3.0
$Product = 'ecscli'
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
switch ($ECS_ver)
    {
    '2.2.1'
        {
        $url = "https://community.emc.com/servlet/JiveServlet/downloadBody/52139-102-3-171387/ecscli_2.2.1.tar.gz"
        }
    }
write-host -ForegroundColor Gray  " ==>we will download ECSCLI $ECS_ver"
$Filename = Split-Path -Leaf $url
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    $DownloadOK = Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File"
    }
Write-Output $Filename
} #end ECSCLI

<#
.DESCRIPTION
   receives latest free docker for Windows
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABDocker
.EXAMPLE

#>
#requires -version 3
function Receive-LABDocker
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    <#
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet('')]
    $sio_ver,
    #>
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    '1.12'
    )]
    [string]$ver="1.12",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'win'
    )]
    [string]$arch="win",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'beta','stable'
    )]
    [string]$branch="beta",
	[switch]$force
)
$Product = 'docker'
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

$url = "https://download.docker.com/win/$($branch)/InstallDocker.msi"

write-host -ForegroundColor Gray  " ==>we will download $Product $ver"
$Filename = Split-Path -Leaf $url
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    $DownloadOK = Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File"
    }
Write-Output $Filename
} #end docker

<#
.DESCRIPTION
   receives latest labbuildr OpenWRT
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABOpenWrt
.EXAMPLE

#>
#requires -version 3
function Receive-LABOpenWRT
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    <#
	Version of openwrt for labbuilde
    #>
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    '15_5'
    )]
    [string]$ver="15_5",
    [switch]$unzip
    #[switch]$force

)
$Product = 'OpenWRT'
$Destination_path = $Destination 
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
write-host -ForegroundColor Magenta  "we will check for the latest OpenWRT version from bintray"
$url = "https://bintray.com/artifact/download/bottkars/generic/OpenWRT_$($ver).7z"
$Filename = Split-Path -Leaf $url
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
    $Downloadok = $true
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File"
    }
if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
    {
    Expand-LAB7Zip "$Destination_File"
    Get-vmx "Openwrt_$ver"
    }
} #end OpenWRT

<#
.Synopsis
   Short description
.DESCRIPTION
   receives latest os masters from labbuildr repo on azure
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABMaster
.EXAMPLE

#>
#requires -version 3
function Receive-LABMaster
{
[CmdletBinding(DefaultParametersetName = "vmware",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "vmware", Mandatory = $false)]
    $Destination=".\",
    <#
	Available Masters:
	==================
    '2016TP5','2016TP5_GER',
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE',
	'OpenWRT',
	'Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster'
	#>
	[Parameter(ParameterSetName = "vmware", Mandatory = $true)]
    [ValidateSet(
    '2016TP5','2016TP5_GER',
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE',
	'OpenWRT',
	'Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster'
    )]
    [string]$Master,
    [Parameter(ParameterSetName = "vmware", Mandatory = $false)]
    [ValidateSet('vmware','hyperv','fusion')]
    [string]$mastertype = 'vmware',
    [switch]$unzip
    #[switch]$force

)
$Product = 'Master'
$Destination_path = $Destination 
if (!(Test-Path $Destination_path))
    {
    Try
        {
        $NewDirectory = New-Item -ItemType Directory $Destination_path -ErrorAction Stop -Force -Confirm:$false
        }
    catch
        {
        Write-Warning "Could not create Destination Directory"
        break
        }
    }
write-host -ForegroundColor Magenta  "we will check for the latest $Master $Product version from Azure"
Switch ($mastertype)
    {
    "vmware"
        {
        $Packer = "7z"
        }
    "hyperv"
        {
        $Packer = "zip"
        }
	"fusion"
		{
		$Packer = "rar"
        }
    }

Switch ($Master)
    {
    '2012R2Fall_Ger'
        {
        $URL = "https://labbuildrmaster.blob.core.windows.net/master/2012R2Fall_Ger.$Packer"
        }
    'CentOS7 Master'
        {
        $URL = "https://labbuildrmaster.blob.core.windows.net/master/CentOS7.$Packer"
        }
    "OpenWRT"
        {
        $URL = "https://labbuildrmaster.blob.core.windows.net/master/OpenWRT_15_5.$Packer"
        }
    default
        {
        $URL = "https://labbuildrmaster.blob.core.windows.net/master/$Master.$Packer"
        }    
    }
$Filename = Split-Path -Leaf $url
$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    Write-Verbose $ConfirmPreference
    if ($ConfirmPreference -match "none")
        { 
        $commit = 0 
        }
    else
        {
        $commit = Get-LAByesnoabort -title "confirm master $master download from labbuild repo" -message "master download may take a while"
        }
    Switch ($commit)
        {
            0
            {
            $StopWatch = [System.Diagnostics.Stopwatch]::StartNew()
            try
                {
                Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File" 
                }
            catch
                {
                Write-Error "Error receiving $Destination_File"
                break
                    }
            $StopWatch.Stop()
            Write-host -ForegroundColor White "Master Download took $($StopWatch.Elapsed.ToString())"
            }
            1
            {
            Write-Warning "Download was refused by user"
            break
            }      
        }

    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File"
    }
if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
    {
    Write-Host -ForegroundColor White " ==>Extracting Master $Master, this may take a while"
    Switch ($mastertype)
        {
        "vmware"
            {
            Expand-LAB7Zip "$Destination_File" -destination $Destination
            }
        "hyperv"
            {
            Expand-LABZip -zipfilename $Destination_File -destination $Destination
            }
		"fusion"
			{
			Expand-LABrar -rarfile $Destination_File -destination $Destination
			}
        }
    Return $true
    }
}
<#
.DESCRIPTION
   receives latest trila version of SQL from Microsoft
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABSQL
.EXAMPLE

#>
#requires -version 3 
function Receive-LABSQL
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
    param(
    [ValidateSet('SQL2014SP1slip','SQL2012','SQL2012SP1','SQL2012SP2','SQL2012SP1SLIP','SQL2014','SQL2016','SQL2016_ISO')]$SQLVER,
    [String]$Destination,
    [String]$Product_Dir= "SQL",
    [String]$Prereq = "prereq",
    [switch]$extract,
    [switch]$force
    )
    $SQL2012_inst = "http://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/x64/SQLFULL_x64_ENU_Install.exe"
    $SQL2012_lang = "http://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/x64/SQLFULL_x64_ENU_Lang.box"
    $SQL2012_core = "http://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/x64/SQLFULL_x64_ENU_Core.box"
    $SQL2012_box = "http://download.microsoft.com/download/3/B/D/3BD9DD65-D3E3-43C3-BB50-0ED850A82AD5/SQLServer2012SP1-FullSlipstream-x64-ENU.box"
    $SQL2012SP1SLIP_INST = "http://download.microsoft.com/download/3/B/D/3BD9DD65-D3E3-43C3-BB50-0ED850A82AD5/SQLServer2012SP1-FullSlipstream-x64-ENU.exe"
    $SQL2012SP1SLIP_box= "http://download.microsoft.com/download/3/B/D/3BD9DD65-D3E3-43C3-BB50-0ED850A82AD5/SQLServer2012SP1-FullSlipstream-x64-ENU.box"
    $SQL2012_SP1 = "http://download.microsoft.com/download/3/B/D/3BD9DD65-D3E3-43C3-BB50-0ED850A82AD5/SQLServer2012SP1-KB2674319-x64-ENU.exe"
    $SQL2012_SP2 = "http://download.microsoft.com/download/D/F/7/DF7BEBF9-AA4D-4CFE-B5AE-5C9129D37EFD/SQLServer2012SP2-KB2958429-x64-ENU.exe"
    $SQL2014_ZIP = "http://care.dlservice.microsoft.com/dl/download/evalx/sqlserver2014/x64/SQLServer2014_x64_enus.zip"
    $SQL2014SP1SLIP_INST = "http://care.dlservice.microsoft.com/dl/download/2/F/8/2F8F7165-BB21-4D1E-B5D8-3BD3CE73C77D/SQLServer2014SP1-FullSlipstream-x64-ENU.exe"
    $SQL2014SP1SLIP_box= "http://care.dlservice.microsoft.com/dl/download/2/F/8/2F8F7165-BB21-4D1E-B5D8-3BD3CE73C77D/SQLServer2014SP1-FullSlipstream-x64-ENU.box"
    $SQL2016_ISO = "http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.iso"
    $SQL2016_box = "http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.box"
    $SQL2016_inst = "http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.exe"
    $SQL2016_SSMS = "http://download.microsoft.com/download/E/D/3/ED3B06EC-E4B5-40B3-B861-996B710A540C/SSMS-Setup-ENU.exe"
    $Product_Dir = Join-Path $Destination $Product_Dir
    Write-Host -ForegroundColor Gray " ==>destination: $Product_Dir"
    if (!(Test-Path $Product_Dir))    
    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
    }
    $Prereq_Dir = Join-Path $Destination $Prereq
    Write-Host -ForegroundColor Gray " ==>prereq = $Prereq_Dir"
    Write-Host -ForegroundColor Gray " ==>we are now going to test $SQLVER"
    Switch ($SQLVER)
        {
            "SQL2012"
            {
            $SQL_BASEVER = $SQLVER
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            if (!(Test-Path "$SQL_BASEDir\SQLFULL_x64_ENU\SETUP.EXE"))
                {
                foreach ($url in ($SQL2012_inst,$SQL2012_lang,$SQL2012_core))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDir"
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>Trying Download of $FileName"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                        }
                    }
                If ($Extract.ispresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                    $FileName = Split-Path -Leaf $SQL2012_inst
                    Start-Process "$SQL_BASEDir\$FileName" -ArgumentList "/X /q" -Wait
                    }    
                }

            }
            "SQL2012SP1"
            {
            #Getting SP1
            $url = $SQL2012_SP1
            $FileName = Split-Path -Leaf -Path $Url
            $SQL_BASEVER = "SQL2012"
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            $SQL_VER_DIR = Join-Path $SQL_BASEDir $SQLVER
            $SQL_SPSETUP = Join-Path $SQL_VER_DIR $FileName
            Write-Host -ForegroundColor Gray " ==>Testing SQL Setup $SQL_SPSETUP"
                if (!(test-path  "$SQL_SPSETUP"))
                    {
                    Write-Host -ForegroundColor Gray " ==>Trying Download $FileName"
                    if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $SQL_SPSETUP))
                        { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File $SQL_SPSETUP
                        }
            #first check for 2012
            if (!(Test-Path "$SQL_BASEDir\SQLFULL_x64_ENU\SETUP.EXE"))
                {
                foreach ($url in ($SQL2012_inst,$SQL2012_lang,$SQL2012_core))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDir"
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                        }
                    }
                    If ($Extract.ispresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                        $FileName = Split-Path -Leaf $SQL2012_inst
                        Start-Process "$SQL_BASEDir\$FileName" -ArgumentList "/X /q" -Wait
                        }    
                }

            # end 2012

            }
            "SQL2012SP2"
            {
            #### Getting Sp2
            $url = $SQL2012_SP2
            $FileName = Split-Path -Leaf -Path $Url
            $SQL_BASEVER = "SQL2012"
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            $SQL_VER_DIR = Join-Path $SQL_BASEDir $SQLVER
            $SQL_SPSETUP = Join-Path $SQL_VER_DIR $FileName
            Write-Host -ForegroundColor Gray " ==>Testing SQL Setup $SQL_SPSETUP"
                if (!(test-path  "$SQL_SPSETUP"))
                    {
                    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
                    if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $SQL_SPSETUP))
                        { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File $SQL_SPSETUP                        
                        }
            #first check for 2012
            if (!(Test-Path "$SQL_BASEDir\SQLFULL_x64_ENU\SETUP.EXE"))
                {
                foreach ($url in ($SQL2012_inst,$SQL2012_lang,$SQL2012_core))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDir"
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>Trying Download $FileName"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                        }
                    }
                If ($Extract.ispresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                        $FileName = Split-Path -Leaf $SQL2012_inst
                        Start-Process "$SQL_BASEDir\$FileName" -ArgumentList "/X /q" -Wait
                        }    
                }

            # end 2012


            }
            "SQL2012SP1Slip"
            {
             #### Getting SP1 Slip
            $SQL_BASEVER = "SQL2012"
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            $SQL_VER_DIR = Join-Path $SQL_BASEDir $SQLVER
            $SQL_SPSETUP = Join-Path "$SQL_BASEDir" "$FileName"
            if (!(Test-Path "$SQL_VER_DIR\setup.exe"))
                {
                foreach ($url in ($SQL2012SP1SLIP_box,$SQL2012SP1SLIP_INST))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDIR"
                    if (!(test-path  "$SQL_BASEDIR\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>Trying Download $Filename"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDIR\$FileName"))
                            {  
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                       Unblock-File "$SQL_BASEDir\$FileName"
                       }
                    }
                    If ($Extract.ispresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                        Start-Process $SQL_BASEDIR\$FileName -ArgumentList "/X:$SQL_VER_DIR /q" -Wait
                        }
                    }
                }

            "SQL2014"
            {
            $SQL_BASEVER = $SQLVER
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER

            if (!(Test-Path $SQL_BASEDIR\$SQLVER\setup.exe))
            {
            foreach ($url in ($SQL2014_ZIP))
                {
                $FileName = Split-Path -Leaf -Path $Url
                Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDIR"
                ### Test if the 2014 ENU´s are there
                if (!(test-path  "$SQL_BASEDir\SQLServer2014-x64-ENU.exe"))
                    {
                    ## Test if we already have the ZIP
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            { 
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                    }
                 Expand-LABZip -zipfilename $SQL_BASEDir\$FileName -destination $SQL_BASEDir -Folder ENUS
                 # Remove-Item $SQL_BASEDir\$FileName 
                 # Move-Item $Sourcedir\enus\* $Sourcedir\
                 # Remove-Item $Sourcedir\enus
                 }
                # New-Item -ItemType Directory $Sourcedir\$SQLVER
                if ($extract.IsPresent)
                    {
                    Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                    Start-Process "$SQL_BASEDir\SQLServer2014-x64-ENU.exe" -ArgumentList "/X:$SQL_BASEDir\$SQLVER /q" -Wait
                    } 
                }
            
            }
            }
            "SQL2014SP1slip"
            {
            $SQL_BASEVER = "SQL2014"
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER

            if (!(Test-Path "$SQL_BASEDir\$SQLVER\setup.exe"))
                {
                foreach ($url in ($SQL2014SP1SLIP_box,$SQL2014SP1SLIP_INST))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDir"
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            {  
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit 
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                        }
                    }
                    if ($extract.ispresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                        Start-Process $SQL_BASEDir\$FileName -ArgumentList "/X:$SQL_BASEDir\$SQLVER /q" -Wait
                        }
                }
            }
            "SQL2016"
            {
            $SQL_BASEVER = "SQL2016"
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 461 
            if (!(Test-Path "$SQL_BASEDir\$SQLVER\setup.exe") -or !(Test-Path "$SQL_BASEDir\$SQLVER\ssms*.exe"))
                {
                foreach ($url in ($SQL2016_box,$SQL2016_SSMS,$SQL2016_inst))
                    {
                    $FileName = Split-Path -Leaf -Path $Url
                    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $SQL_BASEDir"
                    if (!(test-path  "$SQL_BASEDir\$FileName"))
                        {
                        Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
                        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                            {  
                            write-warning "Error Downloading file $Url, Please check connectivity"
                            exit 
                            }
                        Unblock-File "$SQL_BASEDir\$FileName"
                        }
                    }
                    if ($extract.ispresent)
                        {
                        Write-Host -ForegroundColor Gray " ==>Creating $SQLVER Installtree, this might take a while"
                        Start-Process $SQL_BASEDir\$FileName -ArgumentList "/X:$SQL_BASEDir\$SQLVER /q" -Wait
                        }
                }
            }

            "SQL2016_ISO"
            {
            $SQL_BASEVER = "SQL2016"
            $url = $SQL2016_ISO
            $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
            $FileName = Split-Path -Leaf $SQL2016_ISO
            if (!(Test-Path "$SQL_BASEDir\$FileName"))
                {
                Write-Host -ForegroundColor Gray " ==>Trying $SQLVER Download"
                if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  "$SQL_BASEDir\$FileName"))
                    {  
                    write-warning "Error Downloading file $Url, Please check connectivity"
                    exit 
                    }
                Unblock-File "$SQL_BASEDir\$FileName"
                }
            }

          } #end switch#
    Write-Host -ForegroundColor Gray " ==>$SQLVER is now available in $SQL_BASEDir"
    return $True
    }
<#
.DESCRIPTION
   receives latest .Net Versions from Microsoft
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABNetFramework
.EXAMPLE

#>
#requires -version 3
function Receive-LABNetFramework
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    '451','452','46','461'
    )]
    [string]$Net_Ver="452"
)

Switch ($Net_Ver)
    {
    '451'
        {
        $Url = "https://download.microsoft.com/download/1/6/7/167F0D79-9317-48AE-AEDB-17120579F8E2/NDP451-KB2858728-x86-x64-AllOS-ENU.exe"
        }
    '452'
        {
        $Url = "http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe"
        }
    '46'
        {
        $Url = "https://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe"
        }
    '461'
        {
        $Url = "https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe"
        }
    }
    if (Test-Path -Path "$Destination")
        {
        Write-Host -ForegroundColor Gray " ==>$Destination found"
        }
        else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for NetFramework Prereqs"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  "$Destination\$FileName"))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
            }
        
    }
<#
.Synopsis
   Short description
.DESCRIPTION
   receives OpenSSL, se get-help rEceive-LabOpenSSL -online for details
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABOpenSSL
.EXAMPLE

#>
#requires -version 3
function Receive-LABOpenSSL
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\"
    #[Parameter(ParameterSetName = "1", Mandatory = $false)]
    #[ValidateSet(
    #)]
    #[#string]$_Ver="452"
)

if (Test-Path -Path "$Destination")
    {
    Write-Host -ForegroundColor Gray " ==>$Destination found"
    }
else
    {
    Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for OpenSSL"
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }
Write-Host -ForegroundColor Gray " ==>Checking for latest OpenSSL light"

$OpenSSL_URL = "https://slproweb.com/products/Win32OpenSSL.html"
try
	{
	$Req = Invoke-WebRequest  -UseBasicParsing -Uri $OpenSSL_URL
	}
catch 
	{
	Write-Host "Error getting OpenSSL"
	$_
	break
	}
try 
	{
	Write-Host -ForegroundColor Gray " ==>Trying to Parse OpenSSL Site $OpenSSL_URL"
	$Parse = $Req.Links | where {$_ -Match "Win64OpenSSL_Light"}
	} 
catch
	{
	Write-Host -ForegroundColor Yellow "Error Parsing"
	$_
	break
	}

$File = ($Parse | Select-Object -First 1).outerHTML
$link = $File.Split('"') | where {$_ -Match "/download"}
$URL = "https://slproweb.com" + $($link)
Write-Verbose " ==>got $URL"
    $FileName = Split-Path -Leaf -Path $Url
    if (!(test-path  "$Destination\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
            { write-warning "Error Downloading file $Url, Please check connectivity"
            exit
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
        }
$Version = $FileName -replace "Win64OpenSSL_Light-"
$Version = $Version -replace ".exe"
$object = New-Object psobject
$object | Add-Member -MemberType NoteProperty -Name Filename -Value $FileName
$object | Add-Member -MemberType NoteProperty -Name Version -Value $Version
Write-Output $object 
}

<#
.Synopsis
   Short description
.DESCRIPTION
   receives Fling, see get-help rEceive-LabFling -online for details
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABFling
.EXAMPLE

#>
#requires -version 3
function Receive-LABFling
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'esxi-embedded-host-client'
	)]
    [string]$FLING="esxi-embedded-host-client"
)

if (Test-Path -Path "$Destination")
    {
    Write-Host -ForegroundColor Gray " ==>$Destination found"
    }
else
    {
    Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for Fling"
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }
Write-Host -ForegroundColor Gray " ==>Checking for latest Fling $FLING"

$Fling_URL = "https://labs.vmware.com/flings/$FLING"
try
	{
	$Req = Invoke-WebRequest  -UseBasicParsing -Uri $Fling_URL
	}
catch 
	{
	Write-Host "Error getting Fling"
	$_
	break
	}
try 
	{
	Write-Host -ForegroundColor Gray " ==>Trying to Parse Fling Site $Fling_URL"
	$Parse = $Req.Links | where href -match esxui-signed-
	} 
catch
	{
	Write-Host -ForegroundColor Yellow "Error Parsing"
	$_
	break
	}

$URL = $Parse.href
Write-Verbose " ==>got $URL"
    $FileName = Split-Path -Leaf -Path $Url
    if (!(test-path  "$Destination\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
            { write-warning "Error Downloading file $Url, Please check connectivity"
            exit
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
        }
$Version = $FileName -replace "esxui-signed-"
$Version = $Version -replace ".vib"
$object = New-Object psobject
$object | Add-Member -MemberType NoteProperty -Name Filename -Value $FileName
$object | Add-Member -MemberType NoteProperty -Name Version -Value $Version
Write-Output $object 
}

<#
.DESCRIPTION
   receives Python for Windows latest / stable
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABPython
.EXAMPLE

#>
#requires -version 3
function Receive-LABPython
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet('2.7','3.5'
    )]
    [string]$Py_Release="2.7"
)
$Product = "Python"
if (Test-Path -Path "$Destination")
    {
    Write-Host -ForegroundColor Gray " ==>$Destination found"
    }
else
    {
    Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for Python"
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }
$Product_Dir = Join-Path $Destination $Product
Write-Host -ForegroundColor Gray " ==>destination : $Product_Dir"
if (!(Test-Path $Product_Dir))    
    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
}

Write-Host -ForegroundColor Gray " ==>Checking for latests Python"

$Python_URL = "https://www.python.org/downloads/windows/"
try
	{
	$Req = Invoke-WebRequest  -UseBasicParsing -Uri $Python_URL
	}
catch 
	{
	Write-Host "Error getting Python"
	$_
	break
	}
try 
	{
	Write-Host -ForegroundColor Gray " ==>Trying to Parse Python on $Python_URL"
	switch ($Py_Release)
		{
		"2.7"
			{
			$Parse = $Req.Links | where {$_ -match "python-$($Py_Release).*.amd64.msi"} # | Sort-Object -Descending |Select-Object -First 1
			}
		"3.5"
			{
			$Parse = $Req.Links | where {$_ -match "python-$($Py_Release).*-amd64.exe"} # | Sort-Object -Descending |Select-Object -First 1
			}
		}
	} 
catch
	{
	Write-Host -ForegroundColor Yellow "Error Parsing"
	$_
	break
	}

$URL= ($Parse | Select-Object -First 1).href
$FileName = Split-Path -Leaf $URL
Write-Verbose " ==>got $URL"
    $FileName = Split-Path -Leaf -Path $Url
    if (!(test-path  "$Product_Dir\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Product_Dir\$FileName"))
            { write-warning "Error Downloading file $Url, Please check connectivity"
            exit
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Product_Dir"
        }
$Version = $FileName -replace "python-"
$Version = $Version -replace ".amd64.msi"
$object = New-Object psobject
$object | Add-Member -MemberType NoteProperty -Name Filename -Value $FileName
$object | Add-Member -MemberType NoteProperty -Name Version -Value $Version
Write-Output $object 
}
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABWinservISO
.EXAMPLE

#>
#requires -version 3
function Receive-LABWinservISO
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
	<#
	Versions:
	'2012R2','2016TP5','2012'
	#>
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    '2012R2','2016TP5','2012'
        )]
    [string]$winserv_ver,
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    'en_US','de_DE'
        )]
    [string]$lang
)
Switch ($lang)
    {
    'de_DE'
        {
        Write-Verbose $lang
        Switch ($winserv_ver)
            {
            '2012R2'
                {
                $URL = "http://care.dlservice.microsoft.com/dl/download/3/3/4/33482C88-DBFB-43F6-925A-7E684D072B15/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_DE-DE-IR3_SSS_X64FREE_DE-DE_DV9.ISO"
                }
            '2012'
                {
                $URL = 'http://care.dlservice.microsoft.com/dl/download/7/C/6/7C6A5A9A-321B-4EF8-95FD-0A483C1EBDC2/9200.16384.WIN8_RTM.120725-1247_X64FRE_SERVER_EVAL_DE-DE-HRM_SSS_X64FREE_DE-DE_DV5.ISO'
                }
            '2016TP5'
                {
                $URL = 'http://care.dlservice.microsoft.com/dl/download/8/9/2/89284B3B-BA51-49C8-90F8-59C0A58D0E70/14300.1000.160324-1723.RS1_RELEASE_SVC_SERVER_OEMRET_X64FRE_EN-US.ISO'
                }
            default
                {
                write-host -ForegroundColor Magenta "this download will be integrated soon"
                return
                }
            }
        }
    'en_US'
        {
        Switch ($winserv_ver)
            {
            '2012R2'
                {
                $URL = "http://care.dlservice.microsoft.com/dl/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
                }
            '2012'
                {
                $URL = "http://care.dlservice.microsoft.com/dl/download/6/D/A/6DAB58BA-F939-451D-9101-7DE07DC09C03/9200.16384.WIN8_RTM.120725-1247_X64FRE_SERVER_EVAL_EN-US-HRM_SSS_X64FREE_EN-US_DV5.ISO"
                }
            '2016TP5'
                {
                $URL = 'http://care.dlservice.microsoft.com/dl/download/8/9/2/89284B3B-BA51-49C8-90F8-59C0A58D0E70/14300.1000.160324-1723.RS1_RELEASE_SVC_SERVER_OEMRET_X64FRE_EN-US.ISO'
                }
            default
                {
                write-host -ForegroundColor Magenta "this download will be integrated soon"
                return
                }
            }
        }
    }
    if (Test-Path -Path "$Destination")
        {
        Write-Host -ForegroundColor Gray " ==>$Destination found"
        }
        else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for ISO Files Prereqs"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
        $FileName = Split-Path -Leaf -Path $URL
        if (!(test-path  "$Destination\$FileName"))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, Trying to Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
                { 
                write-warning "Error Downloading file $Url, Please check connectivity"
                break
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
            }
    }
<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABlabbuildresxiISO
.EXAMPLE

#>
#requires -version 3
function Receive-LABlabbuildresxiISO
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
	<#
	Versions: VMware-VMvisor-Installer-6.0.0.update01-labbuildr-ks.x86_64
	'6.0.0.update01','6.0.0.update02'
	#>
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    '6.0.0.update01','6.0.0.update02'
        )]
    [string]$labbuildresxi_ver
)
	$URL = "https://labbuildrmaster.blob.core.windows.net/iso/VMware-VMvisor-Installer-$($labbuildresxi_ver)-labbuildr-ks.x86_64.iso"
    if (Test-Path -Path "$Destination")
        {
        Write-Host -ForegroundColor Gray " ==>$Destination found"
        }
    else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for ISO Files"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
    $FileName = Split-Path -Leaf -Path $URL
    if (!(test-path  "$Destination\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, Trying to Download"
        if (!($recvOK = Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            break
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
        }
	$ISO = Join-Path $Destination $FileName
	Write-Output $ISO
}

<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABlabbuildresxiISO
.EXAMPLE

#>
#requires -version 3
function Receive-LABnestedesxtemplate
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=".\",
	<#
	Versions: VMware-VMvisor-Installer-6.0.0.update01-labbuildr-ks.x86_64
	'6.0.0.update01','6.0.0.update02'
	#>
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    'Nested_ESXi6','Nested_ESXi5'
        )]
    [string]$nestedesx_ver
)
write-host "Browsing http://www.virtuallyghetto.com/ for templates"	
$HREF =	(Invoke-WebRequest http://www.virtuallyghetto.com/2015/12/deploying-nested-esxi-is-even-easier-now-with-the-esxi-virtual-appliance.html -UseBasicParsing).links | where href -match $nestedesx_ver
$URL = $HREF.href    
if (Test-Path -Path "$Destination")
        {
        Write-Host -ForegroundColor Gray " ==>$Destination found"
        }
    else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for OVA Files"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
    $FileName = Split-Path -Leaf -Path $URL
    if (!(test-path  "$Destination\$FileName"))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, Trying to Download"
        if (!($recvOK = Receive-LABBitsFile -DownLoadUrl $URL -destination "$Destination\$FileName"))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            break
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
        }
	$OVA = Join-Path $Destination $FileName
	Write-Output $OVA
}

<#
.DESCRIPTION
   receives latest free and frictionless scaleio version from emc.com by query webbage
.LINK
   https://github.com/bottkars/labtools/wiki/Test-LABMaster
.EXAMPLE

#>
#requires -version 3
function Test-LABmaster
{
[CmdletBinding(DefaultParametersetName = "vmware",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "vmware", Mandatory = $false)]
    $Masterpath=".\",
	<#
	Possible Master for labbuildr:
	'2016TP5','2016TP5_GER',
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE',
	'OpenWRT',
	'Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster'
	#>
    [Parameter(ParameterSetName = "vmware", Mandatory = $true)]
    [ValidateSet(
    '2016TP5','2016TP5_GER',
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE',
	'OpenWRT',
	'Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster'
    )]
    [string]$Master,
    [Parameter(ParameterSetName = "vmware", Mandatory = $false)]
    [ValidateSet('vmware','hyperv')]
    $mastertype = 'vmware'
)

switch ($ConfirmPreference)
    {
    "None"
    
        {
        $Confirm = $False
        }
    }

switch ($mastertype)
    {
    "vmware"
        {
        $MasterVMX = Get-vmx -path "$Masterpath\$Master\" -WarningAction SilentlyContinue
        if (!$Mastervmx)
            {
            Write-Host -ForegroundColor Yellow " ==>Could not find $Masterpath\$Master"
            Write-Host -ForegroundColor Gray " ==>Trying to load $Master from labbuildr Master Repo"
            if ($recvok = Receive-LABMaster -Master $Master -Destination $Masterpath -mastertype vmware -unzip -Confirm:$Confirm)
                {
                $MasterVMX = Get-vmx -path "$Masterpath\$Master\" -ErrorAction SilentlyContinue
                }
            else
                {
                Write-Warning "No valid master found /downloaded"
                break
                }
            $MasterVMX = Get-vmx -path "$Masterpath\$Master" -WarningAction SilentlyContinue
            }
        if (!$MasterVMX.Template) 
            {
            Write-Host -ForegroundColor Gray " ==>Templating Master VMX"
            $template = $MasterVMX | Set-VMXTemplate
            }
        $Basesnap = $MasterVMX | Get-VMXSnapshot -WarningAction SilentlyContinue | where Snapshot -Match "Base"
            if (!$Basesnap) 
            {
            Write-Host -ForegroundColor Gray " ==>Base snap does not exist, creating now"
            $Basesnap = $MasterVMX | New-VMXSnapshot -SnapshotName BASE
            }
        }
    "hyperv"
        {
        Write-Host -ForegroundColor Magenta " ==>Testing for Hyper-V Master $Masterpath\$Master.vhdx "
        if (!($MasterVMX = (Get-ChildItem -Path $Masterpath -Filter "$Master.vhdx" -Recurse).FullName))
            {
            try
                {
                Receive-LABMaster -Destination $Masterpath -Master $Master -mastertype hyperv -unzip -Confirm:$false -ErrorAction Stop
                }
            catch
                {
                Write-Error "Error Downloading Master"
                Return $false
                }
            }
        else 
            {
            Write-Host -ForegroundColor Magenta " ==>found Master $Mastervmx"
            }
        }
    }
Write-Output $MasterVMX
}

<#
.DESCRIPTION
   receives latest Acropbat from Adobe
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABAcrobat
.EXAMPLE

#>
#requires -version 3
function Receive-LABAcrobat
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
    [Parameter(Mandatory = $true)][String]$Destination,
    [Parameter(Mandatory = $false)]
    [ValidateSet('en_US','de_DE')][string]$lang = "en_US",
    [String]$Product_Dir= "Acrobat",
    [String]$Prereq = "prereq",
    [switch]$unzip,
    [switch]$force
)
    $Product_Dir = Join-Path $Destination $Product_Dir
    Write-Host -ForegroundColor Gray " ==>destination : $Product_Dir"
if (!(Test-Path $Product_Dir))    
    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Product_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path "$Product_Dir" -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }
}



$readerfiles = (
"ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/1500720033/AcroRdrDC1500720033_$lang.msi",
"ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/1501620045/AcroRdrDCUpd1501620045.msp"
)

$readerfiles = 
foreach ($url in $readerfiles)
    {
    $File = Split-Path -Leaf $url
    if (!(Test-Path "$Product_Dir\$File") -or $force.IsPresent)
        {
        Get-LABFTPFile -Source $url -TarGet  "$Product_Dir\$File" -Verbose
        }
    else
        {
        Write-Host -ForegroundColor Gray " ==>File $Product_Dir\$File already exists, use -Force to overwrite"
        }
    }
}