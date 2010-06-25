Feature: Admin Submissions
  In order to manage everyones submissions 
  As an admin
  I want to list, show, and remove everyones submissions
  
  ####  WARNING
  #
  #  need to prep before running this cucumber:
  #  stop other workers, clean work dirs, then run:
  #  RAILS_ENV=cucumber rake ruote_kit:run_worker
  #
    
  @culerity
  Scenario: As an admin. List others submissions.  Show others submissions. Remove others submissions
    Given a workflow: "work1" exists with name: "test error workflow"
    And a protocol: "prot1" exists with name: "throw error", process_timeout: 5, executable: "/opt/bin/run_error.rb", pass_filenames: true, role_id: 1
    And a protocol: "prot2" exists with name: "test tar", process_timeout: 5, executable: "/opt/bin/run_tar.rb", pass_filenames: true, role_id: 1
    And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
    And a stage exists with position: 2, protocol: protocol "prot2", workflow: workflow "work1"
    When I log in with username: "test" and password: "password"
    And I go to the list of workflows page
    Then I should see "test error workflow"
    When I follow "Submit"
    Then I should see "New submission"
    When I select "test one" from "Output Project:"
    And I select index 0 from multiselect
    And I press "Submit"
    Then I should see "(active)"
    And I wait for 30 seconds
    When I log in with username: "test_admin" and password: "password"
    And I go to the list of submissions page
    Then I should see "test -- "
    And I should see "test one"
    And I should see "| throw error | test tar |"
    And I should see "Details"
    And I should see "Remove"
    When I follow "Details"
    Then I should see "FORCED ERROR"
    When I go to the list of submissions page
    And I follow "Remove"
    Then 0 submissions should exist
    And 0 tasks should exist
    
  
  