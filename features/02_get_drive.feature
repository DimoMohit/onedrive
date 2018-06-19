Feature: Get Drive using Token

  Scenario: Fetching Drive List using Token
    Given we have a valid token
    When visited the drive url with response_token is header
    Then we should get the drive list

  Scenario: Fetching MyDrive using Token
    Given we have a valid token
    When visited the my drive with response_token is header
    Then we should get my drive

  Scenario: Fetching Recent Folder using Token
    Given we have a valid token
    When visited the recent drive with response_token is header
    Then we should get the recent drive

  Scenario: Fetching Special Folder using Token
    Given we have a valid token
    When visited the document drive with response_token is header
    Then we should get the special drive
