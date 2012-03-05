Feature: Login to app
As a user
I would like to login
To see protected content

  Background:
    Given a user exists

  Scenario: Logging in
    When I visit the home page
    And I fill in valid login credentials
    And I sign in
    Then I should be signed in
