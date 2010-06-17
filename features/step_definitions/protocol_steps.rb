Given /^the following protocols:$/ do |protocols|
  Protocol.create!(protocols.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) protocol$/ do |pos|
  visit protocols_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following protocols:$/ do |expected_protocols_table|
  expected_protocols_table.diff!(tableish('table tr', 'td,th'))
end


# dragging and parameter list related...

When /^I drag the last parameter to the top$/ do
  # find last parameter and drag to top
  
  lid = Parameter.last.id
  fid = Parameter.first.id
  
  source_xpath = "//li[@id='parameter_#{lid}']//span[@class='handle']"
  target_xpath = "//li[@id='parameter_#{fid}']//span[@class='handle']"
  
  # evaluate_script("$('#parameter_#{fid}').before($('#parameter_#{lid}'))") # HANGS selenium. no go with culerity
  
  # drag(source_xpath,target_xpath) #this doesn't work!!
  # Capybara.page.driver.find(source_xpath).first.drag_to(Capybara.page.driver.find(target_xpath).first) # this doesn't work either!!  oh well

end

Then /^input (\d+) in list "([^\"]*)" should be "([^\"]*)"$/ do |ind, list, id|
  
  within(:css, "ul##{list}") do
    all('input')[ind.to_i][:id].should == id

    
  end

end