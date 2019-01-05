Feature: Amazon search
  As a user I want to search a new
  smarthpone called iPhone 6S, see
  the first item in the list and then,
  add it to the cart. 

  Scenario Outline: amazon_mobile_phone
    Given I am in amazon webpage
    When I look for <phone> in the searchBox
    Then I see a list of results
    And I want to see the <number> item
    And I want to add it to the shopping cart
     
    Examples:
      | phone             | number | 
      | iphone 6s         | first  | 
      | xiamoi redmi note | second | 