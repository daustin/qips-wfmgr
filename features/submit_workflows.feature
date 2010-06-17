Feature: Submit Workflows
  In order to run jobs
  As a user
  I want to submit and monitor workflows
  
  ###############################
  # YOU MUST RUN RUOTE WORKER IN A SEPARATE THREAD FOR THIS TO WORK!!
  #  RAILS_ENV=cucumber rake ruote_kit:run_worker
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
  
  @culerity
  Scenario: Submit a valid workflow. Check for active and inactive status.  Look for appropriate parameters.
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
    
    
  Scenario: Reject an invalid submission
  
  Scenario: Halt an erroneous submission. View errors for the submission
  
  Scenario: Verify outputs of submission

