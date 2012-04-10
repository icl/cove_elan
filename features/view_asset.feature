Feature: Looking at assets online
  As a user
  I would like to pre/view assets
  So I don't have to create a baroque file system

  Background:
    Given I am signed in

  Scenario: A video 
    Given I make a video asset
    And I navigate to its page
    Then I should see the video

  Scenario: An image
    When I look at the page for an image asset
    Then I should see the image

  Scenario: A word document

  Scenario: Who knows?
