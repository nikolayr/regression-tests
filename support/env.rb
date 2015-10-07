# this will add @scenario_name to all scenarios
Before do |scenario|
    case scenario
        when Cucumber::Ast::OutlineTable::ExampleRow
            @scenario_name = scenario.scenario_outline.name
        when Cucumber::Ast::Scenario
            @scenario_name = scenario.name
        else
            raise("Unhandled class")
    end
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

