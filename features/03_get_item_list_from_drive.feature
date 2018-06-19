Feature: Get Item List from drive using Token

  Scenario: Fetching Item List from drive using Token
    Given we have a valid token
    And have drive list
    When visited the item url with drive id
    Then we should get the item list
  Scenario: Fetching Item List from my drive using Token
    Given we have a valid token
    When visited the item url without drive id
    Then we should get the OneDriveExceptions

  Scenario: Fetching Item from my drive using Token
    Given we have a valid token
    When visited the item url with its id "3385EC73AA67569B%2134136"
    Then we should get the item

  Scenario: Search Item from my drive using Token
    Given we have a valid token
    When we search for item "dummy"
    Then we should get the items
