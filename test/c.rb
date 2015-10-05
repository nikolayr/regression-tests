require 'capybara'
require 'capybara/poltergeist'
require 'wait_until'


# for options see - https://github.com/teampoltergeist/poltergeist#Customization
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:inspector => true})
#, :js_errors => false})
end

# :js_errors => false
# :window_size => [800,600]

session = Capybara::Session.new(:selenium)#:poltergeist
session.visit "https://freefeed.net/"

#Wait.until!("login box with username is loaded") { session.has_content?("Username") }
Wait.until!("login box with username is loaded") { session.evaluate_script('$.active') }

if session.has_content?("Username")
  puts "All shiny, captain!"
  session.save_screenshot('screenshot1.png')
else
#  puts "readyState is:",session.inspect

  session.save_screenshot('screenshot2.png')
  puts ":( no tagline fonud, possibly something's broken"
  exit(-1)
end


