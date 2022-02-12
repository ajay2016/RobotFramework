*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
Library             Collections
# Test Setup (Before Test)
Test Setup          open browser with given url

# Tear down method to close browser (After Test)
Test Teardown       Close Browser Session
Resource            Generic.robot

# Global variables module
*** Variables ***
${Login_Msg_Error}      css:.alert-danger
${shop_page_load}       css:.nav-link
${item_text}            xpath:(//*[text()='Blackberry'])
${checkout_button}      //*[@id='navbarResponsive']/ul/li
${ok_button}            id:okayBtn
${terms}                id:terms


*** Test Cases ***
# testcase name

#Validate UnSuccessful Login
    # Teststeps
    # data from resources
    # fill the login form     ${user_name}        ${invalid_password}
    # wait until element is located in the page   ${Login_Msg_Error}
    # verify the error message is correct


#Validate cards display after successful login
    #data from resources
#    fill the login form     ${user_name}        ${valid_password}
#    wait until element is located in the page   ${shop_page_load}
#    verify cards title in shop page
#    select the card         Blackberry
#    click on checkout

Select user form and switch to child window
    fill the login details and select user option   ${user_name}        ${valid_password}

*** Keywords ***

fill the login form
    # methods with different  arguments get data from test case on run time

    [arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn


wait until element is located in the page
    [arguments]         ${element}
    Wait Until Element Is Visible       ${element}


verify the error message is correct
    ${result_text}=  Get Text    ${Login_Msg_Error}
    # from builtin library
    Should Be Equal As Strings      ${result_text}          Incorrect username/password.
    # Validating in 1 line
    Element Text Should Be          ${Login_Msg_Error}      Incorrect username/password.
#Close Browser Session
    #close browser
verify cards title in shop page
    # Create list with the items
    @{expectedList} =       Create List     iphone X    Samsung Note 8   Nokia Edge   Blackberry

    # Get WebElements Returns a list of WebElement objects matching the locator.
    ${elements} =  Get WebElements         css:.card-title
    # actual empty list Creating @ after $
    @{actualList} =       Create List
    FOR	${element}	IN	@{elements}
        # python to get text
      Log  ${element.text}
      Append To List	${actualList}	${element.text}
    END

    Lists Should Be Equal       ${expectedList}     ${actualList}

select the card
    [arguments]     ${cardname}
    # All the Elements
    ${elements} =  Get WebElements         css:.card-title
    # index is set to 1 for iteration
    ${index} =	Set Variable	1
    FOR	${element}	IN	@{elements}
        # if found Exit
        Exit For Loop If  '${element.text}' == '${cardname}'
        # need keyword Evaluate Evaluates the given expression in Python and returns the result.
        ${index} =  Evaluate     ${index} + 1

    END
    # Click with that index
    Click Button    xpath:(//*[@class ='card-footer'])[${index}]/button
click on checkout
    wait until element is visible   ${checkout_button}
    Click Element    ${checkout_button}
    #click element    ${checkout_button}
    Element Text Should Be          ${item_text}      Blackberry

fill the login details and select user option

    [arguments]                         ${username}     ${password}
    Input Text                          id:username     ${username}
    Input Password                      id:password     ${password}
    Click Element                       xpath://input[@value = 'user']
    wait until element is visible       ${ok_button}
    click element                       ${ok_button}
    click element                       ${ok_button}
    wait until element is not visible   ${ok_button}
    Select From List By Label           css:select.form-control     Teacher
    Select Checkbox                     ${terms}
    checkbox should be selected         ${terms}




