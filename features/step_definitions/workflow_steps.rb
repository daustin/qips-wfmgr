
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

# the following steps assist with managing items from lims

Then /^I should have (\d+) items in lims$/ do |c|
  u = User.find(ILIMS_USER_ID)
  u.items.length.should == c.to_i
end

Then /^I should have an item "([^\"]*)" in lims$/ do |n|
  u = User.find(ILIMS_USER_ID)
  i = u.find_item_by_name(n)
  i.should_not be_nil
end

Then /^item "([^\"]*)" should contain "([^\"]*)"$/ do |n, s|
  u = User.find(ILIMS_USER_ID)
  i = u.find_item_by_name(n)
  file = `#{WGET_CMD} #{ILIMS_SITE}/items/#{i.id}/download.xml`
  
  file.should =~ /#{s}/
  
end

Then /^I remove all items except "([^\"]*)" in lims$/ do |s|
  
  u = User.find(ILIMS_USER_ID)
  u.items.each do |i|
    unless i['attachment_file_name'] == s
      item = Item.find(i['id'].to_i)
      item.destroy
    end
  end
  
  
end

