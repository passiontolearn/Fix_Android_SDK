SETLOCAL
SET SourceDir=S:\Install\LOCAL_Android_SDK\SDK
SET DestDir=D:\Android\SDK
SET Source_Android_ConfDir=S:\Install\LOCAL_AndroidStudio_config
SET Dest_Android_ConfDir="%USERPROFILE%\.AndroidStudio2.2\config"

:: NOTE! ASSUME we are running on Windows 10 (and ROBOCOPY 10.0 exists)
::
:: Thanks to: 
:: http://www.techrepublic.com/blog/windows-and-office/use-robocopys-multi-threaded-feature-to-quickly-back-up-your-data-in-windows-7/
:: https://community.spiceworks.com/topic/209883-robocopy-only-copy-new-changed-files
ROBOCOPY "%SourceDir%" "%DestDir%" /MIR /Z /W:5 /MT:32

IF NOT exist %Dest_Android_ConfDir% (
	echo Directory %Dest_Android_ConfDir% does NOT exist! 
	echo CREATING it ...
	mkdir "%Dest_Android_ConfDir%"
	echo.
	echo RESTORING default Android config folder
	ROBOCOPY "%Source_Android_ConfDir%" "%Dest_Android_ConfDir%" /MIR /Z /W:5 /MT:32	
)

:: **** Comment out this section if you don't want to Edit the Android JDK configuration file 
SET JDK_ConfFile='%USERPROFILE%\.AndroidStudio2.2\config\options\jdk.table.xml'
SET Default_JDK_Path='%USERPROFILE%\AppData\Local\Android\Sdk'
SET NEW_JDK_Path=%DestDir%

:: Thanks to:
:: 		  http://stackoverflow.com/a/17144445
:: 		  http://stackoverflow.com/a/1892868
:: 		  http://stackoverflow.com/a/40089770
::		  http://stackoverflow.com/a/14672752
::
:: NOTE:  I used (\") here to capture double quotes and workaround having 
::        to use or escape them in the powershell string !
powershell "(Get-Content %JDK_ConfFile%) -replace '(<homePath value=\")(\w*)(\")', '$1%NEW_JDK_Path%$3' | Set-Content %JDK_ConfFile%"
 
PAUSE