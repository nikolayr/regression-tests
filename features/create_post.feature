Feature: Create Posts.
  As a user that has been logged in to the site, I want to be able to 
  make posts to my feed.
  # $(".ember-view.ember-text-area.edit-post-area")
 
  Scenario: Log in to the site
    Given I am logged in as "User1"
    When I type in text "some arbitrary text" to edit box
      And press button "Post"
    Then I should see new post with text "some arbitrary text" in my feed
      And I should see empty edit box
 