*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
Library             DataDriver       file=resources/data.csv     encoding=utf_8     dialect=unix
# Test Setup (Before Test)
#Test Setup          open browser with given url

# Tear down method to close browser (After Test)
Test Teardown       Close Browser

Test Template       Validate UnSuccessful Login

# Global variables module
*** Variables ***
${Login_Msg_Error}      css:.alert-danger

*** Test Cases ***
Log in with user ${username} with password ${password}

*** Keywords ***
Validate UnSuccessful Login
    # Teststeps
    [arguments]         ${username}     ${password}
    open browser with given url
    fill the login form     ${username}     ${password}
    wait until it checks and display error
    verify the error message is correct

open browser with given url
    Create WebDriver   Chrome
    Go To  https://www.rahulshettyacademy.com/loginpagePractise/
    MAXIMIZE BROWSER WINDOW

fill the login form
    [arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn
wait until it checks and display error
    Wait Until Element Is Visible       ${Login_Msg_Error}
verify the error message is correct
    ${result_text}=  Get Text    ${Login_Msg_Error}
    # from builtin library
    Should Be Equal As Strings      ${result_text}          Incorrect username/password.
    Element Text Should Be          ${Login_Msg_Error}      Incorrect username/password.
#Close Browser Session
    #close browser


