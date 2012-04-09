Feature: MetaData Fields
  As a user
  I would like to add metadata fields to templates
  So that I can see useful information

  Background:
    Given I am signed in

  Scenario: Select a metadata group
    Given a work document exists
    Given I make a meta data field group named "numero uno"
    When  I edit a template
    And I select metadata group "numero uno"
    Then I should see fields group "numero uno"

  Scenario: Create metadata group
    When I request a new meta data group
    And I fill in a reasonable name like "numero_uno"
    And I submit the group
    Then I should have a new metadata group named "numero_uno"

  Scenario: Create metadata field

  Scenario: Add fields to metadata group


