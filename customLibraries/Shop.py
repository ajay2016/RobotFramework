from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Shop(object):

    def __init__(self):
        # To initialize Selenium library
        self.selenium_lib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def hello_world(self):
        print("Hello World")

    @keyword
    def add_items_to_cart_and_checkout(self, product_lists):
        # ${elements} = Get WebElements         css:.card - title
        product_titles = self.selenium_lib.get_webelements("css:.card-title")
        # iterate
        i = 1
        for product_title in product_titles:
            if product_title.text in product_lists:
                self.selenium_lib.click_button("(//*[@class ='card-footer'])["+str(i)+"]/button")

            i = i + 1
        self.selenium_lib.wait_until_element_is_visible("//*[@id='navbarResponsive']/ul/li")
        self.selenium_lib.click_element("//*[@id='navbarResponsive']/ul/li")
