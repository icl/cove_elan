 @javascript
Feature: MetaData Fields
  As a user
  I would like to add metadata fields to templates
  So that I can see useful information

  Scenario: Select a metadata group
    Given a work document exists
    Given a meta data field group exists
    Given I am signed in
    When  I edit a template
    And I select a metadata group
    Then I should see fields for that group

  Scenario: Create metadata group

  Scenario: Create metadata field

  Scenario: Add fields to metadata group


