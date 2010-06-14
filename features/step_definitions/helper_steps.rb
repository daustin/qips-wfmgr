#HELPERS for various features

# wait for seconds

When /^I wait for (\d+) seconds?$/ do |n|
  sleep n.to_i
end

# for special UI multiselect. ONLY works with selenium

When /^I select index (\d+) from multiselect$/ do |ind|
  within(:css, "li.ui-element") do
        all('a')[ind.to_i].click 
  end
end

When /^I remove index (\d+) from multiselect$/ do |ind|
  within(:css, "ul.selected") do
        all('a')[ind.to_i].click
  end
  
end

# testing the value of an input

Then /^input "([^\"]*)" should have value "([^\"]*)"$/ do |id, val|

  locate(:css, "input##{id}").value.should == val
  
end
