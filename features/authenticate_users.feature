Feature: Authenticate Users
In order to restrict and organize users data
As a user
I want to log in with the appropriate information 

###############################################################
#
#   THIS USES ACTIVE RESOURCE. 
#   TEST DATA IS THE LIVE REMOTE DATA!
#
#

Scenario: Valid login
  When I log in with username: "dave" and password: "password"
  Then I should not see "Log in"
  And I should see "Logged in successfully."
  And I should see "Welcome, dave!"

Scenario: Missing or bad username
  When I log in with username: "test2" and password: "secret"
  Then I should see "Invalid login or password."
  And I should see "Log in"
  And I should not see "Welcome, test2!"

Scenario: Missing or bad password
  When I log in with username: "test" and password: "secret2"
  Then I should see "Invalid login or password."
  And I should see "Log in"
  And I should not see "Welcome, test!"

Scenario: Logout and reset session
  When I log in with username: "dave" and password: "password"
  Then I should not see "Log in"
  And I should see "Logged in successfully."
  And I should see "Welcome, dave!"
  When I follow "Logout"
  And I go to the list of workflows page
  Then I should see "You must first log in or sign up before accessing this page."
  And I should see "Log in"
  And I should not see "Welcome, dave!"
  