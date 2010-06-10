Feature: Manage protocols
  In order to have users run specific tasks
  As an administrator
  I want to list, create, update, and destroy protocols and their parameters
  
  Scenario: list protocols
  
  @selenium
  Scenario: Create a valid protocol with parameter and aux files
    When I log in with username: "dave" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with "protocol name"
    And I fill in "Description" with "protocol description"
    And I fill in "Executable" with "/path/to/exec.sh"
    And I select index "0" from multiselect
    And I press "Submit"
    Then I should see "Protocol was successfully created."
    And I should see "protocol name"
    And I should see "protocol description"
    And I should see "/path/to/exec.sh"
    And I should see "interact-prot-3882.txt"
  
  Scenario: Reject and invalid protocol
  
  Scenario: Edit a protocol. Add / remove params and aux files
  
  Scenario: Review a protocol. re arrange parameter ordering
  
  Scenario: Destroy a protocol
  
  