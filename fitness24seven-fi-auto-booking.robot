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
${UserName}         name.surname@gmail.com     #WARNING
${UserPass}         secretpassword123    #WARNING WARNING WARNING
${URL}              https://fi.fitness24seven.com    #no closing backslash
${BROWSER}          edge
${maxActLen}        10      #cut activity name
${maxActNum}        10      #how many activities are max in table

*** Test Cases ***
#Network scanning
#    [Documentation]    Network details about execution machine
#    ${ip}=             Evaluate [l for l in ([ip for ip in socket.gethostbyname_ex(socket.gethostname())[2] if not ip.startswith("127.")][:1], [[(s.connect(('8.8.8.8', 53)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]]) if l][0][0]    socket
#    Log To Console     Private IP is: ${ip}
#    Open Browser       http://api.hostip.info/get_json.php     ${BROWSER}
#    ${ippublic}=       Get Text       //html/body/pre         #get the IP address text
#    Log To Console     Public networking details are: ${ippublic}
#    Close Browser

Open F24
    [Documentation]    Open the Fitness24/7 page at ${URL}
    Open Browser    ${URL}/kirjaudu-sisaan/    ${BROWSER}
    Wait Until Element Is Visible    //*[@id="onetrust-accept-btn-handler"]    timeout=3s
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
    Sleep   						1 seconds

Select location
    Go To    ${URL}/kirjaudu-sisaan/aikataulu/      #change to booking page
    Sleep                   3 seconds               #do not use geo location "Löydä lähin kuntosalini"
    Wait Until Element Is Visible       //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]/div[1]/h4    #load maa header => always 'not visible after 5 seconds'
    Click Element                //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]/div/span/span/svg/path    #click maa header
    Click Element                //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]/div[2]/ul/li[1]/label[2]    #click HARDCODED first element
    Log To Console      Clicked hardcoded country
    Click Element               xpath=(//label[@for="checkbox-Finland-input"])
    Log To Console      Clicked country
    Sleep                   5 seconds
    Wait Until Element Is Visible       //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[3]/div[1]/h4
    Log To Console      Kaupunki visible
    Click Element    xpath=(//h4[@class="c-filter-dropdown__title"])[2]
    Click Element    xpath=(//span[@class="c-filter-checkbox--checkmark"])[10] #
    Click Element    xpath=(//h4[@class="c-filter-dropdown__title"])[3]
    Click Element    xpath=(//span[@class="c-filter-checkbox--checkmark"])[13]
    Click Element    xpath=(//h3[@class="c-weekday-switcher__weekday-container__day-number"])[10]
    Click Element    xpath=(//h3[@class="c-weekday-switcher__weekday-container__day-number"])[9]

    #Wait Until Element Is Visible        //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[1]/div/button/span        #wait for page load: button Löydä lähin kuntosalini
    #Wait Until Element Is Visible        //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]/div[1]            #loading list Maa
    #Wait Until Element Is Visible        //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[2]
    #Click Element                       //svg[@class="injected-svg c-icon c-icon--close c-toaster__close-icon"]            #close virhe warning
    #Click Element                       //span[@class="c-filter-checkbox--checkmark"]
    #Click Element    //path
    #Click Element    //svg[@class="injected-svg c-icon c-icon--select-dropdown-arrow c-filter-dropdown__filter-icon"]
    #Click Element    xpath=(//h4[@class="c-filter-dropdown__title"])[2]
    #Click Element    //svg[@class="injected-svg c-icon c-icon--select-dropdown-arrow c-filter-dropdown__filter-icon"]
    #Click Element
    #Click Element    xpath=(//h4[@class="c-filter-dropdown__title"])[2]
    #Click Element    //label[@for="checkbox-TAMPERE-input"]
    #Click Element    //div[@class="c-filter-dropdown__button c-filter-dropdown__button--clickable"]
    #Click Element    //label[@for="checkbox-Tampere Keskusta GROUP-input"]
    #Click Element    xpath=(//h3[@class="c-weekday-switcher__weekday-container__day-number"])[11]
    #Click Element                       //label[@for="checkbox-Finland-input"]
    #Select Checkbox                      //*[@id="checkbox-${Country}-input"]     #tick ${Country}
    #Log To Console                       country ${Country} selected
    #Wait Until Element Is Visible        //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[3]/div[1]/h4            #loading list Kaupunki
#click Kaupunki ${City}
    Click element                       //*[@id="checkbox-${City}-input"]
    Wait Until Element Is Visible        //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[4]/div/h4            #loading list Kuntosali
    Log To Console                       Kaupunki ${City} selected
#click Kuntosali ${Gym}
    #Click element                       //*[@id="wmp"]/div/div[3]/div/div/div[1]/div[1]/div[2]/div[1]/div/div[4]/div[2]/ul/li/label[1]/span
    #Wait Until Element Is Visible
    #Sleep   						4 seconds

Select timetable
    #Calendar ${Day}
    #Sleep   						4 seconds

#Book activity F24
    #[Documentation]     Select from the list

