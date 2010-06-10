#HELPERS for various features

# wait for seconds

When /^I wait for (\d+) seconds?$/ do |n|
  sleep n.to_i
end

# for special UI multiselect

When /^I select index "([^\"]*)" from multiselect$/ do |ind|
  within(:css, "li.ui-element") do
        all('a')[ind.to_i].click
  end
end


