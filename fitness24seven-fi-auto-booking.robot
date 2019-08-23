# execute in cmd> as
# robot fitness24seven-fi-auto-booking.robot
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
${Gym}              Jyväskylä Kauppakulma PLUS
${Day}              maanantai
${Activity}         BodyPump
${UserName}         email@email.com
${UserPass}         secretpassword123    #WARNING WARNING WARNING
${URL}              https://boka.fitness24seven.com/brp/mesh/selectUnit.action
${BROWSER}          chrome
${maxActLen}        10      #cut activity name
${maxActNum}        10      #how many activities are max in table

*** Test Cases ***
Open F24
    [Documentation]    Open the Fitness24/7 page at ${URL}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Login F24
    [Documentation]     First and second screen, gym selection and login
    Select From List By Label       //*[@id="selectUnitBody"]/div/div[3]/div/div/form/table/tbody/tr[1]/td[2]/select        ${Gym}
    Click element                   //*[@id="selectUnitBody"]/div/div[3]/div/div/form/table/tbody/tr[2]/td[2]/div/input     #click Välj
    #Sleep   						1 seconds
    Input Text                      //*[@id="username"]     ${UserName}
    Input Text                      //*[@id="loginForm"]/table/tbody/tr[2]/td[2]/input      ${UserPass}
    Click element                   //*[@id="loginForm"]/table/tbody/tr[3]/td[2]/div/input      #click Jatka
    Click element                   //*[@id="bookGroupActivity"]        #click Varaa ryhmäliikuntatunti
    #Sleep   						1 seconds

Book activity F24
    [Documentation]     Searching for activities by iterating over table in selected day
    Click element       //*[@id="showGroupActivitiesDateForm"]/table/tbody/tr[1]/td[2]/a[contains(text(),'${Day}')]
    : FOR   ${index}    IN RANGE    0   ${maxActNum}
        \   ${valid}    Run keyword and return status   Get Text    //*[@id="showGroupActivitiesBody"]/div[1]/div[3]/div/div/table/tbody/tr[${index}]/td[2]
        \   Run keyword If  '${valid}' == 'True'    FindRequestedActivity     ${index}    ${activity}

*** Test Cases ***
Report booking
    Log To Console    \nInform user ${UserName}

Close case
    [Documentation]    End session
    #do screenshot!
    Click element       //*[@id="logout"]/a     #logoff from website
    Close Browser

*** Keywords ***
FindRequestedActivity
    [Documentation]     If activity is requested one then start booking at corect index
    [Arguments]    ${index}   ${activity1}
    ${activity2}=       Get Activity   ${index}
    ${valid}    Run keyword and return status     Should Start With    ${activity2}    ${activity1}
    Run keyword If      '${valid}' == 'True'   Make Booking    ${index}
    #...     ELSE    Log To Console        > Lesson ${activity2} located at ${index} is NOT ${activity1}

Get Activity
    [Documentation]     Fetch activity name from table and cut it to be shorter
    [Arguments]    ${index}
    ${activityTest}=    Get Text    //*[@id="showGroupActivitiesBody"]/div[1]/div[3]/div/div/table/tbody/tr[${index}]/td[2]
    ${length} =  Get Length  ${activityTest}
    ${activityShort}=   Get Substring   ${activityTest}    0    ${maxActLen}
    [Return]    ${activityShort}

Make Booking
    [Arguments]     ${correctIndex}
    Log to Console      Lesson ${Activity} is under index ${correctIndex}
    ${bookORqueue}      Get Text    //*[@id="showGroupActivitiesBody"]/div[1]/div[3]/div/div/table/tbody/tr[${correctIndex}]/td[9]/a
    Log to Console      Booking status is ${bookORqueue}
    Click element       //*[@id="showGroupActivitiesBody"]/div[1]/div[3]/div/div/table/tbody/tr[${correctIndex}]/td[9]/a