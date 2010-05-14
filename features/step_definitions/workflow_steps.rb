Given /^the following workflows:$/ do |workflows|
  Workflow.create!(workflows.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) workflow$/ do |pos|
  visit workflows_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following workflows:$/ do |expected_workflows_table|
  expected_workflows_table.diff!(tableish('table tr', 'td,th'))
end
