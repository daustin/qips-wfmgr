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
