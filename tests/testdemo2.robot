*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
Library             Collections
Library             String
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

Validate Child window functionality
    # Teststeps
    Select the link of child window
    Verify user to directed to child window
    Get the email form the child window
    Switch to parent window and Enter Email


*** Keywords ***
Select the link of child window
    Click Element   css:a.blinkingText
    Sleep           5
Verify user to directed to child window
    Switch Window               NEW
    #${handles}=  Get Window Handles
    #Switch Window   ${handles}[1]
    element text should be      css:h2          DOCUMENTS REQUEST
Get the email form the child window
   ${email_text} =  Get Text    css:.red
  @{words} =        Split String	${email_text}	at

  # 0 index Please email us
  # 1 index  mentor@rahulshettyacademy.com with below template to receive response
  ${words1} =    Get From List	${words}	1
  # make required email as global so that below test can use it
  ${word2} =    Split String	${words1}   with
  ${reqd_email}=    Get From List	${word2}    0

  Set Global Variable       ${reqd_email}
  log   ${reqd_email}

Switch to parent window and Enter Email
    Switch Window   MAIN
    Title Should Be     LoginPage Practise | Rahul Shetty Academy
    Input Text          id:username     ${reqd_email}



