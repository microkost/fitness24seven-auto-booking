# Automatic login for group classes in Fitness24seven

Current version is unfinished due to changes in [access system](https://forum.fitness24seven.se/org/fitness24seven-se/d/mobile-access-entry-system/) during 2023/10

## Usage on Windows

* Clone the repository / Download in the Zip file
* Open the PowerShell console
* list the directory with the cloned files
* open text editor with file fitness24seven-fi-auto-booking-launch.ps1
* configure values of variables (gym location, class, date+time) and save changes
* execute PS> ./fitness24seven-fi-auto-booking-launch.ps1
* enjoy auto-booked activity 👌

## Installation on Windows

Requires [installed Python](https://www.python.org/downloads/windows/)

and the following libraries (commands for Powershell console)

    pip install robotframework
    pip install --upgrade robotframework-selenium2library

When starting the PowerShell script for the first time, there might be an error "fitness24seven-fi-auto-booking-launch.ps1 is not digitally signed". This can be removed by executing the command:

    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

### Browser control

Download, unpack and place to PATH accessible folder (e.g. C:\Program files\Chromedriver) one or all following browser drivers: Chromedriver / Geckodriver / [Microsoft Edge WebDriver](https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/) based on your local browser preference/presence. These components must be always up-to-date.

## Donation

If this project helps you, you can send me the equivalent of a cup of coffee via the following link:

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HNJEAWP87ZT3S&source=url)