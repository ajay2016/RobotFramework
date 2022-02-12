*** Settings ***
Documentation     All the page objects and keywords of landing page
Library           SeleniumLibrary

*** Variables ***
${Shop_page_load}           css:.nav-link




*** Keywords ***

Verify items in the Checkout Page and proceed
    # Create list with the items
    @{expectedList} =  Create List       Nokia Edge   Blackberry
     # Get WebElements Returns a list of WebElement objects matching the locator.
    ${elements} =  Get WebElements         css:h4.media-heading
     # actual empty list Creating @ after $
    @{actualList} =       Create List
    FOR	${element}	IN	@{elements}
        # python to get text
      Log  ${element.text}
      Append To List	${actualList}	${element.text}
    END

    Lists Should Be Equal       ${expectedList}     ${actualList}

    click element   css:.btn-success
