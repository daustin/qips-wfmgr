Given /^the following submissions:$/ do |submissions|
  Submission.create!(submissions.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) submission$/ do |pos|
  visit submissions_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following submissions:$/ do |expected_submissions_table|
  expected_submissions_table.diff!(tableish('table tr', 'td,th'))
end
