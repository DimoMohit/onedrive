Feature: Get Token using OAuth2

  Scenario: Fetching Token using Code
    Given client_id, redirect_uri and scope is known
    When visited the authorize uri with response_type as code
    Then we should get the token

  Scenario: Fetching Refresh Token using Code
    Given client_id, redirect_uri and scope is known
    When visited the authorize uri with response_type as refresh_token
    Then we should get the token
