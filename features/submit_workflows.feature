Feature: Submit Workflows
  In order to run and manage jobs
  As a user
  I want to submit and monitor workflows and manage submissions
  
  ###############################
  # YOU MUST RUN RUOTE WORKER IN A SEPARATE THREAD FOR THIS TO WORK!!
  #  RAILS_ENV=cucumber rake ruote_kit:run_worker
  #
  #  also assumes there exists a project in ilims called "test one"
  #  also assumes there is an rmgr role with role_id
  #  Assumes username test is user id 3
  #
  ##
  
  Background:
    Given a workflow: "work1" exists with name: "test workflow", description: "test workflow description"
    And a protocol: "prot1" exists with name: "test reverse", process_timeout: 5, executable: "/opt/bin/run_reverse.rb", params_filename: "test.params", params_template: "test1: <%= values[:test_one] %>     test2: <%= values[:test_two] %>", pass_filenames: true, role_id: 1
    And a parameter exists with field_type: "text", field_label: "test one", var_name: "test_one", protocol: protocol "prot1"
    And a parameter exists with field_type: "text", field_label: "test two", var_name: "test_two", protocol: protocol "prot1"
    And a protocol: "prot2" exists with name: "test tar", process_timeout: 5, executable: "/opt/bin/run_tar.rb", pass_filenames: true, role_id: 1
    And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
    And a stage exists with position: 2, protocol: protocol "prot2", workflow: workflow "work1"
    And I log in with username: "test" and password: "password"
    And I should have 1 items in lims
    And I should have an item "test.txt" in lims
  
  @culerity
  Scenario: Submit a valid workflow. Check for active and inactive status.  Look for appropriate parameters.  Verify output of submission. Then delete the outputs.
    Given I go to the list of workflows page
    Then I should see "test workflow"
    When I follow "Submit"
    Then I should see "New submission"
    When I select "test one" from "Output Project:"
    And I select index 0 from multiselect
    And I fill in "test one" with "one"
    And I fill in "test two" with "two"
    And I press "Submit"
    Then I should see "(active)"
    And I should see "test.txt"
    And I should see "0 - test reverse"
    And I should see "1 - test tar"
    And I should see "test.params"
    And I should see "test1: one"
    And I should see "test2: two"
    # Waiting for the job to finish...
    When I wait for 30 seconds
    And I refresh the page
    Then I should not see "(active)"
    And I should see "()"
    And I should see "Processing test.txt..."
    And I should see "Tarring files..."
    And I should have 3 items in lims
    And I should have an item "test.txt.rev" in lims
    And item "test.txt.rev" should contain "eerht owt eno tset"
    When I follow "test one"
    Then I should see "Username"
    And I should see "Password"
    When I fill in "Username or Email Address" with "test"
    And I fill in "Password" with "password"
    And I press "Log in"
    Then I should see "test.txt.rev"
    And I should see "archive"
    Then I remove all items except "test.txt" in lims

  Scenario: Reject an invalid submission
    Given I go to the list of workflows page
    Then I should see "test workflow"
    When I follow "Submit"
    Then I should see "New submission"
    When I select "test one" from "Output Project:"
    And I press "Submit"
    Then I should not see "(active)"
    And I should see "You must choose at least one input file"
    And I should have 1 items in lims
  
  @culerity
  Scenario: Halt an erroneous submission. View errors for the submission. List erroneous submission. Check to make sure others submissions arent visible. Remove submission from list. 
    Given I clean the database
    And a workflow: "work1" exists with name: "test error workflow"
    And a protocol: "prot1" exists with name: "throw error", process_timeout: 5, executable: "/opt/bin/run_error.rb", pass_filenames: true, role_id: 1
    And a protocol: "prot2" exists with name: "test tar", process_timeout: 5, executable: "/opt/bin/run_tar.rb", pass_filenames: true, role_id: 1
    And a stage exists with position: 1, protocol: protocol "prot1", workflow: workflow "work1"
    And a stage exists with position: 2, protocol: protocol "prot2", workflow: workflow "work1"
    Given I go to the list of workflows page
    Then I should see "test error workflow"
    When I follow "Submit"
    Then I should see "New submission"
    When I select "test one" from "Output Project:"
    And I select index 0 from multiselect
    And I press "Submit"
    Then I should see "(active)"
    When I wait for 30 seconds
    And I refresh the page
    Then I should see "Throwing error..."
    And I should see "FORCED ERROR"
    And I should see "Your submission appears to have an error and is probably stuck. Please contact your system administrator."
    And I should see "(active with errors)"
    And I should not see "Tarring files..."
    And I should have 1 items in lims
    When I go to the list of submissions page
    Then I should see "test one"
    And I should see "| throw error | test tar |"
    And I should see "Your submission appears to have an error and is probably stuck. Please contact your system administrator."
    When I change all submissions to have user_id: 1
    And I go to the list of submissions page
    Then I should not see "throw error"
    When I change all submissions to have user_id: 3
    And I go to the list of submissions page
    Then I should see "throw error"
    When I follow "Remove"
    Then 0 submissions should exist
    And 0 tasks should exist
    Then I remove all items except "test.txt" in lims
  
