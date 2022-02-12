*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
# Tear down method to close browser
Test Teardown       Close Browser
# Resource (PO, utilities files)
# Test template of keywords
Test Template       Validate UnSuccessful Login

# Global variables module
*** Variables ***
${Login_Msg_Error}      css:.alert-danger


*** Test Cases ***      username                    password
# testcase name
Invalid username        qwrrr                       learning
Invalid password        rahulshettyacademy          jjhghf
Special character       567&ght                      learning

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


