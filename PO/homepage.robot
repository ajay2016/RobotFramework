*** Settings ***
Documentation    All the page objects and keywords of home page

Library         SeleniumLibrary
Library         OperatingSystem
Resource        Generic.robot

*** Variables ***
${Login_Msg_Error}      css:.alert-danger

*** Keywords ***

fill the login form
    # methods with different  arguments get data from test case on run time

    [arguments]         ${username}     ${password}
    Input Text          id:username     ${username}
    Input Password      id:password     ${password}
    Click Button        id:signInBtn

wait until element is located in the page

    Wait Until element passed is located on Page       ${Login_Msg_Error}

verify the error message is correct
    ${result_text}=  Get Text    ${Login_Msg_Error}
    # from builtin library
    Should Be Equal As Strings      ${result_text}          Incorrect username/password.
    # Validating in 1 line
    Element Text Should Be          ${Login_Msg_Error}      Incorrect username/password.

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
