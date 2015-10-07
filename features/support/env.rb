#require 'cucumber/core/ast/data_table'
#require 'cucumber/core/ast/scenario'
#require 'cucumber/core/ast/scenario_outline'

# this will add @scenario_name to all scenarios
Before do |scenario|

    @session = Capybara::Session.new(:selenium)#:poltergeist
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

