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

# testing the value of an input (or select) tag

Then /^(input|select|radio) "([^\"]*)" should have value "([^\"]*)"$/ do |tag, id, val|

  if tag == 'radio'
    locate(:css, "input##{id}_#{val}")[:checked].should be_true
  else
    locate(:css, "#{tag}##{id}").value.should == val
  end
end

# testing the options of a select tag

Then /^(select|radio) "([^\"]*)" should have options "([^\"]*)"$/ do |tag, id, options|

  options_array = options.split(',')

  if tag == 'select'

    within(:css, "select##{id}") do
      count = 0
      all('option').each do |o|
        o.value.should == options_array[count]
        o.text.should == options_array[count]
        count +=1 
      end
    end
  
  end
  
  if tag == 'radio'
    
    options_array.each do |v|

      locate(:css, "input##{id}_#{v}")[:name].should == id
      locate(:css, "input##{id}_#{v}").value.should == v

    end
        
  end
  
end

# test if checkbox is not checked

Then /^input "([^\"]*)" should not be checked$/ do |arg1|
  find_field(arg1)[:checked].should be_false 
end









