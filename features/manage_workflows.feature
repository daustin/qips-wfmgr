Feature: Manage workflows
  In order to submit jobs.
  As a user
  I want to List, Create, Update, and Delete my workflows. 

  # note this feature file assumes username test has an id of 3!!!
  
  Scenario: list my workflows and the links
  Given a workflow: "work1" exists with name: "test workflow", description: "test workflow description", user_id: 3
  And a protocol: "prot1" exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And a protocol: "prot2" exists with name: "test protocol 2", process_timeout: 5, executable: "/path/test2.sh", role_id: 1
  And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
  And a stage exists with position: 2, protocol: protocol "prot2", workflow: workflow "work1"
  And I log in with username: "test" and password: "password"
  When I go to the list of workflows page
  Then I should see "test workflow"
  And I should see "test workflow description"
  And I should see "| test protocol 1 | test protocol 2 |"
  And I should see "Submit"
  And I should see "Show"
  And I should see "Edit"
  And I should see "Destroy"
  And I should see "New workflow"
    
  Scenario: Do not list others workflows
  Given a workflow exists with name: "test workflow", description: "test workflow description", user_id: 3
  And a workflow exists with name: "test other workflow", description: "someone elses", user_id: 1
  And I log in with username: "test" and password: "password"
  When I go to the list of workflows page
  Then I should see "test workflow"
  And I should see "test workflow description"
  And I should not see "test other workflow"
  And I should not see "someone elses"
    
  Scenario: List public workflows and only their submit link 
  Given a workflow exists with name: "test workflow", description: "test workflow description"
  And I log in with username: "test" and password: "password"
  When I go to the list of workflows page
  Then I should see "test workflow"
  And I should see "test workflow description"
  And I should see "Submit"
  And I should not see "Show"
  And I should not see "Edit"
  And I should not see "Destroy"
  
  @culerity
  Scenario: Create valid workflow with a protocol
  Given a protocol exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And I log in with username: "test" and password: "password"
  When I go to the new workflow page
  And I fill in "Name" with "test workflow name"
  And I fill in "Description" with "test workflow description"
  And I follow "Add"
  And I select "test protocol 1" from "-"
  And I press "Save Only"
  Then I should see "Workflow was successfully created"
  And I should see "test workflow name"
  And I should see "test workflow description"
  And I should see "| test protocol 1 |"
    
  @culerity
  Scenario: Reject invalid workflow
  Given a protocol exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And I log in with username: "test" and password: "password"
  When I go to the new workflow page
  And I fill in "Name" with ""
  And I fill in "Description" with "test workflow description"
  And I follow "Add"
  And I select "test protocol 1" from "-"
  And I press "Save Only"
  Then I should not see "Workflow was successfully created"
  And I should see "Name can't be blank"
  And 0 workflows should exist
  
  @culerity
  Scenario: Do not save blank protocol selections
  Given a protocol exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And I log in with username: "test" and password: "password"
  When I go to the new workflow page
  And I fill in "Name" with "test workflow name"
  And I fill in "Description" with "test workflow description"
  And I follow "Add"
  And I press "Save Only"
  Then I should see "Workflow was successfully created"
  And I should see "test workflow name"
  And I should see "test workflow description"
  And 0 stages should exist
  
  Scenario: Show a workflow and its protocols
  Given a workflow: "work1" exists with name: "test workflow", description: "test workflow description", user_id: 3
  And a protocol: "prot1" exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And a protocol: "prot2" exists with name: "test protocol 2", process_timeout: 5, executable: "/path/test2.sh", role_id: 1
  And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
  And a stage exists with position: 2, protocol: protocol "prot2", workflow: workflow "work1"
  And I log in with username: "test" and password: "password"
  When I go to the show page for that workflow
  Then I should see "Name: test workflow"
  And I should see "Description: test workflow description"
  And I should see "test protocol 1"
  And I should see "/path/test.sh"
  And I should see "test protocol 2"
  And I should see "/path/test2.sh"
  
  @culerity
  Scenario: Edit a workflow, add / remove protocol
  Given a workflow: "work1" exists with name: "test workflow", description: "test workflow description", user_id: 3
  And a protocol: "prot1" exists with name: "test protocol 1", process_timeout: 5, executable: "/path/test.sh", role_id: 1
  And a protocol: "prot2" exists with name: "test protocol 2", process_timeout: 5, executable: "/path/test2.sh", role_id: 1
  And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
  And I log in with username: "test" and password: "password"
  When I go to the edit page for that workflow
  And I fill in "Name" with "test workflow again"
  And I fill in "Description" with "test description"
  And I follow "remove"
  And I press "Update"
  Then I should see "Workflow was successfully updated."
  And I should see "test workflow again"
  And I should see "test description"
  And I should not see "test protocol 1"
  And 0 stages should exist
  When I follow "Edit"
  And I follow "Add"
  And I select "test protocol 2" from "-"
  And I press "Update"
  Then I should see "Workflow was successfully updated."
  And I should see "test protocol 2"
  And I should see "/path/test2.sh"
  And 1 stages should exist
    
  Scenario: Destroy a workflow
  Given a workflow: "work1" exists with name: "test workflow", description: "test workflow description", user_id: 3
  And I log in with username: "test" and password: "password"
  When I go to the list of workflows page
  And I follow "Destroy"
  Then I should not see "test workflow"
  And 0 workflows should exist
  
  
  
  
  
  