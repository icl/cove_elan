Feature: Marking Assets for Review
As a researcher
I would like to mark assets to be reviewed
So that someone will fill in all the neccessary metadata

  Background:
    Given I am signed in

  Scenario: New Asset
    When I upload an asset
    Then it should it should be marked as needing review

  Scenario: Old Asset that should be reviewed
    Given an asset that needs review
    When I mark it for review
    Then it should it should be marked as needing review    
    And it should appear in the list to be reviewed

  Scenario: Remove needs review
    Given an asset that needs review
    When I confirm that it has been reviewed
    Then it should not be marked to be reviewed
    Then it shouldn't appear in the list to be reviewed

