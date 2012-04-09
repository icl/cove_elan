Feature: Capture Data
  As a researcher
  I would like to capture arbitrary files
  So I don't list them in a dusty old box

  Background:
    Given I am signed in

  Scenario: Upload one file

  Scenario: Scan a path
    When I ask COVE to scan "some_path"
    Then COVE should create record a capture for "some_path"
    And create assets for any files in "some_path"

