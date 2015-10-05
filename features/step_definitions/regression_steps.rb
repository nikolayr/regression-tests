require 'capybara'
require 'capybara/poltergeist'
require 'wait_until'


P_SITE='https://micropeppa.freefeed.net'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:inspector => true})
#, :js_errors => false})
end

# :js_errors => false
# :window_size => [800,600]

#http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Session


Given /^I am on "([^"]*)" page$/ do |page_name|

  url_path = nil

  @session = Capybara::Session.new(:selenium)#:poltergeist

  case page_name
    when 'login'
      url_path = '/session/signin'
    when 'homepage'
      url_path = '/'
  else
    pending # pour some code 
  end

  @session.visit(P_SITE + url_path)

  Wait.until!("loading page:#{page_name} on ") { @session.evaluate_script('$.active') }

  #check page transition
  #check that current session path is url_path

end

Given /^There is a user "([^"]*)" with password "([^"]*)"$/ do |username, user_password|

  case username
    when '_testuser'
      username = 'testuser'
  end
  @usern = {:username=>username,:password=>user_password}


end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  steps %Q{ 
    When fill in "#{arg1}" with "#{arg2}"
  }
end

When /^fill in "([^"]*)" with "([^"]*)"$/ do |control_name, payload|

  ctrl_id = nil
  case control_name
    when 'unknown_ctrl'
      ctrl_id = 'unknown_ctrl'
    else
      ctrl_id = control_name.downcase
  end

  #@session.fill_in(ctrl_id, :with => payload)

  element = @session.find("input\##{ctrl_id}")
  unless element.nil?
    element.native.send_key(payload)
  else
    puts "can't find control:#{control_name}"
    fail if true
  end

end

When /^press "([^"]*)"$/ do |arg1|
  @session.click_link_or_button(arg1)
end

When(/^I enter user credentials$/) do
  @usern.each do |u_key,u_val|
    steps %Q{
    When I fill in "#{u_key}" with "#{u_val}"
    }
  end
end

Then /^I should be on the homepage$/ do
  steps %Q{
    Then I should see "homepage"
  }

  @session.save_screenshot('screenshot1.png')

end

Then /^I should see "([^"]*)"$/ do |arg1|
  case arg1
    when 'homepage'
      home_str = @session.evaluate_script("$('.box-header-timeline').text()")
      home_str.match(/.*Home*/)
      #fail if $&.nil?

      raise("Meow Home not found")
      # wait for ajax t ocomplete

      puts "meow:",@session.evaluate_script('$(".logged-user").find("div").find("a")[2].innerHTML')

      #
      # == sign out

    else
      puts "add visibility check form"
      return false
  end

end

Then /^I should be on "([^"]*)" page$/ do |page_title|

  case page_title
    when "homepage"
      'sign out' == @session.evaluate_script('$(".logged-user").find("div").find("a")[2].innerHTML')
  else
    false
  end

end

When /^I follow "([^"]*)"$/ do |arg1|
  @session.click_link(arg1)
end

#http://eggsonbread.com/2010/09/06/my-cucumber-best-practices-and-tips

 Given /^I am logged in as "([^"]*)"$/ do |name|

   user_name = 'testuser'
   user_password='ntcnbhjdfybt'

   steps %Q{
         Given I'm logged in as #{user_name} with password
   }
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

  #Wait.until!("wait ajax req completed") { @session.evaluate_script('$.active') }

#  wait_until do
#    page.evaluate_script('$.active') == 0
#  end
end


