<#  
.Synopsis
   meta
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
    [Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json"
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.DefaultGateway = $DefaultGateway.IPAddressToString
    Write-Host -ForegroundColor Gray " ==>setting Default Gateway $DefaultGateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABDockerRegistry
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDockerRegistry")]
	param (    
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DockerRegistry,
    [Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json"
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Global:labdefaults.DockerRegistry = $DockerRegistry.IPAddressToString
    Write-Host -ForegroundColor Gray " ==>setting Docker Registry $DockerRegistry"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABDNS1
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDNS1")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$DNS1
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Global:labdefaults.DNS1 = $DNS1.IPAddressToString
    Write-Host -ForegroundColor Gray " ==>setting DNS1 $DNS1"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABAPT_Cache_IP
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABAPT_Cache_IP")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$APT_Cache_IP
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    $Global:labdefaults.APT_Cache_IP = $APT_Cache_IP.IPAddressToString
    Write-Host -ForegroundColor Gray " ==>setting APT_Cache_IP $APT_Cache_IP"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABDNS
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABDNS1")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $False,Position = 1)][system.net.ipaddress]$DNS1,
    [Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][system.net.ipaddress]$DNS2
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    
    if ($DNS1)
        {
        $Global:labdefaults.DNS1 = $DNS1.IPAddressToString
        }
    if ($DNS2)
        {
        $Global:labdefaults.DNS2 = $DNS2.IPAddressToString
        }
    Write-Host -ForegroundColor Gray " ==>setting DNS"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABvmnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABvmnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet9','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19')]$VMnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.vmnet = $VMnet
    Write-Host -ForegroundColor Gray " ==>setting LABVMnet $VMnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABVlanID
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABvlanid")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateRange(0,4096)]$vlanID
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.vlanID = $vlanID
    Write-Host -ForegroundColor Gray " ==>setting LABVMnet $VMnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
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
	[Parameter(ParameterSetName = "1", Mandatory = $false )][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile="./Switchdefaults.json"

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
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.Gateway = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $Gateway"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABOpenWRT
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABOpenWRT")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.OpenWRT = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $OpenWRT"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABNoDomainCheck
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABNoDomainCheck")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.NoDomainCheck = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $NoDomainCheck"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABpuppet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$enabled
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.puppet = $enabled.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting $puppet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABSQLver
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateSet(#'SQL2014SP1slip','SQL2012','SQL2012SP1','SQL2012SP2','SQL2012SP1SLIP','SQL2014','SQL2016',
	'SQL2012_ISO',
	'SQL2014SP2_ISO',
	'SQL2016_ISO')]$SQLVER  

    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.SQLVER = $SQLVER
    Write-Host -ForegroundColor Gray " ==>setting SQL Version to $SQLVER"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABScaleIOver
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
    [ValidateSet(
	'2.0-13000.211','2.0-10000.2075','2.0-12000.122',
	'2.0-7536.0','2.0-7536.0','2.0-7120.0','2.0-6035.0','2.0-5014.0',
	'1.32-277.0','1.32-402.1','1.32-403.2','1.32-2451.4','1.32-3455.5','1.32-4503.5',
	'1.31-258.2','1.31-1277.3','1.31-2333.2',
	'1.30-426.0'
    )]
    [alias('siover','ScaleIOVer')]
    $ScaleIO_ver
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.ScaleIOver = $ScaleIO_ver
    Write-Host -ForegroundColor Gray " ==>setting ScaleIO Version to $ScaleIO_ver"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABNWver
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
    [ValidateSet(
    'nw9201','nw9203','nw9204',#-#           
    'nw9111','nw9112','nw9113',#-#    
	'nw9100','nw9102','nw9103','nw9104','nw9105','nw9106',#-#
    'nw9010','nw9011','nw9012','nw9013','nw9014','nw9015','nw9016','nw9017','nw9018','nw9019',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
	'nw8240','nw8241','nw8242','nw8243','nw8244','nw8245','nw8246','nw8247',#-#
    'nw8230','nw8231','nw8232','nw8233','nw8234','nw8235','nw8236','nw8237','nw8238',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw8210',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw8200',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw8130',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw8120',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw8100',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012','nw8010',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw8000',
    'nwunknown'
    )]
    $nw_ver

    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.nw_ver = $nw_ver
    Write-Host -ForegroundColor Gray " ==>setting Networker Version to $nw_ver"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABnmmver
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
    [ValidateSet(
    'nmm9201','nmm9203',#-#         
    'nmm9111','nmm9112','nmm9113',#-#
    'nmm9100','nmm9102','nmm9103','nmm9104','nmm9105','nmm9106',#-#
    'nmm9010','nmm9011','nmm9012','nmm9013','nmm9014','nmm9015','nmm9016',
    'nmm90.DA','nmm9001','nmm9002','nmm9003','nmm9004','nmm9005','nmm9006','nmm9007','nmm9008',
	'nmm8240','nmm8241','nmm8242','nmm8243','nmm8244','nmm8245',#-#
    'nmm8230','nmm8231','nmm8232','nmm8233','nmm8234','nmm8235','nmm8236','nmm8237','nmm8238',
    'nmm8226','nmm8225','nmm8224','nmm8223','nmm8222','nmm8221','nmm822',
    'nmm8218','nmm8217','nmm8216','nmm8215','nmm8214','nmm8213','nmm8212','nmm8211','nmm8210',
    'nmm8206','nmm8205','nmm8204','nmm8203','nmm8202','nmm8200',
    'nmm8138','nmm8137','nmm8136','nmm8135','nmm8134','nmm8133','nmm8132','nmm8131','nmm8130',
    'nmm8127','nmm8126','nmm8125','nmm8124','nmm8123','nmm8122','nmm8121','nmm8120',
    'nmm8119','nmm8118','nmm8117','nmm8116','nmm8115','nmm8114', 'nmm8113','nmm8112', 'nmm811',
    'nmm8105','nmm8104','nmm8103','nmm8102','nmm8100',
    'nmm8044','nmm8043','nmm8042','nmm8041',
    'nmm8037','nmm8036','nmm8035','nmm81034','nmm8033','nmm8032','nmm8031',
    'nmm8026','nmm8025','nmm81024','nmm8023','nmm8022','nmm8021',
    'nmm8016','nmm8015','nmm81014','nmm8013','nmm8012','nmm8010',
    'nmm8007','nmm8006','nmm8005','nmm81004','nmm8003','nmm8002','nmm8000',
    'nmmunknown'
    )]
    $nmm_ver

    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.nmm_ver = $nmm_ver
    Write-Host -ForegroundColor Gray " ==>setting Networker Version to $nmm_ver"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABExchangeCU
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABExchangeCU")]
	param (
	[Parameter(Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "E16", Mandatory = $true)]
    [ValidateSet('final','cu1','cu2','cu3','cu4','cu5','cu6','cu7')]
    $e16_cu,
    [Parameter(ParameterSetName = "E15", Mandatory = $false)]
    [ValidateSet('cu1','cu2','cu3','sp1','cu5','cu6','cu7','cu8','cu9','cu10','cu11','cu12','cu13','cu14','cu15','cu16','cu17','cu18')]
    $e15_cu,
    [Parameter(ParameterSetName = "E14", Mandatory = $true)]
    [ValidateSet('ur1','ur2','ur3','ur4','ur5','ur6','ur7','ur8v2','ur9','ur10','ur11','ur12','ur13','ur14','ur15','ur16','ur17','ur18')]
    $e14_ur = "ur13",
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('sp3')]
    $e14_sp="sp3"
  #  [Parameter(ParameterSetName = "E14", Mandatory = $false)]
  #  [ValidateSet('de_DE','en_US')]
  #  $e14_lang = "de_DE"
    )

if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
switch ($PsCmdlet.ParameterSetName)
{
    "E16"
        {
        $Global:labdefaults.e16_cu = $e16_cu
        Write-Host -ForegroundColor Gray " ==>setting E16CU to $e16_cu"
        }
    "E15"
        {
        $Global:labdefaults.e15_cu = $e15_cu
        Write-Host -ForegroundColor Gray " ==>setting E15CU to $e15_cu"
        }     
    "E14"
        {
        $Global:labdefaults.e14_ur = $e14_ur
        $Global:labdefaults.e14_sp = $e14_sp
 #       $Global:labdefaults.e14_lang = $e14_lang
        Write-Host -ForegroundColor Gray " ==>setting E14 with $e14cu $e14_sp"
       }
    }          
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABNWver
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
    [ValidateSet(
    'nw9201','nw9203','nw9204',#-#           
    'nw9111','nw9112','nw9113',#-#    
	'nw9100','nw9102','nw9103','nw9104','nw9105','nw9106',#-#
    'nw9010','nw9011','nw9012','nw9013','nw9014','nw9015','nw9016','nw9017','nw9018','nw9019',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
	'nw8240','nw8241','nw8242','nw8243','nw8244','nw8245','nw8246','nw8247',#-#
    'nw8230','nw8231','nw8232','nw8233','nw8234','nw8235','nw8236','nw8237','nw8238',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw8210',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw8200',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw8130',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw8120',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw8100',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012','nw8010',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw8000',
    'nwunknown'
    )]
    $nw_ver

    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.nw_ver = $nw_ver
    Write-Host -ForegroundColor Gray " ==>setting Networker Version to $nw_ver"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}



function Set-LABPuppetMaster
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppetMaster")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('puppetlabs-release-7-11', 'PuppetEnterprise')]$PuppetMaster = "PuppetEnterprise"
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.puppetmaster = $PuppetMaster
    Write-Host -ForegroundColor Gray " ==>setting $puppetMaster"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABLanguageTag
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABLanguageTag")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][ValidateSet('af-ZA',
    'sq-AL','ar-DZ','ar-BH','ar-EG','ar-IQ','ar-JO','ar-KW','ar-LB','ar-LY','ar-MA','ar-OM','ar-QA','ar-SA','ar-SY','ar-TN','ar-AE','ar-YE',
    'hy-AM','Cy-az-AZ','Lt-az-AZ','eu-ES','be-BY','bg-BG','ca-ES','zh-CN','zh-HK','zh-MO','zh-SG','zh-TW','zh-CHS','zh-CHT','hr-HR','cs-CZ',
    'da-DK','div-MV','nl-BE','nl-NL',
    'en-AU','en-BZ','en-CA','en-CB','en-IE','en-JM','en-NZ','en-PH','en-ZA','en-TT','en-GB','en-US','en-ZW','et-EE',
    'fo-FO','fa-IR','fi-FI','fr-BE','fr-CA','fr-FR','fr-LU','fr-MC','fr-CH','gl-ES','ka-GE',
    'de-AT','de-DE','de-LI','de-LU','de-CH',
    'el-GR','gu-IN','he-IL','hi-IN','hu-HU','is-IS','id-ID','it-IT','it-CH','ja-JP','kn-IN','kk-KZ','kok-IN','ko-KR','ky-KZ','lv-LV','lt-LT','mk-MK','ms-BN','ms-MY','mr-IN','mn-MN',
    'nb-NO','nn-NO','pl-PL','pt-BR','pt-PT','pa-IN','ro-RO','ru-RU','sa-IN','Cy-sr-SP','Lt-sr-SP','sk-SK','sl-SI',
    'es-AR','es-BO','es-CL','es-CO','es-CR','es-DO','es-EC','es-SV','es-GT','es-HN','es-MX','es-NI','es-PA','es-PY','es-PE','es-PR','es-ES','es-UY','es-VE',
    'sw-KE','sv-FI','sv-SE','syr-SY','ta-IN','tt-RU','te-IN','th-TH','tr-TR','uk-UA','ur-PK','Cy-uz-UZ','Lt-uz-UZ','vi-VN'
)]
$LanguageTag = "en-US"
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.LanguageTag = $LanguageTag
    Write-Host -ForegroundColor Gray " ==>setting $LanguageTag"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABTimeZone
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABTimeZone")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateSet(
    'W. Europe Standard Time',
    'W. Central Africa Standard Time',
    'E. Europe Standard Time',
    'Egypt Standard Time',
    'FLE Standard Time',
    'GTB Standard Time',
    'Israel Standard Time',
    'South Africa Standard Time',
    'Russian Standard Time',
    'Arab Standard Time',
    'E. Africa Standard Time',
    'Arabic Standard Time',
    'Iran Standard Time',
    'Arabian Standard Time',
    'Caucasus Standard Time',
    'Transitional Islamic State of Afghanistan Standard Time',
    'Ekaterinburg Standard Time',
    'West Asia Standard Time',
    'India Standard Time',
    'Nepal Standard Time',
    'Central Asia Standard Time',
    'Sri Lanka Standard Time',
    'N. Central Asia Standard Time',
    'Myanmar Standard Time',
    'SE Asia Standard Time',
    'North Asia Standard Time',
    'China Standard Time',
    'Singapore Standard Time',
    'Taipei Standard Time',
    'W. Australia Standard Time',
    'North Asia East Standard Time',
    'Korea Standard Time',
    'Tokyo Standard Time',
    'Yakutsk Standard Time',
    'AUS Central Standard Time',
    'Cen. Australia Standard Time',
    'AUS Eastern Standard Time',
    'E. Australia Standard Time',
    'Tasmania Standard Time',
    'Vladivostok Standard Time',
    'West Pacific Standard Time',
    'Central Pacific Standard Time',
    'Fiji Islands Standard Time',
    'New Zealand Standard Time',
    'Tonga Standard Time'
    )]$TimeZone = 'W. Europe Standard Time'
    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.TimeZone= $TimeZone
    Write-Host -ForegroundColor Gray " ==>setting $Timezone"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABMainMemUseFile
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABnmm")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$UseFile
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    
    $Global:labdefaults.MainMemUseFile = $UseFile.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting  MainMemUseFile to $($UseFile.IsPresent)"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABnmm
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABnmm")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][switch]$NMM
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }

    
    $Global:labdefaults.NMM = $NMM.IsPresent
    Write-Host -ForegroundColor Gray " ==>setting NMM to $($NMM.IsPresent)"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABsubnet
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABsubnet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)][system.net.ipaddress]$subnet
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.Mysubnet = $subnet.IPAddressToString
    Write-Host -ForegroundColor Gray " ==>setting subnet $subnet"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


##Set-LABAnsiblePublicKey
function Set-LABAnsiblePublicKey
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABAnsiblePublicKey")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$AnsiblePublicKey
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.AnsiblePublicKey = $AnsiblePublicKey
    Write-Host -ForegroundColor Gray " ==>setting AnsiblePublicKey $AnsiblePublicKey"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABHostKey
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABHostKey")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$HostKey
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.HostKey = $HostKey
    Write-Host -ForegroundColor Gray " ==>setting HostKey $HostKey"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABSMBPassword
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABSMBPassword")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$SMBPassword
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.SMBPassword = $SMBPassword
    Write-Host -ForegroundColor Gray " ==>setting SMBPassword $SMBPassword"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABSMBUsername
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABSMBUsername")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$SMBUsername
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.SMBUsername = $SMBUsername
    Write-Host -ForegroundColor Gray " ==>setting SMBUsername $SMBUsername"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABBuilddomain
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABBuilddomain")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateLength(1,63)][ValidatePattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,63}[a-zA-Z0-9]+$")][string]$BuildDomain
    )
    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.builddomain = $builddomain.ToLower()
    Write-Host -ForegroundColor Gray " ==>setting builddomain $($builddomain.ToLower())"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABCustomDomainSuffix
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABCustom_DomainSuffix")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
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
    
    $Global:labdefaults.Custom_DomainSuffix = $Custom_DomainSuffix.ToLower()
    Write-Host -ForegroundColor Gray " ==>setting Custom_DomainSuffix $($Custom_DomainSuffix.ToLower())"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}
function Set-LABSources
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABSources")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [ValidateLength(3,256)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$Sourcedir
    )
 
    try
        {
        Get-Item -Path $Sourcedir -ErrorAction Stop | Out-Null 
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

    if (!(Test-Path $Sourcedir)){break} 

    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.sourcedir = $Sourcedir
    Write-Host -ForegroundColor Gray " ==>setting Sourcedir $Sourcedir"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}

function Set-LABSMBSources
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABSMBSources")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [ValidateLength(3,256)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]$SMBSourcedir
    )
	if ($SMBSourcedir -match "\\\\")
		{
		write-host "got UNC SMBSourcedir, will check permissions"
		$SOURCES_ON_UNC = $true
		if ($labdefaults.SMBusername -and $LabDefaults.SMBPassword)
			{
		<#if (!(Get-SmbMapping -RemotePath $Sourcedir))
		#	{
				try
					{
									New-SmbMapping -RemotePath $Sourcedir -UserName $LabDefaults.SMBUsername -Password $LabDefaults.SMBPassword
					}
				catch
					{
					Write-Host "Could not connect to SMB Share"
					exit
					}
				}#>
			Get-PSDrive Sources -ErrorAction SilentlyContinue | Remove-PSDrive
			try
				{
				$SecurePassword = $labdefaults.SMBPassword | ConvertTo-SecureString -AsPlainText -Force
				$Credential = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $labdefaults.SMBUsername, $SecurePassword
				New-PSDrive –Name “Sources” –PSProvider FileSystem –Root $SMBSourcedir -Credential $Credential -Scope Global -ErrorAction Stop
				}
			catch
				{
				Write-Warning $_
				break
				}
			}
		else
			{
			Get-PSDrive Sources -ErrorAction SilentlyContinue | Remove-PSDrive
			try
				{
				New-PSDrive –Name “Sources” –PSProvider FileSystem –Root “$SMBSources” -Scope Global -ErrorAction Stop
				}
			catch
				{
				Write-Warning $_
				break
				}
			<#if (!(Get-SmbMapping -RemotePath $SMBSourcedir))
				{
				try
					{
					New-SmbMapping -RemotePath $SMBSourcedir 
					}
				catch
					{
					Write-Host "Could not connect to SMB Share"
					exit
					}
				}#>
			}
		}	   
    try
        {
        Get-Item -Path $SMBSourcedir -ErrorAction Stop | Out-Null 
        }
    catch
        [System.Management.Automation.DriveNotfoundException] 
        {
        Write-Warning "Drive not found, make sure to have your Source Stick connected"
        exit
        }
    catch #[System.Management.Automation.ItemNotfoundException]
        {
        Write-Warning "no SMBSources directory found, trying to create"
        New-Item -ItemType Directory -Path $SMBSourcedir -Force| Out-Null
        }

    if (!(Test-Path $SMBSourcedir)){break} 

    if (!(Test-Path $Defaultsfile))
    {
        Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
        New-LABdefaults -Defaultsfile $Defaultsfile
    }
    
    $Global:labdefaults.SMBSourcedir = $SMBSourcedir
    Write-Host -ForegroundColor Gray " ==>setting SMBSourcedir $SMBSourcedir"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


function Set-LABMasterpath
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABMaster")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json",
    [ValidateLength(3,200)]
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)] 
    $Masterpath
    )
    try
        {
        Get-Item -Path $Masterpath -ErrorAction Stop | Out-Null 
        }
    catch
        [System.Management.Automation.DriveNotFoundException] 
        {
        Write-Warning "Drive not found, make sure to have your Source Stick connected"
        exit
        }
    catch [System.Management.Automation.ItemNotFoundException]
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
    
    $Global:labdefaults.Masterpath = $Masterpath
    Write-Host -ForegroundColor Gray " ==>setting Masterpath $Masterpath"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}



function Get-LABSIOConfig
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./scaleioenv.xml"
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
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$Defaultsfile="./defaults.json"
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
        #$Default = [xml]([System.IO.File]::ReadAllText("$Defaultsfile"))
     <#   [xml]$Default = Get-Content -Path $Defaultsfile
        $object = New-Object psobject
	    $object | Add-Member -MemberType NoteProperty -Name LanguageTag -Value $Default.config.LanguageTag
        $object | Add-Member -MemberType NoteProperty -Name TimeZone -Value $Default.config.TimeZone
	    $object | Add-Member -MemberType NoteProperty -Name Master -Value $Default.config.master
        $object | Add-Member -MemberType NoteProperty -Name ScaleIOVer -Value $Default.config.scaleiover
        $object | Add-Member -MemberType NoteProperty -Name BuildDomain -Value $Default.config.Builddomain
        $object | Add-Member -MemberType NoteProperty -Name Custom_DomainSuffix  -Value $Default.config.Custom_DomainSuffix
        $object | Add-Member -MemberType NoteProperty -Name MySubnet -Value $Default.config.MySubnet
        $object | Add-Member -MemberType NoteProperty -Name vmnet -Value $Default.config.vmnet
        $object | Add-Member -MemberType NoteProperty -Name vlanID -Value $Default.config.vlanID
        $object | Add-Member -MemberType NoteProperty -Name DefaultGateway -Value $Default.config.DefaultGateway
        $object | Add-Member -MemberType NoteProperty -Name DockerRegistry -Value $Default.config.DockerRegistry
        $object | Add-Member -MemberType NoteProperty -Name APT_Cache_IP -Value $Default.config.APT_Cache_IP
        $object | Add-Member -MemberType NoteProperty -Name DNS1 -Value $Default.config.DNS1
        $object | Add-Member -MemberType NoteProperty -Name DNS2 -Value $Default.config.DNS2
        $object | Add-Member -MemberType NoteProperty -Name Gateway -Value $Default.config.Gateway
        $object | Add-Member -MemberType NoteProperty -Name AddressFamily -Value $Default.config.AddressFamily
        $object | Add-Member -MemberType NoteProperty -Name IPV6Prefix -Value $Default.Config.IPV6Prefix
        $object | Add-Member -MemberType NoteProperty -Name IPv6PrefixLength -Value $Default.Config.IPV6PrefixLength
        $object | Add-Member -MemberType NoteProperty -Name Sourcedir -Value $Default.Config.Sourcedir
        $object | Add-Member -MemberType NoteProperty -Name SMBSourcedir -Value $Default.Config.SMBSourcedir
        $object | Add-Member -MemberType NoteProperty -Name SQLVer -Value $Default.config.sqlver
        $object | Add-Member -MemberType NoteProperty -Name e14_ur -Value $Default.config.e14_ur
        $object | Add-Member -MemberType NoteProperty -Name e14_sp -Value $Default.config.e14_sp
        $object | Add-Member -MemberType NoteProperty -Name e15_cu -Value $Default.config.e15_cu
        $object | Add-Member -MemberType NoteProperty -Name e16_cu -Value $Default.config.e16_cu
        $object | Add-Member -MemberType NoteProperty -Name Server2016KB -Value $Default.config.Server2016KB
        $object | Add-Member -MemberType NoteProperty -Name NMM_Ver -Value $Default.config.nmm_ver
        $object | Add-Member -MemberType NoteProperty -Name NW_Ver -Value $Default.config.nw_ver
        $object | Add-Member -MemberType NoteProperty -Name NMM -Value $Default.config.nmm
        $object | Add-Member -MemberType NoteProperty -Name Masterpath -Value $Default.config.Masterpath
        $object | Add-Member -MemberType NoteProperty -Name NoDomainCheck -Value $Default.config.NoDomainCheck
		$object | Add-Member -MemberType NoteProperty -Name OpenWRT -Value $Default.config.OpenWRT
        $object | Add-Member -MemberType NoteProperty -Name Puppet -Value $Default.config.Puppet
        $object | Add-Member -MemberType NoteProperty -Name PuppetMaster -Value $Default.config.PuppetMaster
        $object | Add-Member -MemberType NoteProperty -Name HostKey -Value $Default.config.Hostkey
        $object | Add-Member -MemberType NoteProperty -Name SMBPassword -Value $Default.config.SMBPassword
        $object | Add-Member -MemberType NoteProperty -Name SMBUsername -Value $Default.config.SMBUsername
        $object | Add-Member -MemberType NoteProperty -Name AnsiblePublicKey -Value $Default.config.AnsiblePublicKey
		$object | Add-Member -MemberType NoteProperty -Name MainMemUseFile -Value $Default.config.MainMemUseFile
        Write-Output $object
        #>
        $Default = Get-Content $Defaultsfile | ConvertFrom-Json
        Write-Output $Default
        }
    }
end {
    
    }
}

function Get-LABSwitchDefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Get-LABSwitchDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 1)][ValidateScript({ Test-Path -Path $_ })]$SwitchDefaultsfile="./Switchdefaults.json"
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
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true)]$Defaults

    )
begin {
    }
process { <#
        $xmlcontent =@()
		$xmlcontent += ("<!--
      Warning ! DO NOT EDIT THIS FILE !!!!!!!!!!!!!!!
	  edits may break labbuildr functionality
	  -->")
        $xmlcontent += ("<config>")
        $xmlcontent += ("<LanguageTag>$($Global:labdefaults.LanguageTag)</LanguageTag>")
        $xmlcontent += ("<Timezone>$($Global:labdefaults.TimeZone)</Timezone>")
        $xmlcontent += ("<nmm_ver>$($Global:labdefaults.nmm_ver)</nmm_ver>")
        $xmlcontent += ("<nmm>$($Global:labdefaults.nmm)</nmm>")
        $xmlcontent += ("<nw_ver>$($Global:labdefaults.nw_ver)</nw_ver>")
        $xmlcontent += ("<master>$($Global:labdefaults.Master)</master>")
        $xmlcontent += ("<sqlver>$($Global:labdefaults.SQLVER)</sqlver>")
        $xmlcontent += ("<e14_ur>$($Global:labdefaults.e14_ur)</e14_ur>")
        $xmlcontent += ("<e14_sp>$($Global:labdefaults.e14_sp)</e14_sp>")
        $xmlcontent += ("<e15_cu>$($Global:labdefaults.e15_cu)</e15_cu>")
        $xmlcontent += ("<e16_cu>$($Global:labdefaults.e16_cu)</e16_cu>")
        $xmlcontent += ("<Server2016KB>$($Global:labdefaults.Server2016KB)</Server2016KB>")
        $xmlcontent += ("<vmnet>$($Global:labdefaults.VMnet)</vmnet>")
        $xmlcontent += ("<vlanID>$($Global:labdefaults.vlanID)</vlanID>")
        $xmlcontent += ("<Custom_DomainSuffix>$($Global:labdefaults.Custom_DomainSuffix)</Custom_DomainSuffix>")
        $xmlcontent += ("<BuildDomain>$($Global:labdefaults.BuildDomain)</BuildDomain>")
        $xmlcontent += ("<MySubnet>$($Global:labdefaults.MySubnet)</MySubnet>")
        $xmlcontent += ("<AddressFamily>$($Global:labdefaults.AddressFamily)</AddressFamily>")
        $xmlcontent += ("<IPV6Prefix>$($Global:labdefaults.IPV6Prefix)</IPV6Prefix>")
        $xmlcontent += ("<IPv6PrefixLength>$($Global:labdefaults.IPv6PrefixLength)</IPv6PrefixLength>")
        $xmlcontent += ("<Gateway>$($Global:labdefaults.Gateway)</Gateway>")
        $xmlcontent += ("<DefaultGateway>$($Global:labdefaults.DefaultGateway)</DefaultGateway>")
        $xmlcontent += ("<DockerRegistry>$($Global:labdefaults.DockerRegistry)</DockerRegistry>")        
        $xmlcontent += ("<APT_Cache_IP>$($Global:labdefaults.APT_Cache_IP)</APT_Cache_IP>")
        $xmlcontent += ("<DNS1>$($Global:labdefaults.DNS1)</DNS1>")
        $xmlcontent += ("<DNS2>$($Global:labdefaults.DNS2)</DNS2>")
        $xmlcontent += ("<Sourcedir>$($Global:labdefaults.Sourcedir)</Sourcedir>")
        $xmlcontent += ("<SMBSourcedir>$($Global:labdefaults.SMBSourcedir)</SMBSourcedir>")
        $xmlcontent += ("<ScaleIOVer>$($Global:labdefaults.ScaleIOVer)</ScaleIOVer>")
        $xmlcontent += ("<Masterpath>$($Global:labdefaults.Masterpath)</Masterpath>")
        $xmlcontent += ("<NoDomainCheck>$($Global:labdefaults.NoDomainCheck)</NoDomainCheck>")
        $xmlcontent += ("<OpenWRT>$($Global:labdefaults.OpenWRT)</OpenWRT>")
        $xmlcontent += ("<Puppet>$($Global:labdefaults.Puppet)</Puppet>")
        $xmlcontent += ("<PuppetMaster>$($Global:labdefaults.PuppetMaster)</PuppetMaster>")
        $xmlcontent += ("<Hostkey>$($Global:labdefaults.HostKey)</Hostkey>")        
		$xmlcontent += ("<SMBPassword>$($Global:labdefaults.SMBPassword)</SMBPassword>")
		$xmlcontent += ("<SMBUsername>$($Global:labdefaults.SMBUsername)</SMBUsername>")
        $xmlcontent += ("<AnsiblePublicKey>$($Global:labdefaults.AnsiblePublicKey)</AnsiblePublicKey>")
		$xmlcontent += ("<MainMemUseFile>$($Global:labdefaults.MainMemUseFile)</MainMemUseFile>")
        $xmlcontent += ("</config>")
		Write-Host -ForegroundColor Gray " ==>saving defaults to $Defaultsfile"
        $xmlcontent | Set-Content $defaultsfile #>
        }
end {
	# $Global:labdefaults = Get-LABDefaults
	Write-Host -ForegroundColor Gray " ==>saving defaults to $Defaultsfile"
	$Global:labdefaults | ConvertTo-Json | Out-File $Defaultsfile
	}
}

function Save-LABSwitchdefaults
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Save-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile="./Switchdefaults.json",
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
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile="./scaleioenv.xml",
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
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$Defaultsfile="./defaults.json"
    )
        Write-Host -ForegroundColor Gray " ==>generating  defaults from template"
        copy-item defaults.json.example $Defaultsfile
     }

function New-LABSwitchdefaults   
{
    [CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/New-LABDefaults")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false)]$SwitchDefaultsfile="./Switchdefaults.json"
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
    	$7za = $Global:vmware_packer
    
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
			$7zdestination =  " -y -o"+$destination
            }
        else
            {
			$7zdestination = " -o"+$destination
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
        [Parameter(Mandatory = $true, Position = 1)]
        [System.IO.FileInfo]$Archive,
        [string]$filepattern,
        [int]$chmod,
        [string]$destination = "./",
        [switch]$force
        )
	$Origin = $MyInvocation.MyCommand
	if (test-path($Archive))
	{
	#$Archivefile = Get-ChildItem $Archive
	switch ($global:vmxtoolkit_type)
		{
<#		"OSX"
			{
			$extract_Parameter = "x -y"
			$extract_destination = $destination
			$Extract_Arguments= "$extract_Parameter $($Archivefile.FullName) $destination"
			}
#>
		default
			{
			$extract_Parameter = "x"
			
				switch ($global:vmxtoolkit_type)
					{
						'win_x86_64'
						{
                        if ($global:vmwareversion -lt 12.5)
                            {
                            if ($force.ispresent)
							    {
							    $extract_Options = "-y" # -o" #+$destination
							    }
						    else
							    {
							    $extract_Options  = "" #"-o" #+$destination
							    }
                             }
                        else
                            {     
						    if ($force.ispresent)
							    {
                                $extract_Options = "-y -bb0 -bso0 -bsp0"# -o" #+$destination
							    }
						    else
							    {
							    $extract_Options = "-bb0 -bso0 -bsp0"# -o" #+$destination
							    }
                            }
					    }
						default
						{
						if ($force.ispresent)
							{
							$extract_Options = "-y" # -o" #+$destination
							}
						else
							{
							$extract_Options  = "" #"-o" #+$destination
							}
					}
				
				}
			if ($filepattern)
				{
				$Extract_Arguments = "$extract_Parameter $extract_Options -o$destination $($Archive.FullName) $filepattern"
				}
			else
				{
				$Extract_Arguments = "$extract_Parameter $extract_Options -o$destination $($Archive.FullName)"
				}
			}
		}
        Write-Host -ForegroundColor Gray " ==>extracting $($Archive.fullname) to $destination"
        if (!(test-path  $destination))
            {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
            }
        Write-Host -ForegroundColor Gray " ==>Using $global:vmware_packer with $Extract_Arguments"
		Start-Process "$global:VMware_Packer" -ArgumentList $Extract_Arguments -Wait -NoNewWindow -PassThru # 2>&1
		switch ($LASTEXITCODE)
            {
            0
                {
                Write-Host -ForegroundColor Gray " ==>Sucess expanding $Archive"
                $object = New-Object psobject
	            $object | Add-Member -MemberType NoteProperty -Name Destination -Value "$Destination"
	            $object | Add-Member -MemberType NoteProperty -Name Archive -Value "$($Archive.Name)"
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
         if ($chmod -and $global:vmxtoolkit_type -ne 'win_x86_64')   
            {
            chmod -Rv $chmod $destination    
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
        [string]$destination = "./",
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
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$UserName = "anonymous",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]$Password = "anonymous@LABbuildr.local",
    [Parameter(ParameterSetName = "1", Mandatory = $false)][switch]$Defaultcredentials
) 
if (!$TarGet)
    {
    $TarGet = Split-Path -Leaf $Source 
    }
switch ($Global:vmxtoolkit_type)
	{
	"win_x86_64"
		{
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
		Set-LABUi -short -title " ==>Downloading $Source via ftp" 
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
		}
	default
		{
		$CurlArgs1 = "-# -u $($UserName):$($Password)"
		$CurlArgs2 = "-C"
		$Curl = '/usr/bin/curl'
		Set-LABUi -short -title " ==>$Curl $CurlArgs1 $Source -o $TarGet"
		Start-Process "/usr/bin/curl" -ArgumentList "$CurlArgs1 $Source -o $TarGet" -Wait -NoNewWindow
		#Write-Host -ForegroundColor Gray " ==>using curl -u `"$($UserName):$($Password)`" $Source -o $TarGet"
		#curl -# -u  `"$($UserName):$($Password)`" $Source -o $TarGet
		}
	}
return $true	
Set-LABUi
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
    get-vmx | where state -Match running  | Get-VMXToolsState | where {$_.state -Match "intalled" -or $_.state -match "running"} | Set-VMXSharedFolderState -enabled
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
    if ((Get-vmx -path DCNODE).state -ne "running")
        {Get-vmx -path DCNODE | Start-vmx}
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
            Get-vmx -Path DCNODE | Stop-vmx
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
                    Invoke-WebRequest $SourceURL -OutFile $TarGetFile -UseBasicParsing
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
   Receive-LABJava64 receives all versions of networker client and server from legato´s ftp. see Get-help Receive-LABJava64 -online for details
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
        $javaparse = Invoke-WebRequest https://www.java.com/en/download/manual.jsp -UseBasicParsing
        }
    catch [Exception] 
        {
        Write-Warning "Could not connect to java.com"
        Write-Warning $_.Exception
        break
        }
    Write-Host -ForegroundColor Gray " ==>Analyzing response Stream"
    $Link = $javaparse.Links | Where-Object outerHTML -Match "Windows Offline \(64-Bit\)" | Select-Object href
    If ($Link)
        {
        $latest_java8uri = $link.href
        Write-Host -ForegroundColor Gray " ==>$($link.href)"
		$Headers = Invoke-WebRequest  $Link.href -UseBasicParsing -Method Head
		switch ($vmxtoolkit_type)
		{
			'win_x86_64'
			{
			$File =  $Headers.BaseResponse | Select-Object responseUri
			$Length = $Headers.Headers.'Content-Length'
			$Latest_java8 = split-path -leaf $File.ResponseUri.AbsolutePath
			}
			default
			{
			$Latest_java8  = split-path -Leaf $Headers.BaseResponse.RequestMessage.RequestURI.AbsolutePath
			$latest_java8uri = $Headers.BaseResponse.RequestMessage.RequestURI.AbsoluteURI
			}
		}

		if (!$Latest_java8)
			{
			Write-Warning "Could not retrieve latest java, please download manually"
			break
			}
        Write-Host -ForegroundColor Gray " ==>we found $latest_java8 online"
		$Download_File = join-path $DownloadDir $Latest_java8
        if (!(Test-Path $Download_File))
            {
            Write-Host -ForegroundColor Gray " ==>Downloading $Latest_java8"
            Try
                {
                Receive-LABBitsFile -DownLoadUrl $latest_java8uri -destination $Download_File
                #Invoke-WebRequest "$latest_java8uri" -OutFile "$DownloadDir\$latest_java8" -TimeoutSec 60
                }
            catch [Exception] 
                {
                Write-Warning "Could not DOWNLOAD FROM java.com"
                Write-Warning $_.Exception
                break
                } 
			switch ($vmxtoolkit_type)
				{
					'win_x86_64'
					{		
					if ( (Get-ChildItem  $Download_File).length -ne $Length)
						{
						Write-Warning "Invalid FileSize, must be $Length, Deleting Download File"
						Remove-Item $Download_File -Force
						break
						}
					}
					default
					{}
				}
			}
        else
            {
            Write-Host -ForegroundColor Gray "$Latest_java8 already exists in $DownloadDir"
            }
            $object = New-Object psobject
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8 -Value $Latest_java8
	        $object | Add-Member -MemberType NoteProperty -Name LatestJava8File -Value $Download_File
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
        [string]$destination,
		[switch]$force )
$ReturnCode = $True
if (!(Test-Path $Destination ) -or ($force.IsPresent)) #($Global:vmxtoolkit_type -match  "OSX"))
    {
	switch ($global:vmxtoolkit_type)
		{
		"win_x86_64"
			{
			Try 
				{
				if (!(Test-Path (Split-Path $destination)))
					{
					New-Item -ItemType Directory  -Path (Split-Path $destination) -Force
					}
				Set-LABUi -title " ==>Starting Download of $DownLoadUrl to $destination" -short
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
		default
			{
			$CurlArgs1 = "-L -# -o"
			$CurlArgs2 = "-C"
			$Curl = '/usr/bin/curl'
			Set-LABUi -title "$Curl $CurlArgs $destination $DownLoadUrl" -short
			Start-Process "/usr/bin/curl" -ArgumentList "$CurlArgs1 $destination $DownLoadUrl" -Wait -NoNewWindow
			}			
		}
    Set-LABUi
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
    'nw9201','nw9203','nw9204',#-#       
    'nw9111','nw9112','nw9113',#-#
	'nw9100','nw9102','nw9103','nw9104','nw9105','nw9106',#-#
    'nw9010','nw9011','nw9012','nw9013','nw9014','nw9015','nw9016','nw9017','nw9018','nw9019',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
	'nw824'
    'nw8230','nw8231','nw8232','nw8233','nw8234','nw8235','nw8236','nw8237','nw8238',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw8210',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw8200',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw8130',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw8120',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw8100',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012','nw8010',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw8000',
    'nwunknown'
#>

    [Parameter(ParameterSetName = "installer",Mandatory = $true)]
	[ValidateSet(
    'nw9201','nw9203','nw9204',#-#           
    'nw9111','nw9112','nw9113',#-#    
	'nw9100','nw9102','nw9103','nw9104','nw9105','nw9106',#-#
    'nw9010','nw9011','nw9012','nw9013','nw9014','nw9015','nw9016','nw9017','nw9018','nw9019',#
    'nw90.DA','nw9001','nw9002','nw9003','nw9004','nw9005','nw9006','nw9007','nw9008',
	'nw8240','nw8241','nw8242','nw8243','nw8244','nw8245','nw8246','nw8247',#-#
    'nw8230','nw8231','nw8232','nw8233','nw8234','nw8235','nw8236','nw8237','nw8238',
    'nw8226','nw8225','nw8224','nw8223','nw8222','nw8221','nw822',
    'nw8218','nw8217','nw8216','nw8215','nw8214','nw8213','nw8212','nw8211','nw8210',
    'nw8206','nw8205','nw8204','nw8203','nw8202','nw8200',
    'nw8138','nw8137','nw8136','nw8135','nw8134','nw8133','nw8132','nw8131','nw8130',
    'nw8127','nw8126','nw8125','nw8124','nw8123','nw8122','nw8121','nw8120',
    'nw8119','nw8118','nw8117','nw8116','nw8115','nw8114', 'nw8113','nw8112', 'nw811',
    'nw8105','nw8104','nw8103','nw8102','nw8100',
    'nw8044','nw8043','nw8042','nw8041',
    'nw8037','nw8036','nw8035','nw81034','nw8033','nw8032','nw8031',
    'nw8026','nw8025','nw81024','nw8023','nw8022','nw8021',
    'nw8016','nw8015','nw81014','nw8013','nw8012','nw8010',
    'nw8007','nw8006','nw8005','nw81004','nw8003','nw8002','nw8000',
    'nwunknown'
    )]
    $nw_ver,
    [Parameter(ParameterSetName = "nve_update",Mandatory = $true)][switch]$nveupdate,
    [Parameter(ParameterSetName = "nve",Mandatory = $true)][switch]$nve,
	[Parameter(ParameterSetName = "nve_update",Mandatory = $true)]
    [Parameter(ParameterSetName = "nve",Mandatory = $true)][ValidateSet(
    '9.2.0.3',#-#
    '9.0.1-72',#-#
    '9.1.1.1','9.1.1.2','9.1.1.3',#-#
	'9.1.0.3','9.1.0.4',#-#
	'9.0.1.1','9.0.1.2','9.0.1.3','9.0.1.4','9.0.1.5','9.0.1.6' #-#
	)]$nve_ver,
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
	[Parameter(ParameterSetName = "nve_update",Mandatory = $true)]
    [Parameter(ParameterSetName = "installer",Mandatory = $true)]
    [String]$Destination,
    [Parameter(ParameterSetName = "installer",Mandatory = $false)]
    [switch]$unzip,
    [Parameter(ParameterSetName = "nve",Mandatory = $false)]
    [Parameter(ParameterSetName = "installer",Mandatory = $false)]
    [switch]$force
    )
$Destination = Join-Path $Destination  "Networker"        
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
                }
			"9.1.0.91"
				{
				$url= "ftp://ftp.legato.com/pub/eval/2016Q4/nw91/NVE-9.1.0.91.ova"
				}
			"9.1.0.3"
				{
				$url= "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.0/9.1.0.3/ova-9.1-66_9.1.0-132.tar.gz"
				}
			"9.1.0.4"
				{
				$url= "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.0/9.1.0.4/ova-9.1-82_9.1.0-166.tar.gz"
				}
            "9.1.1.1"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.1/ova-9.1.1-145_9.1.1-107.tar.gz"    
                } 
            "9.1.1.2"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.2/ova-9.1.1-156_9.1.1-129.tar.gz"    
                } 
            "9.1.1.3"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.3/ova-9.1.1-189_9.1.1-188.tar.gz"    
                }
            "9.2.0.3"
                {
                $url = "https://download.emc.com/downloads/DL85770/ova-9.2-85_9.2.0-128.tar.gz"    
                }                              
            }
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
				break
                }
            }
            
        if ($Destination_Filename -match ".tar.gz") {
            Expand-LABpackage -Archive $Destination_Filename -destination $Destination -force
            $Destination_Tar = $Destination_Filename -replace ".gz"
            if ( Test-Path $Destination_Tar) {
                Expand-LABpackage -Archive $Destination_Tar -destination $Destination -force
            }
        }
    }
    "nve_update"
        {
        switch ($nve_ver)
            {
			"9.0.1.4"
				{
				$url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.0.1/9.0.1.4/avp-9.0.1-669_9.0.1-194.tar.gz"
				}
			"9.0.1.5"
				{
				$url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.0.1/9.0.1.5/avp-9.0.1-692_9.0.1-230.tar.gz"
				}
			"9.0.1.6"
				{
				$url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.0.1/9.0.1.6/avp-9.0.1-709_9.0.1-253.tar.gz"
				}
            "9.0.1-72"
                {
                $url ="ftp://ftp.legato.com/pub/eval/2016Q2/NveUpgrade-9.0.1.72.avp"
                }
			"9.1.0.91"
				{
				$url= "ftp://ftp.legato.com/pub/eval/2016Q4/nw91/NveUpgrade-9.1.0-91.avp"
				}
			"9.1.0.3"
				{
				$url= "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.0/9.1.0.3/avp-9.1-66_9.1.0-132.tar.gz"
				}
			"9.1.0.4"
				{
				$url= "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.0/9.1.0.4/avp-9.1-82_9.1.0-166.tar.gz"
                }
            "9.1.1.1"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.1/avp-9.1.1-145_9.1.1-107.tar.gz"    
                } 
            "9.1.1.2"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.2/avp-9.1.1-156_9.1.1-129.tar.gz"    
                } 
            "9.1.1.3"
                {
                $url = "ftp://ftp.legato.com/pub/NetWorker/NVE/9.1.1/9.1.1.3/avp-9.1.1-189_9.1.1-188.tar.gz"    
                }
            }
		if ($url)
			{
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
					Break
					}
				if ($Destination_Filename -match ".tar.gz")
					{
					Expand-LABpackage -Archive $Destination_Filename -destination $Destination -force
					}
				}
			}
		else 
			{
			Write-Host "No download found for $nve_ver Update"
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
                "91"
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
				#ftp://ftp.legato.com/pub/eval/2012Q3/
                "nw8000"
                    {
                    $nwzip = "nw80_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2012Q3/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2013Q1/
                "nw8010"
                    {
                    $nwzip = "nw80sp1_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2013Q1/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2013Q3/
                "nw8100"
                    {
                    $nwzip = "nw81_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2013Q3/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2014Q3/
                "nw8120"
                    {
                    $nwzip = "nw812_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2014Q3/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2015Q2/
				"nw8130"
                    {
                    $nwzip = "nw81sp3_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2015Q2/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2014Q3/
                "nw8200"
                    {
                    $nwzip = "nw82_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2014Q3/$nwzip"
                    }
                "nw8210"
                    {
                    $nwzip = "nw821_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2015Q1/$nwzip"
                    }
				#ftp://ftp.legato.com/pub/eval/2016Q1/
                "nw8230"
                    {
                    $nwzip = "nw823_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2016Q1/$nwzip"
                    }
                "nw8240"
                    {
                    $nwzip = "nw824_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2016Q4/$nwzip"
                    }
                "nw9000"
                    {
                    $nwzip = "nw900_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2015Q4/$nwzip"
                    }                
				"nw9010"
                    {
                    $nwzip = "nw901_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2016Q2/$nwzip"
                    }
				"nw9102"
                    {
                    $nwzip = "nw91_$arch.$Extension"
                    $url = "ftp://ftp.legato.com/pub/eval/2016Q4/nw91/$nwzip"
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
					Expand-LABpackage -Archive $Zipfilename -destination $Destinationdir
    
                    # Expand-LABZip -zipfilename "$Zipfilename" -destination "$Destinationdir"
                    }
<#
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
#>

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
    'nmm9201','nmm9203',#-# 
    'nmm9111','nmm9112','nmm9113',#-#   
	'nmm9100','nmm9102','nmm9103','nmm9104','nmm9105','nmm9106',#-#
    'nmm9010','nmm9011','nmm9012','nmm9013','nmm9014','nmm9015','nmm9016','nmm9017','nmm9018','nmm9019',#
    'nmm90.DA','nmm9001','nmm9002','nmm9003','nmm9004','nmm9005','nmm9006','nmm9007','nmm9008',
	'nmm8240','nmm8241','nmm8242','nmm8243','nmm8244','nmm8246',#-#
	'nmm230','nmm8231','nmm8232','nmm8233','nmm8235','nmm8236','nmm8237','nmm8238',
    'nmm8221','nmm8222','nmm8223','nmm8224','nmm8225','nmm8226',
    'nmm8218','nmm8217','nmm8216','nmm8214','nmm8212','nmm8210'
	#>
    [ValidateSet(
    'nmm9201','nmm9203',#-#         
    'nmm9111','nmm9112','nmm9113',#-#   
	'nmm9100','nmm9102','nmm9103','nmm9104','nmm9105','nmm9106',#-#
    'nmm9010','nmm9011','nmm9012','nmm9013','nmm9014','nmm9015','nmm9016','nmm9017','nmm9018','nmm9019',#
    'nmm90.DA','nmm9001','nmm9002','nmm9003','nmm9004','nmm9005','nmm9006','nmm9007','nmm9008',
	'nmm8240','nmm8241','nmm8242','nmm8243','nmm8244','nmm8246',#-#
	'nmm230','nmm8231','nmm8232','nmm8233','nmm8235','nmm8236','nmm8237','nmm8238',
    'nmm8221','nmm8222','nmm8223','nmm8224','nmm8225','nmm8226',
    'nmm8218','nmm8217','nmm8216','nmm8214','nmm8212','nmm8210'
    )]
    $nmm_ver,
    [String]$Destination,
    [switch]$unzip,
    [switch]$force
    )
$nmm_scvmm_ver = $nmm_ver -replace "nmm","scvmm"
$Destination = Join-Path $Destination  "Networker"        


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
        "821"
            {
			if ($nmm_ver -eq "nmm8210")
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/eval/2015Q1/$nmm_zip",
					"ftp://ftp.legato.com/pub/eval/2015Q1/$scvmm_zip")
				}
			else
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
					"ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
				}
			}

        "823"
            {
			if ($nmm_ver -eq "nmm8230")
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/eval/2016Q1/$nmm_zip",
					"ftp://ftp.legato.com/pub/eval/2016Q1/$scvmm_zip")
				}
			else
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
					"ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
				}
			}
        "824"
            {
			if ($nmm_ver -eq "nmm8240")
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/eval/2016Q4/$nmm_zip",
					"ftp://ftp.legato.com/pub/eval/2016Q4/$scvmm_zip")
				}
			else
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
					"ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
				}
			}
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
        "910"
            {
			$nmm_family = "91"
			if ($nmm_ver -eq "nmm9102")
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/eval/2016Q4/nw91/$nmm_zip",
					"ftp://ftp.legato.com/pub/eval/2016Q4/nw91/$scvmm_zip")
				}
			else
				{
				$nmm_zip = "nmm$($nmm_family)_win_x64.zip"
				$SCVMM_zip = "scvmm$($nmm_family)_win_x64.zip"
				$urls = ("ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$nmm_zip",
					"ftp://ftp.legato.com/pub/NetWorker/NMM/Cumulative_Hotfixes/$($nmmdotver.Substring(0,5))/$nmmdotver/$scvmm_zip")
				}
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
            Expand-LABpackage -Archive "$Zipfile" -destination "$Destinationdir" -verbose
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
    [ValidateSet('SC2012_R2','SC2016')]
    $SC_VERSION = "SC2012_R2",
    [Parameter(Mandatory = $true)][ValidateSet('SCOM','SCVMM','SCO','SCDPM','ConfigMGR','SCAC')]$Component,
    [Parameter(Mandatory = $true)][String]$Destination,
    [String]$Product_Dir= "SysCtr",
    [String]$Prereq = "prereq",
    [switch]$unzip,
    [switch]$force
)
$Component = $Component.ToUpper()
    Try
        {
        $Product_Dir = Join-path (Join-Path $Destination $Product_Dir) $SC_Version
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Product_Dir"
        break
        }    
    
    
    Write-Host -ForegroundColor Gray " ==>SCDIR : $Product_Dir"
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
try 
     {
     $Prereq_Dir = Join-Path (join-path $Destination $Prereq) $SC_VERSION -ErrorAction stop
     }
catch
     {
     Write-Warning "error finding Destination Directory !"
     }
if (!(Test-Path $Prereq_Dir))    
	{
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $Prereq_Dir"
        $NewDirectory = New-Item -ItemType Directory -Path $Prereq_Dir -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $Prereq_Dir"
        break
        }
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
    if (!(test-path  (join-path $Prereq_Dir $FileName)))
        {
        Write-Host -ForegroundColor Gray " ==>Trying Download"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  (join-path $Prereq_Dir $FileName)))
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
			#$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/05/kb3147191_adminconsole_amd64_44c4ccfe8d85f44ba4a64404a9b2700eb2008fb8.cab"
			$Latest_UR_ADMINCONSOLE = "http://download.microsoft.com/download/B/E/7/BE757BC7-8B8F-4FB8-8AE8-83F02F3F4988/kb3199246_AdminConsole_amd64.msp"
			#$Latest_UR_SERVER = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/05/kb3147167_vmmserver_amd64_9683b2eb7ac71cfddc08f9a02123071114f76c47.cab"
            $Latest_UR_SERVER = "http://download.microsoft.com/download/B/E/7/BE757BC7-8B8F-4FB8-8AE8-83F02F3F4988/kb3199246_vmmserver_amd64.msp"
			$UR = $true
			}
        "SC2016"
            {
            $adkurl = "http://download.microsoft.com/download/9/A/E/9AE69DD5-BA93-44E0-864E-180F5E700AB4/adk/adksetup.exe" #ADKsetup 10_1607
            $URL = "http://care.dlservice.microsoft.com/dl/download/2/B/8/2B8C6E4F-7918-40A6-9785-986D4D1175A5/SC2016_SCVMM.EXE"
            $WAIK_VER = "WAIK_10_1607"
			#$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/c/msdownload/update/software/uprl/2016/10/kb3190598_adminconsole_amd64_060d74669243b992442f10bea58f1fdac123c570.cab"
			#$Latest_UR_SERVER = "http://download.windowsupdate.com/c/msdownload/update/software/uprl/2016/10/kb3190597_vmmserver_amd64_e9309c8483010256b1b7fb4983572f2dcb04c80c.cab"
			#$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2017/01/kb3209586_vmmserver_amd64_2d0a8b66564aaac2459959d2b7c142e07e0d939c.cab"
			#$Latest_UR_SERVER = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2017/01/kb3209586_vmmserver_amd64_2d0a8b66564aaac2459959d2b7c142e07e0d939c.cab"
            $Latest_UR_SERVER ="http://download.windowsupdate.com/c/msdownload/update/software/updt/2017/02/kb4011491_vmmserver_amd64_dd697546265af71d9edc388fe23803dad3146271.cab"
            $Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2017/02/kb4011492_adminconsole_amd64_2e008dcc1aa7f36bb3f449be93debca9314ffc78.cab"
			$UR = $true
            }
    }# end switch
    Write-Host -ForegroundColor Gray " ==>Testing $WAIK_VER in $Destination"
    $WAIK_DIR = Join-Path $Destination $WAIK_VER
    if (!(test-path  "$WAIK_DIR"))
        {
        New-Item -ItemType Directory $WAIK_DIR -Force | Out-Null
        }
    $FileName = Split-Path -Leaf -Path $adkurl
    if (!(test-path  (join-path $WAIK_DIR 'Installers')))
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
        Start-Process -FilePath (join-path $WAIK_DIR $FileName) -ArgumentList "/quiet /layout $WAIK_DIR" -Wait -WindowStyle Normal -PassThru
        }
    } # end SCVMM
if ($Component -match 'SCOM')
    {
    Write-Host -ForegroundColor Gray " ==>we are now going to test $Component prereqs"
		        
			Switch ($SC_VERSION)
				{
				'SC2016'
					{
					$DownloadUrls= (
					'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi',
					#'https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi',
					#'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi',
					'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
					)

					}
				default
					{
					$DownloadUrls= (
					#https://download.microsoft.com/download/A/1/2/A129F694-233C-4C7C-860F-F73139CF2E01/ENU/x86/ReportViewer.msi
					'http://download.microsoft.com/download/F/B/7/FB728406-A1EE-4AB5-9C56-74EB8BDDF2FF/ReportViewer.msi',
					'http://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/SQLSysClrTypes.msi'
					)
					}

				}

    Foreach ($URL in $DownloadUrls)
    {
    $FileName = Split-Path -Leaf -Path $Url
    Write-Host -ForegroundColor Gray " ==>Testing $FileName in $Prereq_Dir"
    if (!(test-path  (join-path $Prereq_Dir $FileName))) 
        {
        Write-Host -ForegroundColor Gray " ==>Trying Download"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  (join-path $Prereq_Dir $FileName)))
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
			$Latest_UR_SERVER = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/08/kb3183990-amd64-server_7cb9b71b43dfd1d021e9763587b99aa63d519924.cab"
			$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2016/08/kb3183990-amd64-enu-console_53f29af4b869596567a8d3af67c92f738016124d.cab"
			
			$UR = $true
            }
        
        "SC2016"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/6/4/F/64F31A3C-D4FD-41B9-8EF5-74B1A87721E2/SC2016_SCOM_EN.EXE"
			#$Latest_UR_SERVER = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/10/kb3190029-amd64-server_98ce5e30a75646f68eb65351b10e2fea1384b83b.cab"
			#$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/10/kb3190029-amd64-enu-console_dc7df4d8fc15f24ee7331c423b98c22cf6c9c6ab.cab"
			#ur2
			$Latest_UR_SERVER = "http://download.windowsupdate.com/d/msdownload/update/software/uprl/2017/02/kb3209591-amd64-server_003575ae652462b88e8593f893e7fc9b73144636.cab"
			$Latest_UR_ADMINCONSOLE = "http://download.windowsupdate.com/c/msdownload/update/software/uprl/2017/02/kb3209591-amd64-enu-console_a1956c8cc78ba17719bf451d08629d6e04aba7ad.cab"

			$UR = $true
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
        
        "SC2016"
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/1/6/6/166A63BF-E3CE-49EF-8E8D-D599995C6E75/SC2016_SCDPM.EXE"
            }
        }    
}#end scdpm

    $FileName = Split-Path -Leaf -Path $Url
    Write-Host -ForegroundColor Gray " ==>Testing $SC_Version"
    if (!(test-path  (join-path $Product_Dir $FileName)) -or $force.IsPresent) 
        {
        Write-Host -ForegroundColor Gray " ==>Getting $SC_Version $FileName, Could take a While"

        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  (join-path $Product_Dir $FileName)))
            { 
            write-warning "Error Downloading file $Url, Please check connectivity"
            return $False
            }
        Unblock-File -Path (join-path $Product_Dir $FileName)
        }
    if ($unzip.IsPresent) 
        {
        if ((Test-Path (join-path $Product_Dir (join-path $Component "Setup.exe"))) -and !$force.IsPresent)
            { 
            Write-Warning "setup.exe already exists, overwrite with -force"
            $returnvalue =  $true
            }
        else
            {
            Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
            Start-Process (join-path $Product_Dir $FileName) -ArgumentList "/SP- /dir=$Product_Dir\$Component /SILENT" -Wait
            $returnvalue = $true
            }
        }
	if ($UR)
	{
		Write-Host "Downloading URs"
		foreach ($URL in ($Latest_UR_ADMINCONSOLE,$Latest_UR_SERVER))
		{
			$Component_Dir = Join-Path $Product_Dir $Component
            if (!(test-path $Component_Dir))
                {
                    New-Item -ItemType Directory $Component_Dir
                }
			$Update_Dir = Join-Path $Component_Dir "$($Component)Updates"
            if (!(test-path $Update_Dir))
                {
                    New-Item -ItemType Directory $Update_Dir
                }
			$FileName = Split-Path -Leaf -Path $Url
			$Update_File = Join-Path $Update_Dir $FileName
			Write-Host -ForegroundColor Gray " ==>Testing $SC_Version Updates"
			if (!(test-path  "$Update_File") -or $force.IsPresent) 
				{
				Write-Host -ForegroundColor Gray " ==>Getting $Update_File, Could take a While"

				if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination "$Update_File"))
					{ 
					write-warning "Error Downloading file $Url, Please check connectivity"
					}
				}
			if ($unzip.IsPresent -and $Update_File -match ".cab") 
				{
					Expand-LABpackage -Archive $Update_File -destination $Update_Dir -force
					#Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
					#Start-Process "$Product_Dir\$FileName" -ArgumentList "/SP- /dir=$Product_Dir\$Component /SILENT" -Wait
					#$return = $true
				}
			}	
		}
return $returnvalue
}

<#
.DESCRIPTION
   receives latest Sharepoint Versions from Microsoft by Give CU / SP
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABSharepoint
.EXAMPLE

#>
#requires -version 3
function Receive-LABSharepoint
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
    [Parameter(ParameterSetName = "sp16",Mandatory = $true)][switch][alias('sp16')]$Sharepoint2016,
    #[Parameter(ParameterSetName = "sp16", Mandatory = $false)]
    #[ValidateSet('final','cu1','cu2','cu3','cu4','cu5')]
    #$sp16_cu,
	[Parameter(ParameterSetName = "sp13",Mandatory = $true)][switch][alias('sp3')]$Sharepoint2013,
    #[Parameter(ParameterSetName = "sp13", Mandatory = $false)]
    #[ValidateSet('cu1')]
    #$sp13_cu,
    #[Parameter(ParameterSetName = "E14",Mandatory = $true)][switch][alias('e14')]$Sharepoint2010,
    #[Parameter(ParameterSetName = "E14", Mandatory = $false)]
    #[ValidateSet(ur1','ur2','ur3','ur4','ur5','ur6','ur7','ur8v2','ur9','ur10','ur11','ur12','ur13','ur14','ur15','ur16')]
    #$e14_ur = "ur13",
   # [Parameter(ParameterSetName = "E14", Mandatory = $false)]
   # [ValidateSet('de_DE','en_US')]
    #$e14_lang = "de_DE",
    [Parameter(Mandatory = $true)][String]$Destination,
    [String]$Product_Dir= "Sharepoint",
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

#############
if ($Sharepoint2016)
    {
    $sp_version = "SP2016"
    $Prereq_Dir = Join-Path $Product_Dir "$sp_version$Prereq"
    Write-Host -ForegroundColor Gray " ==>prereq = $Prereq_Dir"
	if (Test-Path -Path "$Prereq_Dir")
		{
		Write-Host -ForegroundColor Gray " ==>$Prereq_Dir found"
		}
	else
		{
		Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for $sp_version Prereqs"
		New-Item -ItemType Directory -Path $Prereq_Dir -Force | Out-Null
		}
    $Product_Dir = Join-Path $Product_Dir $sp_version
    #$ex_cu = $sp16_cu

    Write-Host -ForegroundColor Gray " ==>we are now going to test $sp_version prereqs"
    $DownloadUrls = (
					"https://download.microsoft.com/download/4/B/1/4B1E9B0E-A4F3-4715-B417-31C82302A70A/ENU/x64/sqlncli.msi",#Microsoft SQL Server 2012 SP1 Native Client
					"https://download.microsoft.com/download/5/7/2/57249A3A-19D6-4901-ACCE-80924ABEB267/1033/amd64/msodbcsql.msi",#Microsoft ODBC Driver 11 for SQL Server
					"http://download.microsoft.com/download/E/0/0/E0060D8F-2354-4871-9596-DC78538799CC/Synchronization.msi",#Microsoft Sync Framework Runtime v1.0 SP1 (x64)
					"https://download.microsoft.com/download/A/6/7/A678AB47-496B-4907-B3D4-0A2D280A13C0/WindowsServerAppFabricSetup_x64.exe",#Windows Server AppFabric 1.1
					"http://download.microsoft.com/download/0/1/D/01D06854-CA0C-46F1-ADBA-EBF86010DCC6/rtm/MicrosoftIdentityExtensions-64.msi",#Windows Identity Foundation (KB974405)
					"http://download.microsoft.com/download/3/C/F/3CF781F5-7D29-4035-9265-C34FF2369FA2/setup_msipc_x64.exe",#Microsoft Information Protection and Control Client 2.1
					"http://download.microsoft.com/download/1/C/A/1CAA41C7-88B9-42D6-9E11-3C655656DAB1/WcfDataServices.exe",#Microsoft WCF Data Services 5.6
					"https://download.microsoft.com/download/F/1/0/F1093AF6-E797-4CA8-A9F6-FC50024B385C/AppFabric-KB3092423-x64-ENU.exe",#Cumulative Update Package 7 for Microsoft AppFabric 1.1 for Windows Server (KB 3092423)
					"https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe",#Visual C++ Redistributable Package for Visual Studio 2012
					"https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe",#Visual C++ Redistributable Package for Visual Studio 2015
					"http://download.microsoft.com/download/0/3/E/03EB1393-4F4E-4191-8364-C641FAB20344/50901.00/Silverlight_x64.exe" #Exchange Managed WEB API
                     )
    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  (join-path $Prereq_Dir $FileName)))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination (join-path $Prereq_Dir $FileName)))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Prereq_Dir"
            }
        }
    Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 46   
    switch ($sp16_cu)
        {
        default
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/0/0/4/004EE264-7043-45BF-99E3-3F74ECAE13E5/officeserver.img"
			}
        }
    }
if ($Sharepoint2013)
    {
    $sp_version = "SP2013"
	$Prereq_Dir = Join-Path $Product_Dir "$sp_version$Prereq"
    Write-Host -ForegroundColor Gray " ==>prereq = $Prereq_Dir"
	if (Test-Path -Path "$Prereq_Dir")
		{
		Write-Host -ForegroundColor Gray " ==>$Prereq_Dir found"
		}
	else
		{
		Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for $sp_version Prereqs"
		New-Item -ItemType Directory -Path $Prereq_Dir -Force | Out-Null
		}
    $Product_Dir = Join-Path $Product_Dir $sp_version  

    Write-Host -ForegroundColor Gray " ==>we are now going to test $sp_version prereqs"
    $DownloadUrls = (
					"http://download.microsoft.com/download/9/1/3/9138773A-505D-43E2-AC08-9A77E1E0490B/1033/x64/sqlncli.msi", # Microsoft SQL Server 2008 R2 SP1 Native Client
					"http://download.microsoft.com/download/E/0/0/E0060D8F-2354-4871-9596-DC78538799CC/Synchronization.msi", # Microsoft Sync Framework Runtime v1.0 SP1 (x64)
					"http://download.microsoft.com/download/A/6/7/A678AB47-496B-4907-B3D4-0A2D280A13C0/WindowsServerAppFabricSetup_x64.exe", # Windows Server App Fabric
					"http://download.microsoft.com/download/7/B/5/7B51D8D1-20FD-4BF0-87C7-4714F5A1C313/AppFabric1.1-RTM-KB2671763-x64-ENU.exe", # Cumulative Update Package 1 for Microsoft AppFabric 1.1 for Windows Server (KB2671763)
					"http://download.microsoft.com/download/D/7/2/D72FD747-69B6-40B7-875B-C2B40A6B2BDD/Windows6.1-KB974405-x64.msu", #Windows Identity Foundation (KB974405)
					"http://download.microsoft.com/download/0/1/D/01D06854-CA0C-46F1-ADBA-EBF86010DCC6/rtm/MicrosoftIdentityExtensions-64.msi", # Microsoft Identity Extensions
					"http://download.microsoft.com/download/9/1/D/91DA8796-BE1D-46AF-8489-663AB7811517/setup_msipc_x64.msi", # Microsoft Information Protection and Control Client
					"http://download.microsoft.com/download/8/F/9/8F93DBBD-896B-4760-AC81-646F61363A6D/WcfDataServices.exe" # Microsoft WCF Data Services 5.0
                )

    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  (join-path $Prereq_Dir $FileName)))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination (join-path $Prereq_Dir $FileName)))
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
    Switch ($sp13_cu)
        {
        default
            {
            $URL = "http://care.dlservice.microsoft.com/dl/download/3/D/7/3D713F30-C316-49B8-9CC0-E1BFC34B63A0/SharePointServer_x64_en-us.img"
			}
		}
    } 
$FileName = Split-Path -Leaf -Path $Url
$Downloadfile = Join-Path $Product_Dir $FileName
if (!(Test-path $Product_Dir))
	{
	New-Item -ItemType Directory -Path $Product_Dir
	}
if (!(test-path  $Downloadfile))
    {
    Write-Host -ForegroundColor Gray " ==>we are now Downloading $Downloadfile from $url, this may take a while"
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
    $SP_CU_PATH = Join-Path $Product_Dir "$sp_version$ex_cu"
    Write-Verbose $SP_CU_PATH
    if ((Test-Path (join-path "$SP_CU_PATH" "Setup.exe")) -and (!$force.IsPresent))
        { 
        Write-Host -ForegroundColor Gray "setup.exe already exists, overwrite with -force"
        return $true
        }
    else
        {
        Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
        Start-Process (join-path $Product_Dir $FileName) -ArgumentList "/extract:$Product_Dir\$SP_version$sp_cu /passive" -Wait
        $return = $true
        }
    }
elseif (($Filename.Contains(".iso")) -or ($Filename.Contains(".img")))
    { 
    Write-Host -ForegroundColor Gray " ==>no unzip required, CU delivered as ISO"
    $return = $true
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
    [ValidateSet('final','cu1','cu2','cu3','cu4','cu5','cu6','cu7')]
    $e16_cu,
    [Parameter(ParameterSetName = "E15",Mandatory = $true)][switch][alias('e15')]$Exchange2013,
    [Parameter(ParameterSetName = "E15", Mandatory = $false)]
    [ValidateSet('cu1','cu2','cu3','sp1','cu5','cu6','cu7','cu8','cu9','cu10','cu11','cu12','cu13','cu14','cu15','cu16','cu17','cu18')]
    $e15_cu,
    [Parameter(ParameterSetName = "E14",Mandatory = $true)][switch][alias('e14')]$Exchange2010,
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('ur1','ur2','ur3','ur4','ur5','ur6','ur7','ur8v2','ur9','ur10','ur11','ur12','ur13','ur14','ur15','ur16','ur17','ur18')]
    $e14_ur = "ur13",
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('sp3')]
    $e14_sp="sp3",
    [Parameter(ParameterSetName = "E14", Mandatory = $false)]
    [ValidateSet('de_DE','en_US')]
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
	if ($ex_cu -lt "cu3")
		{
		$NET_VER = "452"
		}
	else
		{
		$NET_VER = "462"
		}
    $Product_Dir = Join-Path $Product_Dir $ex_version
    Write-Host -ForegroundColor Gray " ==>we are now going to test $EX_Version prereqs"
    $DownloadUrls = (
		       #"http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe",
                "http://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe"
                )
    foreach ($URL in $DownloadUrls)
        {
        $FileName = Split-Path -Leaf -Path $Url
        if (!(test-path  (join-path $Prereq_Dir $FileName)))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination (join-path $Prereq_Dir $FileName)))
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
	Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver $NET_VER   
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
        'CU3'
            {
            $URL = "https://download.microsoft.com/download/4/C/E/4CE65F66-CE89-4F4D-96C0-A97E08FA1693/ExchangeServer2016-x64-cu3.iso"
            }
		'CU4'
			{
			$URL = 'https://download.microsoft.com/download/B/9/F/B9F59CF4-7C60-49EF-8A5B-8C2B7991FA86/ExchangeServer2016-x64-cu4.iso'
			}
		'CU5'
			{
			$URL = 'https://download.microsoft.com/download/A/A/7/AA7F69B2-9E25-4073-8945-E4B16E827B7A/ExchangeServer2016-x64-cu5.iso'
            }
        'CU6'
			{
			$URL = 'https://download.microsoft.com/download/2/D/B/2DB1EEA2-CD9B-48F1-8235-1C9B82D19D68/ExchangeServer2016-x64-cu6.iso'
			}
        'CU7'
			{
			$URL = 'https://download.microsoft.com/download/0/7/4/074FADBD-4422-4BBC-8C04-B56428667E36/ExchangeServer2016-x64-cu7.iso'
			}
        }
    }
if ($Exchange2013)
    {
    $ex_cu = $e15_cu
	if ($ex_cu -lt "cu16")
		{
		$NET_VER = "452"
		}
	else
		{
		$NET_VER = "462"
		}

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
        if (!(test-path  (join-path $Prereq_Dir $FileName)))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination (join-path $Prereq_Dir $FileName)))
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
    Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver $NET_VER 
	$Mapi_CDO = Join-Path $Prereq_Dir (Join-Path "ExchangeMapiCdo" "ExchangeMapiCdo.msi") 
    Write-Host -ForegroundColor Gray " ==>Testing $Mapi_CDO"      
    if (!(test-path  "$Mapi_CDO"))
        {
        Write-Host -ForegroundColor Gray " ==>Extracting MAPICDO"
        Expand-LABpackage -Archive (Join-Path $Prereq_Dir 'ExchangeMapiCdo.EXE') -destination $Prereq_Dir
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
		"CU14"
            {
            $url = "https://download.microsoft.com/download/0/C/E/0CE142F1-E61D-4DBF-9436-334A4045A91F/Exchange2013-x64-cu14.exe"
			}
		"CU15"
			{
			$URL = "https://download.microsoft.com/download/3/A/5/3A5CE1A3-FEAA-4185-9A27-32EA90831867/Exchange2013-x64-cu15.exe"
			}
		'cu16'
			{
			$URL = 'https://download.microsoft.com/download/7/B/9/7B91E07E-21D6-407E-803B-85236C04D25D/Exchange2013-x64-cu16.exe'
            }
        'cu17'
			{
			$URL = 'https://download.microsoft.com/download/D/E/1/DE1C3D22-28A6-4A30-9811-0A0539385E51/Exchange2013-x64-cu17.exe'
            }
        'cu18'
			{
            $URL = 'https://download.microsoft.com/download/5/9/8/598B1735-BC2E-43FC-88DD-0CDFF838EE09/Exchange2013-x64-cu18.exe'
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
	switch ($e14_lang)
		{
		"de_DE"
			{
			$DownloadUrls = (
						'http://download.microsoft.com/download/6/2/D/62DFA722-A628-4CF7-A789-D93E17653111/ExchangeMapiCdo.EXE',
						'https://download.microsoft.com/download/D/F/F/DFFB3570-3264-4E01-BB9B-0EFDA4F9354F/UcmaRuntimeSetup.exe',
						'https://download.microsoft.com/download/0/1/3/0131A8C8-001B-4448-9DD8-62C98D862560/filterpack2010sp1-kb2460041-x64-fullfile-de-de.exe',
						'https://download.microsoft.com/download/D/1/2/D12F3512-6BED-4D5B-919A-DDD42C41F839/FilterPack64bit.exe'
						)
			}
		"en_US"
			{
			$DownloadUrls = (
						'http://download.microsoft.com/download/6/2/D/62DFA722-A628-4CF7-A789-D93E17653111/ExchangeMapiCdo.EXE',
						'https://download.microsoft.com/download/D/F/F/DFFB3570-3264-4E01-BB9B-0EFDA4F9354F/UcmaRuntimeSetup.exe',
						'https://download.microsoft.com/download/A/A/3/AA345161-18B8-45AE-8DC8-DA6387264CB9/filterpack2010sp1-kb2460041-x64-fullfile-en-us.exe',
						#'https://download.microsoft.com/download/0/1/3/0131A8C8-001B-4448-9DD8-62C98D862560/filterpack2010sp1-kb2460041-x64-fullfile-de-de.exe',
						'https://download.microsoft.com/download/D/1/2/D12F3512-6BED-4D5B-919A-DDD42C41F839/FilterPack64bit.exe'
						)
			}


			}
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
        if (!(test-path  (join-path $LANG_Prereq_Dir $FileName)))
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
    if (!(test-path  "$LANG_Prereq_Dir/ExchangeMapiCdo/ExchangeMapiCdo.msi"))
        {
        Write-Host -ForegroundColor Gray " ==>Extracting MAPICDO"
        Expand-LABpackage -Archive (Join-Path $LANG_Prereq_Dir 'ExchangeMapiCdo.EXE')-destination $LANG_Prereq_Dir
		#Start-Process -FilePath "$LANG_Prereq_Dir\ExchangeMapiCdo.EXE" -ArgumentList "/x:$LANG_Prereq_Dir /q" -Wait
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
        'ur14'
            {
            $de_DE_URL = 'https://download.microsoft.com/download/7/C/C/7CC9FCBA-7AFE-4A9E-A728-18C90C79D846/Exchange2010-KB3151097-x64-de.msp'
            $en_US_URL = 'https://download.microsoft.com/download/6/0/C/60C7CA35-8725-4FC3-BD7F-186D1695CE1F/Exchange2010-KB3151097-x64-en.msp'
            }
        'ur15'
            {
            $de_DE_URL = 'https://download.microsoft.com/download/E/5/3/E53BD2CD-BBF2-4B5F-AF5F-E8A098CEB9FB/Exchange2010-KB3184728-x64-de.msp'
            $en_US_URL = 'https://download.microsoft.com/download/7/B/C/7BC68310-0D80-4853-9663-A26E333C1F95/Exchange2010-KB3184728-x64-en.msp'
            }
		'ur16'
			{
			$de_DE_URL = "https://download.microsoft.com/download/E/4/B/E4BC16FF-DD7F-49EC-9460-178F8DA2890E/Exchange2010-KB3184730-x64-de.msp"
			$en_US_URL = "https://download.microsoft.com/download/8/A/4/8A4D8150-3757-4EC5-8CFB-8E28124EF390/Exchange2010-KB3184730-x64-en.msp"
            }
        'ur17'
			{
			$de_DE_URL = "https://download.microsoft.com/download/6/C/5/6C52002A-0F0E-4305-9575-8058B70A9F1C/Exchange2010-KB4011326-x64-de.msp"
			$en_US_URL = "https://download.microsoft.com/download/F/6/5/F658C317-2DA5-4693-B294-A6AF146C8BB1/Exchange2010-KB4011326-x64-en.msp"
			}
        'ur18'
			{
            $de_DE_URL = 'https://download.microsoft.com/download/8/4/4/8448AD24-C5DE-4A57-904F-CDE3FFC17C82/Exchange2010-KB4018588-x64-de.msp'
            $en_US_URL = 'https://download.microsoft.com/download/6/2/C/62CC17A0-AAD5-4819-8E89-A7D368697513/Exchange2010-KB4018588-x64-en.msp'
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
		if (!(Test-path $Product_Dir))
			{
			New-Item -ItemType Directory -Path $Product_Dir
			}
        if (!(test-path  $Downloadfile))
            {
            Write-Host -ForegroundColor Gray " ==>we are now Downloading $Downloadfile from $url, this may take a while"
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
            if ((Test-Path (join-path "$EX_CU_PATH" "Setup.exe")) -and (!$force.IsPresent))
                { 
                Write-Host -ForegroundColor Gray "setup.exe already exists, overwrite with -force"
                return $true
                }
            else
                {
                Write-Host -ForegroundColor Gray " ==>we are going to extract $FileName, this may take a while"
                Start-Process (join-path $Product_Dir $FileName) -ArgumentList "/extract:$Product_Dir\$ex_version$ex_cu /passive" -Wait
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
    
    #$Uri = "http://www.emc.com/products-solutions/trial-software-download/scaleio.htm"
    #$request = Invoke-WebRequest -Uri $Uri -UseBasicParsing
    foreach ($arch in $MyArch)
    {
    write-host -ForegroundColor Gray " ==>we will check for the latest ScaleIO $arch version from EMC.com"        
	$Extract_Path = Join-Path $Destination_path "ScaleIO_$($Arch)_SW_Download"
    switch ($arch)
		{
		'VMware'
			{
            $Url = "http://downloads.emc.com/emc-com/usa/ScaleIO/ScaleIO_2.0.1.3_Complete_VMware_SW_Download.zip"
            $uri = ((Invoke-WebRequest -UseBasicParsing -Uri "https://www.emc.com/scaleiovmwaresoftwaredownload.htm").links | where  OuterHtml -Match 'zip').href
			}
		'Windows'
			{
			$Url= "http://downloads.emc.com/emc-com/usa/ScaleIO/ScaleIO_2.0.1.3_Complete_Windows_SW_Download.zip"
            $uri = ((Invoke-WebRequest -UseBasicParsing -Uri "https://www.emc.com/scaleiowindowssoftwaredownload.htm").links | where  OuterHtml -Match 'zip').href
			}
		'Linux'
			{
			$Url = "http://downloads.emc.com/emc-com/usa/ScaleIO/ScaleIO_2.0.1.3_Complete_Linux_SW_Download.zip"
            $uri = ((Invoke-WebRequest -UseBasicParsing -Uri "https://www.emc.com/scaleiolinuxsoftwaredownload.htm").links | where  OuterHtml -Match 'zip').href
			}
		}
	
    if ($uri)
        {
            $url = $uri -replace '\s',''
        }
    else 
        {
            Write-Host "Could not parse download, using default url"
        }
	#$DownloadLinks = $request.Links | where href -match $arch
    #foreach ($Link in $DownloadLinks)
        #{
        #$Url = $link.href
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
                    $Downloadok = Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File"
                    # $Downloadok = $true
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
        #}#
		Write-Host " ==>Reading Package Content"
		$Package_Content = .$VMware_Packer l $Destination_File
		$Package_Content = $Package_Content -match "EMC-ScaleIO-lia" | Select-Object -First 1
		$LIA_File = Split-Path -Leaf $Package_Content
		Write-host "Got $LIA_File"
		$ver = $LIA_File -replace "EMC-scaleio-lia-"
		$ver = $ver -replace ".{4}$"
		Write-Host " ==>Got Version $ver"
		Write-Output $ver 
        if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
            {
			#if ($force.IsPresent)
			#	{
				$Package = Expand-LABpackage -Archive "$Destination_File" -destination  "$Extract_Path" -force
			#	}
			#else
			#	{
			#	$Package = Expand-LABpackage -Archive "$Destination_File" -destination  "$Extract_Path"
			#	}
            ## linug deb packages
			if ($arch -eq "linux")
				{
				Write-Verbose "getting latest UBUNTU Directory"
				$Ubuntu = Get-ChildItem -Path $Extract_Path -Include *UBUNTU* -Recurse -Directory
				$Ubuntudir = $Ubuntu | Sort-Object -Descending | Select-Object -First 1
				$tarfiles = Get-ChildItem -Path $Ubuntudir -Filter "*.tar" -Recurse -Include *Ubuntu*
				foreach ($tarfile in $tarfiles)
					{
					Write-Host -ForegroundColor Gray " ==>Expanding UBUNTU siob tars"
					Expand-LABpackage -Archive $tarfile -destination $tarfile.Directory -force -chmod 755
					}

				}
				
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
$Link = $request.Links | where OuterHTML -Match simulator.zip | Select-Object -First 1
$Url = $link.href
Write-Verbose $Url
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
    Expand-LABpackage -Archive "$Destination_File" -destination "$Destination_path"
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
    $Destination="./",
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
    [Parameter(ParameterSetName = "install", Mandatory = $false)]
    [System.IO.DirectoryInfo]$Destination="./",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [Parameter(ParameterSetName = "install", Mandatory = $false)]
    [ValidateSet(
    'win'
    )]
    [string]$arch="win",
    [Parameter(ParameterSetName = "install", Mandatory = $false)]
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'beta','stable'
    )]
    [string]$branch="stable",
	[switch]$force,
    [Parameter(ParameterSetName = "install", Mandatory = $true)]
	[switch]$install,
    [Parameter(ParameterSetName = "install", Mandatory = $true)]
	[System.IO.DirectoryInfo]$Install_Dir
)
$Product = 'docker'
#$Product_Download = '$'
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
[System.IO.FileInfo]$Destination_File = Join-Path $Destination_path $FileName
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    $DownloadOK = Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File" -force
    if (!$DownloadOK)
		{
		break
		}
	}
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $($Destination_File.fullname)"
    }
# Write-Output $Filename

if ($install.IsPresent)
	{
	$target_dir = Join-Path $Install_Dir $Product
	write-host " ==>installing $($Destination_File.fullname) in $target_dir"
	Start-Process "msiexec.exe" -ArgumentList "/a $($Destination_File.fullname) /qb TARGETDIR=$target_dir" -Wait -NoNewWindow
	$Files = ('docker.exe','docker-machine.exe','docker-compose.exe','docker-credential-wincred.exe','notary.exe')
	foreach ($file in $files)
		{
		Write-Host " ==>Copying $File to $target_dir"
		Get-ChildItem -Path "$target_dir\PFiles" -Recurse -Filter $file | Copy-Item -Destination $target_dir -Force -PassThru} 
		Write-Host " ==>getting DockerMachineDriver for VMware"
		$Download_URL = "https://github.com/pecigonzalo/docker-machine-vmwareworkstation/releases/download/v1.0.10/docker-machine-driver-vmwareworkstation.exe"
		$Destination_File = Join-Path $target_dir ( Split-Path -Leaf $Download_URL) 
		Invoke-WebRequest -Uri $Download_URL -OutFile $Destination_File -UseBasicParsing
		}
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
    $Destination="./",
	[switch]$start,
   <#
	Version of openwrt for labbuildr
    #>
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    '15_5','15_5_1'
    )]
    [string]$ver='15_5_1',
    [switch]$unzip
    #[switch]$force

)
$Product = 'OpenWRT'
$Destination_path = (get-item $Destination).fullname 
If ($start.IsPresent)
	{
	$unzip = $true
	}
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
write-host -ForegroundColor Magenta  "we will check for the latest OpenWRT version from Azure Repo"
$url = "https://labbuildrmaster.blob.core.windows.net/master/OpenWRT_$($ver).7z"
$Filename = Split-Path -Leaf $url
$Destination_File = Join-Path $Destination_path $FileName
Write-Verbose " Destination file: $Destination_File"
if (!(test-path -Path $Destination_File) -or ($force.IsPresent))
    {
    Write-Host -ForegroundColor Gray " ==>trying to download $Filename"
    Receive-LABBitsFile -DownLoadUrl  $URL -destination "$Destination_File" | Out-Null
    }
Else
    {
    Write-Host -ForegroundColor Gray  " ==>found $Destination_File"
    }
if ((Test-Path "$Destination_File") -and $unzip.IsPresent)
    {
    Expand-LABpackage -Archive "$Destination_File"  -destination $Destination | Out-Null
	Get-vmx "OpenWRT_$ver"
    }
if ($start.IsPresent)
	{
	$MyOpenwrt = Get-vmx "OpenWRT_$ver" 
    $MyOpenwrt | Set-VMXVnet -Adapter 0 -Vnet $Global:labdefaults.vmnet | Out-Null
    $Myopenwrt | start-vmx -nowait | Out-Null
	Set-LABOpenWRT -enabled
	Set-LABDefaultGateway -DefaultGateway ($Global:labdefaults.MySubnet -replace ".$","4")
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
    $Destination="./",
    <#
	Available Masters:
	==================
    '2016TP5','2016TP5_GER','2016','2016core',#
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE','openSUSE42_2',#
	'OpenWRT',
	'Centos7_3_1611','Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster',
    'photon-1.0-rev2'
	#>
	[Parameter(ParameterSetName = "vmware", Mandatory = $true)]
    [ValidateSet(
    '2016','2016core',#
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE','openSUSE42_2',#
	'OpenWRT',
	'Centos7_3_1611','Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster',
    'photon-1.0-rev2'
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
write-host -ForegroundColor Magenta  "we will check for the latest $Master $Product version"
Switch ($mastertype)
    {
    "vmware"
        {
		switch ($global:vmxtoolkit_type)
			{
<#			"LINUX"
				{
				$packer = 'rar'
				}
			"OSX"
				{
				$packer = 'rar'
				}
				#>
			default
				{
				$packer = '7z'
				}
			}
        }
    "hyperv"
        {
        $Packer = "zip"
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
    'photon-1.0-rev2'
        {
        $URL = "https://bintray.com/vmware/photon/download_file?file_path=photon-custom-hw11-1.0-62c543d.ova"
        $ova = $true
        }
    default
        {
        $URL = "https://labbuildrmaster.blob.core.windows.net/master/$Master.$Packer"
        }    
    }
    if ($URL -match "=") 
        {
        $FileName = ($URL -split "=")[-1]
        }
    else{
        $Filename = Split-Path -Leaf $url
        }
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
        "hyperv"
            {
            Expand-LABZip -zipfilename $Destination_File -destination $Destination
            }
		default
			{
            if ($ova)
                {
                Import-VMXOVATemplate -ova $Destination_File -destination $Destination -Name $Master -acceptAllEulas
                }
            else
                {
			    Expand-LABpackage -Archive $Destination_File -destination $Destination
                }
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
    [ValidateSet(#'SQL2014SP1slip','SQL2012','SQL2012SP1','SQL2012SP2','SQL2012SP1SLIP','SQL2014','SQL2016',
	'SQL2012_ISO',
	'SQL2014SP2_ISO',
	'SQL2016_ISO')]$SQLVER,
    [String]$Destination,
    [String]$Product_Dir= "SQL",
    [String]$Prereq = "prereq",
    [switch]$extract,
    [switch]$force,
    [switch]$no_ssms
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
    $SQL2014SP2_ISO = "http://care.dlservice.microsoft.com/dl/download/6/D/9/6D90C751-6FA3-4A78-A78E-D11E1C254700/SQLServer2014SP2-FullSlipstream-x64-ENU.iso"
	$SQL2012_ISO = "https://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/SQLFULL_ENU.iso"
	$SQL2016_box = "http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.box"
    $SQL2016_inst = "http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.exe"
    #$SQL2016_SSMS = "http://download.microsoft.com/download/E/D/3/ED3B06EC-E4B5-40B3-B861-996B710A540C/SSMS-Setup-ENU.exe"
    #$SQL2016_SSMS = "http://download.microsoft.com/download/7/8/0/7808D223-499D-4577-812B-9A2A60048841/SSMS-Setup-ENU.exe"
	#$SQL2016_SSMS = "https://download.microsoft.com/download/C/B/C/CBCFAAD1-2348-4119-B093-199EE7AADCBC/SSMS-Setup-ENU.exe"
    #$SQL2016_SSMS = "https://download.microsoft.com/download/9/3/3/933EA6DD-58C5-4B78-8BEC-2DF389C72BE0/SSMS-Setup-ENU.exe"
    #$SQL2016_SSMS ="https://download.microsoft.com/download/5/0/B/50B02ECB-CB5C-4C23-A1D3-DAB4467604DA/SSMS-Setup-ENU.exe"
    $sql2016_ssms = "https://download.microsoft.com/download/C/3/D/C3DBFF11-C72E-429A-A861-4C316524368F/SSMS-Setup-ENU.exe"
	$SSMS_LATEST = '17.2'
	#$SSMS_LATEST = '16.5.3'
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
	switch ($SQLVER)
		{
		"SQL2016_ISO"
			{
			$SQL_BASEVER = "SQL2016"
			$url = $SQL2016_ISO
			Receive-LABNetFramework -Destination $Prereq_Dir -Net_Ver 461 
		    $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
			$SSMS_FileName = Join-Path ($SQL_BASEDir) (Split-Path -Leaf $SQL2016_SSMS)
			try
				{
				$SSMS_VERSION_INFO = (Get-ChildItem $SSMS_FileName -ErrorAction SilentlyContinue).VersionInfo.ProductName 
				}
			catch 
				{
				write-host -ForegroundColor Gray " ==>No Previous SSMS Version Found"
				}

			if (!($SSMS_VERSION_INFO) -or $SSMS_VERSION_INFO -notmatch $SSMS_LATEST)
				{
                $SSMS_REQUIRED = $true        
				}
			else
				{
				Write-Host " ==> Found $SSMS_VERSION_INFO"
				}
			}
		"SQL2014SP2_ISO"
			{
			$SQL_BASEVER = "SQL2014"
			$url = $SQL2014SP2_ISO
			}
		"SQL2012_ISO"
			{
			$SQL_BASEVER = "SQL2012"
			$url = $SQL2012_ISO
			}
		}
    $SQL_BASEDir = Join-Path $Product_Dir $SQL_BASEVER
    $FileName = Join-Path ($SQL_BASEDir) (Split-Path -Leaf $URL)
    if (!(Test-Path $SQL_BASEDir))    
    {
    Try
        {
        Write-Host -ForegroundColor Gray " ==>Trying to create $SQL_BASEDir"
        $NewDirectory = New-Item -ItemType Directory -Path $SQL_BASEDir -ErrorAction Stop -Force
        }
    catch
        {
        Write-Warning "Could not create Destination Directory $SQL_BASEDir"
        break
        }
    }
    if ($no_ssms.ispresent)
        {
            $SSMS_REQUIRED = $false
        }
    if  ($SSMS_REQUIRED)
        {
        Write-Host -ForegroundColor Gray " ==> Getting SSMS $SSMS_LATEST"
        Receive-LABBitsFile -DownLoadUrl $SQL2016_SSMS -destination $SSMS_FileName -force
        }
    if (!(Test-Path $FileName))
        {
        Write-Host -ForegroundColor Gray " ==>Trying $SQLVER Download"
        if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination  $FileName))
            {  
            write-warning "Error Downloading file $Url, Please check connectivity"
            exit 
            }
        #Unblock-File "$SQL_BASEDir\$FileName"
        }
    Write-Host -ForegroundColor Gray " ==>$SQLVER is now available in $SQL_BASEDir"
    return $True
    }


#http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/12/windows10.0-kb3206632-x64_b2e20b7e1aa65288007de21e88cd21c3ffb05110.msu
<#
.DESCRIPTION
   receives latest .Net Versions from Microsoft
.LINK
   https://github.com/bottkars/labtools/wiki/Receive-LABWindows2016Update
.EXAMPLE

#>
#requires -version 3
function Receive-LABWindows2016Update
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination="./",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'KB3206632','KB3213986','KB4010672','KB4013429','KB4015438','KB4016635','KB4015217','KB4041688'
    )]
    [string]$KB = 'KB4041688'
)

Switch ($KB)
    {
    'KB3206632'
        {
        $Url = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/12/windows10.0-kb3206632-x64_b2e20b7e1aa65288007de21e88cd21c3ffb05110.msu"
        }
	'KB3213986'
		{
		$Url = 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/12/windows10.0-kb3213986-x64_a1f5adacc28b56d7728c92e318d6596d9072aec4.msu'
		}
	'KB4010672'
		{
		$Url = 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2017/01/windows10.0-kb4010672-x64_e12a6da8744518197757d978764b6275f9508692.msu'
		}
	'KB4013429'
		{
		$Url = 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2017/03/windows10.0-kb4013429-x64_ddc8596f88577ab739cade1d365956a74598e710.msu'
		}
	'KB4015438'
		{
		$url = 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2017/03/windows10.0-kb4015438-x64_c0e4b528d1c6b75503efd12d44d71a809c997555.msu'
		}
	'KB4016635'
		{
		$Url = 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2017/03/windows10.0-kb4016635-x64_2b1b48aa6ec51c019187f15059b768b1638a21ab.msu'
		}		
	'KB4015217'
		{
		$Url = 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2017/04/windows10.0-kb4015217-x64_60bfcc7b365f9ab40608e2fb96bc2be8229bc319.msu'
        }
    'KB4041688'
        {
        $Url = 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2017/10/windows10.0-kb4041688-x64_a098c258a1d8f6b4bbfff87ee5ab687d629d3bd9.msu'
        }   
    }
    if (Test-Path -Path "$Destination")
        {
        Write-Host -ForegroundColor Gray " ==>$Destination found"
        }
        else
        {
        Write-Host -ForegroundColor Gray " ==>Creating Sourcedir for Server 2016 Updates"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        }
        $FileName = Split-Path -Leaf -Path $Url
		$Destination_File = Join-Path $Destination $FileName
        if (!(test-path  $Destination_File))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Destination_File))
                { write-warning "Error Downloading file $Url, Please check connectivity"
                exit
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
            }
	Set-LABWindows2016KB -Server2016KB $KB
	Write-Output $KB
    }

function Set-LABMaster
{
[CmdletBinding(DefaultParametersetName = "vmware",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    <#
	Available Masters:
	==================
    '2016TP5','2016TP5_GER','2016','2016core',#
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012'
	#>
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
	[Parameter(ParameterSetName = "vmware", Mandatory = $true)]
    [ValidateSet(
    '2016','2016core',#
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012'   
    )]
    [string]$Master
)
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.Master= $Master
    Write-Host -ForegroundColor Gray " ==>setting Master to $Master"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
}


   

function Set-LABWindows2016KB
{
	[CmdletBinding(HelpUri = "https://github.com/bottkars/labtools/wiki/Set-LABpuppet")]
	param (
	[Parameter(ParameterSetName = "1", Mandatory = $false,Position = 2)]$Defaultsfile="./defaults.json",
    [Parameter(ParameterSetName = "1", Mandatory = $true,Position = 1)]
	[ValidateSet(
    'KB3206632','KB3213986','KB4010672','KB4013429','KB4015438','KB4016635','KB4015217','KB4041688'
    )]$Server2016KB 

    )
if (!(Test-Path $Defaultsfile))
    {
    Write-Host -ForegroundColor Gray " ==>Creating New defaultsfile"
    New-LABdefaults -Defaultsfile $Defaultsfile
    }
    $Global:labdefaults.Server2016KB = $Server2016KB
    Write-Host -ForegroundColor Gray " ==>setting Server2016KB to $Server2016KB"
    Save-LABdefaults -Defaultsfile $Defaultsfile -Defaults $Global:labdefaults
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
    $Destination="./",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    '451','452','46','461','462'
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
	'462'
		{
		$Url = "https://download.microsoft.com/download/F/9/4/F942F07D-F26F-4F30-B4E3-EBD54FABA377/NDP462-KB3151800-x86-x64-AllOS-ENU.exe"
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
		$Destination_File = Join-Path $Destination $FileName
        if (!(test-path  $Destination_File))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Destination_File))
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
    $Destination="./",
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
	'1_0_1','1_0_2','1_1_0'
    )]
    [string]$OpenSSL_Ver="1_0_2"
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
	$Parse = $Req.Links | where {$_ -Match "Win64OpenSSL_Light-$OpenSSL_Ver"}
	#https://slproweb.com/download/Win32OpenSSL_Light-1_0_1t.exe
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
    $Destination="./",
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
    $Destination="./",
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
function Receive-LABPhotonOS
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param(
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    $Destination=$Sourcedir,
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet('1.0'
    )]
    [string]$Photon_Release="1.0"
)
$Product = "Photon"
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

Write-Host -ForegroundColor Gray " ==>Checking for latests Photon URL"
<#
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
#>
$URL = "https://bintray.com/vmware/photon/download_file?file_path=photon-custom-hw11-1.0-13c08b6.ova"
Write-Verbose " ==>got $URL"
    $FileName = ($URL -split "=")[-1]
    if (!(test-path  (join-path $Product_Dir $FileName )))
        {
        Write-Host -ForegroundColor Gray " ==>$FileName not found, trying to download $Filename"
        if (!(Invoke-WebRequest $URL -UseBasicParsing -OutFile (join-path $Product_Dir $FileName)))
            { 
			write-warning "Error Downloading file $Url, Please check connectivity"
            break
            }
        }
    else
        {
        Write-Host -ForegroundColor Gray  " ==>found $Filename in $Product_Dir"
        }
$object = New-Object psobject
$object | Add-Member -MemberType NoteProperty -Name Filename -Value $FileName
$object | Add-Member -MemberType NoteProperty -Name Version -Value $Photon_Release
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
    $Destination="./",
	<#
	Versions:
	'2012R2','2016','2012'
	#>
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    '2012R2','2016','2012'
        )]
    [string]$winserv_ver,
    [Parameter(ParameterSetName = "1", Mandatory = $false)]
    [ValidateSet(
    'en_US','de_DE'
        )]
    [string]$lang = 'en_US'
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
            '2016'
                {
                $URL = 'http://care.dlservice.microsoft.com/dl/download/A/0/6/A0696267-C005-4E35-8336-2CB1105D3F07/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_DE-DE.ISO'
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
            '2016'
                {
                $URL = 'http://care.dlservice.microsoft.com/dl/download/1/6/F/16FA20E6-4662-482A-920B-1A45CF5AAE3C/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO'
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
		$Destination_File = Join-Path $Destination $FileName
        if (!(test-path  $Destination_File))
            {
            Write-Host -ForegroundColor Gray " ==>$FileName not found, Trying to Download"
            if (!(Receive-LABBitsFile -DownLoadUrl $URL -destination $Destination_File))
                { 
                write-warning "Error Downloading file $Url, Please check connectivity"
                break
                }
            }
        else
            {
            Write-Host -ForegroundColor Gray  " ==>found $Filename in $Destination"
            }
		Write-Output ([System.IO.FileInfo]$Destination_File)

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
    $Destination="./",
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
    $Destination="./",
	<#
	Versions: VMware-VMvisor-Installer-6.0.0.update01-labbuildr-ks.x86_64
	'6.0.0.update01','6.0.0.update02'
	#>
    [Parameter(ParameterSetName = "1", Mandatory = $true)]
    [ValidateSet(
    'Nested_ESXi6','Nested_ESXi5','Nested_ESXi6.5'
        )]
    [string]$nestedesx_ver
)
write-host "Browsing http://www.virtuallyghetto.com/ for templates"	
switch ($nestedesx_ver)
	{
	'Nested_ESXi6.5'
		{
		$ESXI_BASEURL = 'http://www.virtuallyghetto.com/2016/11/esxi-6-5-virtual-appliance-is-now-available.html'
		}
	default
		{
		$ESXI_BASEURL = 'http://www.virtuallyghetto.com/2015/12/deploying-nested-esxi-is-even-easier-now-with-the-esxi-virtual-appliance.html'
		}
	}
$HREF =	(Invoke-WebRequest $ESXI_BASEURL -UseBasicParsing).links | where href -match $nestedesx_ver
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
    $Masterpath="./",
	<#
	Possible Master for labbuildr:
	'2016TP5','2016TP5_GER','2016','2016core',#
    '2016TP4',
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE','openSUSE42_2',#
	'OpenWRT',
	'Centos7_3_1611','Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster',
    'photon-1.0-rev2'
	#>
    [Parameter(ParameterSetName = "vmware", Mandatory = $true)]
    [ValidateSet(
    '2016','2016core',#
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012',
    'OpenSUSE','openSUSE42_2',#
	'OpenWRT',
	'Centos7_3_1611','Centos7_1_1511','Centos7_1_1503','Centos7 Master',
    'Ubuntu14_4','Ubuntu15_4','Ubuntu15_10','Ubuntu16_4',
	'esximaster',
    'photon-1.0-rev2'
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
        $MasterVMX = Get-vmx -path (join-path $Masterpath $Master) -WarningAction SilentlyContinue
        if (!$Mastervmx)
            {
            Write-Host -ForegroundColor Yellow " ==>Could not find "(join-path $Masterpath $Master)
            Write-Host -ForegroundColor Gray " ==>Trying to load $Master from labbuildr Master Repo"
            if ($recvok = Receive-LABMaster -Master $Master -Destination $Masterpath -mastertype vmware -unzip -Confirm:$Confirm)
                {
                $MasterVMX = Get-vmx -path (join-path $Masterpath $Master) -ErrorAction SilentlyContinue
                }
            else
                {
                Write-Warning "No valid master found /downloaded"
                break
                }
            $MasterVMX = Get-vmx -path (join-path $Masterpath $Master) -WarningAction SilentlyContinue
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
        Write-Host -ForegroundColor Magenta " ==>Testing for Hyper-V Master $Masterpath\$Master.vhdx"
        if (!($MasterVMX = (Get-ChildItem -Path $Masterpath -Filter "$Master.vhdx" -Recurse).FullName))
            {
            Write-Host -ForegroundColor Yellow " ==>Could not find "(join-path $Masterpath "$Master.vhdx")
            Write-Host -ForegroundColor Gray " ==>Trying to load $Master from labbuildr Master Repo"
            if ($recvok = Receive-LABMaster -Destination $Masterpath -Master $Master -mastertype hyperv -unzip -Confirm:$false -ErrorAction Stop)
                {
                $MasterVMX = (Get-ChildItem -Path $Masterpath -Filter "$Master.vhdx" -Recurse).FullName
                }
            else
                {
                Write-Warning "No valid master found /downloaded"
                break
                }
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
#"ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/1501620045/AcroRdrDCUpd1501620045.msp"
#"ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/1501720053/AcroRdrDCUpd1501720053.msp"
"ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/1501720050/AcroRdrDCUpd1501720050.msp"
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



function Test-LABDC
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	$DCNODE = "DCNode"
	)
if ($dcvmx = get-vmx $DCNODE -WarningAction SilentlyContinue)
{
	Write-Host -ForegroundColor White  " ==>Domaincontroller already deployed, Comparing Workorder Parameters with Running Environment"
	Test-LABdcrunning
	    $dcvmx | Wait-VMXuserloggedIn -username  Administrator
	    write-verbose "Verifiying Domainsetup"
        $EnableFolders = get-vmx -path $DCNODE | Set-VMXSharedFolderState -enabled
	    $Checkdom = $dcvmx | Invoke-VMXPowershell -Guestuser $Adminuser -Guestpassword $Adminpassword -ScriptPath "$IN_Guest_UNC_Scriptroot\$DCNODE" -Script checkdom.ps1 # $CommonParameter
	    $BuildDomain, $RunningIP, $VMnet, $MyGateway = test-domainsetup
	    $IPv4Subnet = convert-iptosubnet $RunningIP
	    $Work_Items +=  " ==>will Use Domain $BuildDomain and Subnet $IPv4Subnet.0 for on $VMnet the Running Workorder"
        If ($MyGateway)
            {
            $Work_Items +=  " ==>we will configure Default Gateway at $MyGateway"
            $AddGateway  = "-DefaultGateway $MyGateway"
            Write-Verbose -Message " ==>we will add a Gateway with $AddGateway"
            }
    


	
}
}

function Test-LABdcrunning
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	$DCNODE = "DCNODE"
	)
$Origin = $MyInvocation.MyCommand
if (!$NoDomainCheck.IsPresent)
	{
	if ((get-vmx -Path $DCNODE).state -ne "running")
		{
		Write-Host -ForegroundColor White  " ==>Domaincontroller not running, we need to start him first"
		$Started = get-vmx -path $DCNODE | Start-vmx
		if (!$started)
			{
			Write-Warning " ==>Domaincontroller not found, giving up"
			break
			}
		}
	} 
} 

function New-LabVMX
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$true)]
	[switch]$Ubuntu,
	[Parameter(ParameterSetName = "CentOS",Mandatory=$true)]
	[switch]$CentOS,
	[Parameter(ParameterSetName = "Windows",Mandatory = $true)]
	[switch]$Windows,
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$false)]
	[ValidateSet('14_4','15_4','15_10','16_4')]
	$Ubuntu_ver = '14_4',
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[ValidateSet('Centos7_3_1611','Centos7_1_1511','Centos7_1_1503')]
	$CentOS_ver = 'Centos7_3_1611',
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateSet(
    '2016','2016core',#
    '2012R2_Ger','2012_R2','2012R2FallUpdate','2012R2Fall_Ger',
    '2012_Ger','2012'
    )]
	$Windows_ver = '2016',
	[Parameter(ParameterSetName = "CentOS",Mandatory=$true)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$true)]
	$VMXname,
	[switch]$start = $false,
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateRange(0,3)]
	[int]$SCSI_Controller = 1,
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$true)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateRange(0,7)]
	[int]$SCSI_DISK_COUNT = 0,
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$false)]
	[Uint64]$SCSI_DISK_SIZE = 100GB,
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$false)]
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateSet('pvscsi','lsisas1068')]
	$SCSI_Controller_Type = "pvscsi",
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory=$false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateSet('vmnet2','vmnet3','vmnet4','vmnet5','vmnet6','vmnet7','vmnet9','vmnet10','vmnet11','vmnet12','vmnet13','vmnet14','vmnet15','vmnet16','vmnet17','vmnet18','vmnet19')]
	$vmnet = $Global:labdefaults.vmnet,
	<#
    Size for general nodes
    'XS'  = 1vCPU, 512MB
    'S'   = 1vCPU, 768MB
    'M'   = 1vCPU, 1024MB
    'L'   = 2vCPU, 2048MB
    'XL'  = 2vCPU, 4096MB 
    'TXL' = 4vCPU, 6144MB
    'XXL' = 4vCPU, 8192MB
    #>
	[Parameter(ParameterSetName = "CentOS",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateSet('XS', 'S', 'M', 'L', 'XL','TXL','XXL')]
	$Size = "XL",
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateSet('nat', 'bridged','custom','hostonly')]
	$ConnectionType = 'hostonly',
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
	[ValidateSet('e1000e','vmxnet3','e1000')]$AdapterType = 'vmxnet3',
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateRange(0,99)][alias ('apr')][int]$activationpreference,
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[ValidateRange(1,9)][int]$Scenario = 9,
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $False)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[Validatelength(1, 10)][string]$Scenarioname = 'default',
	[Parameter(ParameterSetName = "CentOS",Mandatory = $false, ValueFromPipelineByPropertyName = $false)]
	[Parameter(ParameterSetName = "Windows",Mandatory=$false)]
	[Parameter(ParameterSetName = "Ubuntu",Mandatory = $false, ValueFromPipelineByPropertyName = $False)]
	[Validatelength(1, 50)][string]$Displayname = $VMXname,
	$Masterpath = $Global:labdefaults.Masterpath,
    [Parameter(Mandatory=$false)][ValidateSet('8192','12288','16384','20480','30720','51200','65536')]$Memory,
	[switch]$vtbit

)
if ($Ubuntu.IsPresent)
	{
	$Required_Master = "Ubuntu$Ubuntu_ver"
	}
if ($CentOS.IsPresent)
	{
	$Required_Master = "$CentOS_ver"
	}
if ($Windows.IsPresent)
	{
	$Required_Master = "$Windows_ver"
	}
try
    {
    $MasterVMX = test-labmaster -Masterpath $MasterPath -Master $Required_Master -erroraction stop
    }
catch
    {
    Write-Warning "Required Master $Required_Master not found
    please download and extraxt $Required_Master to ./$Required_Master
    see: 
    ------------------------------------------------
    get-help $($MyInvocation.MyCommand.Name) -online
    ------------------------------------------------"
    break
    }
Write-Host -ForegroundColor Gray " ==>found Master $($Mastervmx.VMXName)"
if (!(get-vmx -path (Join-Path (Get-Location) $VMXname) -WarningAction SilentlyContinue))
	{
	Set-LABUi -title "Creating $VMXname from $Master $($Mastervmx.VMXName) "
	$NodeClone = $MasterVMX | Get-VMXSnapshot | where Snapshot -Match "Base" | New-VMXLinkedClone -CloneName $VMXname
	If ($SCSI_DISK_COUNT -gt 0)
		{
		If ($SCSI_Controller -ne 0)
			{
			$controller = $NodeClone | Set-VMXScsiController -SCSIController $SCSI_Controller -Type $SCSI_Controller_Type
			$startlun = 0
			$endlun = $SCSI_DISK_COUNT -1
			}
		else
			{
			$startLun = 1
			$endlun = $SCSI_DISK_COUNT
			}
		foreach ($LUN in ($startlun..$endlun))
				{
				$Diskname =  "SCSI$SCSI"+"_LUN$LUN.vmdk"
				$Newdisk = New-VMXScsiDisk -NewDiskSize $SCSI_DISK_SIZE -NewDiskname $Diskname -Verbose -VMXName $NodeClone.VMXname -Path $NodeClone.Path 
				$AddDisk = $NodeClone | Add-VMXScsiDisk -Diskname $Newdisk.Diskname -LUN $LUN -Controller $SCSI_Controller
				}
		}
	$Nodeclone | Set-VMXNetworkAdapter -Adapter 0 -ConnectionType $ConnectionType -AdapterType $AdapterType -WarningAction SilentlyContinue | Out-Null
	$Nodeclone | Set-VMXVnet -Adapter 0 -vnet $vmnet| Out-Null
	Set-VMXDisplayName -DisplayName $Displayname -config $NodeClone.config |Out-Null
    if ($Global:labdefaults.$MainMemUseFile -eq "false")
        {
	    $NodeClone | Set-VMXMainMemory -usefile:$false | Out-Null
        }
    else {
       	$NodeClone | Set-VMXMainMemory -usefile:$true | Out-Null
    }    
	Set-VMXscenario -Scenarioname $Scenarioname -Scenario $Scenario -config $NodeClone.config | Out-Null
	$NodeClone |Set-VMXSize -Size $Size | Out-Null
    if ($Memory)
      {
          	$NodeClone |Set-VMXMemory -MemoryMB $Memory | Out-Null
      }  

	if ($vtbit.ispresent)
		{		
		$NodeClone | Set-VMXVTBit -VTBit  | Out-Null
		}
	if ($start.IsPresent)
		{
		$Started = $NodeClone | Start-VMX -nowait
		}
	Write-Output $NodeClone
	}
else
	{
	#Write-Warning "Machine $VMXname already exists"
	}
Set-LABUi
}

function Set-LabUbuntuVMX
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path,
	[Parameter(Mandatory=$false)]
	[ValidateSet('14_4','15_4','15_10','16_4')]
	$Ubuntu_ver = '14_4',
	####
	[Parameter(Mandatory=$false)]
	$Scriptdir = (join-path (Get-Location) "labbuildr-scripts"),
	[Parameter(Mandatory=$false)]
	$Sourcedir = $Global:labdefaults.Sourcedir,
	[Parameter(Mandatory=$false)]
	$DefaultGateway = $Global:labdefaults.DefaultGateway,
	[Parameter(Mandatory=$false)]
	$guestpassword = "Password123!",
	$Rootuser = 'root',
	$Hostkey = $Global:labdefaults.HostKey,
	$Default_Guestuser = 'labbuildr',
	[Parameter(Mandatory=$true)]
	$ip,
	[Parameter(Mandatory=$false)]
	$Subnet = $Global:labdefaults.MySubnet,
	[Parameter(Mandatory=$false)]
	$DNS1 = $Global:labdefaults.DNS1,
	[Parameter(Mandatory=$false)]
	$DNS2 = $Global:labdefaults.DNS2,
	[Parameter(Mandatory=$false)]
	$Host_Name = $VMXName,
	[Parameter(Mandatory=$false)]
	$DNS_DOMAIN_NAME = "$($Global:labdefaults.BuildDomain).$($Global:labdefaults.Custom_DomainSuffix)",
	[switch]$use_aptcache = $true,
	[string[]]$additional_packages,
	$net_dev = 'eth0' #future use
	)

begin
{
	switch ($ubuntu_ver)
		{
    "16_4"
        {
        $netdev = "ens160"
        }
    "15_10"
        {
        $netdev= "eno16777984"
        }
    default
        {
        $netdev= "eth0"
        }
    }
	$required_packages = ('python','git')
	$required_packages += $additional_packages	
	$required_packages = $required_packages -join " "
}
process
{
try
	{
	$nodeclone = Get-VMX -VMXName $VMXName -ErrorAction stop
	}
catch
	{
	break
	}
If (!$DefaultGateway)
	{
	$DefaultGateway = $ip
	}
if ($nodeclone.status -ne "started")
	{
	$nodeclone | start-vmx | Out-Null
	do {
		$ToolState = Get-VMXToolsState -config $NodeClone.config
		Set-LABUi -short -title "VMware tools are in $($ToolState.State) state"
		sleep 5
    }
    until ($ToolState.state -match "running")
	$installmessage += "Node $($nodeclone.vmxname) is reachable via ssh $ip with root:$($guestpassword)  or $($Default_Guestuser):$($Guestpassword)`n"
	Set-LABUi -title "Configuration of $($nodeclone.vmxname)"
    $NodeClone | Set-VMXSharedFolderState -enabled | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Sources -Folder $Sourcedir  | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Scripts -Folder $Scriptdir  | Out-Null
    If ($ubuntu_ver -match "15")
        {
        $Scriptblock = "systemctl disable iptables.service"
        $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
        }

    $Scriptblock = "sed -i '/PermitRootLogin without-password/ c\PermitRootLogin yes' /etc/ssh/sshd_config"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  | Out-Null
        
    $Scriptblock = "/usr/bin/ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa -force"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  | Out-Null
    
    $Scriptblock = "/usr/bin/ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  | Out-Null

    $Scriptblock = "/usr/bin/ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  | Out-Null

    if ($labdefaults.AnsiblePublicKey)
            {
            $Scriptblock = "echo '$($labdefaults.AnsiblePublicKey)' >> /root/.ssh/authorized_keys"
            Set-LABUi -short -title $Scriptblock
            $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword
            }

    if ($Hostkey)
        {
        $Scriptblock = "echo '$Hostkey' >> /root/.ssh/authorized_keys"
        Set-LABUi -short -title $Scriptblock
        $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
        $Scriptblock = "mkdir /home/$Default_Guestuser/.ssh/;echo '$Hostkey' >> /home/$Default_Guestuser/.ssh/authorized_keys;chmod 0600 /home/$Default_Guestuser/.ssh/authorized_keys"
        Set-LABUi -short -title $Scriptblock
        $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
        }

    $Scriptblock = "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys;chmod 0600 /root/.ssh/authorized_keys"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

	Set-LABUi -short -title "setting sudoers"
	$Scriptblock = "echo '$Default_Guestuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
	Set-LABUi -short -title $Scriptblock
	$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword #  -logfile $Logfile  

 	$Scriptblock = "sed -i 's/^.*\bDefaults    requiretty\b.*$/Defaults    !requiretty/' /etc/sudoers"
	Set-LABUi -short -title $Scriptblock
	$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile  

    $Scriptblock = "echo 'auto lo' > /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'iface lo inet loopback' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'auto $netdev' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'iface $netdev inet static' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'address $ip' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'gateway $DefaultGateway' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'netmask 255.255.255.0' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'network $subnet.0' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'broadcast $subnet.255' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
        
    $Scriptblock = "echo 'dns-nameservers $DNS1 $DNS2' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    $Scriptblock = "echo 'dns-search $DNS_DOMAIN_NAME' >> /etc/network/interfaces"
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
        
    $Scriptblock = "echo '127.0.0.1       localhost' > /etc/hosts; echo '$ip $Host_Name $Host_Name.$DNS_DOMAIN_NAME' >> /etc/hosts; hostname $Node"
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
    $Scriptblock = "hostnamectl set-hostname $Host_Name.$DNS_DOMAIN_NAME"
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    switch ($ubuntu_ver)
        {
        "14_4"
            {
            $Scriptblock = "/sbin/ifdown eth0 && /sbin/ifup eth0"
            }
        default
            {
            $Scriptblock = "/etc/init.d/networking restart"
            }
        }         
    Set-LABUi -short -title $Scriptblock
    $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null

    Write-Host -ForegroundColor Cyan " ==>Testing default Route, make sure that Gateway is reachable ( eg. install and start OpenWRT )
    if failures occur, you might want to open a 2nd labbuildr windows and run start-vmx OpenWRT "
    $Scriptblock = "DEFAULT_ROUTE=`$(ip route show default | awk '/default/ {print `$3}');ping -c 1 `$DEFAULT_ROUTE"
    $Possible_Error_Fix = "1.) If no Router is present, install OpenWRT with Receive-LAbOpenWrt -start `n2.)Check if VPN Connection are Blocking inet Access for VM´sn` Retry when fixed"
	Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Possible_Error_Fix $Possible_Error_Fix -Guestuser $Rootuser -Guestpassword $Guestpassword     

	if ($use_aptcache)
		{
		$NodeClone | Set-LabAPTCacheClient -cache_ip $Global:labdefaults.APT_Cache_IP
		}
	$Scriptblock="apt-get update; apt-get install $required_packages -y"
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile


	}
}
end
{Set-LABUi}
}

function Set-LabCentosVMX
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path,
	[Parameter(Mandatory=$false)]
	[ValidateSet('Centos7_3_1611','Centos7_1_1511','Centos7_1_1503')]
	$CentOS_ver = 'Centos7_3_1611',
	[Parameter(Mandatory=$false)]
	$Scriptdir = (join-path (Get-Location) "labbuildr-scripts"),
	[Parameter(Mandatory=$false)]
	$Sourcedir = $Global:labdefaults.Sourcedir,
	[Parameter(Mandatory=$false)]
	$DefaultGateway = $Global:labdefaults.DefaultGateway,
	[Parameter(Mandatory=$false)]
	$guestpassword = "Password123!",
	$Rootuser = 'root',
	$Hostkey = $Global:labdefaults.HostKey,
	$Default_Guestuser = 'labbuildr',
	[Parameter(Mandatory=$true)]
	$ip,
	[Parameter(Mandatory=$false)]
	$Subnet = $Global:labdefaults.MySubnet,
	[Parameter(Mandatory=$false)]
	$DNS1 = $Global:labdefaults.DNS1,
	[Parameter(Mandatory=$false)]
	$DNS2 = $Global:labdefaults.DNS2,
	[Parameter(Mandatory=$false)]
	$Host_Name = $VMXName,
	[Parameter(Mandatory = $False)]
	[AllowNull()] 
    [AllowEmptyString()]
	[ValidateSet('ansible','docker','generic','influxdb','grafana','')]
	[string[]]$Additional_Epel_Packages,	
	[AllowNull()] 
    [AllowEmptyCollection()]
	[string[]]$Additional_Packages,
	[Parameter(Mandatory=$false)]
	$DNS_DOMAIN_NAME = "$($Global:labdefaults.BuildDomain).$($Global:labdefaults.Custom_DomainSuffix)",
	$netdev= "eno16777984"
	)

begin
{
	if (!$DNS2)
		{
		$DNS2 = $DNS1
		}
	$OS ='Centos'
    $Logfile = "/tmp/labbuildr.log"
	$OS_Sourcedir = Join-Path $Sourcedir $OS
	$OS_CacheDir = Join-Path $OS_Sourcedir "cache"
    $yumcachedir = Join-path -Path $OS_CacheDir "yum"  -ErrorAction stop
	$epel = "http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
	If (!$DefaultGateway)
		{
		$DefaultGateway = $ip
		}
	Write-Verbose "yumcachedir $yumcachedir"
	$System_Packages = ('bind-utils','ntp','curl','git')
	$System_Packages = $System_Packages + $Additional_Packages -join " "
}

process
	{
	try
		{
		$nodeclone = Get-VMX -VMXName $VMXName -ErrorAction stop
		}
	catch
		{
		break
		}
	if ($nodeclone.status -ne "started")
		{
		$nodeclone | start-vmx | Out-Null
		}
	do {
			$ToolState = Get-VMXToolsState -config $NodeClone.config
			Write-Verbose "VMware tools are in $($ToolState.State) state"
			sleep 5
		}
    until ($ToolState.state -match "running")
	$installmessage += "Node $($nodeclone.vmxname) is reachable via ssh $ip with root:$($guestpassword)  or $($Default_Guestuser):$($Guestpassword)`n"
    $NodeClone | Set-VMXSharedFolderState -enabled | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Sources -Folder $Sourcedir  | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Scripts -Folder $Scriptdir  | Out-Null
	##### evaluating net device
	Write-Host -ForegroundColor Magenta " ==>Evaluating ethernet devices in $($nodeclone.vmxname)"
	$Scriptblock = 'vmtoolsd --cmd="info-set guestinfo.IF0 $(ls /sys/class/net)"'
	$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
	$Interfaces = $nodeclone | Get-VMXVariable -GuestVariable IF0 | Select-Object IF0
	Write-Host -ForegroundColor Gray " ==>Found interfaces $($Interfaces.IF0 -join ",")"
	$eth0 = $Interfaces.IF0 | where {$_ -ne "lo"} | Select-Object -First 1
	if ($eth0)
		{
		$netdev = $eth0
		Write-Host -ForegroundColor Gray  " ==>setting netdev to evaluated $netdev"
		}
	else
		{
		Write-Host -ForegroundColor Gray  " ==>using default netdev $netdev"
		}
	
	####
	$NodeClone | Set-VMXLinuxNetwork -ipaddress $ip -network "$subnet" -netmask "255.255.255.0" -gateway $DefaultGateway -device $netdev -Peerdns -DNS1 $DNS1 -DNS2 $DNS2 -DNSDOMAIN "$DNS_DOMAIN_NAME" -Hostname $Host_name  -rootuser $Rootuser -rootpassword $Guestpassword | Out-Null

    $Scriptblock =  "systemctl start NetworkManager"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
	
    $Scriptblock =  "chmod 777 $Logfile"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

	write-verbose "Setting Hostname"
	$Scriptblock = "nmcli general hostname $Host_name.$DNS_DOMAIN_NAME;systemctl restart systemd-hostnamed"
    Set-LABUi -short -title $Scriptblock
	Write-Verbose $Scriptblock
	$NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile  | Out-Null

    $Scriptblock =  "/etc/init.d/network restart"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  -logfile $Logfile

    $Scriptblock =  "systemctl stop NetworkManager"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  -logfile $Logfile

    Write-Host -ForegroundColor Gray " ==>you can now use ssh into $ip with root:Password123! and Monitor $Logfile"

    Write-Host -ForegroundColor Gray " ==>Disabling IPv6"
    $Scriptblock = "echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf;sysctl -p"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile

    Write-Host -ForegroundColor Gray " ==>disabeling firewalld"
    $Scriptblock = 'if [ "$(systemctl is-enabled firewalld)" == "enabled" ]; then echo $(systemctl disable firewalld);fi;
if [ "$(systemctl is-active firewalld)" == "active" ]; then echo $(systemctl stop firewalld); fi'
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile

    $Scriptblock =  "echo '$ip $($Host_name) $($Host_name).$DNS_DOMAIN_NAME'  >> /etc/hosts"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile

    $Scriptblock = "echo 'kernel.pid_max=655360' >> /etc/sysctl.conf;sysctl -w kernel.pid_max=655360"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile
    if ($EMC_ca.IsPresent)
        {
        $files = Get-ChildItem -Path "$Sourcedir\EMC_ca"
        foreach ($File in $files)
            {
            $NodeClone | copy-VMXfile2guest -Sourcefile $File.FullName -targetfile "/etc/pki/ca-trust/source/anchors/$($File.Name)" -Guestuser $Rootuser -Guestpassword $Guestpassword
            }
        $Scriptblock = "update-ca-trust"
        Write-Verbose $Scriptblock
        $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
        }
	
	Write-Verbose "setting sudoers"
    $Scriptblock = "echo '$Default_Guestuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword #  -logfile $Logfile

    $Scriptblock = "sed -i 's/^.*\bDefaults    requiretty\b.*$/Defaults    !requiretty/' /etc/sudoers"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

	Write-Verbose "Changing Password for $Default_Guestuser to $Guestpassword"
    $Scriptblock = "echo $Guestpassword | passwd $Default_Guestuser --stdin"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

	### generate user ssh keys
    $Scriptblock ="/usr/bin/ssh-keygen -t rsa -N '' -f /home/$Default_Guestuser/.ssh/id_rsa"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Default_Guestuser -Guestpassword $Guestpassword

    $Scriptblock = "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys;chmod 0600 ~/.ssh/authorized_keys"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Default_Guestuser -Guestpassword $Guestpassword
    #### Start ssh for pwless  root local login
    $Scriptblock = "/usr/bin/ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa"
    Write-Verbose $Scriptblock
    Set-LABUi -short -title $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile

    $Scriptblock = "cat /home/$Default_Guestuser/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword #  -logfile $Logfile

    if ($labdefaults.AnsiblePublicKey)
            {
            $Scriptblock = "echo '$($labdefaults.AnsiblePublicKey)' >> /root/.ssh/authorized_keys"
            Set-LABUi -short -title $Scriptblock
            Write-Verbose $Scriptblock
            $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword
            }
    if ($Hostkey)
            {
            $Scriptblock = "echo '$($Hostkey)' >> /root/.ssh/authorized_keys"
            Set-LABUi -short -title $Scriptblock
            Write-Verbose $Scriptblock
            $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword
            }
    $Scriptblock = "cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys;chmod 0600 /root/.ssh/authorized_keys"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
	$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword # -logfile $Logfile
    
	$Scriptblock = "{ echo -n '$($NodeClone.vmxname) '; cat /etc/ssh/ssh_host_rsa_key.pub; } >> ~/.ssh/known_hosts"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  #-logfile $Logfile

    $Scriptblock = "{ echo -n 'localhost '; cat /etc/ssh/ssh_host_rsa_key.pub; } >> ~/.ssh/known_hosts"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword  #-logfile $Logfile
	#### end ssh
	### testing default route
    Write-Host -ForegroundColor Cyan " ==>Testing default Route, make sure that Gateway is reachable ( install and start OpenWRT )
    if failures occur, open a 2nd labbuildr window and run start-vmx OpenWRT "

    $Scriptblock = "DEFAULT_ROUTE=`$(ip route show default | awk '/default/ {print `$3}');ping -c 1 `$DEFAULT_ROUTE"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

    ### preparing yum
    $file = "/etc/yum.conf"
    $Property = "cachedir"
    $Scriptblock = "grep -q '^$Property' $file && sed -i 's\^$Property=/var*.\$Property=/mnt/hgfs/Sources/$OS/\' $file || echo '$Property=/mnt/hgfs/Sources/$OS/yum/`$basearch/`$releasever/' >> $file"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword #-logfile $Logfile
    $file = "/etc/yum.conf"
    $Property = "keepcache"
    $Scriptblock = "grep -q '^$Property' $file && sed -i 's\$Property=0\$Property=1\' $file || echo '$Property=1' >> $file"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword #-logfile $Logfile
    $Scriptblock="yum makecache"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
    $Scriptblock="yum install yum-plugin-versionlock -y"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

    $Scriptblock="yum versionlock open-vm-tools"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
    if ($update.IsPresent)
        {
        Write-Verbose "Performing yum update, this may take a while"
        $Scriptblock = "yum update -y"
        Write-Verbose $Scriptblock
        Set-LABUi -short -title $Scriptblock
        $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
        }
    $Scriptblock = "yum install $System_Packages -y;systemctl enable ntpd;systemctl start ntpd"
    Set-LABUi -short -title $Scriptblock
    Write-Verbose $Scriptblock
    $Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
	if ($Additional_Epel_Packages)
		{
		Write-Host -ForegroundColor Gray " ==>adding EPEL Repo"
        Set-LABUi -short -title $Scriptblock
        $Scriptblock = "rpm -i $epel"
        $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword | Out-Null
		}
    if ($Additional_Epel_Packages -contains 'docker')
		{
		$Scriptblock = "curl https://get.docker.com/ | sh -;systemctl enable docker"
		Write-Verbose $Scriptblock
        Set-LABUi -short -title $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword
		$Packages = "tar wget python-setuptools"
		Write-Verbose "Checking for $Packages"
		$Scriptblock = "yum install $Packages -y"
        Set-LABUi -short -title $Scriptblock
		Write-Verbose $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

		$Scriptblock = "systemctl start docker.service"
	    Set-LABUi -short -title $Scriptblock
    	Write-Verbose $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
		}
	if ($Additional_Epel_Packages -contains 'influxdb')
		{
		$Scriptblock ="cat > /etc/yum.repos.d/influxdb.repo  <<EOF
[influxdb]
name = InfluxDB Repository - RHEL \`$releasever
baseurl = https://repos.influxdata.com/rhel/\`$releasever/\`$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
"
		Write-Verbose $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

		$Scriptblock ="yum install influxdb -y"
		Write-Verbose $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile

		}
	if ($Additional_Epel_Packages -contains 'grafana')
		{
		$Scriptblock ="yum install https://grafanarel.s3.amazonaws.com/builds/grafana-3.1.1-1470047149.x86_64.rpm -y"
		Write-Verbose $Scriptblock
		$Bashresult = $NodeClone | Invoke-VMXBash -Scriptblock $Scriptblock -Guestuser $Rootuser -Guestpassword $Guestpassword -logfile $Logfile
		}
#>


	}
end
	{
    Set-LABUi
    }
}

function Test-LABuserLoggedIn
{
	param (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
	$whois,
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
	$Adminuser,
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
	$Adminpassword,
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path
	)
	$Origin = $MyInvocation.MyCommand
	Write-Host -ForegroundColor Gray -NoNewline " ==>waiting for user $whois logged in " 
	do
		{
		$sleep = 1
		$cmdresult = Get-VMXProcessesInGuest -Guestuser $Adminuser -Guestpassword $Adminpassword -config $Config -VMXName $VMXName -ErrorAction SilentlyContinue
		foreach ($i in (1..$sleep))
			{
			Write-Host -ForegroundColor Yellow "-`b" -NoNewline
			sleep 1
			Write-Host -ForegroundColor Yellow "\`b" -NoNewline
			sleep 1
			Write-Host -ForegroundColor Yellow "|`b" -NoNewline
			sleep 1
			Write-Host -ForegroundColor Yellow "/`b" -NoNewline
			sleep 1
			}
	}
until ($cmdresult -match $whois) 
Write-Host	-ForegroundColor Green "[success]"
}
function Set-LabWindowsVMX
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path,
	[Parameter(Mandatory=$false)]
	$Scriptdir = (join-path (Get-Location) "labbuildr-scripts"),
	[Parameter(Mandatory=$false)]
	[switch]$NO_DOMAIN_JOIN,
	[Parameter(Mandatory=$false)]
	$Sourcedir = $Global:labdefaults.Sourcedir,
	[Parameter(Mandatory=$false)]
	$DefaultGateway = $Global:labdefaults.DefaultGateway,
	[Parameter(Mandatory=$false)]
	$guestpassword = "Password123!",
	$Rootuser = 'Administrator',
	$Hostkey = $Global:labdefaults.HostKey,
	$Default_Guestuser = 'labbuildr',
	[Parameter(Mandatory=$true)][ipaddress]
	$ip,
	[Parameter(Mandatory=$false)]
	$Subnet = $Global:labdefaults.MySubnet,
	[Parameter(Mandatory=$false)]
	$DNS1 = $Global:labdefaults.DNS1,
	[Parameter(Mandatory=$false)]
	$DNS2 = $Global:labdefaults.DNS2,
	[Parameter(Mandatory=$false)]
	$Host_Name = $VMXName,
	[Parameter(Mandatory = $False)]
	[AllowNull()] 
    [AllowEmptyCollection()]
	[string[]]$Additional_Packages,
	[Parameter(Mandatory=$false)]
	$custom_domainsuffix = "$($Global:labdefaults.Custom_DomainSuffix)",
	$Builddomain = "$($Global:labdefaults.BuildDomain)",
	$IN_Guest_UNC_Scriptroot = "\\vmware-host\Shared Folders\Scripts",
	$IN_Guest_UNC_Sourcepath = "\\vmware-host\Shared Folders\Sources",
    $IN_Guest_UNC_NodeScriptDir = "$IN_Guest_UNC_Scriptroot\Node",
    $Timezone = "$($Global:labdefaults.TimeZone)"
	)

begin
{
$System_Packages = $System_Packages -join " "
if ($NO_DOMAIN_JOIN.IsPresent)
	{
	$Addonparameters = "-NO_DOMAIN_JOIN"
	}
if ($DefaultGateway)
	{
	$Addonparameters = "$Addonparameters -DefaultGateway $DefaultGateway"
	}
[System.Version]$subnet = $Subnet.ToString()
$Subnet = $Subnet.major.ToString() + "." + $Subnet.Minor + "." + $Subnet.Build
}

process
	{
	try
		{
		$nodeclone = Get-VMX -VMXName $VMXName -ErrorAction stop
		}
	catch
		{
		break
		}
	if ($nodeclone.status -ne "started")
		{
		$nodeclone | start-vmx | Out-Null
		}
	Write-Host -ForegroundColor Gray " ==>waiting for firstboot finished on " -NoNewline 
	Write-Host -ForegroundColor Magenta "$VMXName" -NoNewline
	do {
			$ToolState = Get-VMXToolsState -config $NodeClone.config
			Write-Verbose "VMware tools are in $($ToolState.State) state"
			sleep 5
		}
    until ($ToolState.state -match "running")
	Write-Host -ForegroundColor Green "[success]"
	Write-verbose "waiting for Pass 1 (sysprep Finished)"
	$nodeclone | Test-LABuserLoggedIn -Adminuser $Rootuser -Adminpassword $guestpassword -whois Administrator -ErrorAction SilentlyContinue
    $NodeClone | Set-VMXSharedFolderState -enabled | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Sources -Folder $Sourcedir  | Out-Null
    $NodeClone | Set-VMXSharedFolder -add -Sharename Scripts -Folder $Scriptdir  | Out-Null    
	$NodeClone | Invoke-VMXPowershell -Guestuser $Rootuser -Guestpassword $guestpassword -ScriptPath $IN_Guest_UNC_NodeScriptDir -Script configure-node.ps1 -Parameter "-nodeip $ip -nodename $($nodeclone.vmxname)  -domainsuffix $custom_domainsuffix  -IPv4Subnet  $Subnet $Addonparameters -domain $Builddomain -Timezone '$Timezone'" -nowait -interactive # $CommonParameter

	


	}
end
	{}
}

function Set-LabAPTCacheClient
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path,
	[Parameter(Mandatory=$true)]
	[ipaddress]$cache_ip,
	$Guestuser = 'root',
	$Guestpassword = 'Password123!'
	)

begin
{
$Scriptblock = "cat > /etc/apt/apt.conf.d/01proxy <<EOF
Acquire::http { Proxy `"http://$($cache_ip):3142`"; };`
Acquire::https { Proxy `"https://$($cache_ip):3142`"; };`
"
}
process
{

if ( (Get-VMX -VMXName $VMXName).state -ne "running")
	{
	Write-Warning "VM must be in a running state"
	}
else
	{
	Invoke-VMXBash -VMXName $VMXName -config $config -Scriptblock $Scriptblock -Guestuser $Guestuser -Guestpassword $Guestpassword | Out-Null
	}

}
end
{
}
}


function Deny-LabDefaults
{
Write-Host -ForegroundColor Magenta -NoNewline "
                ///////"
Write-Host -ForegroundColor Gray "
                ( o  o )
            --ooO-(_)-Ooo--"
Write-Host -ForegroundColor Yellow "
Keep Calm, '-defaults' Parameter has been deprecated for this Scenario/Solutionpack!
All your defaults are passed from the environment.
Please retry coommand without -defaults switch"
}

function Get-LabVMXUserPublicKey
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename')][string]$VMXName,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]$config,
    [Parameter(Mandatory=$false)]$Path,
	[Parameter(Mandatory=$true)]$sshuser,
	[Parameter(Mandatory=$false)]
	$guestpassword = "Password123!",
	$guestuser = 'root'
    )
}

function Stop-LabUnity
{
[CmdletBinding(DefaultParametersetName = "1",
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
	[OutputType([psobject])]
param
    (
	[Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [Alias('Clonename','VMXname')][string]$UnityName = "UnityNode1",
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $false)]$config,
    [Parameter(Mandatory=$false)]$serviceuser = "service",
	[Parameter(Mandatory=$false)]$servicepassword = "service"
    )
if ($config)
    {
    $Nodeclone = get-vmx -config $config
    }
else
    {
    $Nodeclone = get-vmx -VMXName $UnityName     
    }
if (!$Nodeclone)
    {
        Write-Host "$VMXname not found"
    }
if ($NodeClone.state -match "running")
    {
    $NodeClone | Invoke-VMXBash -Scriptblock "/usr/bin/sudo -n /EMC/Platform/bin/svc_shutdown --system-halt --force" -Guestuser $serviceuser -Guestpassword $servicepassword
    }            
else
    {
        Write-host "$($nodeclone.vmxname) is not  in running state"
    }
}




function Set-LABUi
{
param
(
[Parameter(Mandatory = $false,Position = 0)]$title,
[switch]$short)

if ($short)
	{
	$host.ui.RawUI.WindowTitle = "$title"
	}
else
	{
	$host.ui.RawUI.WindowTitle = "Domain:$($labdefaults.BuildDomain)|Subnet:$($labdefaults.MySubnet)|GW:$($labdefaults.Defaultgateway)|DNS1: $($labdefaults.DNS1)|DNS2:$($labdefaults.DNS2)|$title"
	}
}
