require 'capybara'
require 'capybara/poltergeist'
require 'wait_until'
require 'rspec/expectations'

P_SITE='https://micropeppa.freefeed.net'


# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     # Disable the `expect` sytax...
#     c.syntax = :should
#
#     # ...or disable the `should` syntax...
#     c.syntax = :expect
#
#     # ...or explicitly enable both
#     c.syntax = [:should, :expect]
#   end
# end


Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:inspector => true})
#, :js_errors => false})
end

# :js_errors => false
# :window_size => [800,600]

#http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Session


Given /^I am on "([^"]*)" page$/ do |page_name|

  # reset saved user credentials
  @current_user = nil

  url_path = nil

  case page_name
    when 'login'
      url_path = '/session/signin'
    when 'homepage'
      url_path = '/'
    when 'login error'
      steps %Q{
        Given }
  else
    raise ("add initial state:#{page_name}")
  end

  @session.visit(P_SITE + url_path)

  Wait.until!("loading page:#{page_name} on ") { @session.evaluate_script('$.active') == 0 }

end

Given /^There is a user "([^"]*)" with password "([^"]*)"$/ do |username, user_password|

  case username
    when '_testuser'
      username = 'testuser'
  end

  @current_user = {:username=>username,:password=>user_password}

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
  @current_user.each do |u_key,u_val|
    steps %Q{
    When I fill in "#{u_key}" with "#{u_val}"
    }
  end
end

Then /^I should be on the homepage$/ do


  expect(@session.find("div.box-header-timeline")).to have_content("Home")

end

#DEPRECATION: Using `should` from rspec-expectations' old `:should` syntax without explicitly
# enabling the syntax is deprecated. Use the new `:expect` syntax or
# explicitly enable `:should` with `config.expect_with(:rspec) { |c| c.syntax = :should }` instead.
# Called from /home/ruban/projects/regression-tests/features/step_definitions/regression_steps.rb:98:in
# `block in <top (required)>'.

Then /^I should see "([^"]*)"$/ do |arg1|

  case arg1
    when 'sign out'
      expect(@session.find("div.logged-user")).to have_link("sign out")
    when 'homepage'
      expect(@session.find("div.box-header-timeline")).to have_content("Home")
    else
      raise("expected to see:#{arg1}" )
  end

end

Then /^I should be on "([^"]*)" page$/ do |page_title|

  case page_title
    when 'login error'

    when 'homepage'
      unless 'sign out' == @session.evaluate_script('$(".logged-user").find("div").find("a")[2].innerHTML')
        raise "can't see 'sign out' link"
      end
  else
    raise("unknown place #{page_title}")
  end

end

When /^I follow "([^"]*)"$/ do |arg1|
  @session.click_link(arg1)
end

#http://eggsonbread.com/2010/09/06/my-cucumber-best-practices-and-tips

 Given /^I am logged in as "([^"]*)"$/ do |name|

   case name
     when 'testuser'
       steps %Q{ Given There is a user "testuser" with password "ntcnbhjdfybt}
   end

   steps %Q{
    When I enter user credentials
      And press "Sign in"
    Then I should be on the homepage
   }

end

When /^I type in text "([^"]*)" to edit box$/ do |arg1|

  @session.within('div.p-create-post-view') do
    fill_in('textarea', :with => arg1)
  end
#  $("div.p-create-post-view").find("textarea")
#  @session.fill_in('', :with => arg1)
end

Then /^I should see new post with text "([^"]*)" in my feed$/ do |arg1|

  Wait.until!("adding post to feed") { @session.evaluate_script('$.active') }

  last_post_text = @session.evaluate_script("$('div.posts').\
find('div.ember-view').\
find('.post-body.p-timeline-post').\
find('div.body').\
find('div.text')[0].innerHTML")

  if arg1 == last_post_text.strip

  else
    raise("can't find new post with text:#{arg1}")
  end


end

Then /^I should see empty edit box$/ do

  unless "" == page.evaluate_script('$("div.p-create-post-view").find("textarea")[0].value')
    raise("edit bos is not empty")
  end

end

When /^press button "([^"]*)"$/ do |arg1|
  @session.click_link_or_button(arg1)
end

When /^I wait until all Ajax requests are complete$/ do

  Wait.until!("wait ajax req completed") { @session.evaluate_script('$.active') }

#  wait_until do
#    page.evaluate_script('$.active') == 0
#  end
end


