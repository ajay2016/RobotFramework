*** Settings ***
Documentation       To validate the login form
Library             SeleniumLibrary
Library             Collections
Library             ../customLibraries/Shop.py
# Test Setup (Before Test)
Test Setup          open browser with given url

# Tear down method to close browser (After Test)
#Test Teardown       Close Browser Session
Resource            ../PO/generic.robot
Resource            ../PO/homepage.robot
Resource            ../PO/shop_page.robot

# Global variables module
*** Variables ***


${item_text}            xpath:(//*[text()='Blackberry'])
${checkout_button}      //*[@id='navbarResponsive']/ul/li
${ok_button}            id:okayBtn
${terms}                id:terms
${product_lists}        Blackberry, Nokia Edge


*** Test Cases ***
# testcase name

Validate UnSuccessful Login
    # Teststeps
    # data from resources
     homepage.fill the login form     ${user_name}        ${invalid_password}
     homepage.wait until element is located in the page
     homepage.verify the error message is correct


Validate cards display after successful login
    #data from resources
   homepage.fill the login form     ${user_name}        ${valid_password}
   shop_page.wait until element is located
    shop_page.verify cards title in shop page
    #select the card         Blackberry
    #click on checkout
    shoppage.add to cart and checkout    ${product_lists}

#Select user form and switch to child window
   homepage.fill the login details and select user option   ${user_name}        ${valid_password}








#Close Browser Session
    #close browser


click on checkout
    wait until element is visible   ${checkout_button}
    Click Element    ${checkout_button}
    #click element    ${checkout_button}
    Element Text Should Be          ${item_text}      Blackberry


    #hello world




