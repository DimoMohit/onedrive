Feature: Get Drive using Token

  Scenario: Fetching Drive List using Token
    Given we have a valid token
    When visited the drive url with response_token is header
    Then we should get the drive list
