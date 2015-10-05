Feature: Authorization.
  As a user that has been registered on the site, I want to be able to access
  my account settings and my feed in order to enjoy new information in my feed
  and contact with my friends.

  Scenario: Log in to the site
    Given I am on "login" page
      And There is a user "_testuser" with password "ntcnbhjdfybt"
    When I enter user credentials
      And press "Sign in"
    Then I should be on the homepage
      And I should see "sign out"

  Scenario: Unregistered 
    Given I am on "login" page
    When I fill in "Username" with "notexists"
      And fill in "Password" with "notexists"
      And press "Sign in"
    Then I should be on "login error" page
      And I should see "We could not find the nickname you provided."
      And I should see "Create an account »"

  Scenario: Wrong password
    Given I am on "login" page
      And There is a user "_testuser" with password "ntcnbhjdfybt"
    When I fill in "Username" with "_testuser"
      And fill in "Password" with "unntcnbhjdfybt"
      And press "Sign in"
    Then I should be on "login error" page
      And I should see "The password you provided does not match the password in our system."
      And I should see "Create an account »"

  Scenario: Empty password field
    Given I am on "login" page
    When I fill in "Username" with "_testuser"
      And press "Sign in"
    Then I should be on the homepage
          #on Friendfeed no error is displayed. on pepyatka:
    # And I should see "Error: user undefined doesn't exist"
          #Error: Please enter password

  Scenario: Reach Create account page from login error
    Given I am on "login error" page
    When I follow "Create an account »"
    Then I should be on "registration" page
