*** Settings ***
Documentation    All the page objects and keywords of home page

Library         SeleniumLibrary
Library         OperatingSystem


*** Variables ***
${shop_page_load}       css:.nav-link


*** Keywords ***

wait until element is located

    Wait Until Element Is Visible       ${shop_page_load}

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
