Feature: Manage protocols
  In order to have users run specific tasks
  As an administrator
  I want to list, create, update, and destroy protocols and their parameters
  
  Scenario: list protocols
    Given a protocol exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params", role_id: 1
    And I log in with username: "test" and password: "password"
    When I go to the list of protocols page
    Then I should see "test protocol name"
    And I should see "test protocol description"
    And I should see "true"
    And I should see "/path/test.sh"
    And I should see "test.params"
    
  @culerity
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
    And I follow "Add"
    And I select "text" from "Field type"
    And I fill in "Field Label" with "Test one"
    And I fill in "Var Name" with "test1"
    And I fill in "Description" with "params description"
    And I fill in "Initial value" with "init value"
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
    And I should see "test.txt"
    And I should see "Test one:"
    And I should not see "test1"
    And input "test1" should have value "init value"
    And I should see "params description"
  
  @culerity
  Scenario: Reject an invalid protocol - missing information
    When I log in with username: "test" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with ""
    And I fill in "Description" with "test protocol description"
    And I fill in "Executable" with ""
    And I fill in "Process timeout" with ""
    And I follow "Add"
    And I fill in "Field Label" with ""
    And I fill in "Var Name" with ""
    And I press "Submit"
    Then I should not see "Protocol was successfully created."
    And I should see "Name can't be blank"
    And I should see "Executable can't be blank"
    And I should see "Process timeout can't be blank"
    And 0 parameters should exist
  
  @culerity
  Scenario: Reject an invalid protocol - invalid information format
    When I log in with username: "test" and password: "password"
    And I go to the new protocol page
    And I fill in "Name" with "test protocol name"
    And I fill in "Description" with "test protocol description"
    And I fill in "Executable" with "/te st/exec uta ble.sh"
    And I fill in "Process timeout" with "nan"
    And I fill in "Params filename" with "te st.par ams"
    And I follow "Add"
    And I fill in "Field Label" with "test"
    And I fill in "Var Name" with "te st"
    And I press "Submit"
    Then I should not see "Protocol was successfully created."
    And I should see "Executable cannot contain whitespaces"
    And I should see "Params filename cannot contain whitespaces"
    And I should see "Process timeout must be an integer"
    And I should see "Var name cannot contain whitespaces"

  @culerity
  Scenario: Edit a protocol. Add / remove params and aux files
    Given I log in with username: "test" and password: "password"
    And a protocol exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params", role_id: 1
    When I go to the edit page for that protocol
    And I select index 0 from multiselect
    And I follow "Add"
    And I fill in "Field Label" with "test label"
    And I fill in "Var Name" with "test1"
    And I fill in "Initial value" with "init value"
    And I press "Submit"
    Then I should see "test.txt"
    And I should see "test label:"
    And input "test1" should have value "init value"
    When I follow "Edit"
    And I remove index 0 from multiselect
    And I follow "Remove"
    And I press "Submit"
    Then I should not see "test.txt"
    And I should not see "test label:"
    And 0 parameters should exist
  
  @culerity
  Scenario: Review a protocol. Verify parameters look like they should. Test drag and drop.
    Given I log in with username: "test" and password: "password"
    And a protocol: "test" exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params", role_id: 1
    And a parameter exists with field_type: "text", field_label: "test text", var_name: "test_text", initial_value: "test value", protocol: protocol "test"
    And a parameter exists with field_type: "select", field_label: "test select", var_name: "test_select", value_options: "one,two,three", initial_value: "two", protocol: protocol "test"
    And a parameter exists with field_type: "radio_box", field_label: "test radio", var_name: "test_radio", value_options: "four,five,six", initial_value: "five", protocol: protocol "test"
    And a parameter exists with field_type: "check_box", field_label: "test check", var_name: "test_check", protocol: protocol "test"
    When I go to the show page for that protocol
    Then I should see "test text:"
    And input "test_text" should have value "test value"
    And I should see "test select:"
    And select "test_select" should have options "one,two,three"
    And select "test_select" should have value "two"
    And I should see "test radio:"
    And radio "test_radio" should have options "four,five,six"
    And radio "test_radio" should have value "five"
    And input "test_check" should not be checked
    ### dragging doesn't appear to be supported right now 
    # When I drag the last parameter to the top
    # And I go to the show page for that protocol
    # Then input 0 in list "parameters" should be "test_check"
      
  Scenario: Destroy a protocol
    Given a protocol exists with name: "test protocol name", process_timeout: 5, description: "test protocol description", run_concurrent: "true", executable: "/path/test.sh", params_filename: "test.params", role_id: 1
    And I log in with username: "test" and password: "password"
    When I go to the list of protocols page
    And I follow "Destroy"
    Then 0 protocols should exist
  