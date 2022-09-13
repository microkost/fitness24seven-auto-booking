# execute in cmd> robot fitness24seven-fi-auto-booking.robot --log NONE --output NONE --report NONE
# OR cmd> with parameters as
# robot --variable Gym:'Helsinki Hakaniemi' --variable Day:maanantai --variable Activity:BodyPump --log NONE --output NONE --report NONE fitness24seven-fi-auto-booking.robot
# send thank you via https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HNJEAWP87ZT3S&source=url if you like it

*** Settings ***
Documentation     Fitness24Seven group lesson automatized sign-in tool
Suite Setup       Log To Console    Fitness24Seven group lesson auto sign-in tool
Suite Teardown    Close Browser

*** Settings ***
Library         Selenium2Library
Library  		String

*** Variables ***
${Country}          FINLAND
${City}             TAMPERE
${Gym}              Tampere Keskusta GROUP
${Day}              maanantai
#${Activity}         BodyPump
${UserName}         email@email.com
${UserPass}         secretpassword123    #WARNING WARNING WARNING
${URL}              https://fi.fitness24seven.com/
${BROWSER}          chrome
${maxActLen}        10      #cut activity name
${maxActNum}        10      #how many activities are max in table

*** Test Cases ***
Open F24
    [Documentation]    Open the Fitness24/7 page at ${URL}
    Open Browser    ${URL}/kirjaudu-sisaan/    ${BROWSER}
    Click element                   //*[@id="onetrust-accept-btn-handler"]     #Accept cookies
    Maximize Browser Window

Login F24
    [Documentation]     Login to Fitness24Seven website
    Click element                   //html/body/header/div[1]/div/nav/ul[3]/li/a     #Kirjaudu sisään open login form
    Wait Until Element Is Visible                    //*[@id="wmp"]/div/div[2]/div/div/div/div/button
    Click element                   //*[@id="wmp"]/div/div[2]/div/div/div/div/button     #Kirjaudu sisään button
    Wait Until Element Is Visible                   //*[@id="api"]/div[1]/h1
    Input Text                      //*[@id="email"]        ${UserName}
    Input Text                      //*[@id="password"]     ${UserPass}
    Click element                   //*[@id="next"]     #click login
    #Sleep   						1 seconds

Select timetable
    Go To    ${URL}/kirjaudu-sisaan/aikataulu/     #change to booking page
    Click element                   //*[@id="wmp"]/div/div[2]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]/div[1]     #click Maa    
    Wait Until Element Is Visible //*[@id="checkbox-${Country}-input"]
    #Select Checkbox //*[@id="checkbox-${Country}-input"]     #tick ${Country}
    #Kaupunki ${City}
    #Kuntosali ${Gym} 
    #Calendar ${Day}

#Book activity F24
    #[Documentation]     Select from the list

