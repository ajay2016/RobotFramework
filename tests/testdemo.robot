*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
# Tear down method to close browser
Test Teardown       Close Browser
# Resource (PO, utilities files)

# Global variables module
*** Variables ***
${Login_Msg_Error}      css:.alert-danger


*** Test Cases ***
# testcase name

Validate UnSuccessful Login
    # Teststeps

    open browser with given url
    fill the login form
    wait until it checks and display error
    verify the error message is correct

*** Keywords ***
open browser with given url
    Create WebDriver   Chrome
    Go To  https://www.rahulshettyacademy.com/loginpagePractise/
    MAXIMIZE BROWSER WINDOW
fill the login form
    Input Text          id:username     rahulshettyacademy
    Input Password      id:password     12333
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


