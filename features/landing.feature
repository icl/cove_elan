Feature: Landing Page
  As a user
  I would like to land on friendly page
  To keep it chill

  Scenario: New User
    When I visit the home page
    Then I should not see a warning about logging in

