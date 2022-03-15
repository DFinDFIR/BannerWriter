<#
.SYNOPSIS
Banner Writing Mostly for testing, fun and adding to other scripts

.DESCRIPTION
DF made this script, testing synopsis and description sections etc

.PARAMETER StartExtender
Use this to set a longer value for the starting thing

#>
Param
(  
  [Parameter(Mandatory=$false)]
  [string]$BannerPath,

  [Parameter(Mandatory=$false)]
  [string]$ForeGroundColor,

  [Parameter(Mandatory=$false)]
  [string]$BackgroundColor,
  
  [Parameter(Mandatory=$false)]
  [switch]$DisableScreenJanking,

  [Parameter(Mandatory=$false)]
  [int]$StartExtender
  
  
)

function Get-Color(){
    Param ([string]$in)
    $out=$in
    While($in -eq $out){
        $out=Get-Random -InputObject $Colors
    }
    $out
    return
}

function Write-Banner(){
	param([string]$BannerPath)	
	$StartColors=@("White","Blue","DarkBlue","Green","Cyan","DarkCyan","Magenta","DarkMagenta","DarkRed","DarkYellow","Gray","DarkGray","Black")
	$Colors=@("White","Blue","DarkBlue","Green","Cyan","DarkCyan","Magenta","DarkMagenta","DarkRed","DarkYellow","Gray","DarkGray")
    
    Clear-Host
    $y=(Get-Content $BannerPath).Count
    $i=0
    $j=0
    $holder="---------------------------------------------------------------------------"
    @(0..$y) | ForEach-Object{
        $c=$StartColors[$i]
        Write-Host -ForegroundColor $c -BackgroundColor $c ($holder)
        $j=$j+1
        if($j % 2 -eq 0){$i=$i+1}
        if($i-ge $StartColors.Count){$i=0}
        # $StartColors | ForEach-Object{
        #     Write-Host -ForegroundColor $_ -BackgroundColor $_ ($holder)
        #     Write-Host -ForegroundColor $_ -BackgroundColor $_ ($holder)
        # }
    }
    Write-Host("")
    if($StartExtender -eq 0) {$StartExtender=1500}
    Start-Sleep -Milliseconds $StartExtender
    Clear-Host
    if($DisableScreenJanking)
    {
    	Get-Content $BannerPath | ForEach-Object{
    		Write-Host ($_)		
    	 }
    	 Write-Host(" ")
    	 Write-Host(" ")
    	 return
    }
    if($BackgroundColor -eq "") {$b="black"}
    else {$b=$BackgroundColor}
    
    if($ForeGroundColor -eq ""){
        $f=Get-Random -InputObject $Colors
        @(1..10)| ForEach-Object{    	
        	#$b=Get-Color($f)
        	Get-Content $BannerPath | ForEach-Object{
        		Write-Host -ForegroundColor $f -BackgroundColor $b ($_)
         	}        
    		Start-Sleep -Milliseconds 50
            $f=Get-Random -InputObject $Colors
        	Clear-Host
    	}
    }
    else{$f=$ForegroundColor}
        # $Host.UI.RawUI.BackgroundColor = "Black"
        # $Host.UI.RawUI.ForegroundColor = "Magenta"
        Clear-Host
        Get-Content $BannerPath | ForEach-Object{
          Write-Host -ForegroundColor $f -BackgroundColor $b ($_)     
    	}    
    	Write-Host(" ")
    	Write-Host(" ")    
}

#  End of functions
##############################
$Defaultbg=(Get-Host).UI.RawUI.BackgroundColor
$Defaultfg=(Get-Host).UI.RawUI.ForegroundColor
if($BannerPath -eq "")
{
$BannerPath=Get-ChildItem -Path .\Banner -Recurse -Include *.txt | Get-Random
}
Write-Banner($BannerPath)
$Host.UI.RawUI.BackgroundColor = $Defaultbg
$Host.UI.RawUI.ForegroundColor = $Defaultfg
