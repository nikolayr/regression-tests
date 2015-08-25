P_SITE='http://micropeppa.freefeed.net/'

Given /^I am on "([^"]*)" page$/ do |page_name|

  url_path = nil
  payload_check = nil

  case page_name
    when 'login'
      url_path = '/session/signin'
      payload_check = {:node => '.p-signin-header', :value => 'Sign in'}
    when 'homepage'
      url_path = ['','/']
  else
    pending # pour some code 
  end

  #redirect to page - url_path

  #check page transition
  #check that current session path is url_path
  #check that page has payload payload_check 


  
end

Given /^There is a user "([^"]*)" with password "([^"]*)"$/ do |username, user_password|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  steps %Q{ 
    When fill in "#{arg1}" with "#{arg2}"
  }
end

When /^fill in "([^"]*)" with "([^"]*)"$/ do |control_name, payload|

  case control_name
    when 'login'
    when 'password'
    
  else
    pending # express the regexp above with the code you wish you had
  end
end

When /^press "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be on the homepage$/ do
  steps %Q{
    I should be on "homepage" page
  }
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be on "([^"]*)" page$/ do |page_title|

  case page_title
    when "homepage"
      pending # check URL-ADDRESS? 
  else
    pending # express the regexp above with the code you wish you had
  end

end

When /^I follow "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


 Given /^I am logged in as "([^"]*)"$/ do |name|
  pending # express the regexp above with the code you wish you had

 # Look ma, no quotes!
 # Easier to do "extract steps from plain text" refactorings with cut and paste!
#  steps %Q{
#    Given the user #{name} exists
#    Given I log in as #{name}
#  }

end

When /^I type in text "([^"]*)" to edit box$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see new post with text "([^"]*)" in my feed$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see empty edit box$/ do
  pending # express the regexp above with the code you wish you had
end

When /^press button "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I wait until all Ajax requests are complete$/ do
#  wait_until do
#    page.evaluate_script('$.active') == 0
#  end
end

