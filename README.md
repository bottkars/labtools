# labtools
##about
labtools is a collection of tools for labbuildr, labbuildr-hyperv and labbuildr-flex   
the tools also run outside labbuildr 
##description
labtools are mainly focused on management of environment paramaters ( Network, Versions, Directorie aka _labdefaults_ ) and downloads of sources.
it has a "package management" to retrieve software downloads from various sources like emc, microsoft, openssl, Oracle java etc
##supported os  
* labtools was designed for windows using powershell 3 or greater  
* with the availabilty of Powershell for OSX, osx is supported with a testing state in branch OSX
see [PowerShell for OSX](https://github.com/PowerShell/PowerShell/blob/master/docs/installation/linux.md#os-x-1011) for instructions
to use labtools in osx, .Net Core libs for OSX are required  
for details on installation of .NET Core LIBS see [.NET Core on MACOS](https://www.microsoft.com/net/core#macos)    

##package / sw management commands  
```Powershell
Get-Command -Module labtools -Verb receive
```
![image](https://cloud.githubusercontent.com/assets/8255007/17549632/6eab9d60-5ef1-11e6-9205-aee855593193.png)

