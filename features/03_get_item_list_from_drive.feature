Feature: Get Item List from drive using Token

  Scenario: Fetching Item List from drive using Token
    Given we have a valid token
    When visited the item url with drive id
    Then we should get the item list
  Scenario: Fetching Item List from my drive using Token
    Given we have a valid token
    When visited the item url without drive id
    Then we should get the item list
