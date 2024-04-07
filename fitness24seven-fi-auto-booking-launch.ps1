#
# auto booking manual launcher
# open powershell, PS> cd C:\temp\..., PS> .\fitness24....ps1
# require local execution to be enabled with the command: Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
#

# exercice settings start (change here safely)
$Gym = "Tampere"
$Day = "perjentai"
$Activity = "BodyPump"

# your credentials for login to F24.
$f24username = "name.surname@myemail.com"
$f24password = "PASSWORD_readable"

# tool configuration
$magicFile = "fitness24seven-fi-auto-booking.robot" # the whole logic file
$WORKSPACE = (Get-Location | Select-Object -ExpandProperty Path) # separated for automation lanch

# TODO dependencies check
    # python installed
    # robot framework and selenium library
    # valid chrome/edge/gecko webdriver

# start
powershell robot --variable UserName:"$f24username" --variable UserPass:"$f24password" --log NONE --output NONE --report NONE "$WORKSPACE\$magicFile"