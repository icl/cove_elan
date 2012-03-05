@javascript
Feature: View Annotations
    As a user
    I would like to see annotations that have been entered
    So I can confirm they are as they should be

  Background:
    Given I am signed in

  Scenario: Viewing a document
    When I look at a work document
    Then I should see a table of annotations
    And an image of the tiers

