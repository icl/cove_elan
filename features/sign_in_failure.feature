Feature:
  As a user
  I want to know if a sign in failed
  So I can do somefing about it

  Scenario: Wrong password
    Given a user exists
    And I visit the home page
    And I fill in bad credentials
    And I sign in
    Then I should get a bad sign in message

  Scenario: Successful sign in
    Given a user exists
    And I visit the home page
    And I fill in valid login credentials
    And I sign in
    Then I should get a successful sign in message

  @wip
  Scenario: Sign out
    Given I am signed in
    And I sign out
    Then I should get a sign out message
