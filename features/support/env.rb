#require 'cucumber/core/ast/data_table'
#require 'cucumber/core/ast/scenario'
#require 'cucumber/core/ast/scenario_outline'
require 'capybara'
require 'selenium-webdriver'

Capybara.register_driver :remote_firefox do |app|

   url = 'http://127.0.0.1:4444/wd/hub'
   capabilities = Selenium::WebDriver::Remote::Capabilities.firefox
   Capybara::Selenium::Driver.new(app, :browser => :remote, :url => url,
                                       :desired_capabilities => capabilities)
end

# app host is the base of app being tested, without you cant use visit('/login')
#   Capybara.server_port = 3010
#   ip = "127.0.0.1"
#   Capybara.app_host = "http://#{ip}:#{Capybara.server_port}"

Capybara.current_driver = :remote_browser
Capybara.javascript_driver = :remote_browser

# this will add @scenario_name to all scenarios
Before do |scenario|

    @session = Capybara::Session.new(:remote_firefox)
    @scenario_name = scenario.name

    # case scenario
    #     when Cucumber::Core::Ast::OutlineTable::ExampleRow
    #         @scenario_name = scenario.scenario_outline.name
    #     when Cucumber::Core::Ast::Scenario
    #     else
    #         raise("Unhandled class")
    # end
end

After do |scenario|

# Do something after each scenario.
# The +scenario+ argument is optional, but
# if you use it, you can inspect status with
# the #failed?, #passed? and #exception methods.

  Cucumber.wants_to_quit = true if scenario.failed?
  #reset state of capybara session
  #@session.cleanup!
end

AfterStep do |scenario|

  Wait.until!("after step #{scenario} wait ajax req completed") { @session.evaluate_script('$.active') }

end


#Your steps can then check the scenario name using @scenario_name. Example:
#
#Then /I should get (.*)/ do |result|
#  if @scenario_name == 'Search items from QuickSearch'
#     #Do scenario specific stuff
#  elsif @scenario_name == 'Using a filter'
#     #Do scenario specific stuff
#  end
#
#  #Do combine scenario stuff
#end
#

