
# Login!
Given /^I log in with username: "([^\"]*)" and password: "([^\"]*)"$/ do |username, password|

  visit path_to("the login page")
  fill_in("Username or Email Address", :with => username)
  fill_in("Password", :with => password)
  click_button("Log in")

end

