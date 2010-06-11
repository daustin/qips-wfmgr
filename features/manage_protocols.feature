Feature: Manage protocols
  In order to have users run specific tasks
  As an administrator
  I want to list, create, update, and destroy protocols and their parameters
  
  Scenario: list protocols
    Given a protocol exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params"
    And I log in with username: "test" and password: "password"
    When I go to the list of protocols page
    Then I should see "test protocol name"
    And I should see "test protocol description"
    And I should see "true"
    And I should see "/path/test.sh"
    And I should see "test.params"
    
  @selenium
  Scenario: Create a valid protocol with parameters and aux files
    When I log in with username: "test" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with "test protocol name"
    And I fill in "Description" with "test protocol description"
    And I fill in "Executable" with "/path/to/exec.sh"
    And I check "Run Concurrently"
    And I select "compute" from "Resource Manager Role"
    And I select index 0 from multiselect
    And I fill in "Default args" with "--test_arg"
    And I check "Pass input filenames to executable"
    And I fill in "Process timeout" with "5"
    And I fill in "Params filename" with "test.params"
    And I fill in "Params template" with "test one: <%= values[:test_one] %>     test two: <%= values[:test_two] %>"
    And I press "Submit"
    Then I should see "Protocol was successfully created."
    And I should see "test protocol name"
    And I should see "test protocol description"
    And I should see "/path/to/exec.sh"
    And I should see "(concurrent)"
    And I should see "/path/to/exec.sh --test_arg --input_files=file1,file2"
    And I should see "5 mins"
    And I should see "test.params"
    And I should see "test one:"
    And I should see "test two:"
    And I should see "archive.tar"
  
  Scenario: Reject an invalid protocol - missing information
    When I log in with username: "test" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with ""
    And I fill in "Description" with "test protocol description"
    And I fill in "Executable" with ""
    And I fill in "Process timeout" with ""
    And I press "Submit"
    Then I should not see "Protocol was successfully created."
    And I should see "Name can't be blank"
    And I should see "Executable can't be blank"
    And I should see "Process timeout can't be blank"
  
  Scenario: Reject an invalid protocol - invalid information format
    When I log in with username: "test" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with "test protocol name"
    And I fill in "Description" with "test protocol description"
    And I fill in "Executable" with "/te st/exec uta ble.sh"
    And I fill in "Process timeout" with "nan"
    And I fill in "Params filename" with "te st.par ams"
    And I press "Submit"
    Then I should not see "Protocol was successfully created."
    And I should see "Executable cannot contain whitespaces"
    And I should see "Params filename cannot contain whitespaces"
    And I should see "Process timeout must be an integer"
      
  Scenario: Edit a protocol. Add / remove params and aux files
  
  Scenario: Review a protocol. re arrange parameter ordering
  
  Scenario: Destroy a protocol
    Given a protocol exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params"
    And I log in with username: "test" and password: "password"
    When I go to the list of protocols page
    And I follow "Destroy"
    Then 0 protocols should exist
  